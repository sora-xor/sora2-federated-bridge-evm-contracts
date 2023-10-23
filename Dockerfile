FROM node:20-bookworm AS builder

WORKDIR bridge-relayer

COPY ./contracts ./contracts
COPY ./scripts ./scripts
COPY ./tasks ./tasks
COPY env.template .env
COPY hardhat.config.ts hardhat.config.ts
COPY package.json package.json
COPY truffle-config.js truffle-config.js
COPY tsconfig.json tsconfig.json
COPY yarn.lock yarn.lock

# issue with node-gyp, see https://github.com/npm/cli/issues/6842
RUN yarn global add node-gyp
RUN yarn install

RUN npm run compile

FROM builder AS generate_abi

RUN apt-get update \
    && apt-get install -y jq \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["bash", "./scripts/update_abi.sh"]
