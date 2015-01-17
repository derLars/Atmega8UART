#include "uart.h"

#include <avr/io.h>
#include <util/delay.h>

#define SENDER

#ifndef SENDER

int main(void)
{
	initUart();

	DDRB = 0xff;
	PORTB = 0x00;

	while(1)
	{
		PORTB = receiveChar();
	}
}


#endif

#ifdef SENDER

int main(void)
{
	uint8_t i;

	initUart();

	while(1)
	{
		for(i=0; i<16; i++)
		{
			sendChar(i);
			_delay_ms(2000);
		}
		for(i=15; i>0; i--)
		{
			sendChar(i);
			_delay_ms(2000);
		}
		
	}
}


#endif