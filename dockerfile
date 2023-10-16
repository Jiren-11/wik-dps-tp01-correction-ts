FROM node:20-alpine
COPY . /app
WORKDIR /app
RUN npm install 
RUN ["npm", "run" , "build"]

#Prod Container
FROM node:20-buster
COPY --from=0 /app/build/index.js /prod/index.js
RUN ["useradd", "-m", "-s", "/bin/sh", "node"]
WORKDIR /prod
RUN chown -R node:node /prod
USER node
EXPOSE 8080
CMD node index.js