
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LogicalStep_Lab4_top IS
   PORT
	(
   clkin_50		: in	std_logic;							-- The 50 MHz FPGA Clockinput
	rst_n			: in	std_logic;							-- The RESET input (ACTIVE LOW)
	pb_n			: in	std_logic_vector(3 downto 0); -- The push-button inputs (ACTIVE LOW)
 	sw   			: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds			: out std_logic_vector(7 downto 0);	-- for displaying the the lab4 project details
	-------------------------------------------------------------
	-- you can add temporary output ports here if you need to debug your design 
	-- or to add internal signals for your simulations
	-------------------------------------------------------------
	
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;							-- seg7 digi selectors
	seg7_char2  : out	std_logic							-- seg7 digi selectors
	);
END LogicalStep_Lab4_top;

ARCHITECTURE SimpleCircuit OF LogicalStep_Lab4_top IS

   component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN2 		: in  std_logic_vector(6 downto 0);	--bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DIN1 		: in  std_logic_vector(6 downto 0); --bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
   );
   end component;

   component clock_generator port (
			sim_mode			: in boolean;
			reset				: in std_logic;
         clkin      		: in  std_logic;
			sm_clken			: out	std_logic;
			blink		  		: out std_logic
   );
   end component;

   component pb_inverters port (
			rst_n				: in std_logic;
			rst				: out std_logic;
	
			pb_n_filtered 	: in std_logic_vector(3 downto 0);
			pb					: out std_logic_vector(3 downto 0)	
   );
   end component;

	
	component synchronizer port(
			clk					: in std_logic;
			reset					: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
   );
   end component;
 
   component holding_register port (
			clk					: in std_logic;
			reset					: in std_logic;
			register_clr			: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
   );
   end component;
	
	component state_machine_example port (
			clk_input, reset, clock, light  		:IN std_logic;
			g_ns, y_ns, r_ns, g_ew, y_ew, r_ew  :OUT std_logic;
			in_ns, in_ew								:IN std_logic;
			out_ns, out_ew								:OUT std_logic;
			p_ns, p_ew									:OUT std_logic;
			out_state									:OUT std_logic_vector(7 downto 4)
   );
   end component;
	
	component pb_filters port (
			clkin				: in std_logic;
			rst_n				: in std_logic;
			rst_n_filtered	: out std_logic;
			pb_n				: in  std_logic_vector (3 downto 0);
			pb_n_filtered	: out	std_logic_vector(3 downto 0)
   );
   end component;
				
	
----------------------------------------------------------------------------------------------------
	CONSTANT	sim_mode						: boolean := FALSE; -- set to FALSE for LogicalStep board downloads
	                                                     -- set to TRUE for SIMULATIONS
	
	SIGNAL sm_clken, blink_sig			: std_logic; 
	
	SIGNAL pb, pb_n_filtered			: std_logic_vector(3 downto 0); -- pb(3) is used as an active-high reset for all registers
	
	SIGNAL g_ns, y_ns, r_ns, g_ew, y_ew, r_ew, in_ns, in_ew, out_ns, out_ew, p_ns, p_ew			: std_logic;
	SIGNAL blink_sig, sm_clken, sy_ns, sy_ew 		: std_logic;
	SIGNAL synch_rst, rst, rst_n_filtered			: std_logic;
	SIGNAL led_ns, led_ew				: std_logic_vector(6 downto 0);
	
	
	
BEGIN
----------------------------------------------------------------------------------------------------
INST1: PB_filters port map (clkin_50, rst_n, rst_n_filtered, pb_n, pb_n_filtered);
INST2: pb_inverters port map (rst_n_filtered, rst, pb_n_filtered, pb);
INST3: clock_generator port map (sim_mode, synch_rst, clkin_50, sm_clken, blink_sig);
INST4: synchronizer port map (clkin_50, synch_rst, NOT(rst_n_filtered), synch_rst);
INST5: synchronizer port map (clkin_50, synch_rst, pb(1), sy_ew);
INST6: synchronizer port map (clkin_50, synch_rst, pb(0), sy_ns);
INST7: holding_register port map (clkin_50, synch_rst, out_ew, sy_ew, in_ew);
INST8: holding_register port map (clkin_50, synch_rst, out_ns, sy_ns, in_ns);
INST9: State_Machine_Example port map (clkin_50, synch_rst, sm_clken, blink_sig, r_ns, y_ns, g_ns, r_ew, y_ew, g_ew, leds(0), leds(2), in_ns, in_ew, out_ns, out_ew, leds(7 downto 4));
INST10: segment7_mux port map (clkin_50, led_ns, led_ew, seg7_data, seg7_char2, seg7_char1);
----------------------------------------------------------------------------------------------------
END SimpleCircuit;
