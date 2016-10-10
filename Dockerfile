FROM scratch

COPY shadowsocks-server /shadowsocks-server
COPY conf/sample-server.json /server.json

WORKDIR /

ENTRYPOINT ["/shadowsocks-server"]