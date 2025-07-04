# testp4go
Test project for using/building p4go on different platforms

This shows how to build Go programs which use `p4go`: https://github.com/perforce/p4go

p4go programs depend on libraries:

* P4API - can be downloaded
* OpenSSL - can be downloaded for Linux but needs to be built for the Mac or Windows

# Build on Mac

## Setting up the dependency on `p4go`

In addition it depends on the github p4go library - which has now been fixed so we can do a simple:

    require "github.com/perforce/p4go"

For nicer naming (IMO) our `main.go` we import like this:

    import p4api "github.com/perforce/p4go"

## Download p4api

```
wget https://ftp.perforce.com/perforce/r25.1/bin.macosx12u/p4api-openssl3.tgz
tar zxf p4api-openssl3.tgz
ln -s p4api-2025.1.2761706 p4api
```

## Building OpenSSL on ARM Mac

```
mkdir openssl
cd openssl
VER=3.0.16
wget https://github.com/openssl/openssl/releases/download/openssl-$VER/openssl-$VER.tar.gz
tar zxf openssl-$VER.tar.gz
cd openssl-$VER
./config
    Configuring OpenSSL version 3.0.16 for target darwin64-arm64
    Using os-specific seed configuration
    Created configdata.pm
    Running configdata.pm
    Created Makefile.in
    Created Makefile
    Created include/openssl/configuration.h
    :

make
```

The above will create a couple of dylibs which we need to link against for our executable.

```
mkdir openssl-3
cp openssl/*sylib openssl-3/
export DYLD_LIBRARY_PATH=`pwd`/openssl-3
```

Then we can build:

```
make

CGO_CPPFLAGS="-I/some/path/go/src/github.com/rcowham/testp4go/p4api/include -g" \
CGO_LDFLAGS="-L/some/path/go/src/github.com/rcowham/testp4go/p4api/lib -L/some/path/go/src/github.com/rcowham/testp4go/openssl-3 -lp4api -lssl -lcrypto -framework ApplicationServices -framework Foundation -framework Security" \
go build
# github.com/rcowham/testp4go
```

And to run it:

```
$ ./testp4go
Connected to P4 server: perforce:1666
Info: map[ServerID:myserver caseHandling:sensitive ...]
```
