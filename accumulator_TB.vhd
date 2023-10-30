library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity accumulator_TB is
end accumulator_TB;


architecture behavioral of accumulator_TB is
	
	component accumulator
		port (
			MAX10_CLK1_50 : in std_logic;
			rst_l : in std_logic;
			add : in std_logic;
			HEX0 : out unsigned(6 downto 0);
			HEX1 : out unsigned(6 downto 0);
			HEX2 : out unsigned(6 downto 0);
			HEX3 : out unsigned(6 downto 0);
			HEX4 : out unsigned(6 downto 0);
			HEX5 : out unsigned(6 downto 0);
			HEXdot : out unsigned(5 downto 0);
			LEDR : out unsigned(9 downto 0);
			SW : in unsigned(9 downto 0)
		);
	end component accumulator;
	
	
	signal MAX10_CLK1_50 : STD_LOGIC := '0';
	signal rst_l : std_logic := '1';
	signal add : std_logic := '1';
	signal HEX0 : UNSIGNED(6 downto 0);
	signal HEX1 : UNSIGNED(6 downto 0);
	signal HEX2 : UNSIGNED(6 downto 0);
	signal HEX3 : UNSIGNED(6 downto 0);
	signal HEX4 : UNSIGNED(6 downto 0);
	signal HEX5 : UNSIGNED(6 downto 0);
	signal HEXdot : UNSIGNED(5 downto 0);
	signal LEDR : UNSIGNED(9 downto 0);
	signal SW : UNSIGNED(9 downto 0);


	constant MAX10_CLK1_50_PERIOD : time := 10 ps;
	begin
		uut : accumulator
		port map (
			MAX10_CLK1_50 => MAX10_CLK1_50,
			rst_l => rst_l,
			add => add,
			HEX0 => HEX0,
			HEX1 => HEX1,
			HEX2 => HEX2,
			HEX3 => HEX3,
			HEX4 => HEX4,
			HEX5 => HEX5,
			HEXdot => HEXdot,
			LEDR => LEDR,
			SW => SW
		);
	MAX10_CLK1_50_process : process
	begin

	SW <= "0000001010";
	
	MAX10_CLK1_50 <= '0';
	wait for MAX10_CLK1_50_period / 2;
	MAX10_CLK1_50 <= '1';
	wait for MAX10_CLK1_50_period / 2;
	end process;
	stm_process : process
	begin
	rst_l <= '0';
	add <= '0';
	wait for MAX10_CLK1_50_period *5;
	rst_l <= '1';
	add <= '0';
	wait for MAX10_CLK1_50_period * 2;
	add <= '1';
	wait for MAX10_CLK1_50_period * 2;
	add <= '0';
	wait for MAX10_CLK1_50_period * 2;
	add <= '1';
	wait for MAX10_CLK1_50_period * 2;
	add <= '0';
	wait for MAX10_CLK1_50_period * 2;
	add <= '1';
	wait for MAX10_CLK1_50_period * 7;
	rst_l <= '0';
	wait;
	end process;
end architecture behavioral;
