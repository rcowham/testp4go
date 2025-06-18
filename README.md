# testp4go
Test project for using/building p4go on different platforms

This shows how to build Go programs which use `p4go`: https://github.com/perforce/p4go

p4go programs depend on libraries:

* P4API - can be downloaded
* OpenSSL - can be downloaded for Linux but needs to be built for the Mac or Windows

In addition it depends on the github p4go library, but as of the time of writing this module declares itself in a 
way which is not compatible with a simple `require "github.com/perforce/p4go"

So instead you will need to have a local clone/copy of `p4go` and refer to it.

Assuming we are in the directory of this project (`~/go/src/github.com/rcowham/testp4go`), then set this up:

```
cd ../..
mkdir -p perforce
cd perforce
git clone https://github.com/perforce/p4go
cd ../rcowham/testp4go
```

Note the `go.mod` for this project:

    replace github.com/perforce/p4go/p4 => ../../perforce/p4go

The in our `main.go`:

    import p4api "github.com/perforce/p4go/p4"

# Build on Mac

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

Then we can execute our test program (which will work if `p4 info` works - as in depends on your p4 environment variables defined!)

    ./testp4go
