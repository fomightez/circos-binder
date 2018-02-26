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
  && mv circos-0.69-6 circos \



