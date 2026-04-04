FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
        docker.io \
        curl 
        #install docker insdide jenkins container

RUN mkdir -p /usr/libexec/docker/cli-plugins/ \
    && curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64" -o /usr/libexec/docker/cli-plugins/docker-compose \
    # -o means write output to file
    && chmod +x /usr/libexec/docker/cli-plugins/docker-compose


USER jenkins

