FROM node:latest AS build
WORKDIR /app
COPY . .
RUN npm -version
RUN npm update
RUN npm -version
RUN npm install
RUN npm run build
# Serve Application using Nginx Server
FROM nginx:alpine
COPY --from=build /app/dist/angualr-app/ /usr/share/nginx/html
EXPOSE 4200
