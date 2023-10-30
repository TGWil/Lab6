library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hexdecoder is
port (
    charin : in unsigned (3 downto 0);
    hexout : out unsigned(6 downto 0)
);
end;

architecture simple of hexdecoder is
    begin
        hexout <= "1000000" when charin = "0000" else
            "1111001" when charin = "0001" else
            "0100100" when charin = "0010" else
            "0110000" when charin = "0011" else
            "0011001" when charin = "0100" else
            "0010010" when charin = "0101" else
            "0000010" when charin = "0110" else
            "1111000" when charin = "0111" else
            "0000000" when charin = "1000" else
            "0011000" when charin = "1001" else
            "0001000" when charin = "1010" else
            "0000011" when charin = "1011" else
            "1000110" when charin = "1100" else
            "0100001" when charin = "1101" else
            "0000110" when charin = "1110" else
            "0001110" when charin = "1111" else
            "0110110";
end;