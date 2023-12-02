import processing.serial.*;

Serial myPort;  // Objects for serial communication
float pitch, roll, yaw;

void setup() {
  size(700, 650, P3D);
  noStroke();
  myPort = new Serial(this, "COM5", 9600);  // Replace "COM5" with the appropriate serial port name
}

void draw_rect(float yaw, float pitch, float roll) {
  background(0);
  lights();

  int distance = 50;

  pushMatrix();
  translate(width/2, height/2, -distance);
  rotateX(radians(-pitch));
  rotateY(radians(-yaw));
  rotateZ(radians(roll));
  draw_block(249, 250, 50);
  popMatrix();
}

void draw_block(int r, int g, int b) {
  float size = 90;
  beginShape(QUADS);
  fill(r, g, b);
  
  vertex(-size/2, -size/2, -size/2);
  vertex(size/2, -size/2, -size/2);
  vertex(size/2, size/2, -size/2);
  vertex(-size/2, size/2, -size/2);

  vertex(size/2, -size/2, -size/2);
  vertex(size/2, -size/2, size/2);
  vertex(size/2, size/2, size/2);
  vertex(size/2, size/2, -size/2);

  vertex(size/2, -size/2, size/2);
  vertex(-size/2, -size/2, size/2);
  vertex(-size/2, size/2, size/2);
  vertex(size/2, size/2, size/2);

  vertex(-size/2, -size/2, size/2);
  vertex(-size/2, -size/2, -size/2);
  vertex(-size/2, size/2, -size/2);
  vertex(-size/2, size/2, size/2);

  vertex(-size/2, -size/2, size/2);
  vertex(size/2, -size/2, size/2);
  vertex(size/2, -size/2, -size/2);
  vertex(-size/2, -size/2, -size/2);

  vertex(-size/2, size/2, size/2);
  vertex(size/2, size/2, size/2);
  vertex(size/2, size/2, -size/2);
  vertex(-size/2, size/2, -size/2);

  
  endShape();
}

void draw() {
    // Read data from the serial connection
    if (myPort.available() > 0) {
    String data = myPort.readStringUntil('\n');  // Reads data from the serial port until it finds the newline character ('\n')
    if (data != null) {
      data = data.trim();  // Removes the newline character
      String[] dataParts = split(data, ',');  // Separating data based on commas
      
      if (dataParts.length == 3) {
        yaw = float(dataParts[0]);     // Converts the first string data to an integer
        pitch = float(dataParts[1]);  // Converts the second string data to an integer
        roll = float(dataParts[2]);  // Converts the third string data to an integer
        
        println("Received data : " + pitch + " and " + roll + " and " + yaw);
      }
    }
  }
  draw_rect(yaw, pitch, roll);
}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    pitch += 10;  // Adds 10 degrees to the pitch when the 'P' button is pressed
  } else if (key == 'r' || key == 'R') {
    roll += 10;  // Adds 10 degrees to the roll when the 'R' button is pressed
  } else if (key == 'y' || key == 'Y') {
    yaw += 10;  // Adds 10 degrees to the yaw when the 'Y' button is pressed
  }
}
