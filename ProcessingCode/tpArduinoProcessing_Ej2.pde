import processing.serial.*;

Serial puertoSerie;
boolean entrada1, entrada2, colorSalida1, colorSalida2;

void setup() {
  size(720, 270);

  String puertoDisponible[] = Serial.list();
  puertoSerie = new Serial(this, puertoDisponible[0], 9600);
}

void draw() {
  background(255);

  // Entradas
  fill(255, 170, 120);
  rect(20, 50, 180, 85);
  fill(0);
  textSize(30);
  text("Entradas", 53, 105);

  // Salidas
  fill(200, 160, 255);
  rect(20, 150, 180, 85);
  fill(0);
  textSize(30);
  text("Salidas", 60, 205);

  // Entrada 1
  fill(entrada1 ? color(152, 255, 152) : color(255, 179, 179));
  rect(440, 60, 60, 60);
  fill(0);
  text("E1", 455, 100);

  // Entrada 2
  fill(entrada2 ? color(152, 255, 152) : color(255, 179, 179));
  rect(580, 60, 60, 60);
  fill(0);
  text("E2", 595, 100);

  // Salida 1
  fill(colorSalida1 ? color(152, 255, 152) : color(255, 179, 179));
  rect(440, 160, 60, 60);
  fill(0);
  text("S1", 455, 200);

  // Salida 2
  fill(colorSalida2 ? color(152, 255, 152) : color(255, 179, 179));
  rect(580, 160, 60, 60);
  fill(0);
  text("S2", 595, 200);

  // Leer datos del puerto serie
  while (puertoSerie.available() > 0) {
    String dato = puertoSerie.readStringUntil('\n');
    if (dato != null) {
      dato = dato.trim(); // Eliminar saltos de línea
      //dato.equals("E1 HIGH") compara el string dato con el "E1 HIGH" si ambas coinciden entonces true sino false, como un strcmp
      if (dato.equals("E1 HIGH")) 
          entrada1 = true;
      
      if (dato.equals("E1 LOW")) 
          entrada1 = false;
      
      if (dato.equals("E2 HIGH")) 
          entrada2 = true;
      
      if (dato.equals("E2 LOW")) 
        entrada2 = false;
    }
  }
}

void mousePressed() 
{
  // Verificar si se presionó dentro de los botones

  // Activar o desactivar LED1
  if (mouseX > 440 && mouseX < 500 && mouseY > 160 && mouseY < 220) {
    colorSalida1 = !colorSalida1; // Cambiar el estado
    puertoSerie.write(colorSalida1 ? '1' : '0'); // Enviar comando
  }

  // Activar o desactivar LED2
  if (mouseX > 580 && mouseX < 640 && mouseY > 160 && mouseY < 220) {
    colorSalida2 = !colorSalida2; // Cambiar el estado
    puertoSerie.write(colorSalida2 ? '2' : '0'); // Enviar comando
  }
}
