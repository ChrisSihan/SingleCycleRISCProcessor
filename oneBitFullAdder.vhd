LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY oneBitFullAdder IS
	PORT ( 		i_x	: IN STD_LOGIC;
			i_y	: IN STD_LOGIC;
			i_cin	: IN STD_LOGIC;
			o_cout	: OUT STD_LOGIC;
			o_s	: OUT STD_LOGIC);
END oneBitFullAdder;

ARCHITECTURE struct OF oneBitFullAdder IS

SIGNAL int_s : STD_LOGIC;	
SIGNAL int_cout : STD_LOGIC;	

BEGIN
int_s <= (i_x xor i_y) xor i_cin;
int_cout <= (i_x and i_y) or (i_x and i_cin) or (i_y and i_cin);

		o_s <= int_s;
		o_cout <= int_cout;

END struct;