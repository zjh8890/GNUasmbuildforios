#useage: 
#sys_arch=arm for armv7 build
#sys_arch=aarch64 for arm64 build

sys_arch=aarch64

ifeq ($(sys_arch), aarch64)
	arch = arm64
else
	arch = armv7
endif

SRCPATH=./
prefix=./build/${arch}
libdir=${prefix}
SYS=MACOSX
CC=xcrun -sdk iphoneos clang -Wno-error=unused-command-line-argument-hard-error-in-future -arch ${arch}
CFLAGS=-Wno-maybe-uninitialized -Wshadow -O3 -ffast-math  -Wall -I. -I$(SRCPATH) -arch ${arch} -miphoneos-version-min=6.0 -std=gnu99 -fPIC -fomit-frame-pointer -fno-tree-vectorize
COMPILER=GNU
COMPILER_STYLE=GNU
DEPMM=-MM -g0
DEPMT=-MT
LD=xcrun -sdk iphoneos clang -arch ${arch} -o 
LDFLAGS= -arch arm64 -miphoneos-version-min=6.0 -lm
LIBEXAMPLE=libexample.a
AR=ar rc 
RANLIB=ranlib
STRIP=strip
INSTALL=install
AS=tools/gas-preprocessor.pl -arch ${sys_arch} -- xcrun -sdk iphoneos clang -arch ${arch}
ASFLAGS= -I. -I$(SRCPATH) -c
install: install_static