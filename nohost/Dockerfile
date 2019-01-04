FROM node:lts-slim

RUN npm i -g whistle whistle.nohost
COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD [ "-l"]

EXPOSE  8080