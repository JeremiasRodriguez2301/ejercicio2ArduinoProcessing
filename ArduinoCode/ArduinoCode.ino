#define led1 6
#define led2 7

#define boton1 8
#define boton2 9

bool estadoLed1 = false;
bool estadoLed2 = false;

bool estadoBoton1Anterior = true; // Estado inicial suponiendo botones no presionados
bool estadoBoton2Anterior = true;

void setup() {
  Serial.begin(9600);

  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(boton1, INPUT_PULLUP);
  pinMode(boton2, INPUT_PULLUP);

  digitalWrite(led1, LOW);
  digitalWrite(led2, LOW);
}

void loop() 
{
  // Leer el estado actual de los botones
  bool estadoBoton1Actual = digitalRead(boton1);
  bool estadoBoton2Actual = digitalRead(boton2);

  // Detectar flancos descendentes (botón presionado)
  if (!estadoBoton1Actual && estadoBoton1Anterior) 
  {
    // Cambiar el estado del LED 1
    estadoLed1 = !estadoLed1;
    digitalWrite(led1, estadoLed1 ? HIGH : LOW); //El comando estadoLEd1 ? HIGH : LOW hace que sí estadoLed1 es verdadero escribe HIGH sino un LOW, es como una abreviación del los if else if

    // Enviar mensaje a Processing
    Serial.println(estadoLed1 ? "E1 HIGH" : "E1 LOW");
  }

  if (!estadoBoton2Actual && estadoBoton2Anterior) 
  {
    // Cambiar el estado del LED 2
    estadoLed2 = !estadoLed2;
    digitalWrite(led2, estadoLed2 ? HIGH : LOW);

    // Enviar mensaje a Processing
    Serial.println(estadoLed2 ? "E2 HIGH" : "E2 LOW");
  }

  // Actualizar los estados anteriores de los botones
  estadoBoton1Anterior = estadoBoton1Actual;
  estadoBoton2Anterior = estadoBoton2Actual;

  // Procesar comandos recibidos desde Processing
  if (Serial.available() > 0) {
    char comando = Serial.read();

    switch (comando) {
      case '1': // Apagar LED1
        estadoLed1 = false;
        digitalWrite(led1, LOW);
        Serial.println("E1 LOW");
        break;

      case '2': // Apagar LED2
        estadoLed2 = false;
        digitalWrite(led2, LOW);
        Serial.println("E2 LOW");
        break;

      default:
        // Mensaje desconocido (puedes usar para debugging)
        Serial.println("Comando no reconocido");
        break;
    }
  }
}