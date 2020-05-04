FROM node:alpine as builder
WORKDIR '/app'
COPY package.json . 
RUN npm install
COPY . .
#build is a folder and output of that will be build folder which will be created in working dir. path of this will be /app/build << folder we 
#will copy over after
RUN npm run build 

#having write FROM means that it is terminating each successive block
nginx:stable-alpine
#copy from diffrent phase that we just was working on and dolder is /app/build and folder we want to copy to in NGINX is /usr/share/nginx/html
#which will automatically serve up when the server starts up
COPY --from=builder /app/build /usr/share/nginx/html

#we don't specifically have command for starting nginx.
