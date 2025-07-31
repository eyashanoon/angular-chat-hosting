# Step 1: Build Angular app using Node.js 20.19
FROM node:20.19.0-alpine as builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build -- --configuration production

# Step 2: Use Nginx to serve the Angular app
FROM nginx:alpine
COPY --from=builder /app/dist/chat-client /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
