FROM node:14.18.2-alpine

RUN apk --update add tzdata \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && apk del tzdata

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package.json /usr/src/app/package.json
COPY pnpm-lock.yaml /usr/src/app/pnpm-lock.yaml

# RUN yarn --registry=https://mirrors.cloud.tencent.com/npm/ && yarn
RUN npm install -g pnpm
RUN pnpm install

COPY . .

ENV NODE_ENV production

RUN yarn build

EXPOSE 5000

CMD npm start
