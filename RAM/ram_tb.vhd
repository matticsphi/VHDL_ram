
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:48:27 01/14/2011
-- Design Name:   ram_32x8
-- Module Name:   C:/Xilinx/RAM/ram_tb.vhd
-- Project Name:  RAM
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ram_32x8
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY ram_tb_vhd IS
END ram_tb_vhd;

ARCHITECTURE behavior OF ram_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ram_32x8
	PORT(
		CLK : IN std_logic;
		WE : IN std_logic;
		ADRX : IN std_logic_vector(4 downto 0);
		ADRY : IN std_logic_vector(4 downto 0);
		D_IN : IN std_logic_vector(7 downto 0);          
		DX_OUT : OUT std_logic_vector(7 downto 0);
		DY_OUT : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL CLK :  std_logic := '0';
	SIGNAL WE :  std_logic := '0';
	SIGNAL ADRX :  std_logic_vector(4 downto 0) := "00000";
	SIGNAL ADRY :  std_logic_vector(4 downto 0) := "00000";
	SIGNAL D_IN :  std_logic_vector(7 downto 0) := "00000000";

	--Outputs
	SIGNAL DX_OUT :  std_logic_vector(7 downto 0);
	SIGNAL DY_OUT :  std_logic_vector(7 downto 0);
	
	--Expected Values
	SIGNAL DX_EXP : std_logic_vector(7 downto 0) := "00000000";
	SIGNAL DY_EXP : std_logic_vector(7 downto 0) := "00000000";
	
	--Clock period definitions
	constant clk_period : time := 100ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ram_32x8 PORT MAP(
		CLK => CLK,
		WE => WE,
		ADRX => ADRX,
		ADRY => ADRY,
		D_IN => D_IN,
		DX_OUT => DX_OUT,
		DY_OUT => DY_OUT
	);
	
	--Generate Stimulus
	process
	begin
	WE <= '1';
	for i in 0 to 31 loop
		ADRX <= conv_std_logic_vector(i,5);
		D_IN <= conv_std_logic_vector(i,8);
	end loop;
	
	WE <= '0' after 100ns;
	for i in 0 to 31 loop
		ADRX <= conv_std_logic_vector(i,5) after (100*(i+2))ns;
		DX_EXP <= conv_std_logic_vector(i,8) after (100*(i+2.5))ns;
	end loop;
	
	for i in 0 to 31 loop
		ADRY <= conv_std_logic_vector(i+16,5) after (100*(i+34))ns;
		DY_EXP <= conv_std_logic_vector(i+16,8) after (100*(i+34.5))ns;
	end loop;
	end process;
		
	--clock cycle 50ns
	clk_process: process
	begin
		CLK <= '0';
		wait for clk_period/2;
		CLK <= '1';
		wait for clk_period/2;
	end process;

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		assert (DX_OUT = DX_EXP && DY_OUT = DY_EXP)
		 report "Mismatch at t=" & time'image(now) &
		  " DX_OUT=" & integer'image(conv_integer(DX_OUT)) &
		  " DX_EXP=" & integer'image(conv_integer(DX_EXP)) &
		  " DY_OUT=" & integer'image(conv_integer(DY_OUT)) &
		  " DY_EXP=" & integer'image(conv_integer(DY_EXP))
		  severity failure;
		  
		 assert false
		  report "No error found (t=" & time'image(now) & ")"
		  severity note;
	
	END PROCESS;

END;
