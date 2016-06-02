FROM gliderlabs/alpine:3.3
RUN apk --update --no-cache add alpine-sdk coreutils \
  && adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder \
  && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && mkdir /packages /src \
  && chown builder:abuild /packages /src

USER builder
RUN abuild-keygen -a

ENV REPODEST /packages

USER root
COPY . /src
RUN cp /home/builder/.abuild/*.pub /etc/apk/keys
RUN chown -R builder:abuild /src

USER builder
CMD /src/build-all.sh
