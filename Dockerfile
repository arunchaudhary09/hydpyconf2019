FROM debian:stable-slim

LABEL "maintainer"="Arun Chaudhary <arunchaudhary.bit@gmail.com>"
LABEL "repository"="https://github.com/arunchaudhary09/hydpyconf2019@ci-cd"
LABEL "version"="1.0.1"

LABEL "com.github.actions.name"="SSH"
LABEL "com.github.actions.description"="Run command via SSH"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="orange"

RUN apt-get update && apt-get install -y \
  openssh-client && \
  rm -Rf /var/lib/apt/lists/*


ADD entrypoint.sh /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]
