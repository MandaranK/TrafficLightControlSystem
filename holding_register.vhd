library ieee;
use ieee.std_logic_1164.all;


entity holding_register is port (

			clk					: in std_logic;
			reset					: in std_logic;
			register_clr			: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
 end holding_register;
 
 architecture circuit of holding_register is

	Signal sreg				: std_logic;
	Signal reg_in			: std_logic;


BEGIN
sync: process(clk, reset)
BEGIN

	reg_in <= NOT(reset OR register_clr) AND (din OR sreg);
	
	if(rising_edge(clk)) then
		if(reset ='1') then sreg <= '0';
		else sreg <= input; end if;
	end if;
	
	dout <= sreg;
END PROCESS;
end;