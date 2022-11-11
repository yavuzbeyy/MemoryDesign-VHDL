library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity memory4x3 is
port(
	ADDR: in std_logic_vector(1 downto 0);
	DATA_IN: in std_logic_vector(2 downto 0);	
	RD: in std_logic; 
	WR: in std_logic;
	CS: in std_logic;
	DATA_OUT: out std_logic_vector(2 downto 0)
);
end memory4x3;

architecture behavioral of memory4x3 is
signal RD_DECODER_OUT: std_logic_vector(3 downto 0);
signal WR_DECODER_OUT: std_logic_vector(3 downto 0);
signal first_line_dff_out: std_logic_vector(2 downto 0);	
signal second_line_dff_out: std_logic_vector(2 downto 0);	
signal third_line_dff_out: std_logic_vector(2 downto 0);	
signal fourth_line_dff_out: std_logic_vector(2 downto 0);	
begin

	process (ADDR)
		begin
			if (RD = '1' and CS = '1') then
				RD_DECODER_OUT(0) <= (not ADDR(1)) and (not ADDR(0));
				RD_DECODER_OUT(1) <= (not ADDR(1)) and ADDR(0);
				RD_DECODER_OUT(2) <= (ADDR(1)) and (not ADDR(0));
				RD_DECODER_OUT(3) <= ADDR(1) and ADDR(0);
			else
				RD_DECODER_OUT <= "ZZZZ";
		end if;
	end process;
	
	process (ADDR)
		begin
			if (WR = '1' and CS = '1') then
				WR_DECODER_OUT(0) <= (not ADDR(1)) and (not ADDR(0));
				WR_DECODER_OUT(1) <= (not ADDR(1)) and ADDR(0);
				WR_DECODER_OUT(2) <= (ADDR(1)) and (not ADDR(0));
				WR_DECODER_OUT(3) <= ADDR(1) and ADDR(0);
			else
				WR_DECODER_OUT <= "ZZZZ";
		end if;
	end process;

	
	process (WR_DECODER_OUT(0))
		begin 
			if rising_edge(WR_DECODER_OUT(0)) then
				first_line_dff_out(0) <= DATA_IN(0);
		end if;
	end process;
	
		process (WR_DECODER_OUT(0))
		begin 
			if rising_edge(WR_DECODER_OUT(0)) then
				first_line_dff_out(1) <= DATA_IN(1);
		end if;
	end process;
	
		process (WR_DECODER_OUT(0))
		begin 
			if rising_edge(WR_DECODER_OUT(0)) then
				first_line_dff_out(2) <= DATA_IN(2);
		end if;
	end process;
	
	
	process (WR_DECODER_OUT(1))
		begin 
			if rising_edge(WR_DECODER_OUT(1)) then
				second_line_dff_out(0) <= DATA_IN(0);
		end if;
	end process;
	
		process (WR_DECODER_OUT(1))
		begin 
			if rising_edge(WR_DECODER_OUT(1)) then
				second_line_dff_out(1) <= DATA_IN(1);
		end if;
	end process;
	
		process (WR_DECODER_OUT(1))
		begin 
			if rising_edge(WR_DECODER_OUT(1)) then
				second_line_dff_out(2) <= DATA_IN(2);
		end if;
	end process;
	
	
	process (WR_DECODER_OUT(2))
		begin 
			if rising_edge(WR_DECODER_OUT(2)) then
				third_line_dff_out(0) <= DATA_IN(0);
		end if;
	end process;
	
		process (WR_DECODER_OUT(2))
		begin 
			if rising_edge(WR_DECODER_OUT(2)) then
				third_line_dff_out(1) <= DATA_IN(1);
		end if;
	end process;
	
		process (WR_DECODER_OUT(2))
		begin 
			if rising_edge(WR_DECODER_OUT(2)) then
				third_line_dff_out(2) <= DATA_IN(2);
		end if;
	end process;
	
	
	process (WR_DECODER_OUT(3))
		begin 
			if rising_edge(WR_DECODER_OUT(3)) then
				fourth_line_dff_out(0) <= DATA_IN(0);
		end if;
	end process;
	
		process (WR_DECODER_OUT(3))
		begin 
			if rising_edge(WR_DECODER_OUT(3)) then
				fourth_line_dff_out(1) <= DATA_IN(1);
		end if;
	end process;
	
		process (WR_DECODER_OUT(3))
		begin 
			if rising_edge(WR_DECODER_OUT(3)) then
				fourth_line_dff_out(2) <= DATA_IN(2);
		end if;
	end process;
	
	
	DATA_OUT(0) <= DATA_IN(0) when (RD_DECODER_OUT(0) = '0') else 'Z';
	DATA_OUT(1) <= DATA_IN(1) when (RD_DECODER_OUT(0) = '0') else 'Z';
	DATA_OUT(2) <= DATA_IN(2) when (RD_DECODER_OUT(0) = '0') else 'Z';
	
	DATA_OUT(0) <= DATA_IN(0) when (RD_DECODER_OUT(1) = '0') else 'Z';
	DATA_OUT(1) <= DATA_IN(1) when (RD_DECODER_OUT(1) = '0') else 'Z';
	DATA_OUT(2) <= DATA_IN(2) when (RD_DECODER_OUT(1) = '0') else 'Z';	
	
	DATA_OUT(0) <= DATA_IN(0) when (RD_DECODER_OUT(2) = '0') else 'Z';
	DATA_OUT(1) <= DATA_IN(1) when (RD_DECODER_OUT(2) = '0') else 'Z';
	DATA_OUT(2) <= DATA_IN(2) when (RD_DECODER_OUT(2) = '0') else 'Z';	
	
	DATA_OUT(0) <= DATA_IN(0) when (RD_DECODER_OUT(3) = '0') else 'Z';
	DATA_OUT(1) <= DATA_IN(1) when (RD_DECODER_OUT(3) = '0') else 'Z';
	DATA_OUT(2) <= DATA_IN(2) when (RD_DECODER_OUT(3) = '0') else 'Z';

	
end behavioral;