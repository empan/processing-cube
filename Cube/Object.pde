void drawObject(){
  pushMatrix();
    translate(400,300,0);
    rotateX(x);
    rotateY(y);
    rotateZ(z);
    background(255);
    fill(255,228,225);
    box(100);
    x += .01;
    y += .01;
    z += .01;
  popMatrix(); 
}
