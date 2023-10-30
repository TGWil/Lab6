library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accumulator is 
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
end entity accumulator;


architecture behavioral of accumulator is 
    type state_type is (idle, debouncing, adding);
    signal current_state : state_type;
    signal next_state : state_type;
    signal out0, out1, out2, out3, out4, out5 : unsigned(3 downto 0);
    signal accumulate : unsigned(23 downto 0):= (others => '0');
    signal de : std_logic := '1';

    component hexdecoder 
        port (
            charin : in unsigned (3 downto 0);
            hexout : out unsigned(6 downto 0)
        );
        end component hexdecoder;
    
begin
    process(MAX10_CLK1_50, rst_l, add)
    begin
        HEXdot <= (others => '1');
        if rising_edge(MAX10_CLK1_50) then
            if rst_l = '0' then 
                accumulate <= (others => '0');
                current_state <= idle;
            else
                current_state <= next_state;
            end if;
       
            case current_state is
                when idle =>
                    LEDR <= SW; 
                    --output numbers onto the 7seg.
                    if add = '0' then
                        next_state <= debouncing;
                    else 
                        next_state <= idle;
                    end if;

                when debouncing =>
                    --debouncing logic
                    if add = '1' and de = '1' then
                        --change state to adding
                        de <= '0';
                        next_state <= adding;
                    end if;

                when adding =>
                    if de = '0' then
                        de <= '1';
                        accumulate <= accumulate + SW;
                        next_state <= idle;
                    end if;
            end case;
        end if;    
    end process;

    out0 <= accumulate(3 downto 0);
    out1 <= accumulate(7 downto 4);
    out2 <= accumulate(11 downto 8);
    out3 <= accumulate(15 downto 12);
    out4 <= accumulate(19 downto 16);
    out5 <= accumulate(23 downto 20);

    u0 : hexdecoder
    port map (
        charin => out0,
        hexout => HEX0(6 downto 0)
    );

    u1 : hexdecoder
    port map (
        charin => out1,
        hexout => HEX1(6 downto 0)
    );

    u2 : hexdecoder
    port map (
        charin => out2,
        hexout => HEX2(6 downto 0)
    );

    u3 : hexdecoder
    port map (
        charin => out3,
        hexout => HEX3(6 downto 0)
    );

    u4 : hexdecoder
    port map (
        charin => out4,
        hexout => HEX4(6 downto 0)
    );

    u5 : hexdecoder
    port map (
        charin => out5,
        hexout => HEX5(6 downto 0)
    );

end architecture behavioral;