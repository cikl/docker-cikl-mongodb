FROM cikl/base:0.0.2
MAINTAINER Mike Ryan <falter@gmail.com>

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y --no-install-recommends mongodb-server && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Define mount points.
VOLUME [ "/data" ]

# Define working directory.
WORKDIR /data

ENV ENTRYPOINT_DROP_PRIVS 1
ENV ENTRYPOINT_USER mongodb

# Set to 'development' or 'production'
# production
#   - mongodb will journal and preallocate files
# development
#   - mongodb will NOT journal and preallocate files
ENV CIKL_ENV production

ADD mongodb-command.sh /etc/docker-entrypoint/commands.d/mongodb
ADD mongodb-pre.sh /etc/docker-entrypoint/pre.d/mongodb-pre.sh
RUN chmod a+x /etc/docker-entrypoint/commands.d/mongodb

EXPOSE 27017
EXPOSE 28017

CMD [ "mongodb" ]
