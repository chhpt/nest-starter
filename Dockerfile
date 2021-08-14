FROM node:14.17.5-alpine

RUN apk --update add tzdata \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && apk del tzdata

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package.json /usr/src/app/package.json
COPY yarn.lock /usr/src/app/yarn.lock

# RUN yarn --registry=https://mirrors.cloud.tencent.com/npm/ && yarn
RUN yarn

COPY . .

ENV NODE_ENV production

RUN yarn build

EXPOSE 5000

CMD npm start
