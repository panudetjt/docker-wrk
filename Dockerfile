# Docker image for wrk: Modern HTTP benchmarking tool.
#
# URL: https://github.com/William-Yeh/docker-wrk
#
# Reference:  https://github.com/wg/wrk
#
# Version     4.0.2
#

# pull base image
# FROM williamyeh/ansible:mini-alpine3
# FROM willhallonline/ansible:alpine AS Builder
FROM panudet/ansible:latest AS Builder
# #FROM scratch
# #FROM busybox
# #FROM progrium/busybox
# #FROM alpine:3.3
# #FROM debian:jessie

LABEL authors="William Yeh <william.pjyeh@gmail.com>"
LABEL maintainer="Panudet Tammawongsa <offer.larder0f@icloud.com>"
LABEL version="4.2.0"

# # configure
WORKDIR /ansible

COPY . /ansible

RUN ansible-playbook -c local playbook.yml

# FROM ubuntu:latest
# FROM --platform=linux/amd64 alpine:latest
FROM alpine:latest

RUN apk add --update --no-cache \
    libgcc

WORKDIR /root/
COPY --from=Builder /usr/local/bin/wrk /usr/local/bin/wrk
# COPY ./wrk /usr/local/bin/wrk

# Define default command.
ENTRYPOINT ["/usr/local/bin/wrk"]
