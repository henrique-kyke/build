#!/bin/sh
cd /opt/java/src/codecontrol/codecontrol
mvn clean package

catalina.sh stop

cd $CATALINA_HOME

echo "[INFO] Instalando nova versão"

cd $CATALINA_HOME/webapps

z=ls | grep codecontrol
if [ ! z = "" ]; then
  rm -Rf $CATALINA_HOME/webapps/codecontrol
  #rm $CATALINA_HOME/webapps/codecontrol.war
fi

cd $CATALINA_HOME/work

z=ls 

if [ ! z = "" ]; then
  rm -Rf $CATALINA_HOME/work/Catalina
  echo "[INFO] Pastas temporárias removidas"
fi

cp -R /opt/java/src/codecontrol/codecontrol/codecontrol-web/target/codecontrol $CATALINA_HOME/webapps/


case "$1" in
  clean)
    echo "[INFO] Limpando logs"
    cd $CATALINA_HOME/logs
    rm *.out
    rm *.log
    rm *.txt    
    sleep 1
    ;;
  start)
    echo "[INFO] Iniciando Tomcat"
    catalina.sh start
    sleep 1       
    ;;
  debug)
    echo "[INFO] Iniciando Tomcat em modo DEBUG"
    catalina.sh jpda start
    sleep 1
    ;;
  *) echo "usage{clean| }{start|debug}"
esac

case "$2" in
  start)
    echo "[INFO] Iniciando Tomcat"
    catalina.sh start
    sleep 1       
    ;;
  debug)
    echo "[INFO] Iniciando Tomcat em modo DEBUG"
    catalina.sh jpda start
    sleep 1
    ;;
esac
