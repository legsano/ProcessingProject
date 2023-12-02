import processing.serial.*;

Serial myPort;  // Objects for serial communication
float[] pitch = new float[3];
float[] roll = new float[3];
float[] yaw = new float[3];

void setup() {
  size(700, 650, P3D);
  noStroke();
  myPort = new Serial(this, "COM5", 9600);  // Replace "COM5" with the appropriate serial port name
}

void draw_cubes() {
  for (int i = 0; i < 3; i++) {
    pushMatrix();
    translate((i + 1) * width / 4, height / 2);
    rotateX(radians(-int(pitch[i])));
    rotateY(radians(-int(yaw[i])));
    rotateZ(radians(int(roll[i])));
    
    if (i == 0) {
      draw_rect(255, 0, 0);  // First cuboid is red
    } else if (i == 1) {
      draw_rect(0, 255, 0);  // First cuboid is green
    } else {
      draw_rect(0, 0, 255);  // First cuboid is blue
    }
    
    popMatrix();
  }
}

void draw_rect(int r, int g, int b) {
  float length = 120; // cuboid length
  float width = 80;   // cuboid width
  float height = 30;  // cuboid height
  
  beginShape(QUADS);
  fill(r, g, b);
  
  // Define the vertices of a cube
  vertex(-length/2, -width/2, -height/2);
  vertex(length/2, -width/2, -height/2);
  vertex(length/2, width/2, -height/2);
  vertex(-length/2, width/2, -height/2);

  vertex(length/2, -width/2, -height/2);
  vertex(length/2, -width/2, height/2);
  vertex(length/2, width/2, height/2);
  vertex(length/2, width/2, -height/2);

  vertex(length/2, -width/2, height/2);
  vertex(-length/2, -width/2, height/2);
  vertex(-length/2, width/2, height/2);
  vertex(length/2, width/2, height/2);

  vertex(-length/2, -width/2, height/2);
  vertex(-length/2, -width/2, -height/2);
  vertex(-length/2, width/2, -height/2);
  vertex(-length/2, width/2, height/2);
  
  vertex(-length/2, -width/2, height/2);
  vertex(length/2, -width/2, height/2);
  vertex(length/2, -width/2, -height/2);
  vertex(-length/2, -width/2, -height/2);

  vertex(-length/2, width/2, height/2);
  vertex(length/2, width/2, height/2);
  vertex(length/2, width/2, -height/2);
  vertex(-length/2, width/2, -height/2);


  endShape();
}


void draw() {
  // Read data from the serial connection
  if (myPort.available() > 0) {
    String data = myPort.readStringUntil('\n');    // Reads data from the serial port until it finds the newline character ('\n')
    if (data != null) {                            
      data = data.trim();                          // Removes the newline character
      String[] dataParts = split(data, ',');       // Separating data based on commas
      
      if (dataParts.length == 9) {
        for (int i = 0; i < 3; i++) {
          int dataIndex = i * 3;
          pitch[i] = float(dataParts[dataIndex]);      // Converts the pitch[i] string data to a float
          roll[i] = float(dataParts[dataIndex + 1]);   // Converts the roll[i] string data to a float
          yaw[i] = float(dataParts[dataIndex + 2]);    // Converts the yaw[i] string data to a float
        }
      }
    }
  }
  background(0);
  lights();
  draw_cubes();
}

void keyPressed() {
  // Adjust pitch, roll, or yaw when corresponding keys are pressed
  if (key == 'p' || key == 'P') {
    for (int i = 0; i < 3; i++) {          // Adds 10 degrees to the pitch when the 'P' button is pressed
      pitch[i] += 10;
    }
  } else if (key == 'r' || key == 'R') {
    for (int i = 0; i < 3; i++) {          // Adds 10 degrees to the roll when the 'R' button is pressed
      roll[i] += 10;
    }
  } else if (key == 'y' || key == 'Y') {
    for (int i = 0; i < 3; i++) {          // Adds 10 degrees to the yaw when the 'Y' button is pressed
      yaw[i] += 10;
    }
  }
}
