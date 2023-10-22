FROM ubuntu:kinetic

# This is only needed because the current ubuntu releases are no longer supported
# Likely won't need this after this PR is merged: https://github.com/scylladb/seastar/pull/1630
RUN sed -i -r 's/([a-z]{2}.)?archive.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list \
    && sed -i -r 's/security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

RUN apt -y update \
    && apt -y install build-essential \
    && apt -y install gcc-12 g++-12 gcc-11 g++-11 pandoc \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 12 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 12 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 11 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 11 \
    && apt -y install clang-15 clang-14 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 15 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 15 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 14 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-14 14
COPY seastar/install-dependencies.sh /tmp/
RUN bash /tmp/install-dependencies.sh

# Project dependencies:
RUN apt -y install ninja-build clang

CMD /bin/bash
