FROM dhi.io/alpine-base:3.24-dev AS test
RUN apk add --no-cache curl

FROM dhi.io/composer:2-alpine-dev AS builder
COPY bin /opt/app/bin
COPY src /opt/app/src
COPY composer.json /opt/app/composer.json
COPY composer.lock /opt/app/composer.lock
RUN cd /opt/app && composer install --no-cache --prefer-dist --no-dev --no-scripts --no-progress
RUN apk add --no-cache docker-cli

FROM dhi.io/php:8.5.13-alpine3.24
COPY --from=builder /usr/bin/docker /usr/bin/docker
COPY --from=builder /opt/app /opt/app
ENTRYPOINT ["php", "/opt/app/bin/docker-ec2-metadata.php", "-p", "80", "-vvv"]
