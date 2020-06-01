FROM alpine:3.6
MAINTAINER Sleede <contact@sleede.com>

RUN apk add --no-cache ca-certificates openssl \
    ruby ruby-bigdecimal ruby-json sqlite-libs libstdc++

ARG MAILCATCHER_VERSION=0.8.0.beta2

RUN apk add --no-cache --virtual .build-deps \
        ruby-dev make g++ sqlite-dev \
        && gem install -v $MAILCATCHER_VERSION mailcatcher --no-ri --no-rdoc \
        && apk del .build-deps \
        && rm -rf /var/cache/apk/*

EXPOSE 1025 1080

ENTRYPOINT ["mailcatcher", "--foreground"]
CMD ["--ip", "0.0.0.0"]
