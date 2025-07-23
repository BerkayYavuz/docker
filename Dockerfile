FROM node:20-alpine

#inspect ile bilgi almamızda kolaylık sağlar
LABEL maintaner="berkay"
LABEL version="1.0"
LABEL description="basit node uygulaması"

#Build-time'da kullanırız APP-DIR oluşturduk
ARG APP_DIR=/usr/src/

#Run-time'da kullanılır prod moda geçtiğinden geliştirme paketlerini yüklemez
ENV NODE_ENV=production

#ARG sayesinde oluşturuğumuz APP_DIR'i burada kullandık
WORKDIR ${APP_DIR}

COPY package*.json ./
RUN npm install --only=production 

COPY . .
EXPOSE 3000

#Sağlık kontrolü yani çalışma kontrolü yapıldı
HEALTHCHECK CMD wget --quiet --tries=1 --spider http://localhost:3000 || exit 1

#Güvenlik için root değil node olarak çalışır yoksa bir konteynerden tüm makineye ulaşılabilir
USER node

#Değiştirilmicek komut
ENTRYPOINT ["node"]

#Değiştirilebilen komut
CMD ["app.js"] 

#Kalıcı veri için volume tanımladık
VOLUME ["/usr/src/app/logs"]

#Durdurma sinyali Ctrl+C gibi bir sinyal
STOPSIGNAL SIGINT
