FROM alpine:3.6

ENV VER=3.0.1 METHOD=chacha20 PASSWORD=ss123456
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/Realmyname/test/raw/main/gost-linux-amd64-3 \
  && mv gost-linux-amd64-3 gost && chmod a+x gost/gost

WORKDIR /gost
EXPOSE ${TLS_PORT} $PORT

CMD exec /gost/gost -L=relay+quic://$METHOD:$PASSWORD@:$TLS_PORT -L=relay+quic://$METHOD:$PASSWORD@:$PORT -L=relay+mtls://$METHOD:$PASSWORD@:$TLS_PORT -L=relay+mtls://$METHOD:$PASSWORD@:$PORT

