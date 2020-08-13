FROM rust:1.45.2-alpine3.12

ENV RUSTFLAGS="-C target-feature=-crt-static"

RUN apk add --no-cache bash musl-dev libffi-dev
RUN apk add --no-cache --virtual .build-deps git \
                                             build-base \
                                             zlib-dev \
                                             openssl-dev \
                                             bzip2-dev \
                                             readline-dev \
                                             sqlite-dev

ARG PYENV_HOME=/root/.pyenv
RUN git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_HOME && \
    rm -rfv $PYENV_HOME/.git

ENV PATH $PYENV_HOME/shims:$PYENV_HOME/bin:$PATH
RUN pyenv install 3.6.11
RUN pyenv install 3.7.8
RUN pyenv install 3.8.5
RUN pyenv global 3.6.11 3.7.8 3.8.5
RUN pip3 install --no-cache-dir --upgrade pip setuptools
RUN rm -rf ~/.cache/pip

RUN apk del .build-deps

