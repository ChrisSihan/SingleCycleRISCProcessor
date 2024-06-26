LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registerFile IS
	PORT (
		i_gReset		: IN 	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_regWrite		: IN	STD_LOGIC;
		i_readRegister1 	: IN 	STD_LOGIC_VECTOR(2 downto 0);
		i_readRegister2 	: IN 	STD_LOGIC_VECTOR(2 downto 0);
		i_writeRegister 	: IN 	STD_LOGIC_VECTOR(2 downto 0);
		i_writeData 		: IN 	STD_LOGIC_VECTOR(7 downto 0);
		o_readData1 		: OUT 	STD_LOGIC_VECTOR(7 downto 0);
		o_readData2 		: OUT 	STD_LOGIC_VECTOR(7 downto 0));
END registerFile;

ARCHITECTURE rtl of registerFile IS

COMPONENT eightBitRegister
	PORT (
		i_gReset : IN STD_LOGIC;
		i_clock : IN STD_LOGIC;
		i_enable : IN STD_LOGIC;
		i_A : IN STD_LOGIC_VECTOR(7 downto 0);
		o_q : OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT eightBitDecoder
	PORT (
		i_sel	: IN	STD_LOGIC_VECTOR(2 downto 0);
		o_q	: OUT	STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT eightBit8x3MUX
	PORT (
		i_sel						: IN 	STD_LOGIC_VECTOR(2 downto 0);
		i_A0, i_A1, i_A2, i_A3, i_A4, i_A5, i_A6, i_A7  : IN 	STD_LOGIC_VECTOR(7 downto 0);
		o_q						: OUT	STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

SIGNAL int_register0, int_register1, int_register2, int_register3, int_register4, int_register5, int_register6, int_register7 : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_readData1, int_readData2 : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_writeRegister : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_enable : STD_LOGIC_VECTOR(7 downto 0);

BEGIN

int_enable <= (i_regWrite & i_regWrite & i_regWrite & i_regWrite & i_regWrite & i_regWrite & i_regWrite & i_regWrite) AND int_writeRegister;


decoder: eightBitDecoder
	PORT MAP (	i_sel => i_writeRegister,
			o_q => int_writeRegister);

readData1: eightBit8x3MUX
	PORT MAP (	i_sel => i_readRegister1,
			i_A0 => int_register0,
			i_A1 => int_register1,
			i_A2 => int_register2,
			i_A3 => int_register3,
			i_A4 => int_register4,
			i_A5 => int_register5,
			i_A6 => int_register6,
			i_A7 => int_register7,
			o_q => int_readData1);

readData2: eightBit8x3MUX
	PORT MAP (	i_sel => i_readRegister2,
			i_A0 => int_register0,
			i_A1 => int_register1,
			i_A2 => int_register2,
			i_A3 => int_register3,
			i_A4 => int_register4,
			i_A5 => int_register5,
			i_A6 => int_register6,
			i_A7 => int_register7,
			o_q => int_readData2);

register0: eightBitRegister
	PORT MAP (	i_gReset => i_gReset,
			i_clock => i_clock,
			i_enable => int_enable(0),
			i_A => i_writeData,
			o_q => int_register0);

register1: eightBitRegister
	PORT MAP (	i_gReset => i_gReset,
			i_clock => i_clock,
			i_enable => int_enable(1),
			i_A => i_writeData,
			o_q => int_register1);

register2: eightBitRegister
	PORT MAP (	i_gReset => i_gReset,
			i_clock => i_clock,
			i_enable => int_enable(2),
			i_A => i_writeData,
			o_q => int_register2);

register3: eightBitRegister
	PORT MAP (	i_gReset => i_gReset,
			i_clock => i_clock,
			i_enable => int_enable(3),
			i_A => i_writeData,
			o_q => int_register3);

register4: eightBitRegister
	PORT MAP (	i_gReset => i_gReset,
			i_clock => i_clock,
			i_enable => int_enable(4),
			i_A => i_writeData,
			o_q => int_register4);

register5: eightBitRegister
	PORT MAP (	i_gReset => i_gReset,
			i_clock => i_clock,
			i_enable => int_enable(5),
			i_A => i_writeData,
			o_q => int_register5);

register6: eightBitRegister
	PORT MAP (	i_gReset => i_gReset,
			i_clock => i_clock,
			i_enable => int_enable(6),
			i_A => i_writeData,
			o_q => int_register6);

register7: eightBitRegister
	PORT MAP (	i_gReset => i_gReset,
			i_clock => i_clock,
			i_enable => int_enable(7),
			i_A => i_writeData,
			o_q => int_register7);

	--Output driver
	o_readData1 <= int_readData1;
	o_readData2 <= int_readData2;

END rtl;