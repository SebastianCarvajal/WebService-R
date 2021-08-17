#importar librerias######################
library(plumber)
library(class)

#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}

normalizar <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}
iris_norm <- as.data.frame(lapply(iris[1:4], normalizar))

set.seed(1234)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(2/3, 1/3))

iris.entrenamiento <- iris[ind==1, 1:4]
iris.test <- iris[ind==2, 1:4]

Entrenamiento.Etiquetas <- iris[ind==1,5]
Test.Etiquetas <- iris[ind==2, 5]



  
#Get de Prediccion ##########################################


#* @param sl The parameter Sepal_Length
#* @param sw The parameter Sepal_Width
#* @param pl The parameter Petal_Length
#* @param pw The parameter Peal_Width
#* @get /prediccion
function(sl,sw,pl,pw){
  predecirFlor = data.frame(Sepal.Length = c(sl), Sepal.Width = c(sw), Petal.Length = c(pl), Petal.Width = c(pw))
  iris_pred <- knn(train = iris.entrenamiento, test = predecirFlor, cl = Entrenamiento.Etiquetas, k=3)
  dataRespuesta = data.frame(predecirFlor, iris_pred)
  names(dataRespuesta) <- c("Sepal_Length", "Sepal_Width", "Petal_Length", "Petal_Width", "Specie_Predict")
  dataRespuesta
}


#Get que devuelve el conjunto de datos Completo ##########################################


#* @get /echo
function(){
  data_iris = data.frame(iris)
  names(data_iris) <- c("Sepal_Length", "Sepal_Width", "Petal_Length", "Petal_Width", "Species")
  data_iris
}


#Get que devuelve una imagen de Longitud de anchura y altura de sepalos segun especies de iris########################

#* Plot a 
#* @png
#* @get /image_sepalo
function(){
  iris.color<-c("red","green","blue")[iris$Species]
  
  plot(iris[,1],iris[,2],col=iris.color,main="Longitud y anchura
  de Sépalo según especies de Iris",xlab="Longitud de Sépalo",
       ylab="Anchura de Sépalo")
  
  legend(7.2,2.4,c("Setosa","Versicolor","Virginica"),pch=1,
         col=c("red","green","blue"))
}

#Get que devuelve una imagen de Longitud de anchura y altura de petalos segun especies de iris########################

#* Plot a histogram
#* @png
#* @get /image_petalo
function(){
  iris.color<-c("red","green","blue")[iris$Species]
  
  plot(iris[,3],iris[,4],col=iris.color,main="Longitud y anchura
  de pétalo según especies de Iris",xlab="Longitud de pétalo",
       ylab="Anchura de pétalo")
  
  legend(5.7,0.5,c("Setosa","Versicolor","Virginica"),pch=1,
         col=c("red","green","blue"))
}
