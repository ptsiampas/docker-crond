FROM debian:jessie
LABEL maintainer="peter@wiredelf.com"
RUN apt-get update \
	&& apt install -y cron curl wget vim \
	&& apt-get clean \
  && rm -fr /var/lib/apt/list/*
# cron(8) says the Debian cron daemon reads the files in /etc/cron.d,
# merging into the data from /etc/crontab, to use as the system-wide cron jobs
#
RUN echo "*/5 * * * * root /usr/bin/wget -qO- http://nginx/wp-cron.php" >/etc/cron.d/wpcron
VOLUME /etc/cron.d/
CMD [ "cron","-f" ]
