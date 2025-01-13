BIN_DIR=$(PWD)/bin
PICO_DIR=$(PWD)/cmd/pico-ctl
CC=gcc
CXX=g++
GOFILES=`go list ./...`
GOFILESNOTEST=`go list ./... | grep -v test`
VERSION=$(shell git describe --abbrev=0 --tags 2>/dev/null || echo "v0.0.0")
BUILD=$(shell git rev-parse HEAD)
LDFLAGS=-ldflags="-s -w"

build-all: darwin-arm64 darwin-amd64 linux-arm64 linux-amd64

darwin-arm64: go-lint
	@mkdir -p ${BIN_DIR}
	@echo "Building management cli darwin/arm64 ${VERSION}..."
	@GOOS=darwin GOARCH=arm64 CGO_ENABLED=0 CC=${CC} CXX=${CXX} go build -trimpath ${LDFLAGS} -o ${BIN_DIR}/pico-ctl.darwin.arm64 ${PICO_DIR}

darwin-amd64: go-lint
	@mkdir -p ${BIN_DIR}
	@echo "Building management cli darwin/arm64 ${VERSION}..."
	@GOOS=darwin GOARCH=arm64 CGO_ENABLED=0 CC=${CC} CXX=${CXX} go build -trimpath ${LDFLAGS} -o ${BIN_DIR}/pico-ctl.darwin.amd64 ${PICO_DIR}

linux-arm64: go-lint
	@mkdir -p ${BIN_DIR}
	@echo "Building management cli darwin/arm64 ${VERSION}..."
	@GOOS=darwin GOARCH=arm64 CGO_ENABLED=0 CC=${CC} CXX=${CXX} go build -trimpath ${LDFLAGS} -o ${BIN_DIR}/pico-ctl.linux.arm64 ${PICO_DIR}

linux-amd64: go-lint
	@mkdir -p ${BIN_DIR}
	@echo "Building management cli darwin/arm64 ${VERSION}..."
	@GOOS=darwin GOARCH=arm64 CGO_ENABLED=0 CC=${CC} CXX=${CXX} go build -trimpath ${LDFLAGS} -o ${BIN_DIR}/pico-ctl.linux.amd64 ${PICO_DIR}

go-sync:
	@go mod tidy && go mod vendor

dep-shared:
	@echo "Update shared components..."
	@export GOPRIVATE="github.com/PicoTools" && go get -u github.com/PicoTools/pico-shared/ && go mod tidy && go mod vendor

go-lint:
	@echo "Linting Golang code..."
	@go fmt ${GOFILES}
	@go vet ${GOFILESNOTEST}

