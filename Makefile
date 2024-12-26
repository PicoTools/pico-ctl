BIN_DIR=$(PWD)/bin
PICO_DIR=$(PWD)/cmd/pico-ctl
CC=gcc
CXX=g++

.PHONY: pico-ctl
pico-ctl:
	@mkdir -p ${BIN_DIR}
	@echo "Building management cli..."
	CGO_ENABLED=0 CC=${CC} CXX=${CXX} go build -o ${BIN_DIR}/pico-ctl ${PICO_DIR}
	@strip bin/pico-ctl

.PHONY: go-sync
go-sync:
	@go mod tidy && go mod vendor

.PHONY: dep-shared
dep-shared:
	@echo "Update shared components..."
	@export GOPRIVATE="github.com/PicoTools" && go get -u github.com/PicoTools/pico-shared/ && go mod tidy && go mod vendor

