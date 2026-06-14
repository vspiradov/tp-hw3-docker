FROM node:20-alpine
WORKDIR /app
COPY package.json .
RUN npm install
COPY report.js .
ENTRYPOINT ["node", "report.js"]