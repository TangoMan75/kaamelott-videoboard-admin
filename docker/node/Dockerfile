#/**
# * node-alpine.dockerfile
# *
# * @version  0.1.0
# * @author   "Matthias Morin" <mat@tangoman.io>
# * @license  MIT
# */

# node15.1.0
FROM node:alpine

EXPOSE 3000

WORKDIR /www

COPY ./ ./

RUN set -eux; \
    yarn install

CMD ["yarn", "start"]
