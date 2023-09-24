LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


entity Elevador is
port (clk, reset : IN STD_LOGIC;
		andar : in integer range 0 to 15;
		saida : out integer range 0 to 2;
		andar_atual: buffer integer range 0 to 15);
end elevador;

ARCHITECTURE teste OF Elevador IS
		TYPE andar_desejado IS (A1);
		SIGNAL estado: andar_desejado;
	BEGIN
		PROCESS(clk, reset)
		BEGIN
			IF reset = '1' THEN
				estado <= A1;
				andar_atual <= 1;
			ELSIF(clk'EVENT AND clk='1') THEN
				CASE estado IS
					WHEN A1 =>
						IF andar < andar_atual THEN
							estado <= A1;
							andar_atual <= andar_atual - 1;
							saida <= 0;
						ELSIF andar = andar_atual THEN
							estado <= A1;
							saida <= 1;
						ELSIF andar > andar_atual THEN
							estado <= A1;
							andar_atual <= andar_atual + 1;
							saida <= 2;
						END IF;
				END CASE;
			END IF;
END PROCESS;	
end teste;