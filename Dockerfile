FROM golang:latest as build
LABEL maintainer="don@agilicus.com"

# Build v0.9.0. This commit-id was
# signed by 91A6868BD3F7A907
# https://github.com/restic/restic/issues/1819 for the sed
# Use 0183fea926f6fe801d20f53d3c677ee0bd86d6e2 as commit
# since it picks up the fix for 1819
RUN mkdir -p /go/src/github.com/restic \
 && cd /go/src/github.com/restic \
 && git clone https://github.com/restic/restic \
 && cd restic \
 && git checkout -b build  0183fea926f6fe801d20f53d3c677ee0bd86d6e2 \
 && go run build.go


FROM busybox:latest
COPY --from=build /go/src/github.com/restic/restic/restic /usr/bin/restic
COPY --from=build /etc/ssl /etc/ssl

ADD auto-backup /usr/bin/auto-backup
ENTRYPOINT [ "/usr/bin/auto-backup" ]
