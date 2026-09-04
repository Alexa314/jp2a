#!/bin/bash
set -e
cd "$(dirname "$0")"
JPEG_PREFIX=$(brew --prefix jpeg-turbo 2>/dev/null || echo /usr/local)
CURL_PREFIX=$(brew --prefix curl 2>/dev/null || echo /usr)
# ac_cv_func_malloc_0_nonnull: autoconf's AC_FUNC_MALLOC wrongly flags the
# system malloc as broken and links a nonexistent rpl_malloc.
# curl-config + rpath: jp2a's URL support links Homebrew's @rpath libcurl; point
# configure at it and embed the rpath so dyld finds libcurl.4.dylib at runtime.
ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes \
    LDFLAGS="-Wl,-rpath,$CURL_PREFIX/lib" \
    ./configure --with-jpeg-prefix="$JPEG_PREFIX" --enable-curl \
        --with-curl-config="$CURL_PREFIX/bin/curl-config"
make -j2
cp src/jp2a executable
