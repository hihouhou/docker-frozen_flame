#
# Frozen Flame server Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV FROZEN_FLAME_VERSION 0.65.0.5

# Update & install packages
RUN apt-get update && \
    apt-get install -y curl wget file tar bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32stdc++6 libsdl2-2.0-0 libcurl4-openssl-dev vim


RUN useradd -ms /bin/bash ff

USER ff

RUN mkdir -p /home/ff/steam/ff && \
    usermod -u 1000 ff

#Get steamcmd
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz -O /tmp/steamcmd_linux.tar.gz && \
    cd /tmp && \
    tar xf steamcmd_linux.tar.gz && \
    chmod +x steamcmd.sh && \
    ./steamcmd.sh +login anonymous +force_install_dir /home/ff/steam/ff +app_update 1348640 validate +exit

COPY Game.ini /home/ff/steam/ff/FrozenFlame/Saved/Config/LinuxServer/Game.ini

WORKDIR /home/ff/steam/ff

CMD /bin/bash FrozenFlameServer.sh -LOCALLOGTIMES -MetaGameServerName=$SERVER_NAME
