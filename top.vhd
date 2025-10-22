library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;




entity TOP is
    Port ( Anode : out STD_LOGIC_VECTOR (3 downto 0);
           LED_out : out STD_LOGIC_VECTOR (6 downto 0);
           sw : in STD_LOGIC_VECTOR (9 downto 0); -- change back to 9 downto 0
           copy : in STD_LOGIC;
           enter : in STD_LOGIC;
           reset : in STD_LOGIC;
           left : in std_logic;
           right : in std_logic;
           beg : in std_logic);
end TOP;

architecture Behavioral of TOP is
constant max_size : integer := 6;
type integerarray is array (max_size-1 downto 0) of integer;
signal input_array : integerarray;
signal output_array : integerarray;
signal valid_count : integer range 0 to max_size := 0;
signal done : std_logic;



function Print(numb : in integer)
                return std_logic_vector is
        variable LCD: std_logic_vector(6 downto 0);
        begin
        LCD := "1111110";
        if numb = 0 then
            LCD := "0000001";
        elsif numb = 1 then
            LCD := "1001111";
        elsif numb = 2 then
            LCD := "0010010";
        elsif numb = 3 then
            LCD := "0000110";
        else
            LCD := "1111110";
        end if; 
        return LCD;
    end Print;   
                
                

begin
Anode <= "1110";


get_input: process(reset, copy, sw)
variable temp_array : integerarray;
variable num : integer; -- do you really need this???
variable n : integer := 0;  --:= input_array'length;
begin

--while enter = '0' loop
for j in 0 to (max_size-1) loop

    if (reset = '1') then
        --temp_array(n downto 0) := 0;
        LED_out <= "1111110";
        for i in 0 to (max_size-1) loop
            temp_array(i) := 0;
        end loop;
        n := 0;
        
    elsif (sw = "1000000000") then  --0
        LED_out <= Print(0);
        if copy = '1' then
            n := n+1;
            temp_array(n-1):= 0;
        end if;
    elsif (sw = "0100000000") then  --1
        LED_out <= Print(1);
        if copy = '1' then
            n := n+1;
            temp_array(n-1):= 1;
        end if;
    elsif (sw = "0010000000") then  --2
        LED_out <= Print(2);
        if copy = '1' then
            n := n+1;
            temp_array(n-1):= 2;
        end if;
    elsif (sw = "0001000000") then  --3
        LED_out <= Print(3);
        if copy = '1' then
            n := n+1;
            temp_array(n-1):= 3;
        end if;
    else
        LED_out <= "1111110";
end if;
end loop;


valid_count <= n;
input_array <= temp_array;
end process;







algo: process(enter)
begin
if enter = '1' then
    
--- algorithm code---
output_array <= input_array;

end if;

done <= '1';
end process;






--- A for loop won't work for this. 
print_output : process 
variable position : integer := 0;
begin
if done = '1' then
    if beg = '1' then
        LED_out <= Print(output_array(0));
    elsif right = '1' then
        position := position + 1;
        LED_out <= Print(output_array(position));
    elsif left = '1' then
        position := position - 1;
        LED_out <= Print(output_array(position));
    else
        LED_out <= Print(10);       
    end if;
end if;
wait;
end process;


end Behavioral;


