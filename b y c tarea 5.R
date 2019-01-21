install.packages("rvest")
library('rvest')

#Inicializar la variable archivo con el nombre de mi pagina"
archivo<- 'Tarea5.html'

#Leer el archivo
webpage <- read_html(archivo)

#extrayendo contenido en la clase justificado
contenidoWebNoticia<- html_nodes(webpage,".justificado" )

#pasar info a texto
textoNoticia<- html_text(contenidoWebNoticia)

#viendo la info 
print(textoNoticia)

#los \n representan tabulaciones
#eliminar los \n, comillas puntos y comas del texto
textoNoticia <-gsub("\n","",textoNoticia)
textoNoticia <-gsub("\"","",textoNoticia)
textoNoticia <-gsub("[.]","",textoNoticia)
textoNoticia <-gsub(",","",textoNoticia)
textoNoticia <-gsub("\r","",textoNoticia)
textoNoticia <-gsub("\t","",textoNoticia)

#viendo la info 
print(textoNoticia)
#separar palabras por espacio
splitEspacioNoticia <- strsplit(textoNoticia," ")[[1]]

#pasar palabras a minusculas
splitEspacioNoticia <- tolower(splitEspacioNoticia)

#contar palabras
unlistNoticias <- unlist(splitEspacioNoticia)
tablapalabras <- table(unlistNoticias)

#pasar informacion a un data frame
dfPalabrasNoticia <- as.data.frame(tablapalabras)

#almacenar info en csv
write.csv(dfPalabrasNoticia,file="PalabrasNoticia.csv")

#almacenar info en txt
write.table(dfPalabrasNoticia, file="PalabrasNoticia.txt")


# Extrayendo los elementos que contienen las tablas
  tablaProductos <- html_nodes(webpage, "table")

#extraer elementos de la tabla
  tablaProductosExtraida <- html_table(tablaProductos[[1]])
  
  #ver el contenido de la posicion 1,2 en la tabla
  print(tablaProductosExtraida[1,2])
#Limpiar $ comas y cambios de puntos por coma
  tablaProductosExtraida$Precio <- gsub("\\$","",tablaProductosExtraida$Precio)
  tablaProductosExtraida$Precio <- gsub("[.]","",tablaProductosExtraida$Precio)
  tablaProductosExtraida$Precio <- as.numeric(gsub(",",".",tablaProductosExtraida$Precio))
  
  
# Extraccion de el contenido de las tablas usando el tag table
  Tabla1 <- html_table (tablaProductos[[1]])

# Viendo el contenido de la posición 1,2 de la tabla1
  print(Tabla1[1,2])
  
  install.packages('ggplot2')
  
  
  Graficando los productos
  library(ggplot2)
  
# Gráfico Barra
  Tabla1 %>%
    ggplot() +
    aes(x = Nombre, y = Precio) +
    geom_bar(stat="identity")
  
  # Gráfico boxplot
  tabla1 %>%
    ggplot() +
    geom_boxplot(aes(x = Producto, y = Valor)) +
    theme_bw()
  
  
  
  