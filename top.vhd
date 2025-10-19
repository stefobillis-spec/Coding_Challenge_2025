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

begin


end Behavioral;