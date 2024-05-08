FROM ubuntu

RUN dpkg --add-architecture i386 \
    && apt update \
    && apt install -y wine64 wine32 wget unzip xvfb \
    && mkdir -p /root/.wine/drive_c/steamcmd \
    && mkdir -p /root/.wine/drive_c/users/root/AppData/LocalLow/'Stunlock Studios'/VRisingServer/Settings \
    && wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -P /root/.wine/drive_c/steamcmd/ \
    && cd /root/.wine/drive_c/steamcmd/ \
    && unzip steamcmd.zip \
    && mkdir -p /root/.wine/drive_c/VRisingServer/ \
    && cd /root/.wine/drive_c/steamcmd 

add ./scripts /scripts

WORKDIR /scripts

RUN chmod +x init.sh
RUN ./init.sh

# 27015 Game port
EXPOSE 27015/udp 

# 27016 Query port
EXPOSE 27016/udp

# 27017 Fallback port
EXPOSE 27017/udp

# 25575 RCON port
EXPOSE 25575/tcp

entrypoint ["/scripts/entrypoint.sh"]