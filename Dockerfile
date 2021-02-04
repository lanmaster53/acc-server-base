FROM debian:10.5-slim

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wine-development && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

ENV WINEARCH=win64 \
    WINEDEBUG=-all

RUN wineboot --init

VOLUME /opt/server
WORKDIR /opt/server

CMD ["wine", "accServer.exe"]
