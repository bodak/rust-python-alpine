FROM rust:1.64.0-alpine3.16

ENV RUSTFLAGS="-C target-feature=-crt-static"

RUN apk add --no-cache bash musl-dev libffi-dev make sqlite-dev
RUN apk add --no-cache --virtual .build-deps git \
                                             build-base \
                                             zlib-dev \
                                             openssl-dev \
                                             bzip2-dev \
                                             readline-dev

ARG PYENV_HOME=/root/.pyenv
RUN git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_HOME && \
    rm -rfv $PYENV_HOME/.git

ENV PATH $PYENV_HOME/shims:$PYENV_HOME/bin:$PATH

# https://bugs.python.org/issue45700
RUN env CFLAGS=-O2 pyenv install 3.6.15

RUN pyenv install 3.7.14
RUN pyenv install 3.8.9
RUN pyenv install 3.9.13
RUN pyenv install 3.10.7

RUN pyenv global 3.6.15 3.7.14 3.8.9 3.9.13 3.10.7
RUN pip3 install --no-cache-dir --upgrade pip setuptools
RUN rm -rf ~/.cache/pip

RUN apk del .build-deps
