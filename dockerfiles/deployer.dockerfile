FROM alpine:3.19
RUN apk -v add --update-cache curl openjdk11-jre docker-cli-compose bash make ansible sshpass openssh && apk -v cache clean

WORKDIR /project/maga
VOLUME [ "/project/maga" ]
CMD ["/bin/bash"]