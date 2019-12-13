FROM node AS build

WORKDIR /app
COPY package.json .
RUN npm install
RUN npm install -g grunt-cli

COPY . .
RUN grunt build

FROM nginx:stable

# Expost port 80
EXPOSE 80

COPY --from=build /app/target/dist /var/www
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
