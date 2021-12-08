FROM node:16-alpine as builder
WORKDIR /home/app

COPY package.json .
RUN npm install
RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache

COPY . .
RUN chown node:node .
USER node

RUN npm run build

FROM nginx
COPY --from=builder /home/app/build /usr/share/nginx/html