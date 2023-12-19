library ieee;
use ieee.std_logic_1164.all;


entity synchronizer is port (

			clk					: in std_logic;
			reset					: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
 end synchronizer;
 
 
architecture circuit of synchronizer is

	Signal sreg				: std_logic_vector(1 downto 0);

BEGIN
sync: process(clk, reset)
BEGIN

	if(rising_edge(clk)) then
		if(reset = '1') then sreg(0) <= '0'; sreg(1) <= '0';
		else sreg(1) <= sreg(0); sreg(0) <= din; end if;
	end if;
	
	dout <= sreg(1);
END PROCESS;

end;