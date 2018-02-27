FROM rocker/binder:3.4.2

# Note `## If extending this image, remember to switch back to USER root to apt-get`
# at the end of https://github.com/rocker-org/binder/blob/master/3.4.2/Dockerfile

USER root

# Trying to merge the Dockerfiles from: 
# https://github.com/alexcoppe/bio-dockers/blob/75906f53d87399d80a9349148559ecb9511eba79/circos/Dockerfile
#https://github.com/rocker-org/geospatial/blob/master/3.4.2/Dockerfile 
# https://hub.docker.com/r/genomicpariscentre/bioperl/~/dockerfile/ (found by searching `ubuntu cpan perl gd docker`)
# rocker/binder:3.4.2
# into something that works to install the perl modules Circos needs

# Trying to add circos, and the important dependencies
ENV version 0.69-6

#ADD http://circos.ca/distribution/circos-${version}.tgz /tmp/
RUN wget "http://circos.ca/distribution/circos-0.69-6.tgz" \
  && tar xzvf circos-0.69-6.tgz \
  && rm -rf circos-0.69-6.tgz \


# Update the repository sources list
#RUN apt-get update

# Install compiler and perl stuff
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
     gcc-multilib \
     apt-utils \
     perl \
     expat \
     libexpat-dev \
     cpanminus \
     libarchive-zip-perl \
     libdbd-mysql \
     libdbd-mysql-perl \
     libdbd-pgsql \
     libgd-gd2-perl \
     libgd2-noxpm-dev \
     libpixman-1-0 \
     libpixman-1-dev \
     graphviz \
     libxml-parser-perl \
     libsoap-lite-perl \
     libxml-libxml-perl \
     libxml-dom-xpath-perl \
     libxml-libxml-simple-perl \
     libxml-dom-perl



# Install perl modules 
RUN cpanm CPAN::Meta \
 readline \ 
 Term::ReadKey \
 YAML \
 Digest::SHA \
 Module::Build \
 ExtUtils::MakeMaker \
 Test::More \
 Data::Stag \
 Config::Simple \
 Statistics::Lite \
 Statistics::Descriptive \
 GD \
 GD::Graph \
 GD::Graph::smoothlines \
 Test::Most \
 Algorithm::Munkres \
 Array::Compare Clone \
 #PostScript::TextBlock \
 SVG::Graph \
 Set::Scalar \
 Sort::Naturally \
 Graph \
 GraphViz \
 HTML::TableExtract \
 #Convert::Binary::C \
 Math::Random \
 Error \
 Spreadsheet::ParseExcel \
 XML::Parser::PerlSAX \
 XML::SAX::Writer \
 XML::Twig XML::Writer \
 Math::Bezier \
 Math::Round \
 #Readonly::Tiny \
 Readonly \
 Config::General \
 Params::Validate \
 Font::TTF::Font \
 Regexp::Common \
 Math::VecStat \
 Text::Format \
 SVG \
 Clone \ 
 List::MoreUtils \
 Number::Format \
 Statistics::Basic \
 Set::IntSpan \
 -force Try::Tiny

# Copy repo into ${HOME}, make user own $HOME
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



