FROM gliderlabs/alpine:3.3
RUN apk --update --no-cache add alpine-sdk coreutils \
  && adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder \
  && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && mkdir /packages /src \
  && chown builder:abuild /packages /src

USER builder
RUN abuild-keygen -a

ENV REPODEST /packages

COPY . /src
CMD /src/build-all.sh
