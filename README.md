# BeatsToArduino
Send beats from a song to Arduino. Uses minim in P5 to analyse song.

## Notes
Upload the code to the Arduino Uno. Note the `LedPin` is set to `13`.

Open and run the P5 sketch to check which serial port is the correct one for your Arduino. Chage the port number to the appropriate one. Run the P5 Sketch again and you should see the Arduino Uno onboard led turn on to the beat of the music.

The P5 sketch uses the minim library to analyse the provided .mp3 file and the Serial library to pass data to the Arduino.
