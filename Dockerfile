FROM --platform=$BUILDPLATFORM node:17.9.1 as build

ARG CYBERCHEF_VERSION="v10.5.2" # set to desired release tag
ARG BUILD_TYPE="release" # use 'release' or 'git' to build from source

USER node
WORKDIR /app

RUN \
    set -xe; \
    if [ "${BUILD_TYPE}" = "git" ]; then \
        git clone -b "${CYBERCHEF_VERSION}" --depth=1 https://github.com/gchq/CyberChef.git .; \
        npm config set cal null; \
        npm install && npm rebuild node-sass; \
        export NODE_OPTIONS="--max-old-space-size=2048"; \
        npx grunt prod; \
    else \
        curl -L -o cyberchef.zip \
            https://github.com/gchq/CyberChef/releases/download/${CYBERCHEF_VERSION}/CyberChef_${CYBERCHEF_VERSION}.zip; \
        mkdir build && mkdir build/prod; \
        unzip cyberchef.zip -d build/prod; \
        mv "build/prod/CyberChef_${CYBERCHEF_VERSION}.html" build/prod/index.html; \
    fi

FROM nginxinc/nginx-unprivileged:1.25.3-alpine-slim

COPY --from=build --chown=0:0 /app/build/prod /usr/share/nginx/html

EXPOSE 8080
