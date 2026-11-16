FROM dhi.io/alpine-base:3.24-dev AS test
RUN apk add --no-cache curl

FROM dhi.io/composer:2-alpine-dev AS builder
COPY bin /opt/bin
COPY src /opt/src
COPY composer.json /opt/composer.json
COPY composer.lock /opt/composer.lock
RUN cd /opt && composer install --no-cache --prefer-dist --no-dev --no-scripts --no-progress
RUN apk add --no-cache docker-cli

FROM dhi.io/php:8.5.12-alpine3.24-fpm
COPY --from=builder /usr/bin/docker /usr/bin/docker
COPY --from=builder /opt /opt
ENTRYPOINT ["php", "/opt/bin/docker-ec2-metadata.php", "-p", "80", "-vvv"]
