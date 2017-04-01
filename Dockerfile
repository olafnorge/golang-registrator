FROM alpine:3.5
MAINTAINER Volker Machon <volker@machon.biz>

COPY rootfs/ /

# build and install registrator
WORKDIR /go/src/github.com/gliderlabs/registrator
RUN apk add --no-cache --virtual .run-deps ca-certificates \
    && apk add --no-cache --virtual .go-build-deps \
           build-base \
           git \
           go \
	&& export GOPATH=/go \
  	&& git config --global http.https://gopkg.in.followRedirects true \
	&& go get \
	&& go build -ldflags "-X main.Version=$(cat VERSION)" -o /bin/registrator \
	&& rm -rf /go \
	&& apk del --purge .go-build-deps

# build and install minimalistic busybox
ARG BUSY_BOX_VERSION=1.26.2
RUN [ $(getent group registrator) ] || addgroup -S registrator \
    && [ $(getent passwd registrator) ] || adduser -S -D -G registrator registrator \
    && apk add --no-cache --virtual .busybox-build-deps \
        gcc \
        make \
        musl-dev \
        ncurses-dev \
        openssl \
    && wget -O- "https://busybox.net/downloads/busybox-${BUSY_BOX_VERSION}.tar.bz2" > /tmp/busybox.tar.bz2 \
    && cd /tmp \
    && tar xfj busybox.tar.bz2 \
    && cd /tmp/busybox-${BUSY_BOX_VERSION} \
    && mv /busybox-config .config \
    && make \
    && for DEL_SYM_LINK in $(/bin/busybox find / -type l | /bin/busybox grep bin); do /bin/busybox rm ${DEL_SYM_LINK}; done \
    && for SYM_LINK in /bin/test /bin/[ /bin/[[ /bin/ps /bin/ash /bin/sh; do /bin/busybox ln -s /bin/busybox ${SYM_LINK}; done \
    && apk del --purge .busybox-build-deps \
    && /bin/busybox mv /tmp/busybox-${BUSY_BOX_VERSION}/busybox /bin/busybox.new \
    && /bin/busybox rm -rf /tmp/busybox* \
    && for DEL_USER in $(/bin/busybox grep -v registrator /etc/passwd | /bin/busybox awk -F':' '{print $1}'); do /bin/busybox deluser ${DEL_USER}; done \
    && /bin/busybox mv /bin/busybox.new /bin/busybox

WORKDIR /
USER registrator
ENTRYPOINT ["/bin/registrator"]
