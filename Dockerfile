FROM ubuntu:20.04
LABEL maintainer="devs@agilicus.com"

RUN apt-get update \
 && apt-get -y install restic \
 && rm -rf /var/lib/apt/lists/*

ADD auto-backup /usr/bin/auto-backup
ENTRYPOINT [ "/usr/bin/auto-backup" ]
