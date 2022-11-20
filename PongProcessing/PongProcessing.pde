Pelota pelota; //Define a la pelota como a un objeto global
Paleta paletaIzquierda;//define la paleta izquierda
Paleta paletaDerecha; //define la paleta derecha
int puntuacionIzquierda = 0; //Variables para definir los
int puntuacionDerecha = 0;   //dos marcadores

void setup(){
  size(800,600);
  pelota = new Pelota(width/2, height/2, 50);/*crea una nueva pelota al centro
                                               de la ventana */
  pelota.velocidadX = 5; //Dando a la pelota la velocidad en el eje x
  pelota.velocidadY = random(-3,3); //Dando a la pelota la velocidad en el eje y
                                    //al  azar entre -3 y 3
  paletaIzquierda = new Paleta(15, height/2, 30,200);
  //Se crea la paleta izquierda y derecha con sus respectivos parametros
  paletaDerecha = new Paleta(width-15, height/2,30,200);
}

void draw(){
  background(0); //limpia el lienzo
  pelota.mueve(); //Calcula la nueva posicion de la pelota
  pelota.despliega(); //Dibuja la pelota al centro de la ventana
  
  if (pelota.derecha() > width){
      puntuacionIzquierda = puntuacionIzquierda + 1; //Si la pelota toca el lado derecho el jugador de la izquierda gana un punto
      pelota.x = width/2;// Resetea la pelota al centro de la pantalla
      pelota.y = height/2;
      pelota.velocidadX = -pelota.velocidadX;/*Cambia el sentido de la velocidad
                                             si se toca el marco derecho de la 
                                             ventana*/
  }
  if (pelota.izquierda() < 0){
      puntuacionDerecha = puntuacionDerecha + 1;//Si la pelota toca el lado iquierdo el jugador de la derecha gana un punto
      pelota.x = width/2;// Resetea la pelota al centro de la pantalla
      pelota.y = height/2;
      pelota.velocidadX = -pelota.velocidadX;/*Cambia el sentido de la velocidad
                                             si se toca el marco izquierdo de la 
                                             ventana*/
  }
  if (pelota.inferior() > height){
      pelota.velocidadY = -pelota.velocidadY;/*Cambia el sentido de la velocidad
                                             si se toca la parte inferior 
                                             ventana*/
  }
  if (pelota.superior() < 0){
      pelota.velocidadY = -pelota.velocidadY;/*Cambia el sentido de la velocidad
                                             si se toca la parte superior 
                                             ventana*/
  }
  
  paletaIzquierda.mueve();// metodo para mover la paleta izquierda
  paletaIzquierda.despliega(); //metodo para dibujar la paleta izquierda
  paletaDerecha.mueve(); // metodo para mover la paleta derecha
  paletaDerecha.despliega(); //metodo para dibujar la paleta derecha
  
  /*Las instrucciones siguientes delimitan que las paleta no salgan de la ventana*/
  if (paletaIzquierda.inferior() > height){         //Para mantener la paleta dentro de la ventana si la parte inferior de la paleta es mayor al valor 
    paletaIzquierda.y = height-paletaIzquierda.h/2; //maximo de resolucion. Asignamos a su posicion.y la altura de la ventana menos la mitad del tamaño de la barra
  }
  if (paletaIzquierda.superior() < 0){ //Para mantener la paleta dentro de la ventana si la parte superior de la paleta es menor a 0
    paletaIzquierda.y = paletaIzquierda.h/2; //Asignamos a su posicion.y la mitad del tamaño de la barra
  }
  if (paletaDerecha.inferior() > height){ //Para mantener la paleta dentro de la ventana si la parte inferior de la paleta es mayor al valor 
    paletaDerecha.y = height-paletaDerecha.h/2; //maximo de resolucion. Asignamos a su posicion.y la altura de la ventana menos la mitad del tamaño de la barra
  }
  if (paletaDerecha.superior() < 0){ //Para mantener la paleta dentro de la ventana si la parte superior de la paleta es menor a 0
    paletaDerecha.y = paletaDerecha.h/2; //Asignamos a su posicion.y la mitad del tamaño de la barra
  }
  
  /*Si la pelota pasa detrás de la paleta
    Y si la pelota está en el area de la paleta (entre la parte superior e inferior de la paleta
    rebota a la pelota en la otra dirección
  */
  if( pelota.izquierda() < paletaIzquierda.derecha() && pelota.y > paletaIzquierda.superior() && pelota.y < paletaIzquierda.inferior()){
     pelota.velocidadX = -pelota.velocidadX;
     pelota.velocidadY = map(pelota.y - paletaIzquierda.y, - paletaIzquierda.h/2, paletaIzquierda.h/2, -10, 10);
  } 
  
  if (pelota.derecha() > paletaDerecha.izquierda() && pelota.y > paletaDerecha.superior() && pelota.y < paletaDerecha.inferior()) {
     pelota.velocidadX = -pelota.velocidadX;
     pelota.velocidadY = map(pelota.y - paletaDerecha.y, -paletaDerecha.h/2, paletaDerecha.h/2,-10,10);
  } 

  textSize(40);
  textAlign(CENTER);
  text(puntuacionDerecha, width/2+30,30); //Puntuacion del lado derecho
  text(puntuacionIzquierda, width/2-30,30); //Puntuacion del lado izquierdo
  
}// fin draw()

