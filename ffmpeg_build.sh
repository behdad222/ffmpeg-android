#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd ffmpeg

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    CPU='cortex-a8'
  ;;
  x86)
    CPU='i686'
  ;;
esac

make clean

./configure \
--target-os="$TARGET_OS" \
--cross-prefix="$CROSS_PREFIX" \
--arch="$NDK_ABI" \
--cpu="$CPU" \
--sysroot="$NDK_SYSROOT" \
--enable-libx264 \
--enable-pthreads \
--disable-debug \
--disable-ffserver \
--enable-version3 \
--enable-hardcoded-tables \
--disable-ffplay \
--disable-ffprobe \
--enable-yasm \
--disable-doc \
--disable-shared \
--enable-static \
--disable-everything \
--enable-runtime-cpudetect \
--enable-nonfree \
--disable-network \
--enable-avresample \
--enable-avformat \
--enable-avcodec \
--enable-indev=lavfi \
--enable-hwaccels \
--enable-ffmpeg \
--enable-zlib \
--enable-gpl \
--enable-small \
--disable-filters \
--enable-filter=trim \
--enable-filter=aresample \
--enable-filter=copy \
--enable-filter=fps \
--enable-filter=format \
--enable-filter=null \
--enable-filter=nullsrc \
--enable-filter=pad \
--enable-filter=scale \
--enable-filter=setpts \
--enable-filter=setdar \
--enable-filter=setsar \
--enable-filter=transpose \
--enable-filter=crop \
--enable-bsf=aac_adtstoasc \
--enable-bsf=h264_mp4toannexb \
--disable-encoders \
--enable-encoder=zlib \
--enable-encoder=png \
--enable-encoder=libx264 \
--enable-encoder=mpeg4 \
--enable-encoder=mjpeg \
--enable-encoder=aac \
--disable-muxers \
--enable-muxer=mp4 \
--enable-muxer=adts \
--enable-muxer=h264 \
--enable-muxer=mjpeg \
--enable-muxer=image2 \
--disable-demuxers \
--enable-demuxer=mjpeg \
--enable-demuxer=image2 \
--enable-demuxer=aac \
--enable-demuxer=m4v \
--enable-demuxer=rawvideo \
--enable-demuxer=amr \
--enable-demuxer=mp3 \
--enable-demuxer=ogg \
--enable-demuxer=flac \
--enable-demuxer=concat \
--enable-demuxer=mpegvideo \
--enable-demuxer=mpegts \
--enable-demuxer=h264 \
--enable-demuxer=h263 \
--enable-demuxer=h261 \
--enable-demuxer=mov \
--enable-demuxer=avi \
--enable-demuxer=pcm_s16le \
--disable-decoders \
--enable-decoder=zlib \
--enable-decoder=aac \
--enable-decoder=aac_fixed \
--enable-decoder=aac_latm \
--enable-decoder=amrnb \
--enable-decoder=amrwb \
--enable-decoder=mp3 \
--enable-decoder=mp2 \
--enable-decoder=flac \
--enable-decoder=vorbis \
--enable-decoder=pcm_s16le \
--enable-decoder=pcm_s16be \
--enable-decoder=pcm_s16le_planar \
--enable-decoder=opus \
--enable-decoder=h263 \
--enable-decoder=h264 \
--enable-decoder=mpeg4 \
--enable-decoder=mpeg2video \
--enable-decoder=mpegvideo \
--enable-decoder=mjpeg \
--disable-parsers \
--enable-parser=aac \
--enable-parser=aac_latm \
--enable-parser=mpegaudio \
--enable-parser=mpeg4video \
--enable-parser=flac \
--enable-parser=opus \
--enable-parser=png \
--enable-parser=h264 \
--enable-parser=mjpeg \
--enable-parser=h264 \
--enable-parser=vorbis \
--disable-protocols \
--enable-protocol=file \
--enable-protocol=concat \
--pkg-config="${2}/ffmpeg-pkg-config" \
--prefix="${2}/build/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-cxxflags="$CXX_FLAGS" \
--extra-libs="-lx264 -lm" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1

popd
