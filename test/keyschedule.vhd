library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity keyschedule is
  port (
    -- clk   : in std_logic;
    -- reset : in std_logic;
    K    : in std_logic_vector(127 downto 0);
    nr   : in integer range 0 to 23;
    K_nr : out std_logic_vector(192 downto 0)
  );
end entity;
architecture rtl of keyschedule is

  type key is array (0 to 3) of std_logic_vector(31 downto 0);
  signal T : key;
  type delta is array (0 to 7) of std_logic_vector(31 downto 0);
  constant Delta : delta := (x"c3efe9db", x"44626b02", x"79e27c8a", x"78df30ec", x"715ea49e", x"c785da0a", x"e04ef22a", x"e5c40957");
begin

  T(0) <= K(127 downto 96);
  T(1) <= K(95 downto 64);
  T(2) <= K(63 downto 32);
  T(3) <= K(31 downto 0);

  T(0) <= SHIFT_LEFT(unsigned(T(0)) + SHIFT_LEFT(Delta(nr mod 4), nr), 1);
  T(1) <= SHIFT_LEFT(unsigned(T(1)) + SHIFT_LEFT(Delta(nr mod 4), (nr + 1)), 3)
  T(2) <= SHIFT_LEFT(unsigned(T(2)) + SHIFT_LEFT(Delta(nr mod 4), (nr + 2)), 6)
  T(3) <= SHIFT_LEFT(unsigned(T(3)) + SHIFT_LEFT(Delta(nr mod 4), (nr + 3)), 11)

  K_nr <= T(0) & T(1) & T(2) & T(1) & T(3) & T(1);
end architecture;