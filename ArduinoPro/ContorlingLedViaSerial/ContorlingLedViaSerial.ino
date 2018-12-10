/**********************************************************************
 * opjective:                                                         *                       
 * simple program to control a LED via sarial conmunication           *            
 * i made it to learn access serial from matlab and other PC languges *           
 * like c/c++ java and python  and make simple Gui                    *              
 *                                                                    *                
 * the target board : Arduino uno                                     *                       
 *                                                                    *                    
 * how to use :                                                       *                   
 * simply put character '1' in serial the led on pin 13 will be on    *                     
 * put character '0' in serial the led on pin 13 will be off          *                          
 * and make sure that the baudrate is 9600                            *
 *                                                                    *
 * ********************************************************************
 *  author: Ibram reda                                                *                                                                    
 *  Date  :  @2018                                                    *                           
 **********************************************************************/
int value;

void setup()
{
Serial.begin(9600);
pinMode(13, OUTPUT);
}

void loop()
{
  if(Serial.available()>0)
  {
    value=Serial.read();

    if  (value == '1')           
    { 
    digitalWrite(13, HIGH);
    }
    if(value == '0')         
    { 
    digitalWrite(13, LOW);
    }
  }
}
