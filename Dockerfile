FROM rocker/binder:3.4.2

# Copy repo into ${HOME}, make user own $HOME
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

# Trying to add circos, and the important dependencies
ENV version 0.69-6

#ADD http://circos.ca/distribution/circos-${version}.tgz /tmp/
RUN wget "http://circos.ca/distribution/circos-0.69-6.tgz" \
  && tar xzvf circos-0.69-6.tgz \
  && rm -rf circos-0.69-6.tgz \
  && mkdir circos \
  && mv circos-0.69-6 circos \

# Update the repository sources list
RUN apt-get update

# Install compiler and perl stuff
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils \
 perl \
 expat \
 libexpat-dev 

# Install perl modules 
RUN apt-get install -y cpanminus

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
 Statistics::Descriptive 

RUN apt-get install --yes \
 libarchive-zip-perl

# Install related DB modules
RUN apt-get install --yes \
 libdbd-mysql \
 libdbd-mysql-perl \
 libdbd-pgsql

# Install GD
RUN apt-get remove --yes libgd-gd2-perl

RUN apt-get install --yes \
 libgd2-noxpm-dev

RUN cpanm GD \
 GD::Graph \
 GD::Graph::smoothlines 


# Install BioPerl dependancies, mostly from cpan
RUN apt-get install --yes \
 libpixman-1-0 \
 libpixman-1-dev \
 graphviz \
 libxml-parser-perl \
 libsoap-lite-perl 

RUN cpanm Test::Most \
 Algorithm::Munkres \
 Array::Compare Clone \
 PostScript::TextBlock \
 SVG::Graph \
 Set::Scalar \
 Sort::Naturally \
 Graph \
 GraphViz \
 HTML::TableExtract \
 Convert::Binary::C \
 Math::Random \
 Error \
 Spreadsheet::ParseExcel \
 XML::Parser::PerlSAX \
 XML::SAX::Writer \
 XML::Twig XML::Writer \
 Math::Bezier \
 Math::Round \
 Readonly::Tiny \
 Readonly \
 Config::General \
 Params::Validate \
 Font::TTF::Font \
 Regexp::Common \
 Math::VecStat 
 Text::Format 
 SVG \
 Clone \ 
 List::MoreUtils
        #&& cpanm -force GD Number::Format \
        #&& cpanm Statistics::Basic Set::IntSpan \

RUN apt-get install -y \
 libxml-libxml-perl \
 libxml-dom-xpath-perl \
 libxml-libxml-simple-perl \
 libxml-dom-perl


#RUN     cd /opt/ \
        #&& apk add --update --no-cache perl gd jpeg freetype \
        #&& apk add --update --no-cache --virtual=deps make gd-dev jpeg-dev freetype-dev apkbuild-cpan gcc  musl-dev perl-dev \
        #&& wget -O - http://cpanmin.us | perl - --self-upgrade  \
        #&& cpanm Math::Bezier Math::Round Readonly::Tiny Readonly Config::General Params::Validate Font::TTF::Font Regexp::Common Math::VecStat Text::Format SVG Clone List::MoreUtils  \
        #&& cpanm -force GD Number::Format \
        #&& cpanm Statistics::Basic Set::IntSpan \
        #&& cpanm -force Try::Tiny \
        #&& rm -rf /var/cache/apk/* \
        #&& apk del deps