/* Detecta cuando se oprime un tecla y comienza a agregar velocidad
   a las paletas segun corresponda*/
   void keyPressed(){
     if(keyCode == UP) {
       paletaDerecha.velocidadY = -3;
     }
     if(keyCode == DOWN){
       paletaDerecha.velocidadY = 3;
     }
     if(key == 'a'){
       paletaIzquierda.velocidadY = -3;
     }
     if(key == 'z'){
       paletaIzquierda.velocidadY = 3;
     }
   }
/* Detecta cuando se deja de oprimir la tecla y elimina la velocidad en la paleta */
   void keyReleased(){
     if(keyCode == UP) {
       paletaDerecha.velocidadY = 0;
     }
     if(keyCode == DOWN){
       paletaDerecha.velocidadY = 0;
     }
     if(key == 'a'){
       paletaIzquierda.velocidadY = 0;
     }
     if(key == 'z'){
       paletaIzquierda.velocidadY = 0;
     }
   }

class Pelota {
  float x;// posicion en X de la pelota
  float y;// posicion en Y de la pelota
  float velocidadX;//Velocidad en X de la pelota
  float velocidadY;//Velocidad en Y de la pelota
  float diametro;// Diametro de la pelota
  color c; //Variable para el color de la variable
  
  //Método constructor
  Pelota(float tempX, float tempY, float tempDiametro){
         x = tempX;// pasa el parametro temporal de x para la ubicacion en x
         y = tempY;// pasa el parametro temporal de y para la ubicacion en y
         diametro = tempDiametro;// pasamos el parametro temporal a la variable 
         velocidadX = 0;// Inicializamos la velocidad de X en 0
         velocidadY = 0;// Inicializamos la velocidad de Y en 0
         c = (225);// Damos el color
         
    }//Fin del constructor
    
  void mueve(){// Metodo para simular que la pelota se mueve
      //Añade velocidad a la posicion
      y = y + velocidadY;
      x = x + velocidadX;
  }
  
  void despliega(){// metodo para dibujar la pelota
      fill(c); //estipula el color para dibujar
      ellipse(x,y,diametro,diametro); //dibuja un circulo
      /*se emplea dos vececes la variable diametro porque usaremos
      el mismo valor en y y en x para crear un circulo
      */
  }
  
  //funciones para regresar el valor del borde de la pelota
  float izquierda(){
     return x-diametro/2; /*Para calcular la posicion del borde 
                            de la pelota de la parte izquierda
                          */
  }
  
  float derecha(){
    return x+diametro/2;/*Para calcular la posicion del borde 
                            de la pelota de la parte derecha
                          */
  }
  
  float superior(){
     return y-diametro/2;/*Para calcular la posicion del borde 
                            de la pelota de la parte superior
                          */
  }
  
  float inferior(){
     return y+diametro/2;/*Para calcular la posicion del borde 
                            de la pelota de la parte inferior
                          */
  }
  
}//Fin de clase Pelota

class Paleta{
    
  float x; // Ubicacion horizontal de la paleta
  float y; // Ubicacion vertical de la paleta
  float w; // ancho de la paleta
  float h; // largo de la paleta
  float velocidadY; //velocidad vertical
  float velocidadX; //velocidad horizontal
  color c; // color de la paleta
  
  //Constructor
  Paleta(float tempX, float tempY, float tempW, float tempH){
    x = tempX; //Aqui se pasan las variables de la nueva barra
    y = tempY; 
    w = tempW; 
    h = tempH; 
    velocidadY = 0; 
    velocidadX = 0; 
    c = (255); //Se asigna un color
  }
  
  void mueve(){ //Metodo para mover las paletas
    //a la posicion x and y le agregamos sus respectivos valores
    y += velocidadY;
    x += velocidadX;
  }
  
  void despliega(){ //Dibuja la paleta en pantalla
    fill(c); //color
    rect(x-w/2, y-h/2, w,h); //indicamos que sera un rectangulo y cuanto valdra sus lados y su posicion
  }
  
  //funciones auxiliares
  //que regresa el valor del perimetro del rectangulo
  float izquierda(){
    return x-w/2;
  }
  float derecha(){
    return x+w/2;
  }
  float superior(){
    return y-h/2;
  }
  float inferior(){
    return y+h/2;
  }
  
}//clase Paleta
