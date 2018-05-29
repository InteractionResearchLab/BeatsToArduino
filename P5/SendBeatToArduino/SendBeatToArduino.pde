import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.serial.*;

//Serial Vars
Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port

//Audio Vars
Minim minim;
AudioPlayer song;
BeatDetect beat;
float eRadius;

void setup()
{
  size(200, 200, P3D);

  //setup serial
  //you will want to ensure the serial port is the 
  //same as the one which your arduino is connected to
  for (int i = 0; i < Serial.list().length; i++)
  {
    println("[" + i + "] " + Serial.list()[i]);
  }
  //change the serial port here [x]
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);

  //setuo minim
  minim = new Minim(this);
  song = minim.loadFile("marcus_kellis_theme.mp3", 2048);
  song.play();
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();

  ellipseMode(RADIUS);
  eRadius = 20;
}

void draw()
{
  background(0);
  beat.detect(song.mix);
  float a = map(eRadius, 20, 80, 60, 255);
  fill(60, 255, 0, a);
  if ( beat.isOnset() )
  { 
    eRadius = 80;
    
    //send something to arduino
    myPort.write('H');
  } else 
  {
    myPort.write('L');
  }
  ellipse(width/2, height/2, eRadius, eRadius);
  eRadius *= 0.95;
  if ( eRadius < 20 ) eRadius = 20;
}

/*
  // Wiring/Arduino code:
 // Read data from the serial and turn ON or OFF a light depending on the value
 
 char val; // Data received from the serial port
 int ledPin = 13; // Set the pin to digital I/O 4
 
 void setup() {
 pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
 Serial.begin(9600); // Start serial communication at 9600 bps
 }
 
 void loop() {
 while (Serial.available()) { // If data is available to read,
 val = Serial.read(); // read it and store it in val
 }
 if (val == 'H') { // If H was received
 digitalWrite(ledPin, HIGH); // turn the LED on
 } else {
 digitalWrite(ledPin, LOW); // Otherwise turn it OFF
 }
 delay(100); // Wait 100 milliseconds for next reading
 }
 
 */
