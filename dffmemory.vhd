library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity dffmemory is
port(
	ADDR: in std_logic_vector(2 downto 0);
	DATA_IN: in std_logic;	
	RD: in std_logic; 
	WR: in std_logic;
	CS: in std_logic;
	DATA_OUT: out std_logic
);
end dffmemory;

architecture behavioral of dffmemory is
signal WR_DECODER_OUT: std_logic_vector(7 downto 0);
signal RD_DECODER_OUT: std_logic_vector(7 downto 0);
begin
--READ 3X8 DECODER girişi 3 bitlik adres çıkışı tri state bufferın enable ucuna bağlanıyor.
	process (ADDR)
		begin
			if RD = '1' then
				RD_DECODER_OUT(0) <= (not ADDR(2)) and (not ADDR(1)) and (not ADDR(0));
				RD_DECODER_OUT(1) <= (not ADDR(2)) and (not ADDR(1)) and ADDR(0);
				RD_DECODER_OUT(2) <= (not ADDR(2)) and (ADDR(1)) and (not ADDR(0));
				RD_DECODER_OUT(3) <= (not ADDR(2)) and ADDR(1) and ADDR(0);
				RD_DECODER_OUT(4) <= ADDR(2) and (not ADDR(1)) and (not ADDR(0));
				RD_DECODER_OUT(5) <= ADDR(2) and (not ADDR(1)) and ADDR(0);
				RD_DECODER_OUT(6) <= ADDR(2) and ADDR(1) and (not ADDR(0));
				RD_DECODER_OUT(7) <= ADDR(2) and ADDR(1) and ADDR(0);
			else
				RD_DECODER_OUT <= "ZZZZZZZZ";
		end if;
	end process;
--WRITE 3X8 DECODER girişi 3 bitlik adres çıkış dffin clk ucuna bağlanıyor.
	process (ADDR)
		begin
			if WR = '1' then
				WR_DECODER_OUT(0) <= (not ADDR(2)) and (not ADDR(1)) and (not ADDR(0));
				WR_DECODER_OUT(1) <= (not ADDR(2)) and (not ADDR(1)) and ADDR(0);
				WR_DECODER_OUT(2) <= (not ADDR(2)) and (ADDR(1)) and (not ADDR(0));
				WR_DECODER_OUT(3) <= (not ADDR(2)) and ADDR(1) and ADDR(0);
				WR_DECODER_OUT(4) <= ADDR(2) and (not ADDR(1)) and (not ADDR(0));
				WR_DECODER_OUT(5) <= ADDR(2) and (not ADDR(1)) and ADDR(0);
				WR_DECODER_OUT(6) <= ADDR(2) and ADDR(1) and (not ADDR(0));
				WR_DECODER_OUT(7) <= ADDR(2) and ADDR(1) and ADDR(0);
			else
				WR_DECODER_OUT <= "ZZZZZZZZ";
		end if;
	end process;
	
--D tipi flip floplar
	process (WR_DECODER_OUT(0))
	variable wdff_out: std_logic;
		begin 
			if rising_edge(WR_DECODER_OUT(0)) then
				wdff_out := DATA_IN;
		end if;
	end process;
	
		process (WR_DECODER_OUT(1))
	variable xdff_out: std_logic;
		begin 
			if rising_edge(WR_DECODER_OUT(1)) then
				xdff_out := DATA_IN;
		end if;
	end process;
	
		process (WR_DECODER_OUT(2))
	variable ydff_out: std_logic;
		begin 
			if rising_edge(WR_DECODER_OUT(2)) then
				ydff_out := DATA_IN;
		end if;
	end process;
	
		process (WR_DECODER_OUT(3))
	variable zdff_out: std_logic;
		begin 
			if rising_edge(WR_DECODER_OUT(3)) then
				zdff_out := DATA_IN;
		end if;
	end process;
	
		process (WR_DECODER_OUT(4))
	variable mdff_out: std_logic;
		begin 
			if rising_edge(WR_DECODER_OUT(4)) then
				mdff_out := DATA_IN;
		end if;
	end process;
	
		process (WR_DECODER_OUT(5))
	variable ndff_out: std_logic;
		begin 
			if rising_edge(WR_DECODER_OUT(5)) then
				ndff_out := DATA_IN;
		end if;
	end process;
	
		process (WR_DECODER_OUT(6))
	variable odff_out: std_logic;
		begin 
			if rising_edge(WR_DECODER_OUT(6)) then
				odff_out := DATA_IN;
		end if;
	end process;
	
		process (WR_DECODER_OUT(7))
	variable pdff_out: std_logic;
		begin 
			if rising_edge(WR_DECODER_OUT(7)) then
				pdff_out := DATA_IN;
		end if;
	end process;
	
--Tri state bufferlar
	DATA_OUT <= DATA_IN when (RD_DECODER_OUT(0) = '0') else 'Z';
	DATA_OUT <= DATA_IN when (RD_DECODER_OUT(1) = '0') else 'Z';
	DATA_OUT <= DATA_IN when (RD_DECODER_OUT(2) = '0') else 'Z';
	DATA_OUT <= DATA_IN when (RD_DECODER_OUT(3) = '0') else 'Z';
	DATA_OUT <= DATA_IN when (RD_DECODER_OUT(4) = '0') else 'Z';
	DATA_OUT <= DATA_IN when (RD_DECODER_OUT(5) = '0') else 'Z';
	DATA_OUT <= DATA_IN when (RD_DECODER_OUT(6) = '0') else 'Z';
	DATA_OUT <= DATA_IN when (RD_DECODER_OUT(7) = '0') else 'Z';
	
end behavioral;