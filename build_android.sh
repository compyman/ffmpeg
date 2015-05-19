#!/bin/bash
NDK=$HOME/Downloads/android-ndk-r10e
SYSROOT=$NDK/platforms/android-19/arch-arm/ 
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/
function build_one
{
./configure \
    --prefix=$PREFIX \
    --disable-shared \
    --enable-static \
    --disable-doc \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-ffserver \
    --disable-avdevice \
    --disable-doc \
    --disable-symver \
    --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
    --enable-cross-compile \
    --target-os=linux \
    --arch=arm \
    --cpu=armv7-a \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $ADDI_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG
make clean
make
make install
}

CPU=armeabi-v7a
PREFIX=$(pwd)/android/$CPU 
ADDI_CFLAGS="-marm"
build_one
