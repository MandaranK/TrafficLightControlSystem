library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity State_Machine_Example IS Port
(
 clk_input, reset, clock, light  		:IN std_logic;
 g_ns, y_ns, r_ns, g_ew, y_ew, r_ew    :OUT std_logic;
 in_ns, in_ew									:IN std_logic;
 out_ns, out_ew								:OUT std_logic;
 p_ns, p_ew										:OUT std_logic;
 out_state										:OUT std_logic_vector(7 downto 4)
 );
END ENTITY;
 

 Architecture SM of State_Machine_Example is
 
 
 TYPE STATE_NAMES IS (S0, S1, S2, S3, S4, S5, S6, S7, s8, s9, s10, s11, s12, s13, s14, s15);   -- list all the STATE_NAMES values

 
 SIGNAL current_state, next_state	:  STATE_NAMES;     	-- signals of type STATE_NAMES



 BEGIN

 -------------------------------------------------------------------------------
 --State Machine:
 -------------------------------------------------------------------------------

 -- REGISTER_LOGIC PROCESS EXAMPLE
 
Register_Section: PROCESS (clk_input)  -- this process updates with a clock
BEGIN
	IF(rising_edge(clk_input)) THEN
		IF (reset = '1') THEN
			current_state <= S0;
		ELSIF (clock = '1') THEN
			current_state <= next_State;
		END IF;
	END IF;
END PROCESS;	



-- TRANSITION LOGIC PROCESS EXAMPLE

Transition_Section: PROCESS (current_state, in_ns, in_ew) 

BEGIN
  CASE current_state IS
         WHEN S0 =>		
				IF (in_ew = '1' AND in_ns = '0') THEN next_state <= S6;
				ELSE next_state <= S1; END IF;

         WHEN S1 =>		
				IF (in_ew = '1' AND in_ns = '0') THEN next_state <= S6;
				ELSE next_state <= S2; END IF;
				
         WHEN S2 => next_state <= S3;
				
         WHEN S3 => next_state <= S4;
					
         WHEN S4 => next_state <= S5;

         WHEN S5 => next_state <= S6;
				
         WHEN S6 => next_state <= S7;

         WHEN S7 => next_state <= S8;
			
			WHEN S8 =>
				IF (in_ew = '0' AND in_ns = '1') THEN next_state <= S14;
				ELSE next_state <= S9; END IF;
					
			WHEN s9 =>
				IF (in_ew = '0' AND in_ns = '1') THEN next_state <= S14;
				ELSE next_state <= S10; END IF;

			WHEN S10 => next_state <= S11;
					
			WHEN S11 => next_state <= S12;
					
			WHEN S12 => next_state <= S13;
					
			WHEN S13 => next_state <= S14;
				
			WHEN S14 => next_state <= S15;
					
			WHEN OTHERS => next_state <= S0;
	  END CASE;
 END PROCESS;
 

-- DECODER SECTION PROCESS EXAMPLE (MOORE FORM SHOWN)

Decoder_Section: PROCESS (current_state) 

BEGIN
     CASE current_state IS
	  
         WHEN S0 =>		
			r_ns <= '0'; y_ns <= '0'; g_ns <= light;
			r_ew <= '1'; y_ew <= '0'; g_ew <= '0';
			p_ns <= '0'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "0000";
			
         WHEN S1 =>		
			r_ns <= '0'; y_ns <= '0'; g_ns <= light;
			r_ew <= '1'; y_ew <= '0'; g_ew <= '0';
			p_ns <= '0'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "0001";

         WHEN S2 =>		
			r_ns <= '0'; y_ns <= '0'; g_ns <= '1';
			r_ew <= '1'; y_ew <= '0'; g_ew <= '0';
			p_ns <= '1'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "0010";
			
         WHEN S3 =>		
			r_ns <= '0'; y_ns <= '0'; g_ns <= '1';
			r_ew <= '1'; y_ew <= '0'; g_ew <= '0';
			p_ns <= '0'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "0011";
			
         WHEN S4 =>		
			r_ns <= '0'; y_ns <= '0'; g_ns <= '1';
			r_ew <= '1'; y_ew <= '0'; g_ew <= '0';
			p_ns <= '1'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "0100";

         WHEN S5 =>		
			r_ns <= '0'; y_ns <= '0'; g_ns <= '1';
			r_ew <= '1'; y_ew <= '0'; g_ew <= '0';
			p_ns <= '1'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "0101";
				
         WHEN S6 =>		
			r_ns <= '0'; y_ns <= '1'; g_ns <= '0';
			r_ew <= '1'; y_ew <= '0'; g_ew <= '0';
			p_ns <= '0'; p_ew <= '0';
			out_ew <= '1'; out_ns <= '0';
			out_state <= "0110";
				
         WHEN S7 =>		
			r_ns <= '0'; y_ns <= '1'; g_ns <= '0';
			r_ew <= '1'; y_ew <= '0'; g_ew <= '0';
			p_ns <= '0'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "0111";
			
			WHEN S8 =>
			r_ns <= '1'; y_ns <= '0'; g_ns <= '0';
			r_ew <= '0'; y_ew <= '0'; g_ew <= light;
			p_ns <= '0'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "1000";
			
			WHEN S9 => 
			r_ns <= '1'; y_ns <= '0'; g_ns <= '0';
			r_ew <= '0'; y_ew <= '0'; g_ew <= light;
			p_ns <= '0'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "1001";
			
			WHEN S10 =>
			r_ns <= '1'; y_ns <= '0'; g_ns <= '0';
			r_ew <= '0'; y_ew <= '0'; g_ew <= '1';
			p_ns <= '0'; p_ew <= '1';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "1010";
			
			WHEN S11 =>
			r_ns <= '1'; y_ns <= '0'; g_ns <= '0';
			r_ew <= '0'; y_ew <= '0'; g_ew <= '1';
			p_ns <= '0'; p_ew <= '1';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "1011";
			
			
			WHEN S12 =>
			r_ns <= '1'; y_ns <= '0'; g_ns <= '0';
			r_ew <= '0'; y_ew <= '0'; g_ew <= '1';
			p_ns <= '0'; p_ew <= '1';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "1100";
			
			WHEN S13 => 
			r_ns <= '1'; y_ns <= '0'; g_ns <= '0';
			r_ew <= '0'; y_ew <= '0'; g_ew <= '1';
			p_ns <= '0'; p_ew <= '1';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "1101";
			
			WHEN S14 => 
			r_ns <= '1'; y_ns <= '0'; g_ns <= '0';
			r_ew <= '0'; y_ew <= '1'; g_ew <= '0';
			p_ns <= '0'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '1';
			out_state <= "1110";
			
			WHEN S15 =>
			r_ns <= '1'; y_ns <= '0'; g_ns <= '0';
			r_ew <= '0'; y_ew <= '1'; g_ew <= '0';
			p_ns <= '0'; p_ew <= '0';
			out_ew <= '0'; out_ns <= '0';
			out_state <= "1111";
				
        
	  END CASE;
 END PROCESS;

 END ARCHITECTURE SM;
