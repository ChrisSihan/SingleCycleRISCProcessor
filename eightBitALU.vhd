LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY eightBitALU IS
	PORT (
		i_op		: IN	STD_LOGIC_VECTOR(2 downto 0);
		i_A, i_B	: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_zero		: OUT	STD_LOGIC;
		o_q		: OUT	STD_LOGIC_VECTOR(7 downto 0));
END eightBitALU;

ARCHITECTURE struct OF eightBitALU IS

COMPONENT eightBit8x3MUX
	PORT (
		i_sel						: IN 	STD_LOGIC_VECTOR(2 downto 0);
		i_A0, i_A1, i_A2, i_A3, i_A4, i_A5, i_A6, i_A7  : IN 	STD_LOGIC_VECTOR(7 downto 0);
		o_q						: OUT	STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT eightBitAdder
	PORT (
			i_x		: IN STD_LOGIC_VECTOR(7 downto 0);
			i_y		: IN STD_LOGIC_VECTOR(7 downto 0);
			i_cin		: IN STD_LOGIC;
			o_cout		: OUT STD_LOGIC;
			o_s		: OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT eightBitComparator
	PORT (
			i_Ai, i_Bi			: IN	STD_LOGIC_VECTOR(7 downto 0);
			o_GT, o_LT, o_EQ		: OUT	STD_LOGIC);
END COMPONENT;

SIGNAL int_AND, int_OR, int_ADD, int_SUB, int_SLT : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_cout : STD_LOGIC;
SIGNAL int_notB : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_q : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_A3, int_A4, int_A5 : STD_LOGIC_VECTOR(7 downto 0);

BEGIN
int_notB <= NOT(i_B);

int_AND <= i_A AND i_B;
int_OR <= i_A OR i_B;

int_SLT(7 downto 1) <= "0000000";

adder: eightBitAdder
	PORT MAP (	i_x => i_A,
			i_y => i_B,
			i_cin => '0',
			o_cout => int_cout,
			o_s => int_ADD);

subtractor: eightBitAdder
	PORT MAP (	i_x => i_A,
			i_y => int_notB,
			i_cin => '1',
			o_cout => int_cout,
			o_s => int_SUB);

comparator: eightBitComparator
	PORT MAP (	i_Ai => i_A,
			i_Bi => i_B,
			o_LT => int_SLT(0));
mux: eightBit8x3MUX
	PORT MAP (	i_sel => i_op,
			i_A0 => int_AND,
			i_A1 => int_OR,
			i_A2 => int_ADD,
			i_A3 => int_A3,
			i_A4 => int_A4,
			i_A5 => int_A5,
			i_A6 => int_SUB,
			i_A7 => int_SLT,
			o_q => int_q);
	--Output driver
	o_zero <= '1' WHEN int_q = "00000000" ELSE '0';
	o_q <= int_q;

END struct;
