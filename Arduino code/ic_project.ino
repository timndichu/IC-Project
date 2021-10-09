
#include <WebSocketsClient.h>


#include <Arduino.h>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>


#define GREENLED D0  
#define REDLED D1  
#define YELLOWLED D2  
#define RELAY1 D3  
#define RELAY2 D4  

const char* ssid = "Redmi";
const char* password = "host2000";

const char* server = "ic-project-smart-home.herokuapp.com";
const int port = 3000;

char path[] = "/";
char host[] = "ic-project-smart-home.herokuapp.com";

WebSocketsClient webSocket;

unsigned long messageInterval = 5000;
bool connected = false;
 
#define DEBUG_SERIAL Serial
 
void webSocketEvent(WStype_t type, uint8_t * payload, size_t length) {
  String text = (char*) payload;
    switch(type) {
        case WStype_DISCONNECTED:
            DEBUG_SERIAL.printf("[WSc] Disconnected!\n");
            connected = false;
             digitalWrite(REDLED, HIGH);   // turn the LED on (HIGH is the voltage level)
             delay(500);                       // wait for a second
             digitalWrite(REDLED, LOW);    // turn the LED off by making the voltage LOW
                 digitalWrite(GREENLED, LOW);
            break;
        case WStype_CONNECTED: {
            DEBUG_SERIAL.printf("[WSc] Connected to url: %s\n", payload);
            connected = true;
              digitalWrite(REDLED, LOW);
              digitalWrite(GREENLED, HIGH);
            // send message to server when Connected
            DEBUG_SERIAL.println("[WSc] SENT: Connected");
          
        }
            break;
        case WStype_TEXT: {
            DEBUG_SERIAL.printf("[WSc] RESPONSE: %s\n", payload);
            digitalWrite(YELLOWLED, HIGH);   // turn the LED on (HIGH is the voltage level)
             delay(3000);                       // wait for a second
             digitalWrite(YELLOWLED, LOW);    // turn the LED off by making the voltage LOW
            if(text=="Light One is On!"){
              digitalWrite(RELAY1, HIGH);
                Serial.println(" BULB 1 IS On! " );
             }
              else if(text=="Light Two is On!"){
                 digitalWrite(RELAY2, HIGH);
                Serial.println(" BULB 2 IS On! " );
                }
                else if(text=="Light One is Off!"){
               digitalWrite(RELAY1, LOW);
                Serial.println(" BULB 1 IS OFF " );
             }
              else if(text=="Light Two is Off!"){
                  digitalWrite(RELAY2, LOW);
                Serial.println(" BULB 2 IS OFF " );
                }
                else{
                  //something
                }
        }
            break;
         case WStype_BIN:
            DEBUG_SERIAL.printf("[WSc] get binary length: %u\n", length);
            hexdump(payload, length);
            break;
                case WStype_PING:
                        // pong will be send automatically
                        DEBUG_SERIAL.printf("[WSc] get ping\n");
                        break;
                case WStype_PONG:
                        // answer to a ping we send
                        DEBUG_SERIAL.printf("[WSc] get pong\n");
                        break;
    }
 
}


void setup() {
    DEBUG_SERIAL.begin(115200);
    pinMode(GREENLED, OUTPUT);  
    pinMode(REDLED, OUTPUT);  
    pinMode(YELLOWLED, OUTPUT); 
      pinMode(RELAY1, OUTPUT);
  digitalWrite(RELAY1, LOW);
  pinMode(RELAY2, OUTPUT);
  digitalWrite(RELAY2, LOW);
//  DEBUG_SERIAL.setDebugOutput(true);
    
    DEBUG_SERIAL.println();
    DEBUG_SERIAL.println();
    DEBUG_SERIAL.println();
 
    for(uint8_t t = 4; t > 0; t--) {
        DEBUG_SERIAL.printf("[SETUP] BOOT WAIT %d...\n", t);
        DEBUG_SERIAL.flush();
        delay(1000);
    }
 
    WiFi.begin(ssid, password);
 
    while ( WiFi.status() != WL_CONNECTED ) {
       digitalWrite(REDLED, HIGH);   // turn the LED on (HIGH is the voltage level)
       delay(500);                       // wait for a second
       digitalWrite(REDLED, LOW);    // turn the LED off by making the voltage LOW
      
      delay ( 500 );
      Serial.print ( "." );
    }
    DEBUG_SERIAL.print("Local IP: "); DEBUG_SERIAL.println(WiFi.localIP());
    // server address, port and URL
    webSocket.begin("ic-project-smart-home.herokuapp.com", 80, "/");
 
    // event handler
    webSocket.onEvent(webSocketEvent);
}
 
unsigned long lastUpdate = millis();
 
 
void loop() {
    webSocket.loop();
    if (connected){
//        DEBUG_SERIAL.println("[WSc] SENT: Simple js client message!!");
//        webSocket.sendTXT("Simple js client message!!");
//        lastUpdate = millis();
    }
}
