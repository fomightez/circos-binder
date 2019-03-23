# Dockerfile to build Circos app for Cyverse
# Based on https://github.com/fomightez/circos-binder &
# https://github.com/fomightez/patmatch-binder/tree/master/vice &
# https://github.com/sbl-sdsc/mmtf-genomics/tree/master/vice
FROM discoenv/jupyter-lab:beta
LABEL maintainer "Wayne Decatur *(fomightez on Github)*"

USER root

# Update the packages
RUN apt-get update \
    && apt-get install -y gcc make \
    && apt-get clean \
    && rm -rf /usr/lib/apt/lists/*


USER jovyan


# Install Perl Dependencies needed
RUN conda config --add channels bioconda
RUN conda install -y perl=5.22.0.1 \
    perl-carp=1.38 \
    perl-clone=0.38 \
    perl-config-general=2.61 \
    perl-pathtools=3.73 \
    perl-data-dumper=2.161 \
    perl-digest-md5=2.52 \
    perl-file-temp=0.2304 \
    perl-findbin=1.51 \
    perl-font-ttf=1.05 \
    perl-gd=2.56 \
    perl-getopt-long=2.50 \
    perl-io-all=0.86 \
    perl-list-moreutils=0.428 \
    perl-list-util=1.38 \
    perl-math-bezier=0.01 \
    perl-math-round=0.07 \
    perl-math-vecstat=0.08 \
    perl-memoize=1.03 \
    perl-posix=1.38_03 \
    perl-params-validate=1.26 \
    perl-pod-usage=1.69 \
    perl-readonly=1.04 \
    perl-regexp-common=2016060801 \
    perl-svg=2.64 \
    perl-set-intspan=1.19 \
    perl-statistics-basic=1.6611 \
    perl-text-balanced=2.03 \
    perl-text-format=0.59 \
    perl-time-hires=1.9728


# Install bash kernel and Biopython
RUN pip install bash_kernel==0.7.1 \
    && python3 -m bash_kernel.install \
    && pip install biopython==1.73

WORKDIR /home/jovyan

#Get Circos (see http://circos.ca/documentation/tutorials/configuration/installation/)
RUN curl -OL http://circos.ca/distribution/circos-0.69-6.tgz && \
   tar -xzf circos-0.69-6.tgz && \
   rm -f circos-0.69-6.tgz

#Get Circos tutorial files (see http://circos.ca/distribution/circos-tutorials-0.67.tgz)
RUN curl -OL http://circos.ca/distribution/circos-tutorials-0.67.tgz && \
   tar -xzf circos-tutorials-0.67.tgz && \
   rm -f circos-tutorials-0.67.tgz


# clone circos-binder to get the notebooks
RUN git clone https://github.com/fomightez/circos-binder


# Move circos software folder to same place it is in the MyBinder instance so included 
# notebooks work both on MyBinder launches and in Cyverse VICE launches
RUN mv circos-0.69-6 circos-binder/.
RUN mv circos-tutorials-0.67 circos-binder/.

COPY entry.sh /bin
RUN mkdir /home/jovyan/.irods

WORKDIR /home/jovyan/circos-binder/
ENTRYPOINT ["bash", "/bin/entry.sh"]




