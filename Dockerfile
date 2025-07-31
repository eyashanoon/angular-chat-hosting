# Stage 1: Build the Angular app
FROM node:22-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/chat-client /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
