FROM debian:buster

LABEL org.opencontainers.image.source https://github.com/trstringer/kubectl-image

ARG VERSION
RUN apt update && \
    apt install -y curl && \
    curl -LO "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

ENTRYPOINT ["kubectl"]
