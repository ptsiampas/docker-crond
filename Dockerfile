FROM debian:jessie
LABEL maintainer="peter@wiredelf.com"
RUN apt-get update \
	&& apt-get install -y --no-install-recommends cron curl wget ca-certificates vim \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/*

VOLUME /etc/cron.d/
# Tried placing the file under /etc/cron.d but it didn't work, so have to use
# This work around.
RUN echo "* * * * *  /usr/bin/wget -qO- http://nginx/wp-cron.php" | crontab -
# COPY ./wpcron /etc/cron.d/wpcron
# RUN chmod 644 /etc/cron.d/wpcron

CMD [ "cron","-f" ]