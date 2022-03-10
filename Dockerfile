FROM bitnami/golang:1.16

WORKDIR /opt/mkcert

RUN apt update && \
    apt install -y wget libnss3-tools && \
    wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 && \
    cp mkcert-v1.4.3-linux-amd64 /usr/local/bin/mkcert && \
    chmod +x /usr/local/bin/mkcert && \
    mkcert -install


COPY . /app
WORKDIR /app

RUN mkcert -key-file configs/certs/key.pem -cert-file configs/certs/cert.pem  localhost 127.0.0.1 ::1 0.0.0.0

EXPOSE 8086

CMD ["go", "run","cmd/server/main.go"]
