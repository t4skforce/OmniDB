FROM debian:stable-slim

ARG VERSION="2.17.0"
ARG DOWNLOADURL="https://omnidb.org/dist/2.17.0/omnidb-server_2.17.0-debian-amd64.deb"

RUN  apt-get update \
  && apt-get install -y wget \
  && if [ ! -e '/bin/systemctl' ]; then ln -s /bin/echo /bin/systemctl; fi \
  && cd /tmp/ \
  && wget -q ${DOWNLOADURL} -O omnidb-server.deb \
  && dpkg -i omnidb-server.deb \
  && mkdir -p /data \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

EXPOSE 8000
EXPOSE 25482

VOLUME ["/data"]
CMD ["omnidb-server","-H","0.0.0.0","-p","8000","-w","25482","-d","/data"]
