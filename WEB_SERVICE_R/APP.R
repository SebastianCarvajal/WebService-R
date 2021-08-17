
# Web Service Rest

#ejecutar las siguientes dos lineas solo una vez
install.packages("plumber")
install.packages("class")

#Cambie el directorio de trabajo a la carpeta del proyecto
  #puede consultar su directorio actual con:
  getwd()  
  #para cambiar el directorio utilizar setwd, por ejemplo:
  setwd("C:/1. Universidad/Aplicaciones Distribuidas 2.0/WEB_SERVICE_R")  

#Con las siguientes lineas se inicia el servicio
r <- plumb("Web_Service1.R")
r$run(port=8000)
