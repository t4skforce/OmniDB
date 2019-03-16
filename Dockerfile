FROM debian:stable-slim

ARG VERSION="2.14.0"
ARG DOWNLOADURL="https://omnidb.org/dist/2.14.0/omnidb-server_2.14.0-debian-amd64.deb"

RUN  apt-get update \
  && apt-get install -y wget \
  && ln -s /usr/bin/true /usr/bin/systemctl \
  && cd /tmp/ \
  && wget -q ${DOWNLOADURL} -O omnidb-server.deb \
  && dpkg -i omnidb-server.deb \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

EXPOSE 8000
EXPOSE 25482

WORKDIR /app
CMD ["omnidb-server"]
