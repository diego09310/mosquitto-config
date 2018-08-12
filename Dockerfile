FROM resin/rpi-raspbian:stretch

RUN apt-get update && apt-get install -y wget

RUN wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-stretch.list http://repo.mosquitto.org/debian/mosquitto-stretch.list
RUN apt-get update && apt-get install -y mosquitto

RUN adduser --system --disabled-password --disabled-login mosquitto

VOLUME ["/mosquitto/config", "/mosquitto/data", "/mosquitto/log"]
COPY passwd /mosquitto/

EXPOSE 1883 9001

CMD /usr/sbin/mosquitto -c /mosquitto/config/mosquitto.conf

