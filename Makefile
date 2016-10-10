
GITCOMMIT=$(shell git describe --match 'v[0-9]*' --dirty='.m' --always)
BUILDTIME=$(shell date -u '+%Y%m%d.%I%M%S%p')
VERSION=0.0.3
GO_LDFLAGS=-ldflags "-X `go list ./version`.Version=$(VERSION) -X `go list ./version`.BUILDTIME=$(BUILDTIME) -X `go list ./version`.GITCOMMIT=$(GITCOMMIT) -w"

TAG=${VERSION}
PREFIX=shenshouer/shadowsocks

image:
	@echo "🐳 $@"
	@cp main/server/main.go ./ && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo ${GO_LDFLAGS} -o shadowsocks-server .
	@docker build -t $(PREFIX):$(TAG) .
	@docker push $(PREFIX):$(TAG)
	@rm -f shadowsocks-server main.go
	