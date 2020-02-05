# Add alpine image
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN ["/bin/sh", "-c", "npm config set proxy=http://proxy.houston.hpecorp.net:8080 && npm config set https-proxy=http://proxy.houston.hpecorp.net:8080 && npm install"]
COPY . .
RUN ["/bin/sh", "-c", "npm config set proxy=http://proxy.houston.hpecorp.net:8080 && npm config set https-proxy=http://proxy.houston.hpecorp.net:8080 && npm run build"] 

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html


