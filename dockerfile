# etapa 1: compilar la app ionic
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json .
RUN npm ci

COPY . .
RUN npm run build

# etapa 2: publicar los archivos web de angular
FROM nginx:alpine
COPY --from=build /app/www /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]