FROM openjdk:8-jre-alpine
ENV APP_HOME /app
EXPOSE 8080  # 暴露8080端口
COPY target/*.jar $APP_HOME/
WORKDIR $APP_HOME
ENTRYPOINT ["sh", "-c"]
CMD ["exec java $JAVA_OPTS -Dspring.profiles.active=native -jar $APP_HOME/*.jar"]