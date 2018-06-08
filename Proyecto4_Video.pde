int pantalla=0;
PImage img;

//texto
color ELLIPSE_COLOR = color(0);
color LINE_COLOR = color(0, 125);
color PGRAPHICS_COLOR = color(0); 
int LINE_LENGTH = 25;
boolean reverseDrawing = false;

PGraphics pg;
PFont font;
ArrayList<OneChr> chrs = new ArrayList<OneChr>();

//pantalla2
int count = 5; 
ArrayList<Liner> liners = new ArrayList<Liner>(); 
float gridSize = 128; 
float lineSpeed = 450; 

import processing.video.*;

Movie movie;

void setup(){
  size(640,360);
  background(0); 
  smooth();
  
  colorMode(RGB);
  
  movie= new Movie(this, "consigo.mp4");
  movie.loop();
  
  img= loadImage("instrucciones.png");
  
  //texto
  pg = createGraphics(width, height, JAVA2D);
  pg.beginDraw();
  pg.textSize(150);    //tamaño palabra 
  pg.textAlign(CENTER, CENTER);
  pg.fill(PGRAPHICS_COLOR);
  pg.text("Tintura", pg.width/2, pg.height/3); 
  pg.endDraw();
  
  
  //lineas
  for (int i = 0; i<count; i++) {
    liners.add(new Liner((int)random(width/gridSize), (int)random(height/gridSize), 90 * round(random(4))));
  }
  strokeWeight(10);
}

void movieEvent(Movie movie) {
  movie.read();  
}

void draw(){
  
  switch(pantalla){
    /********** INICIO ********/
    case 0:
      background(0);
      fill(255);
      stroke(0);
      textAlign(CENTER, CENTER);
 
      if(chrs.size() < 2000){
        for (int i=0; i<60; i++) {
          float x = random(width);
          float y = random(height);
          color c = pg.get( int(x), int(y) );
          if ( c == PGRAPHICS_COLOR ) {
            chrs.add( new OneChr(x,y,1) );      
          }
        }
      }
      for( OneChr oc: chrs){
        oc.updateMe();
      }
      
      textSize(18);
      text("Presiona c para continuar",510,310);
  
      if(keyPressed){
        if( key == 'c' || key == 'C'){
          pantalla=1;
        }
      }
    
    break;
    
    
    /************ INSTRUCCIONES ** *******/
    case 1:
        noStroke();
        fill(0, 30);
        rect(-1, -1, width + 1, height + 1);

        for (Liner l : liners) {
          l.update();
          l.draw();
        }
        
        image(img,0,0);
        if(keyPressed){
          if( key == 's' || key == 'S'){
            pantalla=2;
            }
      }
      
    break;
    /************** VIDEO ******************/
    case 2:
          image(movie, 0,0,width,height);
  
          //tint(255,mouseX,mouseY);
          loadPixels();
          
          movie.loadPixels();
          
          tint(map(mouseX,0,width,0,255),map(mouseY,0,height,0,255),255);
  
          if(mouseX>50 && mouseX<600){      //rojos
            tint(255,mouseX,mouseY);
          }
  
          if(mouseY>100 && mouseY<360){      //verdes
              tint(mouseX,255,mouseY);
          }
  
          if(mouseX>610){        //azules
              tint(0,0, 255);
          }
  
         /* if(mouseX==320 && mouseY == 180){        //original
              noTint();
          }*/
  
          movie.updatePixels();
          break;
   }

}

//captura de video
void mousePressed(){
  movie.stop();
  saveFrame();
  movie.play();
}