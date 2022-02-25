FROM alpine:3.15

ENV VER=3.0.1 USER=test PASSWORD=ss123456
ENV TLS_PORT=4433 PORT=8080

RUN mkdir gost && apk add --no-cache wget \
  && wget --no-check-certificate https://github.com/Realmyname/test/raw/main/gost-linux-amd64-3 \
  && mv gost-linux-amd64-3 /gost/gost && chmod a+x /gost/gost

WORKDIR /gost
EXPOSE ${TLS_PORT} $PORT

#CMD exec /gost/gost -L=relay+mwss://$METHOD:$PASSWORD@:$TLS_PORT -L=relay+mws://$METHOD:$PASSWORD@:$PORT -L=relay+grpc://$METHOD:$PASSWORD@:$TLS_PORT -L=relay+grpc://$METHOD:$PASSWORD@:$PORT
CMD exec /gost/gost -L=auto+mwss://$USER:$PASSWORD@:$TLS_PORT -L=auto+mws://$USER:$PASSWORD@:$PORT
