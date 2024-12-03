-- 3. 32-bit Register with Reset and Enable
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity register_32bit is
  Port (
      clk, reset, enable : in STD_LOGIC;
      d : in STD_LOGIC_VECTOR (31 downto 0);
      q : out STD_LOGIC_VECTOR (31 downto 0)
  );
end register_32bit;

architecture Behavioral of register_32bit is
  signal reg : STD_LOGIC_VECTOR (31 downto 0);
begin
  process (clk, reset)
  begin
      if reset = '1' then
          reg <= (others => '0');
      elsif rising_edge(clk) then
          if enable = '1' then
              reg <= d;
          end if;
      end if;
  end process;
  q <= reg;
end Behavioral;