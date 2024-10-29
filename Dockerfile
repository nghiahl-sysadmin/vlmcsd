# Stage 1: Builder
FROM alpine:latest AS builder

RUN apk add --no-cache make build-base

COPY . /opt/vlmcsd

WORKDIR /opt/vlmcsd

RUN make

# Stage 2: Runtime
FROM alpine:latest

RUN apk add --no-cache tzdata && ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime

COPY --from=builder /opt/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd

CMD ["/usr/bin/vlmcsd", "-D", "-d", "-v", "-l", "/var/log/vlmcsd.log"]

