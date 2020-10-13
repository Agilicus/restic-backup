FROM ubuntu:20.04
LABEL maintainer="devs@agilicus.com"

RUN apt-get update \
 && apt-get -y install restic cron ca-certificates rsyslog \
 && rm -rf /var/lib/apt/lists/* \
 && sed -i -e '/imklog/d' /etc/rsyslog.conf

ADD auto-backup /usr/bin/auto-backup
ENTRYPOINT [ "/usr/bin/auto-backup" ]
