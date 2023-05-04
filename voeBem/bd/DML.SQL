use voebem;
-- Aerporto
INSERT INTO aeroporto (codigo_aeroporto, nome_aeroporto, cidade, pais) VALUES
('1', 'Tancredo Neves - Confins', 'Belo Horizonte', 'Brasil'),
('2', 'Internacional de São Paulo - Guarulhos', 'Guarulhos', 'Brasil'),
('3', 'Cesar Bombonato', 'Uberlândia', 'Brasil'),
('4', 'Juscelino Kubitschek', 'Brasília', 'Brasil');
-- Piloto
INSERT INTO `piloto` (`codigo_piloto`, `nome_piloto`, `salario`, `gratificacao`, `companhia`, `pais`) VALUES
(1, 'Roberto Carlos', '5000.00', '2000.00', 'TAM', 'Brasil'),
(2, 'Rafael Marinho', '6000.00', '3000.00', 'GOL', 'Brasil'),
(3, 'Marcos Jose', '4000.00', '1000.00', 'TAP', 'Brasil'),
(4, 'Daniel Oliveira', '4000.00', '1500.00', 'TAM', 'Brasil'),
(5, 'Dmitri Mariskov', '5750.00', '2125.00', 'UTAIR', 'Rússia'),
(6, 'Edik Dyveke', '5300.00', '2910.00', 'ROSSIYA LINESAIR', 'Rússia'),
(7, 'Egor Bogdashha', '6100.00', '2075.00', 'S7 AIRLINES', 'Rússia'),
(8, 'Gav Aylena', '6278.00', '2030.00', 'S7 AEROFLOT', 'Rússia'),
(9, 'Oliver Denis', '7000.00', '2010.00', 'AIR FRANCE', 'França'),
(10, 'Michel Pol', '6510.00', '3055.00', 'FRENCH BLUE', 'França'),
(11, 'Jaqueline Nicole', '8000.00', '1029.00', 'AIGLE AZUR', 'França'),
(12, 'Jean Monila', '5973.00', '3490.00', 'TRANSAVIA FRANCE', 'França'),
(13, 'Wallace Valentin', '6251.00', '3343.00', 'XL AIRWAYS FRANCE', 'França'),
(14, 'Kadambini Padmaja', '5930.00', '3870.00', 'INDIGO AIRLINES', 'Índia'),
(15, 'Prem Haydish', '5185.00', '4050.00', 'KINGFISHER AIRLINES ', 'Índia'),
(16, 'Padma Pyas', '5770.00', '3833.00', 'BHARAT AIRWAYS', 'Índia'),
(17, 'Kabul Hasish', '4990.00', '4730.00', 'MDLR AIRLINES', 'Índia'),
(18, 'Mohamed yaha', '5010.00', '4390.00', 'MDLR AIRLINES', 'Índia'),
(19, 'Manoel Felipe', '7010.00', '3990.00', 'PORTUGÁLIA', 'Portugal'),
(20, 'Antônio Crescêncio', '6560.00', '3730.00', 'TAP PORTUGAL', 'Portugal'),
(21, 'Joaquim Bonifácio', '7810.00', '3000.00', 'AEROCONDOR', 'Portugal'),
(22, 'Alvarez da Cruz', '5970.00', '4010.00', 'ORBEST', 'Portugal');
-- Voo
INSERT INTO `voo` (`codigo_voo`, `aeroporto_origem`, `aeroporto_destino`, `hora`) VALUES
('A100', '2', '3', '12:00:00'),
('A200', '1', '2', '07:00:00'),
('A300', '3', '1', '23:00:00'),
('A400', '3', '2', '16:00:00');
-- Escala
INSERT INTO `escala` (`codigo_voo`, `data_voo`, `codigo_piloto`, `aviao`) VALUES
('A100', '2021-10-23', 4, 'Boeing 385'),
('A200', '2011-10-23', 1, 'Boeing 385'),
('A300', '2011-10-24', 2, 'AirBus232'),
('A400', '2012-10-25', 3, 'AirBus123');
