FROM debian:latest
LABEL maintainer="peter@wiredelf.com"
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
	&& apt-get update \
	&& apt install cron curl wget jq vim -y \
	&& apt-get clean \
  && rm -fr /var/lib/apt/list/*
VOLUME /etc/cron.d/
CMD [ "/usr/sbin/cron","-f","-L /dev/stdout" ]
