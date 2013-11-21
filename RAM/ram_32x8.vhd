----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:29:40 01/14/2011 
-- Design Name: 
-- Module Name:    ram_32x8 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_32x8 is
    Port ( CLK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           ADRX : in  STD_LOGIC_VECTOR (4 downto 0);
           ADRY : in  STD_LOGIC_VECTOR (4 downto 0);
           D_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           DX_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           DY_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end ram_32x8;

architecture Behavioral of ram_32x8 is
	type memory is array (0 to 31) of STD_LOGIC_VECTOR (7 downto 0);
	signal ramX, ramY: memory;
begin
	process(CLK)
	begin
		if (rising_edge(CLK)) then
			if (WE = '1') then
				ramX(conv_integer(ADRX)) <= D_IN;
				ramY(conv_integer(ADRX)) <= D_IN;
			end if;
		end if;
	end process;
	DX_OUT <= ramX(conv_integer(ADRX));
	DY_OUT <= ramY(conv_integer(ADRY));
end Behavioral;

