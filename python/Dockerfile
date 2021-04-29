ARG VERSION=2.1.0
FROM developmentseed/geolambda:${VERSION}

ARG PYVERSION=3.8.8

# install Python
ENV \
    PYENV_ROOT=/root/.pyenv \
    PATH=/root/.pyenv/shims:/root/.pyenv/bin:$PATH

RUN \
    mkdir openssl; \
    wget -qO- https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz \
        | tar xvz -C openssl --strip-components=1; cd openssl; \
    ./config shared --prefix=${PREFIX}/openssl --openssldir=${PREFIX}/openssl; \
    make depend; make install; cd ..; rm -rf openssl

RUN \
    curl https://pyenv.run | bash; \
    CONFIGURE_OPTS="--with-openssl=${PREFIX}/openssl --enable-loadable-sqlite-extensions" \
        LD_RUN_PATH="${PREFIX}/openssl/lib" \
        pyenv install ${PYVERSION}; \
    pyenv global ${PYVERSION}; \
    pip install --upgrade pip

COPY requirements*.txt ./

RUN \
    pip install -r requirements-pre.txt; \
    pip install -r requirements.txt

COPY bin/* /usr/local/bin/
