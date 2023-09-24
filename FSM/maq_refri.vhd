LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY maq_refri IS
	PORT (
		ck : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		botao : IN STD_LOGIC;
		moedas : IN BIT_VECTOR(3 DOWNTO 0);

		soma : OUT INTEGER RANGE 0 TO 210;
		troco : OUT INTEGER RANGE 0 TO 210;

		devolver : OUT STD_LOGIC;
		saida : OUT STD_LOGIC
	);

END maq_refri;

ARCHITECTURE a OF maq_refri IS

	SIGNAL soma_tmp : INTEGER RANGE 0 TO 210 := 0;
	SIGNAL soma_prox : INTEGER RANGE 0 TO 210 := 0;

BEGIN
	soma <= soma_tmp;

	WITH moedas SELECT soma_prox<=
		soma_tmp + 10 WHEN "0001", 
		soma_tmp + 25 WHEN "0010", 
		soma_tmp + 50 WHEN "0100", 
		soma_tmp + 100 WHEN "1000",
		soma_tmp WHEN OTHERS;

	PROCESS (ck, reset)

	BEGIN

		IF reset = '1' THEN --resetar não devolve o troco, apenas zera tudo.
			soma_tmp <= 0;
			saida <= '0';
			devolver <= '0';
			
		ELSIF (rising_edge(ck)) THEN

			IF soma_prox > 100 THEN
				troco <= soma_prox;
				soma_tmp <= 0;
				devolver <= '1';
				saida <= '0';
			ELSIF soma_prox < 100 THEN
				soma_tmp <= soma_prox;
				troco <= 0;
				saida <= '0';
				devolver <= '0';
			ELSIF botao = '1' THEN
				soma_tmp <= 0;
				troco <= 0;
				saida <= '1';
				devolver <= '0';
			ELSE
				soma_tmp <= soma_prox;
				saida <= '0';
				devolver <= '0';
			END IF;
		END IF;

	END PROCESS;
END a;