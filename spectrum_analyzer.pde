//Spectrum analyzer sketch

import processing.serial.*;

Serial myPort;
String sendout = "VRSN";
int[] spectrum;

void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
  background(255);
  size(580,300);
  smooth();
  frameRate(3);
}

void draw() {
  while (myPort.available() > 0) {
    fill(255);
    rect(0,0,width,height);
    myPort.write("SSCN\n");
    String inBuffer = myPort.readString();   
    if (inBuffer != null) {
      println(inBuffer);
      spectrum = int(split(inBuffer,':'));
      println(spectrum);
      for(int i = 0; i<spectrum.length; i++){
        fill(0);
        if(i>=1 & i<58){
          stroke(81,95,243);
          line(i*10,height-spectrum[i],(i+1)*10,height-spectrum[i+1]);
        }
        fill(218,120,4);
        noStroke();
        ellipse(i*10,(height-spectrum[i]),4,4);
      }
    }
  }
}

void mousePressed(){
      myPort.write("SSCN\n");
}
