FROM debian:stable-slim

ARG VERSION="3.0.3b"
ARG DOWNLOADURL="https://github.com/OmniDB/OmniDB/releases/download/3.0.3b/omnidb-server_3.0.3b_linux_x86_64.deb"
ARG BUILD_DATE="2023-06-18T07:40:10Z"

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

VOLUME ["/data"]
CMD ["omnidb-server","-H","0.0.0.0","-p","8000","-d","/data"]
