Zombo [] zombies;
int px = 240;
int py = 240;
int attackCD = 10;
boolean shot = false;

boolean[] keys = {false, false, false, false}; // W A S D
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
 //declare bacteria variables here  
 void setup() {  
   size(480, 480);
   //initialize bacteria variables here  
   zombies = new Zombo[20];
   for (int i = 0; i < 20; i ++) {
     zombies[i] = new Zombo();
   }
 }
 
 void draw() {  
   background(240, 250, 230);
   //move and show the bacteria  
   for (int i = 0; i < 20; i++) {
     zombies[i].show();
     zombies[i].walkie();
   }
   
   // projectiles
   for (int i = 0; i < projectiles.size(); i++) {
     Projectile proj = projectiles.get(i);
     proj.update();
       if (proj.life == 0) {
         projectiles.remove(i);
         i -= 1;
       }
   }
   
   if (attackCD == 0) {
     shot = false;
     attackCD = 10;
   } else if(shot == true) {
     attackCD -= 1;
   }
   
   if (shot == false) {
     shot = true;
     float dir = atan((float)(mouseY-py)/((float)(mouseX-px)));
      if(mouseX < px) {
        dir+= PI;
      }
      projectiles.add(new Projectile(px, py, 30, 5, 10, dir)); // x y l dunno dunno dir
   }
   
   
   
   // player movement
   if(keys[0]) {
     py -= 8;
   }
   if(keys[1]) {
     px -= 8;
   }
   if(keys[2]) {
     py += 8;
   }
   if(keys[3]) {
     px += 8;
   }
   
   
   // player collision
   for (int i = 0; i < zombies.length; i++) {
      if ((px>=zombies[i].x-6 && px<=zombies[i].x+6) && (py>=zombies[i].y-6 && py<=zombies[i].y+6)) {
        fill(255, 100, 100);
        rect(px-8, py-8, 16, 16);
        zombies[i] = new Zombo();
      }
   }
   
   //player draw
   stroke(0);
   fill(150, 170, 200);
   ellipse(px, py, 10, 10);
   
   
   
 }
 
 class Zombo {
   //lots of java!
   int x, y, type;
   Zombo() {
     x = (int)(Math.random()*480);
     y = (int)(Math.random()*480);
     type = (int)(Math.random()*3);
   }
   void show() {
     stroke(0);
     if (type == 0) {
       fill(220, 255, 200);
     } else if (type == 1) {
       fill(70, 180, 130);
     } else {
       fill (150,90, 50);
     }
     ellipse(x, y, 10, 10);
   }
   void walkie() {
     if (px > x) {
       x += (float)((int)(Math.random()*5)-1)*(type+3)/3;
     } else {
       x += (float)((int)(Math.random()*5)-3)*(type+3)/3;
     }
     if (py > y) {
       y += (float)((int)(Math.random()*5)-1)*(type+3)/3;
     } else {
       y += (float)((int)(Math.random()*5)-3)*(type+3)/3;
     }
   }
   
   
   
   
   
 }    
 
void keyPressed() {
  if (keyCode == 87) { // w
    keys[0] = true;
  }
  if (keyCode == 65) { // a
    keys[1] = true;
  }
  if (keyCode == 83) { // s
    keys[2] = true;
  }
  if (keyCode == 68) { // d
    keys[3] = true;
  }
}
void keyReleased() {
  if (keyCode == 87) { // w
    keys[0] = false;
  }
  if (keyCode == 65) { // a
    keys[1] = false;
  }
  if (keyCode == 83) { // s
    keys[2] = false;
  }
  if (keyCode == 68) { // d
    keys[3] = false;
  }
}

class Projectile {
  float xpos, ypos, life, size, speed, direction;
  boolean sploded = false;
  Projectile (float x, float y, float l, float s, float v, float dir) {
    xpos = x;
    ypos = y;
    life = l;
    size = s;
    speed = v;
    direction = dir;
  }
 
  void update() {
    if (sploded == false) {
      xpos += cos(direction)*speed;
      ypos += sin(direction)*speed;
    }
   
    noStroke();
    fill(0);
    if (sploded == false) {
      rect(xpos-size/2, ypos-size/2, size, size);
    } else {
      fill(255, 100, 100);
      rect(xpos-size/2, ypos-size/2, size, size);
    }
   
    life -= 1;
    
    for (int i = 0; i < zombies.length; i++) {
      if ((xpos>=zombies[i].x-6 && xpos<=zombies[i].x+6) && (ypos>=zombies[i].y-6 && ypos<=zombies[i].y+6) && sploded==false) {
        life = 5;
        sploded = true;
        size = 12;
        zombies[i] = new Zombo();
      }
    }
  }
}
