FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
        docker.io \
        curl \ 
        ansible \ 
        sshpass
        #install docker insdide jenkins container

RUN mkdir -p /usr/libexec/docker/cli-plugins/ \
    && curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64" -o /usr/libexec/docker/cli-plugins/docker-compose \
    # -o means write output to file
    && chmod +x /usr/libexec/docker/cli-plugins/docker-compose \ 
 
# Install Docker Buildx 0.17.1
    && curl -SL "https://github.com/docker/buildx/releases/download/v0.17.1/buildx-v0.17.1.linux-amd64" -o /usr/libexec/docker/cli-plugins/docker-buildx \
    && chmod +x /usr/libexec/docker/cli-plugins/docker-buildx

USER jenkins

