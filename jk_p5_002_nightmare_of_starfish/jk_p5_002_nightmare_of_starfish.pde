// Nov 2013
// http://jiyu-kenkyu.org
// http://kow-luck.com
//
// This work is licensed under a Creative Commons 3.0 License.
// (Attribution - NonCommerical - ShareAlike)
// http://creativecommons.org/licenses/by-nc-sa/3.0/
// 
// This basically means, you are free to use it as long as you:
// 1. give http://kow-luck.com a credit
// 2. don't use it for commercial gain
// 3. share anything you create with it in the same way I have
//
// If you want to use this work as more free, or encourage me,
// please contact me via http://kow-luck.com/contact

//========================================
import processing.opengl.*;
int WIDTH = 1280;
float[] ellipseW = new float[WIDTH];
float[] ellipseH = new float[WIDTH];
float[] white = new float[WIDTH];
float[] alpha = new float[WIDTH];
float[] eWInc = new float[WIDTH];
float[] eHInc = new float[WIDTH];
float[] whiteInc = new float[WIDTH];
float[] alphaInc = new float[WIDTH];
float centY, step, ang;
float waveH, waveW;
float wHMov, wWMov;
float SIN;
//============================================
void setup() {
  size(WIDTH, 720, OPENGL);
  colorMode(500, 500);
  background(0);
  frameRate(30);
  blendMode(ADD);
  for (int i = 0; i < WIDTH; i++) {
    ellipseW[i] = random(1, 100);
    ellipseH[i] = random(1, 50);
    white[i] = random(100, 500);
    alpha[i] = random(30, 100);
    eWInc[i] = 0.3;
    eHInc[i] = 0.1;
    whiteInc[i] = 0.6;
    alphaInc[i] = 0.8;
  }
  centY = 0;
  step = 2;
  waveH = centY;
  waveW = 0.8;
  wHMov = 4;
  wWMov = 0.01;
}
//============================================
void draw() {
  background(0);
  translate(width/2, height/2);
  rotateZ(frameCount * 0.01);
  growMe();
  drawMe();
  println(frameRate);
}
//============================================
void drawMe() {
  ellipseMode(CENTER);
  pushMatrix();
  for (int j = 1; j<=5; j++) {
    rotate(radians(72));
    for (int i = 0; i < WIDTH/1.8; i+= step) {
      SIN = sin(radians(i*waveW)) * noise(radians((i*waveW)));
      noStroke();
      fill(white[i], alpha[i]);
      ellipse(i, centY + SIN * waveH, ellipseW[i], ellipseH[i]);

      white[i] += whiteInc[i];
      alpha[i] += alphaInc[i];
      ellipseW[i] += eWInc[i];
      ellipseH[i] += eHInc[i];

      if (white[i] > 500 || white[i] < 100) {
        whiteInc[i] *= -1;
      }
      if (alpha[i] >100 || alpha[i] < 30) {
        alphaInc[i] *=-1;
      }
      if (ellipseW[i] > 100 || ellipseW[i] < 1) {
        eWInc[i] *= -1;
      }
      if (ellipseH[i] > 50 || ellipseH[i] < 1) {
        eHInc[i] *= -1;
      }
    }
  }
  popMatrix();
}
//============================================
void growMe() {
  waveH += wHMov; 
  waveW += wWMov; 
  if (waveH > height || waveH <centY) {
    wHMov *=-1;
  }
  if (waveW > 1 || waveW < 0.1) {
    wWMov *= -1;
  }
}

