# Build dependencies (macOS/Homebrew)

jp2a requires: autoconf, automake, pkg-config, jpeg-turbo, curl (Homebrew).
compile.sh points configure at Homebrew's jpeg-turbo and curl (embedding the
libcurl rpath) and applies the ac_cv_func_malloc_0_nonnull autoconf override.
