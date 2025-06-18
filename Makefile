# File: Makefile
# Makefile for testp4go - showing how to build Go programs which use p4go - focussed on Mac

BINARY=testp4go

current_dir := $(shell pwd)

# Compiler flags
CGO_CPPFLAGS := -I$(current_dir)/p4api/include -g
CGO_LDFLAGS := -L$(current_dir)/p4api/lib -L$(current_dir)/openssl-3 \
               -lp4api -lssl -lcrypto \
               -framework ApplicationServices \
               -framework Foundation \
               -framework Security

# Target to build the Go binary
build:
	CGO_CPPFLAGS="$(CGO_CPPFLAGS)" \
	CGO_LDFLAGS="$(CGO_LDFLAGS)" \
	go build
