FROM debian:jessie
MAINTAINER Lukas Martinelli <me@lukasmartinelli.ch>

RUN useradd -u 9000 -r -s /bin/false app
WORKDIR /code
COPY ./hadolint /usr/bin/

USER app
VOLUME /code
