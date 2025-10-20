entity TOP is
    Port ( Anode : out STD_LOGIC_VECTOR (3 downto 0);
           LED_out : out STD_LOGIC_VECTOR (6 downto 0);
           sw : in STD_LOGIC_VECTOR (9 downto 0);
           copy : in STD_LOGIC;
           enter : in STD_LOGIC;
           reset : in STD_LOGIC);
end TOP;

architecture Behavioral of TOP is
type integerarray is array (natural range <>) of integer;
signal input_array : integerarray;



begin
process
variable num : integer;
begin

while enter = '0' loop

    if (reset = '1') then
    LED_out <= "1111110";
elsif (sw = "1000000000") then  --0
    LED_out <= "0000001";
    if copy = '1' then
        num := 0;
    end if;
elsif (sw = "0100000000") then  --1
    LED_out <= "1001111";
    if copy = '1' then
        num := 1;
    end if;
elsif (sw = "0010000000") then  --2
    LED_out <= "0010010";
    if copy = '1' then
        num := 2;
    end if;
elsif (sw = "0001000000") then  --3
    LED_out <= "0000110";
    if copy = '1' then
        num := 3;
    end if;
else
    LED_out <= "1111110";
end if;
end loop;





end process;
end Behavioral;