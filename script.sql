CREATE SCHEMA IF NOT EXISTS `PARQUE_DB` DEFAULT CHARACTER SET utf8 ;
USE `PARQUE_DB` ;

CREATE TABLE IF NOT EXISTS estados (
  `CD_ESTADO` INT NOT NULL,
  `NM_ESTADO` VARCHAR(100) NOT NULL,
  `UF_ESTADO` VARCHAR(2) NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_ESTADO`),
  UNIQUE INDEX `UF_ESTADO_UNIQUE` (`UF_ESTADO` ASC) VISIBLE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`CIDADES` (
  `CD_CIDADE` INT NOT NULL,
  `NM_CIDADE` VARCHAR(100) NOT NULL,
  `CD_ESTADO` INT NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_CIDADE`),
  INDEX `FK_CIDADE_CD_ESTADO_idx` (`CD_ESTADO` ASC) VISIBLE,
  CONSTRAINT `FK_CIDADE_CD_ESTADO`
    FOREIGN KEY (`CD_ESTADO`)
    REFERENCES estados (`CD_ESTADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`PESSOAS` (
  `CD_PESSOA` INT NOT NULL,
  `NM_PESSOA` VARCHAR(150) NOT NULL,
  `NR_CPF` VARCHAR(11) NOT NULL,
  `NR_TELEFONE` VARCHAR(45) NOT NULL,
  `TX_EMAIL` VARCHAR(150) NULL,
  `TX_RUA` VARCHAR(45) NULL,
  `TX_BAIRRO` VARCHAR(45) NULL,
  `NR_CASA` INT NULL,
  `CD_CIDADE` INT NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_PESSOA`),
  INDEX `FK_PESSOAS_CIDADES_idx` (`CD_CIDADE` ASC) VISIBLE,
  CONSTRAINT `FK_PESSOAS_CIDADES`
    FOREIGN KEY (`CD_CIDADE`)
    REFERENCES `PARQUE_DB`.`CIDADES` (`CD_CIDADE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`TIPOS_PASSAPORTES` (
  `CD_TIPO_PASSAPORTE` INT NOT NULL,
  `TX_DESCRICAO` VARCHAR(100) NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_TIPO_PASSAPORTE`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`PASSAPORTES` (
  `CD_PASSAPORTE` INT NOT NULL,
  `CD_PESSOA` INT NOT NULL,
  `VL_PRECO` DECIMAL(11,3) NOT NULL,
  `CD_TIPO_PASSAPORTE` INT NOT NULL,
  `DT_INICIO_VIGENCIA` DATE NOT NULL,
  `DT_FIM_VIGENCIA` DATE NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_PASSAPORTE`),
  INDEX `FK_PASSAPORTES_PESSOAS_idx` (`CD_PESSOA` ASC) VISIBLE,
  INDEX `FK_PASSAPORTES_TIPOS_PASSAPORTES_idx` (`CD_TIPO_PASSAPORTE` ASC) VISIBLE,
  CONSTRAINT `FK_PASSAPORTES_PESSOAS`
    FOREIGN KEY (`CD_PESSOA`)
    REFERENCES `PARQUE_DB`.`PESSOAS` (`CD_PESSOA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PASSAPORTES_TIPOS_PASSAPORTES`
    FOREIGN KEY (`CD_TIPO_PASSAPORTE`)
    REFERENCES `PARQUE_DB`.`TIPOS_PASSAPORTES` (`CD_TIPO_PASSAPORTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`TIPOS_MOVIMENTACOES` (
  `CD_TIPO_MOVIMENTO` INT NOT NULL,
  `TX_DESCRICAO` VARCHAR(100) NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_TIPO_MOVIMENTO`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`ATRACOES` (
  `CD_ATRACAO` INT NOT NULL,
  `NM_ATRACAO` VARCHAR(100) NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_ATRACAO`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`ESTABELECIMENTOS` (
  `CD_ESTABELECIMENTO` INT NOT NULL,
  `NM_ESTABELECIMENTO` VARCHAR(100) NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_ESTABELECIMENTO`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`FORNECEDORES` (
  `CD_FORNECEDOR` INT NOT NULL,
  `NM_FORNECEDOR` VARCHAR(100) NOT NULL,
  `CD_REPRESENTANTE` INT NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_FORNECEDOR`),
  INDEX `FK_FORNCEDORES_PESSOA_idx` (`CD_REPRESENTANTE` ASC) VISIBLE,
  CONSTRAINT `FK_FORNCEDORES_PESSOAS`
    FOREIGN KEY (`CD_REPRESENTANTE`)
    REFERENCES `PARQUE_DB`.`PESSOAS` (`CD_PESSOA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`MOVIMENTACOES` (
  `CD_MOVIMENTO` INT NOT NULL,
  `CD_TIPO_MOVIMENTO` INT NOT NULL,
  `DT_MOVIMENTO` DATETIME NULL,
  `CD_ATRACAO` INT NULL,
  `CD_ESTABELECIMENTO` INT NULL,
  `CD_FORNECEDOR` INT NULL,
  `CD_PASSAPORTE` INT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_MOVIMENTO`),
  INDEX `FK_MOVIMENTACOES_PASSAPORTES_idx` (`CD_PASSAPORTE` ASC) VISIBLE,
  INDEX `FK_MOVIMENTACOES_TIPOS_MOVIMENTACOES_idx` (`CD_TIPO_MOVIMENTO` ASC) VISIBLE,
  INDEX `FK_MAVIMENTACOES_ATRACOES_idx` (`CD_ATRACAO` ASC) VISIBLE,
  INDEX `FK_MAVIMENTACOES_ESTABELECIMENTOS_idx` (`CD_ESTABELECIMENTO` ASC) VISIBLE,
  INDEX `FK_MAVIMENTACOES_FORNECEDORES_idx` (`CD_FORNECEDOR` ASC) VISIBLE,
  CONSTRAINT `FK_MOVIMENTACOES_PASSAPORTES`
    FOREIGN KEY (`CD_PASSAPORTE`)
    REFERENCES `PARQUE_DB`.`PASSAPORTES` (`CD_PASSAPORTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MOVIMENTACOES_TIPOS_MOVIMENTACOES`
    FOREIGN KEY (`CD_TIPO_MOVIMENTO`)
    REFERENCES `PARQUE_DB`.`TIPOS_MOVIMENTACOES` (`CD_TIPO_MOVIMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAVIMENTACOES_ATRACOES`
    FOREIGN KEY (`CD_ATRACAO`)
    REFERENCES `PARQUE_DB`.`ATRACOES` (`CD_ATRACAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAVIMENTACOES_ESTABELECIMENTOS`
    FOREIGN KEY (`CD_ESTABELECIMENTO`)
    REFERENCES `PARQUE_DB`.`ESTABELECIMENTOS` (`CD_ESTABELECIMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAVIMENTACOES_FORNECEDORES`
    FOREIGN KEY (`CD_FORNECEDOR`)
    REFERENCES `PARQUE_DB`.`FORNECEDORES` (`CD_FORNECEDOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`PRODUTOS` (
  `CD_PRODUTO` INT NOT NULL,
  `NM_PRODUTO` VARCHAR(100) NOT NULL,
  `VL_PRODUTO` DECIMAL(11,3) NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_PRODUTO`))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`ESTOQUES` (
  `CD_ESTABELECIMENTO` INT NOT NULL,
  `CD_PRODUTO` INT NOT NULL,
  `QT_PRODUTO` DECIMAL(11,3) NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_ESTABELECIMENTO`, `CD_PRODUTO`),
  INDEX `FK_ESTOQUES_PRODUTOS_idx` (`CD_PRODUTO` ASC) VISIBLE,
  UNIQUE INDEX `CD_ESTABELECIMENTO_UNIQUE` (`CD_ESTABELECIMENTO` ASC, `CD_PRODUTO` ASC) INVISIBLE,
  CONSTRAINT `FK_ESTOQUES_PRODUTOS`
    FOREIGN KEY (`CD_PRODUTO`)
    REFERENCES `PARQUE_DB`.`PRODUTOS` (`CD_PRODUTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ESTOQUES_ESTABELECIMENTOS`
    FOREIGN KEY (`CD_ESTABELECIMENTO`)
    REFERENCES `PARQUE_DB`.`ESTABELECIMENTOS` (`CD_ESTABELECIMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`FUNCIONARIOS` (
  `CD_FUNCIONARIO` INT NOT NULL,
  `CD_PESSOA` INT NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_FUNCIONARIO`),
  INDEX `FK_FUNCIONARIOS_PESSOAS_idx` (`CD_PESSOA` ASC) VISIBLE,
  CONSTRAINT `FK_FUNCIONARIOS_PESSOAS`
    FOREIGN KEY (`CD_PESSOA`)
    REFERENCES `PARQUE_DB`.`PESSOAS` (`CD_PESSOA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`HORARIOS_TURNOS` (
  `CD_HORARIO_TURNO` INT NOT NULL,
  `CD_FUNCIONARIO` INT NOT NULL,
  `CD_ATRACAO` INT NULL,
  `CD_ESTABELECIMENTO` INT NULL,
  `DT_HORARIO_TURNO` DATE NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_HORARIO_TURNO`),
  INDEX `FK_HORARIOS_TURNOS_ATRACOES_idx` (`CD_ATRACAO` ASC) VISIBLE,
  INDEX `FK_HORARIOS_TURNOS_ESTABELECIMENTOS_idx` (`CD_ESTABELECIMENTO` ASC) VISIBLE,
  INDEX `FK_HORARIOS_TURNOS_FUNCIONARIOS_idx` (`CD_FUNCIONARIO` ASC) VISIBLE,
  CONSTRAINT `FK_HORARIOS_TURNOS_ATRACOES`
    FOREIGN KEY (`CD_ATRACAO`)
    REFERENCES `PARQUE_DB`.`ATRACOES` (`CD_ATRACAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_HORARIOS_TURNOS_ESTABELECIMENTOS`
    FOREIGN KEY (`CD_ESTABELECIMENTO`)
    REFERENCES `PARQUE_DB`.`ESTABELECIMENTOS` (`CD_ESTABELECIMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_HORARIOS_TURNOS_FUNCIONARIOS`
    FOREIGN KEY (`CD_FUNCIONARIO`)
    REFERENCES `PARQUE_DB`.`FUNCIONARIOS` (`CD_FUNCIONARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PARQUE_DB`.`MOVIMENTACOES_PRODUTOS` (
  `CD_MOVIMENTO` INT NOT NULL,
  `CD_PRODUTO` INT NOT NULL,
  `CD_FORNECEDOR` INT NULL,
  `QT_PRODUTO` DECIMAL(11,3) NOT NULL,
  `DATA_STAMP` DATETIME NULL,
  PRIMARY KEY (`CD_MOVIMENTO`, `CD_PRODUTO`),
  INDEX `FK_MOV_PROD_PRODUTOS_idx` (`CD_PRODUTO` ASC) VISIBLE,
  INDEX `FK_MOV_PROD_FORNECEDORES_idx` (`CD_FORNECEDOR` ASC) VISIBLE,
  CONSTRAINT `FK_MOV_PROD_MOVIMENTACOES`
    FOREIGN KEY (`CD_MOVIMENTO`)
    REFERENCES `PARQUE_DB`.`MOVIMENTACOES` (`CD_MOVIMENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MOV_PROD_PRODUTOS`
    FOREIGN KEY (`CD_PRODUTO`)
    REFERENCES `PARQUE_DB`.`PRODUTOS` (`CD_PRODUTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MOV_PROD_FORNECEDORES`
    FOREIGN KEY (`CD_FORNECEDOR`)
    REFERENCES `PARQUE_DB`.`FORNECEDORES` (`CD_FORNECEDOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `PARQUE_DB`;

DELIMITER $$
USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`ESTADOS_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `ESTADOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`ESTADOS_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `ESTADOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`CIDADES_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `CIDADES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`CIDADES_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `CIDADES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`PESSOAS_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `PESSOAS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`PESSOAS_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `PESSOAS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`TIPOS_PASSAPORTES_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `TIPOS_PASSAPORTES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`TIPOS_PASSAPORTES_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `TIPOS_PASSAPORTES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`PASSAPORTES_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `PASSAPORTES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`PASSAPORTES_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `PASSAPORTES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`TIPOS_MOVIMENTACOES_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `TIPOS_MOVIMENTACOES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`TIPOS_MOVIMENTACOES_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `TIPOS_MOVIMENTACOES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`ATRACOES_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `ATRACOES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`ATRACOES_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `ATRACOES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`ESTABELECIMENTOS_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `ESTABELECIMENTOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`ESTABELECIMENTOS_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `ESTABELECIMENTOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`FORNECEDORES_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `FORNECEDORES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`FORNECEDORES_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `FORNECEDORES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`MOVIMENTACOES_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `MOVIMENTACOES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`MOVIMENTACOES_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `MOVIMENTACOES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`PRODUTOS_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `PRODUTOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`PRODUTOS_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `PRODUTOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`ESTOQUES_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `ESTOQUES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`ESTOQUES_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `ESTOQUES` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`FUNCIONARIOS_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `FUNCIONARIOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`FUNCIONARIOS_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `FUNCIONARIOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`HORARIOS_TURNOS_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `HORARIOS_TURNOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`HORARIOS_TURNOS_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `HORARIOS_TURNOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`MOVIMENTACOES_PRODUTOS_BEFORE_INSERT_DATA_STAMP` BEFORE INSERT ON `MOVIMENTACOES_PRODUTOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$

USE `PARQUE_DB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PARQUE_DB`.`MOVIMENTACOES_PRODUTOS_BEFORE_UPDATE_DATA_STAMP` BEFORE UPDATE ON `MOVIMENTACOES_PRODUTOS` FOR EACH ROW
BEGIN
	SET NEW.DATA_STAMP = now();
END$$estados


DELIMITER ;


#---------------------------------------------------------------------------------------------------------------------------------------------------

#PROCEDURES REQUISITADAS PELO TRABALHO PARA CRIAR REGISTROS (2)

#--> PRODUTOS
DELIMITER $$
CREATE PROCEDURE pcr_inserir_registros_produtos(IN cd_prod_ini INT, IN cd_prod_fim INT)
BEGIN
	declare cd_prod_new INT default cd_prod_ini;
    
    while cd_prod_new <= cd_prod_fim do
		insert into produtos (CD_PRODUTO, NM_PRODUTO, VL_PRODUTO) values (cd_prod_new, concat('Produto_', cd_prod_new), rand()*100);
		set cd_prod_new = cd_prod_new + 1;
    end while;
	
END $$
DELIMITER ;

call parque_db.pcr_inserir_registros_produtos(1, 50);

#--> ESTABELECIMENTOS
DELIMITER $$
CREATE PROCEDURE pcr_inserir_registros_estabelecimentos(IN cd_estab_ini INT, IN cd_estab_fim INT)
BEGIN
	declare cd_estab_new INT default cd_estab_ini;
    
    while cd_estab_new <= cd_estab_fim do
		insert into estabelecimentos (CD_ESTABELECIMENTO, NM_ESTABELECIMENTO) values (cd_estab_new, concat('Estabelecimento_', cd_estab_new));
		set cd_estab_new = cd_estab_new + 1;
    end while;
	
END $$
DELIMITER ;

call parque_db.pcr_inserir_registros_estabelecimentos(1, 50);


#--> ESTOQUES
DELIMITER $$
CREATE PROCEDURE pcr_inserir_registros_estoques(IN qtde_estabelecimentos INT, IN qtde_produtos INT)
BEGIN
	declare cd_estab_new INT default 1;
    declare cd_prod_new INT default 1;
    
    while cd_estab_new <= qtde_estabelecimentos do
    
		while cd_prod_new <= qtde_produtos do
			insert into estoques (CD_ESTABELECIMENTO, CD_PRODUTO, QT_PRODUTO) values (cd_estab_new, cd_prod_new, truncate(rand()*10, 0));
			set cd_prod_new = cd_prod_new + 1;
        end while;
    
		set cd_estab_new = cd_estab_new + 1;
        set cd_prod_new = 1;
    end while;
	
END $$
DELIMITER ;

call parque_db.pcr_inserir_registros_estoques(30, 50);



#--> ATRAÇÕES
DELIMITER $$
CREATE PROCEDURE pcr_inserir_registros_atracoes(IN cd_atra_ini INT, IN cd_atra_fim INT)
BEGIN
	declare cd_atra_new INT default cd_atra_ini;
    
    while cd_atra_new <= cd_atra_fim do
		insert into atracoes (CD_ATRACAO, NM_ATRACAO) values (cd_atra_new, concat('Atração_', cd_atra_new));
		set cd_atra_new = cd_atra_new + 1;
    end while;
	
END $$
DELIMITER ;

call parque_db.pcr_inserir_registros_atracoes(1, 20);





#--> INSERÇÃO DE REGISTROS ENTIDADE "ESTADOS"
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('1', 'Acre', 'AC');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('2', 'Alagoas', 'AL');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('3', 'Amapá', 'AP');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('4', 'Amazonas', 'AM');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('5', 'Bahia', 'BA');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('6', 'Ceará', 'CE');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('7', 'Distrito Federal', 'DF');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('8', 'Espírito Santo', 'ES');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('9', 'Goiás', 'GO');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('10', 'Maranhão', 'MA');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('11', 'Mato Grosso', 'MT');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('12', 'Mato Grosso do Sul', 'MS');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('13', 'Minas Gerais', 'MG');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('14', 'Pará', 'PA');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('15', 'Paraíba', 'PB');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('16', 'Paraná', 'PR');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('17', 'Pernambuco', 'PE');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('18', 'Piaui', 'PI');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('19', 'Rio de Janeiro', 'RJ');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('20', 'Rio Grande do Norte', 'RN');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('21', 'Rio Grande do Sull', 'RS');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('22', 'Rondônia', 'RO');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('23', 'Roraima', 'RR');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('24', 'Santa Catarina', 'SC');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('25', 'São Paulo', 'SP');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('26', 'Sergipe', 'SE');
INSERT INTO estados (`CD_ESTADO`, `NM_ESTADO`, `UF_ESTADO`) VALUES ('27', 'Tocantins', 'TO');

#--> INSERÇÃO DE REGISTROS ENTIDADE "CIDADES"
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (1,7,"Lobbes");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (2,22,"Bruderheim");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (3,12,"Kapiti");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (4,14,"Bayreuth");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (5,25,"Melton Mowbray");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (6,12,"Yopal");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (7,9,"Cartagena");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (8,17,"San Martino in Pensilis");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (9,24,"Kanchipuram");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (10,8,"Quesada");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (11,23,"Lukhovitsy");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (12,18,"Bowden");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (13,13,"Piła");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (14,3,"Bradford");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (15,16,"Ashburton");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (16,13,"Basildon");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (17,24,"Sart-Eustache");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (18,17,"Soledad de Graciano Sánchez");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (19,14,"Mannekensvere");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (20,12,"Pamel");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (21,2,"Apeldoorn");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (22,17,"Guardia Perticara");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (23,11,"Hastings");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (24,2,"Labico");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (25,6,"Illapel");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (26,24,"Londrina");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (27,4,"Biggleswade");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (28,9,"Villar Pellice");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (29,22,"Levin");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (30,23,"Tuscaloosa");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (31,25,"Beervelde");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (32,17,"Piagge");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (33,26,"Sahiwal");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (34,22,"Buckingham");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (35,23,"Puntarenas");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (36,12,"Nelson");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (37,12,"Cerchio");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (38,3,"Baie-Saint-Paul");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (39,15,"Kingston");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (40,9,"South Dum Dum");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (41,1,"Pictou");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (42,3,"Guadalupe");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (43,11,"Strasbourg");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (44,21,"Maple Ridge");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (45,21,"Taber");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (46,11,"Plast");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (47,5,"Brucargo");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (48,25,"Bruckneudorf");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (49,1,"Lot");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (50,16,"Tallahassee");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (51,12,"Whitehorse");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (52,23,"Carbonear");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (53,7,"Zeya");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (54,25,"Florenville");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (55,9,"Thines");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (56,17,"Shipshaw");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (57,23,"Maipú");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (58,17,"Notre-Dame-du-Nord");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (59,23,"Heinsch");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (60,23,"Madiun");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (61,2,"Durness");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (62,22,"Torella del Sannio");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (63,14,"Vieuxville");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (64,5,"Oostende");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (65,3,"Sant'Omero");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (66,16,"Bolton");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (67,1,"San Pietro Avellana");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (68,1,"San Esteban");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (69,15,"Tank");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (70,9,"Saint-Eugine-de-Ladrire");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (71,21,"Francavilla Fontana");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (72,4,"Castelmarte");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (73,18,"Grave");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (74,19,"Houdemont");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (75,8,"Boca del Río");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (76,1,"Novo Hamburgo");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (77,15,"Romford");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (78,17,"Pierrefonds");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (79,2,"La Pintana");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (80,9,"Opprebais");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (81,14,"Dingwall");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (82,6,"Ortacesus");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (83,5,"Padang Sidempuan");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (84,26,"Grand-Manil");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (85,13,"Auburn");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (86,23,"Valcourt");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (87,9,"Temploux");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (88,11,"Likino-Dulyovo");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (89,10,"Ceranesi");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (90,21,"Ust-Katav");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (91,10,"Molino dei Torti");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (92,20,"Southaven");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (93,12,"Dehri");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (94,6,"Senftenberg");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (95,7,"Probolinggo");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (96,15,"Lokeren");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (97,7,"Timaukel");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (98,24,"Turrialba");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (99,10,"Ebenthal in Kärnten");
INSERT INTO cidades (cd_cidade,cd_estado,nm_cidade) VALUES (100,27,"Overrepen");




#--> INSERÇÃO DE REGISTROS ENTIDADE "TIPOS_PASSAPORTES"
INSERT INTO `parque_db`.`tipos_passaportes` (`CD_TIPO_PASSAPORTE`, `TX_DESCRICAO`) VALUES ('1', 'Criança');
INSERT INTO `parque_db`.`tipos_passaportes` (`CD_TIPO_PASSAPORTE`, `TX_DESCRICAO`) VALUES ('2', 'Adulto');
INSERT INTO `parque_db`.`tipos_passaportes` (`CD_TIPO_PASSAPORTE`, `TX_DESCRICAO`) VALUES ('3', 'Idoso');



#--> INSERÇÃO DE REGISTROS ENTIDADE "TIPOS_MOVIMENTACOES"
INSERT INTO `parque_db`.`tipos_movimentacoes` (`CD_TIPO_MOVIMENTO`, `TX_DESCRICAO`) VALUES ('1', 'Entrada Atração');
INSERT INTO `parque_db`.`tipos_movimentacoes` (`CD_TIPO_MOVIMENTO`, `TX_DESCRICAO`) VALUES ('2', 'Entrada Estabelecimento');
INSERT INTO `parque_db`.`tipos_movimentacoes` (`CD_TIPO_MOVIMENTO`, `TX_DESCRICAO`) VALUES ('3', 'Entrada Mercadoria');
INSERT INTO `parque_db`.`tipos_movimentacoes` (`CD_TIPO_MOVIMENTO`, `TX_DESCRICAO`) VALUES ('4', 'Saída Mercadoria');




#--> INSERÇÃO DE REGISTROS ENTIDADE "PESSOAS"
insert into pessoas (cd_pessoa, nm_pessoa, nr_cpf, nr_telefone, tx_email, tx_rua, tx_bairro, nr_casa, cd_cidade)
values (1, "Zahir", "32172124767", "953316397", "vitae.dolor@dapibusidblandit.edu", "7349 Elit. Street", "Wie", 71, 53),
(2, "Vielka", "81435557607", "923775055", "feugiat@a.ca", "P.O. Box 315, 3985 Non, Ave", "Oklahoma", 33, 90),
(3, "Wallace", "92801077833", "945885913", "commodo@Integerin.org", "Ap #220-7598 Ullamcorper, Road", "South Gyeongsang", 92, 18),
(4, "Casey", "64871259492", "985887233", "Curabitur.massa.Vestibulum@NullainterdumCurabitur.edu", "Ap #260-7802 Pellentesque Road", "Victoria", 87, 10),
(5, "Destiny", "81625228248", "916723715", "in.dolor@bibendumullamcorper.net", "P.O. Box 669, 2423 Sagittis Rd.", "Hamburg", 44, 50),
(6, "Astra", "25536429837", "978369614", "nisl.Quisque@eget.org", "P.O. Box 686, 1841 Auctor Avenue", "Vienna", 99, 71),
(7, "Cadman", "74326160425", "927643845", "lorem@pharetraNam.org", "194-2657 Ullamcorper, St.", "OV", 90, 48),
(8, "Rhoda", "79681533796", "937438833", "ut@lacus.net", "P.O. Box 151, 6260 Diam. Road", "Istanbul", 26, 24),
(9, "Katelyn", "51687152114", "936985349", "amet@auctor.net", "324-3243 Porttitor Avenue", "SI", 37, 3),
(10, "Gretchen", "14979329972", "941532098", "velit.egestas.lacinia@sociis.com", "P.O. Box 934, 756 Ornare, Road", "North Jeolla", 82, 100),
(11, "Porter", "81736863446", "969978644", "hendrerit.a.arcu@euismod.net", "Ap #278-9192 Mollis. Rd.", "JB", 85, 23),
(12, "Wyoming", "89515654865", "963327040", "lorem@aauctornon.org", "1469 Montes, Rd.", "Sindh", 47, 79),
(13, "Daphne", "55442436425", "931142389", "Cras.vulputate@arcuNuncmauris.edu", "987-2989 Pulvinar Rd.", "TAA", 63, 15),
(14, "Lars", "22946918282", "968273571", "tincidunt.adipiscing.Mauris@cursusnonegestas.ca", "P.O. Box 173, 7623 Lectus. Av.", "Västra Götalands län", 73, 77),
(15, "Colleen", "54767629404", "958432778", "diam.nunc@orci.com", "P.O. Box 166, 4485 Tempus St.", "Uttar Pradesh", 53, 23),
(16, "Bertha", "28964884811", "977978549", "arcu.Morbi.sit@malesuada.edu", "P.O. Box 897, 8066 Accumsan Ave", "Gye", 64, 25),
(17, "Dominic", "36119195759", "968979642", "placerat.augue@egestasDuisac.com", "Ap #340-4312 Malesuada Street", "SI", 53, 17),
(18, "Athena", "95243242836", "917547394", "adipiscing.fringilla@justosit.ca", "P.O. Box 720, 883 Tincidunt, Avenue", "LAM", 83, 51),
(19, "Serena", "95541315387", "937299760", "sit.amet.consectetuer@imperdiet.co.uk", "Ap #205-3226 Ullamcorper Ave", "LD", 27, 70),
(20, "Jesse", "69327179616", "988878844", "pellentesque@idnunc.edu", "P.O. Box 938, 3400 Integer Rd.", "QLD", 68, 13),
(21, "Hayfa", "68126070894", "974104874", "at.lacus.Quisque@NullainterdumCurabitur.com", "4688 Ac Av.", "KPK", 55, 54),
(22, "Axel", "70845422401", "951255257", "Nullam.feugiat.placerat@Donecnibh.com", "1914 Lectus St.", "OR", 74, 23),
(23, "Amal", "57278091891", "919105619", "sapien.molestie@dignissimmagnaa.edu", "589-454 Sed St.", "O", 76, 16),
(24, "Kasimir", "61823231352", "920315626", "Donec@utmi.net", "7912 Nibh Ave", "E", 32, 56),
(25, "Elmo", "31114912921", "933375043", "eget@tellus.co.uk", "P.O. Box 470, 9872 Mattis Rd.", "Île-de-France", 67, 70),
(26, "Calvin", "94154990623", "972359195", "tincidunt.Donec.vitae@metusAliquam.com", "P.O. Box 351, 4962 Congue. Avenue", "Wyoming", 37, 79),
(27, "Dante", "84264192596", "965417419", "nec@Aliquamgravida.org", "Ap #992-8346 Cum St.", "Biobío", 66, 48),
(28, "Nora", "93871978571", "962485356", "volutpat.ornare.facilisis@sapienNunc.org", "3207 Urna. Ave", "Friesland", 29, 28),
(29, "Naomi", "48709411812", "928621651", "orci.Phasellus@Fusce.co.uk", "Ap #117-4600 Taciti St.", "Baden Württemberg", 46, 65),
(30, "Lani", "93526638168", "972687669", "congue.In.scelerisque@aultriciesadipiscing.com", "Ap #948-1837 Nisi Rd.", "III", 80, 83),
(31, "Cally", "56336884465", "971285794", "feugiat.metus.sit@egestasrhoncus.com", "P.O. Box 507, 9165 Malesuada Av.", "Aydın", 28, 93),
(32, "Althea", "45477928494", "948928130", "rutrum@nullaCraseu.com", "Ap #104-1910 Tristique Street", "Małopolskie", 50, 46),
(33, "Quynn", "51335127487", "928721353", "nisi.Aenean@condimentumDonecat.net", "P.O. Box 737, 1969 Sodales Rd.", "Lombardia", 53, 73),
(34, "Desirae", "99442197854", "967219960", "tellus.Aenean.egestas@Inmi.edu", "Ap #314-1700 Sapien. Street", "New South Wales", 55, 54),
(35, "Clayton", "43621753171", "944442053", "ipsum@Praesent.edu", "647-6438 Tempus St.", "CE", 60, 15),
(36, "Valentine", "44608094128", "934638543", "netus.et.malesuada@malesuada.org", "6146 Fringilla Avenue", "AN", 77, 86),
(37, "Aubrey", "65117123695", "987733671", "a.sollicitudin@vehiculaPellentesquetincidunt.edu", "4578 Luctus St.", "ARE", 47, 36),
(38, "Inez", "16145632519", "978189485", "nisi@blanditcongue.edu", "111-1987 Vivamus Ave", "SK", 63, 88),
(39, "Melissa", "59271626906", "995126791", "vulputate@elit.ca", "517-797 Risus. Street", "HB", 29, 89),
(40, "Tara", "86978782101", "934618140", "ac.turpis.egestas@auctor.org", "635-890 Elit, St.", "SN", 32, 55),
(41, "Knox", "34769618493", "951356155", "vel.vulputate.eu@In.edu", "P.O. Box 246, 3537 Cras St.", "Utah", 63, 44),
(42, "Alexander", "49847985948", "961728894", "mauris.sit.amet@nullamagna.edu", "5375 Nec Road", "KPK", 80, 98),
(43, "Herrod", "14617156622", "943515666", "velit@consectetueripsumnunc.co.uk", "Ap #176-8648 Penatibus Ave", "BOL", 75, 34),
(44, "Timothy", "69351938824", "970825841", "Aliquam@egestasnunc.co.uk", "Ap #734-9531 Lacus. Avenue", "BE", 46, 19),
(45, "Michael", "37984328835", "933817448", "odio@duiquis.edu", "Ap #732-3183 Eget Street", "Berlin", 30, 98),
(46, "Marvin", "54216257648", "977294927", "tincidunt.vehicula.risus@magna.com", "409-3448 Lorem Rd.", "C", 75, 97),
(47, "Trevor", "42439326545", "914899051", "tempor@ridiculusmus.net", "441-6494 Ullamcorper Rd.", "Cusco", 74, 4),
(48, "John", "84151325704", "969355447", "tortor.Integer@lacus.com", "4582 Nunc Rd.", "Kerala", 31, 86),
(49, "Brenden", "90178250569", "938835831", "adipiscing.enim@ante.net", "494-4970 Integer Rd.", "Biobío", 77, 47),
(50, "Kameko", "54519662928", "976404463", "mauris.rhoncus@est.edu", "322 Vivamus St.", "WA", 36, 3),
(51, "Constance", "46615097138", "947828618", "tortor.dictum@ametanteVivamus.com", "P.O. Box 211, 5718 Massa. Road", "NSW", 50, 52),
(52, "Logan", "62779350595", "969683345", "mi.pede@ornare.net", "Ap #736-3681 Porttitor Rd.", "Antioquia", 86, 12),
(53, "Fletcher", "49521652493", "916915791", "eu.eleifend@loremloremluctus.edu", "Ap #829-3757 Auctor, St.", "Poitou-Charentes", 43, 28),
(54, "Gavin", "20121030385", "959423240", "Integer@etmagna.edu", "Ap #313-7901 Nec Rd.", "Antioquia", 59, 91),
(55, "Ali", "56661570757", "944389440", "tristique.senectus.et@aliquetmetus.edu", "Ap #198-5876 Id, St.", "Ontario", 46, 72),
(56, "Caleb", "31321665444", "979418326", "dui.Fusce@egetvenenatis.net", "P.O. Box 868, 5225 Velit. Ave", "SJ", 71, 47),
(57, "Tyler", "39837253891", "928313311", "eu.tellus@vellectusCum.edu", "789-5122 Faucibus Av.", "CE", 51, 20),
(58, "Tanisha", "40801260821", "910628529", "lobortis@Aliquam.org", "929-2432 Mauris Road", "MG", 28, 40),
(59, "Clayton", "86709012337", "980292960", "Nullam.ut.nisi@anteiaculisnec.edu", "290-2268 Lorem, Av.", "L", 56, 48),
(60, "Arden", "44746578638", "982349937", "at.augue@utsemNulla.org", "Ap #310-1892 Sit Rd.", "North Island", 90, 23),
(61, "Julian", "36602227469", "972837221", "magna.Nam.ligula@vel.org", "466-6009 Dictum. Av.", "Central Java", 91, 65),
(62, "Simone", "20405673584", "979678134", "Duis@Proinnislsem.co.uk", "2101 Orci Av.", "SA", 25, 3),
(63, "Sybil", "59229299454", "938209086", "euismod.est@Suspendissecommodo.org", "Ap #834-2174 Phasellus Street", "North Island", 83, 82),
(64, "Xantha", "21745087102", "949447487", "sem.semper.erat@pedeNunc.org", "P.O. Box 776, 5401 Neque St.", "East Java", 89, 16),
(65, "Jaquelyn", "33808589296", "969511572", "leo@vitae.ca", "8257 Phasellus Road", "Małopolskie", 90, 81),
(66, "Vera", "87354197497", "921483943", "dis.parturient.montes@vehicula.edu", "P.O. Box 297, 9914 Mauris Ave", "AB", 86, 54),
(67, "Quail", "30567512189", "929374984", "eu@mifringilla.net", "P.O. Box 776, 8896 Adipiscing Rd.", "JI", 63, 88),
(68, "Marsden", "15707051202", "998248092", "Donec.tempor.est@Curabitur.net", "924-2186 Sociis St.", "Jigawa", 58, 20),
(69, "Audra", "63725652845", "976817267", "tortor.dictum@lobortisquam.net", "P.O. Box 205, 6154 Lacus. Avenue", "VIC", 31, 67),
(70, "Winifred", "29112560613", "947942790", "metus@nislMaecenas.org", "P.O. Box 835, 7615 Porttitor Rd.", "Vlaams-Brabant", 90, 66),
(71, "Silas", "80194040892", "917888058", "magna.nec@Aeneanegetmagna.org", "Ap #243-8392 Non Road", "Ulyanovsk Oblast", 48, 15),
(72, "Audrey", "38991460855", "974536229", "vehicula.Pellentesque.tincidunt@dictumultriciesligula.edu", "P.O. Box 132, 3793 Vitae St.", "NI", 36, 5),
(73, "Laith", "49473091857", "995619366", "felis.ullamcorper@Donectemporest.org", "Ap #537-2567 Per Av.", "ARE", 45, 40),
(74, "Herman", "15443346947", "988247629", "Aliquam@nisimagna.edu", "2849 Tempor Street", "AK", 72, 44),
(75, "Brent", "77688613153", "962885014", "facilisis.vitae@rutrumurnanec.co.uk", "1813 Nonummy. Avenue", "N.", 70, 71),
(76, "Sheila", "87363733618", "971642733", "cursus.a@purusgravida.org", "P.O. Box 145, 7600 Aenean Avenue", "Central Java", 34, 43),
(77, "TaShya", "42352192996", "947857434", "Aliquam.gravida.mauris@Duis.net", "9270 Quis Rd.", "EL", 96, 28),
(78, "Ruth", "41192478709", "971324826", "Fusce@lobortismauris.ca", "3280 Tincidunt Av.", "Guanajuato", 78, 28),
(79, "Regina", "76762880793", "995541689", "magna.Nam.ligula@tempusscelerisquelorem.com", "P.O. Box 501, 3192 Ac Rd.", "North Island", 31, 28),
(80, "Hakeem", "22494630252", "922289964", "dui@egestasurna.org", "173-3395 Natoque Rd.", "Maine", 86, 68),
(81, "Signe", "50622184941", "926859920", "quis.pede.Suspendisse@volutpatornarefacilisis.ca", "Ap #741-481 Vel St.", "BR", 96, 20),
(82, "Amena", "24294970418", "970847957", "ligula.eu@vel.net", "Ap #761-2145 Eget St.", "QC", 38, 89),
(83, "Virginia", "80873072305", "922869187", "in.aliquet.lobortis@lobortis.ca", "Ap #100-1623 Vivamus St.", "Gye", 31, 97),
(84, "Kaseem", "86257716884", "950349915", "mauris@egestasascelerisque.net", "P.O. Box 630, 5204 Nibh. Street", "CAJ", 31, 86),
(85, "Conan", "80988589734", "962556949", "Integer@dignissimlacusAliquam.edu", "Ap #655-1028 Vel, Av.", "Ontario", 89, 14),
(86, "Salvador", "38555966679", "951645174", "nec.malesuada@egetmetuseu.net", "P.O. Box 910, 1185 Rutrum St.", "Alajuela", 76, 48),
(87, "Belle", "72967732832", "915328462", "sed.dolor.Fusce@rutrum.co.uk", "2539 Nisi Road", "OH", 41, 13),
(88, "Nehru", "53131595195", "965124026", "est.Nunc.ullamcorper@lacusQuisquepurus.net", "P.O. Box 753, 5765 Ridiculus St.", "HB", 81, 47),
(89, "Cassidy", "68614198526", "980654998", "placerat.velit@Donec.net", "607-7455 Integer Road", "Guanajuato", 37, 83),
(90, "Rylee", "25482363256", "923925948", "ultricies.sem@laoreet.org", "P.O. Box 885, 5576 Lobortis Av.", "PU", 49, 93),
(91, "Amethyst", "59934886288", "937123587", "feugiat@utsem.net", "P.O. Box 976, 9314 Posuere Street", "Chu", 79, 100),
(92, "Macy", "98539717906", "991206675", "augue@semNulla.com", "Ap #188-402 Non, St.", "Berkshire", 68, 91),
(93, "Lillith", "41769184227", "952752147", "viverra@at.com", "9203 Pellentesque Rd.", "KIR", 85, 54),
(94, "Judith", "54979167294", "987613552", "Lorem@DonectinciduntDonec.co.uk", "Ap #571-7653 Aenean St.", "HH", 84, 64),
(95, "Serena", "18128957935", "981964270", "parturient@natoque.co.uk", "P.O. Box 501, 5499 Consectetuer St.", "Basilicata", 93, 51),
(96, "Ariel", "37641032567", "974667925", "pharetra.ut@nonmagnaNam.co.uk", "P.O. Box 817, 270 Ac Road", "C", 84, 72),
(97, "Igor", "90377944746", "958407231", "auctor.Mauris@Pellentesque.ca", "282-5860 Egestas. Avenue", "Cantabria", 54, 8),
(98, "Cruz", "26732068794", "982948289", "libero@a.co.uk", "Ap #139-2539 Id Avenue", "HE", 36, 32),
(99, "Nicholas", "97628443119", "959403651", "malesuada.vel@morbitristique.net", "770-1879 Rutrum, Street", "DS", 81, 58),
(100, "Libby", "52982088191", "940394045", "diam@turpisnonenim.org", "Ap #171-6534 Sapien. St.", "GB", 49, 81);




#--> INSERÇÃO DE REGISTROS ENTIDADE "FUNCIONÁRIOS"
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (1,1);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (2,3);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (3,5);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (4,7);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (5,9);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (6,11);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (7,13);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (8,15);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (9,17);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (10,19);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (11,21);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (12,23);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (13,25);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (14,27);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (15,29);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (16,31);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (17,33);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (18,35);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (19,37);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (20,39);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (21,41);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (22,43);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (23,45);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (24,47);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (25,49);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (26,51);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (27,53);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (28,55);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (29,57);
INSERT INTO funcionarios (cd_funcionario,cd_pessoa) VALUES (30,59);




#--> INSERÇÃO DE REGISTROS ENTIDADE "FORNECEDORES"
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (1,"Lectus PC",14);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (2,"Interdum Feugiat Inc.",26);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (3,"Nec Mauris Company",46);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (4,"Aenean Egestas Corporation",28);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (5,"Suspendisse Aliquet Sem LLP",47);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (6,"Nisl Inc.",23);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (7,"Nullam Incorporated",74);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (8,"Nulla Integer Ltd",89);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (9,"Egestas A Incorporated",8);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (10,"Auctor Nunc Nulla Company",9);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (11,"Dapibus Quam Company",65);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (12,"Orci Lacus Associates",46);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (13,"Arcu Vestibulum Ltd",14);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (14,"Eget Institute",14);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (15,"Praesent Eu Nulla Limited",72);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (16,"Nisl Nulla Inc.",37);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (17,"Duis A Mi Foundation",20);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (18,"Nulla Tempor Foundation",79);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (19,"Montes Nascetur Ridiculus Institute",62);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (20,"Nullam Velit PC",28);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (21,"Molestie In Tempus Inc.",91);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (22,"Neque Sed Dictum Industries",3);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (23,"Sodales Elit Company",68);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (24,"Ipsum Institute",64);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (25,"Blandit Enim Consequat Company",58);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (26,"Dolor Company",55);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (27,"Placerat Orci Limited",25);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (28,"Erat Corp.",10);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (29,"Sociis LLP",56);
INSERT INTO fornecedores (cd_fornecedor,nm_fornecedor,cd_representante) VALUES (30,"Convallis Industries",73);



#--> INSERÇÃO DE REGISTROS ENTIDADE "PASSAPORTES"
insert into passaportes (cd_passaporte, cd_pessoa, vl_preco, cd_tipo_passaporte, dt_inicio_vigencia, dt_fim_vigencia)
values (1, 20, "161.28", 1, "2020/10/23", "2020/11/24"),
(2, 19, "174.62", 1, "2020/10/01", "2020/11/07"),
(3, 15, "446.24", 2, "2020/10/24", "2020/11/07"),
(4, 98, "140.23", 1, "2020/10/04", "2020/11/13"),
(5, 57, "197.33", 1, "2020/10/07", "2020/11/29"),
(6, 87, "492.46", 3, "2020/10/10", "2020/11/26"),
(7, 86, "442.82", 1, "2020/10/22", "2020/11/04"),
(8, 92, "488.98", 1, "2020/10/30", "2020/11/18"),
(9, 59, "298.88", 3, "2020/10/30", "2020/11/21"),
(10, 13, "161.89", 2, "2020/10/12", "2020/11/08"),
(11, 75, "477.78", 3, "2020/10/20", "2020/11/21"),
(12, 11, "189.77", 1, "2020/10/14", "2020/11/28"),
(13, 1, "388.04", 1, "2020/10/08", "2020/11/19"),
(14, 30, "177.40", 2, "2020/10/11", "2020/11/16"),
(15, 82, "422.40", 1, "2020/10/09", "2020/11/15"),
(16, 91, "146.87", 3, "2020/10/18", "2020/11/04"),
(17, 5, "162.94", 1, "2020/10/31", "2020/11/01"),
(18, 74, "428.90", 3, "2020/10/04", "2020/11/30"),
(19, 38, "494.71", 2, "2020/10/26", "2020/11/29"),
(20, 8, "268.10", 3, "2020/10/22", "2020/11/20"),
(21, 65, "268.65", 1, "2020/10/17", "2020/11/25"),
(22, 23, "302.22", 1, "2020/10/24", "2020/11/30"),
(23, 12, "396.99", 3, "2020/10/08", "2020/11/01"),
(24, 4, "192.30", 2, "2020/10/21", "2020/11/28"),
(25, 21, "416.96", 2, "2020/10/06", "2020/11/14"),
(26, 72, "260.96", 3, "2020/10/17", "2020/11/16"),
(27, 23, "377.29", 2, "2020/10/29", "2020/11/01"),
(28, 82, "204.34", 1, "2020/10/07", "2020/11/11"),
(29, 25, "101.92", 3, "2020/10/11", "2020/11/10"),
(30, 92, "405.11", 2, "2020/10/29", "2020/11/20"),
(31, 86, "205.69", 3, "2020/10/12", "2020/11/21"),
(32, 61, "403.95", 1, "2020/10/30", "2020/11/08"),
(33, 66, "127.00", 2, "2020/10/25", "2020/11/27"),
(34, 1, "379.35", 1, "2020/10/31", "2020/11/08"),
(35, 25, "432.64", 1, "2020/10/23", "2020/11/26"),
(36, 33, "151.51", 3, "2020/10/29", "2020/11/24"),
(37, 70, "168.54", 1, "2020/10/05", "2020/11/25"),
(38, 24, "487.52", 3, "2020/10/07", "2020/11/21"),
(39, 85, "442.48", 3, "2020/10/11", "2020/11/25"),
(40, 59, "324.91", 2, "2020/10/28", "2020/11/02"),
(41, 66, "456.88", 3, "2020/10/26", "2020/11/03"),
(42, 37, "136.37", 2, "2020/10/19", "2020/11/05"),
(43, 20, "270.47", 3, "2020/10/30", "2020/11/04"),
(44, 23, "313.32", 3, "2020/10/08", "2020/11/26"),
(45, 22, "495.10", 1, "2020/10/12", "2020/11/30"),
(46, 89, "172.92", 1, "2020/10/02", "2020/11/20"),
(47, 6, "425.51", 3, "2020/10/18", "2020/11/25"),
(48, 3, "433.99", 3, "2020/10/23", "2020/11/15"),
(49, 40, "398.13", 2, "2020/10/02", "2020/11/08"),
(50, 2, "125.01", 2, "2020/10/18", "2020/11/22"),
(51, 52, "314.70", 3, "2020/10/22", "2020/11/19"),
(52, 38, "291.49", 2, "2020/10/28", "2020/11/30"),
(53, 39, "488.27", 3, "2020/10/02", "2020/11/13"),
(54, 96, "183.72", 1, "2020/10/18", "2020/11/02"),
(55, 23, "167.96", 1, "2020/10/10", "2020/11/08"),
(56, 99, "214.60", 3, "2020/10/06", "2020/11/12"),
(57, 41, "347.86", 3, "2020/10/30", "2020/11/13"),
(58, 24, "321.95", 3, "2020/10/05", "2020/11/15"),
(59, 18, "358.47", 3, "2020/10/09", "2020/11/21"),
(60, 51, "128.01", 2, "2020/10/03", "2020/11/23"),
(61, 97, "402.81", 1, "2020/10/03", "2020/11/04"),
(62, 82, "108.64", 2, "2020/10/22", "2020/11/07"),
(63, 38, "344.41", 2, "2020/10/24", "2020/11/10"),
(64, 85, "495.48", 1, "2020/10/27", "2020/11/25"),
(65, 47, "184.64", 2, "2020/10/24", "2020/11/24"),
(66, 52, "219.68", 2, "2020/10/24", "2020/11/03"),
(67, 1, "408.62", 2, "2020/10/21", "2020/11/15"),
(68, 52, "454.33", 1, "2020/10/03", "2020/11/26"),
(69, 6, "361.64", 2, "2020/10/05", "2020/11/25"),
(70, 3, "337.30", 2, "2020/10/25", "2020/11/19"),
(71, 43, "270.83", 3, "2020/10/24", "2020/11/16"),
(72, 56, "174.69", 3, "2020/10/30", "2020/11/09"),
(73, 80, "482.18", 1, "2020/10/19", "2020/11/17"),
(74, 55, "367.50", 2, "2020/10/24", "2020/11/06"),
(75, 75, "138.88", 3, "2020/10/28", "2020/11/01"),
(76, 87, "347.20", 1, "2020/10/19", "2020/11/20"),
(77, 68, "120.71", 3, "2020/10/27", "2020/11/23"),
(78, 61, "317.87", 2, "2020/10/11", "2020/11/02"),
(79, 11, "424.80", 1, "2020/10/14", "2020/11/14"),
(80, 36, "367.60", 1, "2020/10/13", "2020/11/30"),
(81, 93, "187.83", 2, "2020/10/25", "2020/11/05"),
(82, 64, "491.40", 1, "2020/10/04", "2020/11/21"),
(83, 42, "245.61", 3, "2020/10/23", "2020/11/14"),
(84, 89, "446.69", 3, "2020/10/29", "2020/11/21"),
(85, 56, "467.20", 3, "2020/10/26", "2020/11/16"),
(86, 52, "300.44", 3, "2020/10/02", "2020/11/16"),
(87, 76, "367.79", 3, "2020/10/29", "2020/11/16"),
(88, 68, "420.27", 2, "2020/10/25", "2020/11/12"),
(89, 45, "300.91", 2, "2020/10/12", "2020/11/17"),
(90, 98, "427.33", 2, "2020/10/21", "2020/11/05"),
(91, 3, "102.53", 3, "2020/10/04", "2020/11/24"),
(92, 47, "405.56", 2, "2020/10/29", "2020/11/27"),
(93, 99, "338.49", 1, "2020/10/15", "2020/11/28"),
(94, 78, "190.76", 3, "2020/10/18", "2020/11/25"),
(95, 99, "350.48", 2, "2020/10/16", "2020/11/10"),
(96, 43, "346.40", 1, "2020/10/23", "2020/11/07"),
(97, 27, "184.85", 3, "2020/10/16", "2020/11/01"),
(98, 100, "273.42", 2, "2020/10/05", "2020/11/20"),
(99, 31, "399.95", 2, "2020/10/28", "2020/11/06"),
(100, 21, "360.48", 3, "2020/10/29", "2020/11/08");




#--> INSERÇÃO DE REGISTROS ENTIDADE "MOVIMENTOS"
insert into movimentacoes (cd_movimento, cd_tipo_movimento, dt_movimento, cd_atracao, cd_passaporte)
values (1, "1", "2019-11-24 15:43:34", 18, 49),
(2, "1", "2020-02-10 05:39:15", 5, 75),
(3, "1", "2020-08-25 14:42:14", 3, 33),
(4, "1", "2019-11-12 03:50:09", 10, 1),
(5, "1", "2020-03-05 13:29:55", 20, 60),
(6, "1", "2020-04-13 06:43:53", 13, 52),
(7, "1", "2019-11-23 22:29:11", 12, 26),
(8, "1", "2019-11-27 09:56:45", 19, 99),
(9, "1", "2020-10-10 23:24:27", 3, 3),
(10, "1", "2020-11-11 15:45:33", 14, 21),
(11, "1", "2020-03-31 07:37:28", 4, 1),
(12, "1", "2020-06-25 00:19:37", 14, 63),
(13, "1", "2020-01-31 09:35:53", 8, 27),
(14, "1", "2020-08-03 00:20:04", 1, 46),
(15, "1", "2020-07-15 19:45:50", 4, 98),
(16, "1", "2020-09-17 18:49:26", 5, 63),
(17, "1", "2020-05-30 11:59:02", 2, 16),
(18, "1", "2019-10-09 15:44:19", 6, 96),
(19, "1", "2020-07-31 20:55:25", 14, 22),
(20, "1", "2020-01-09 21:36:46", 9, 65),
(21, "1", "2020-07-07 18:34:03", 9, 46),
(22, "1", "2020-10-30 19:06:13", 13, 37),
(23, "1", "2020-05-10 17:24:55", 10, 93),
(24, "1", "2020-08-20 08:27:14", 3, 61),
(25, "1", "2020-03-13 03:45:16", 11, 77),
(26, "1", "2020-05-29 18:43:56", 4, 9),
(27, "1", "2020-02-27 06:13:38", 4, 52),
(28, "1", "2020-06-21 12:46:07", 14, 19),
(29, "1", "2020-05-07 00:08:52", 3, 63),
(30, "1", "2020-08-12 13:18:17", 7, 2),
(31, "1", "2019-11-21 18:09:51", 15, 76),
(32, "1", "2020-07-18 20:29:13", 10, 29),
(33, "1", "2020-01-05 20:37:46", 14, 30),
(34, "1", "2020-01-12 21:44:16", 17, 87),
(35, "1", "2020-09-29 21:51:57", 8, 77),
(36, "1", "2020-11-13 00:52:16", 17, 83),
(37, "1", "2019-12-03 07:23:36", 6, 16),
(38, "1", "2020-04-08 15:41:21", 18, 23),
(39, "1", "2019-12-09 16:09:16", 10, 22),
(40, "1", "2020-02-24 08:20:11", 17, 63),
(41, "1", "2020-07-12 14:51:01", 13, 45),
(42, "1", "2020-01-11 03:01:15", 15, 13),
(43, "1", "2020-10-31 18:11:14", 1, 41),
(44, "1", "2020-07-22 10:02:26", 11, 57),
(45, "1", "2020-06-12 19:40:37", 18, 59),
(46, "1", "2020-08-21 17:33:02", 19, 65),
(47, "1", "2020-05-01 13:03:10", 4, 74),
(48, "1", "2020-01-04 21:19:17", 4, 75),
(49, "1", "2020-11-20 02:48:29", 17, 83),
(50, "1", "2020-05-13 17:44:44", 8, 27),
(51, "1", "2020-02-05 18:22:01", 14, 44),
(52, "1", "2020-08-19 10:50:59", 15, 34),
(53, "1", "2020-10-23 22:43:44", 16, 67),
(54, "1", "2020-03-19 07:21:23", 2, 77),
(55, "1", "2020-01-05 13:35:00", 16, 50),
(56, "1", "2020-09-13 11:19:25", 8, 62),
(57, "1", "2020-02-23 16:50:40", 8, 54),
(58, "1", "2020-07-19 17:45:06", 3, 48),
(59, "1", "2020-07-06 02:45:36", 10, 60),
(60, "1", "2020-09-13 15:21:40", 6, 51),
(61, "1", "2020-06-05 17:56:50", 11, 47),
(62, "1", "2020-03-08 19:49:18", 15, 29),
(63, "1", "2020-09-30 14:02:56", 1, 40),
(64, "1", "2020-04-30 03:05:42", 19, 97),
(65, "1", "2020-03-17 02:15:51", 17, 99),
(66, "1", "2019-11-19 17:47:03", 14, 36),
(67, "1", "2020-10-28 18:57:34", 18, 85),
(68, "1", "2020-05-15 12:06:38", 9, 63),
(69, "1", "2020-06-06 03:32:01", 2, 59),
(70, "1", "2020-11-25 07:25:16", 14, 98),
(71, "1", "2020-09-23 07:23:59", 18, 24),
(72, "1", "2020-07-14 16:12:11", 3, 54),
(73, "1", "2020-10-04 21:56:34", 8, 83),
(74, "1", "2020-02-26 05:09:40", 5, 61),
(75, "1", "2020-02-06 14:53:06", 12, 13),
(76, "1", "2020-07-13 06:18:07", 8, 67),
(77, "1", "2020-11-03 02:43:24", 12, 1),
(78, "1", "2020-09-30 09:22:39", 6, 75),
(79, "1", "2020-07-28 14:32:49", 16, 16),
(80, "1", "2019-10-26 19:25:13", 19, 9),
(81, "1", "2020-06-22 15:56:31", 14, 70),
(82, "1", "2020-06-24 14:55:35", 18, 50),
(83, "1", "2020-10-19 03:45:13", 5, 41),
(84, "1", "2020-11-14 23:20:56", 15, 54),
(85, "1", "2020-02-17 00:20:18", 15, 84),
(86, "1", "2020-09-29 01:24:51", 2, 7),
(87, "1", "2020-06-15 20:08:18", 9, 10),
(88, "1", "2020-03-18 21:51:27", 1, 88),
(89, "1", "2020-01-08 03:33:13", 10, 77),
(90, "1", "2020-08-17 20:07:53", 4, 60),
(91, "1", "2020-02-25 12:51:14", 18, 11),
(92, "1", "2020-10-08 12:32:39", 18, 27),
(93, "1", "2020-09-09 19:19:11", 9, 25),
(94, "1", "2020-09-01 08:09:57", 9, 90),
(95, "1", "2020-05-23 15:37:38", 5, 47),
(96, "1", "2020-01-28 12:40:23", 8, 96),
(97, "1", "2020-03-29 04:27:37", 5, 7),
(98, "1", "2019-12-11 03:31:43", 19, 5),
(99, "1", "2019-12-30 22:06:52", 3, 59),
(100, "1", "2020-07-03 04:32:41", 4, 71);

insert into movimentacoes (cd_movimento, cd_tipo_movimento, dt_movimento, cd_estabelecimento, cd_passaporte)
values (101, "2", "2020-01-15 18:16:38", 25, 69),
(102, "2", "2020-09-19 07:32:16", 15, 39),
(103, "2", "2019-11-01 14:04:32", 1, 73),
(104, "2", "2020-10-15 09:33:43", 7, 78),
(105, "2", "2020-08-21 20:38:29", 29, 4),
(106, "2", "2020-05-28 07:42:08", 25, 72),
(107, "2", "2019-12-21 18:36:49", 10, 48),
(108, "2", "2020-10-17 08:26:54", 27, 13),
(109, "2", "2019-12-14 08:49:24", 3, 68),
(110, "2", "2019-11-16 01:18:50", 22, 4),
(111, "2", "2020-04-20 05:54:28", 24, 81),
(112, "2", "2020-04-26 17:02:14", 26, 81),
(113, "2", "2020-06-24 03:16:23", 22, 61),
(114, "2", "2020-09-16 00:04:51", 21, 10),
(115, "2", "2019-11-28 05:50:08", 2, 19),
(116, "2", "2020-06-07 06:46:27", 9, 75),
(117, "2", "2020-08-10 22:58:53", 27, 41),
(118, "2", "2020-03-27 13:19:35", 5, 22),
(119, "2", "2020-02-12 13:03:37", 25, 33),
(120, "2", "2020-05-30 11:58:25", 25, 84),
(121, "2", "2020-02-14 22:35:59", 30, 79),
(122, "2", "2020-09-30 17:48:25", 8, 86),
(123, "2", "2019-11-10 05:32:44", 12, 65),
(124, "2", "2020-09-02 13:02:54", 14, 15),
(125, "2", "2020-04-05 10:45:24", 3, 43),
(126, "2", "2020-07-28 19:39:26", 11, 87),
(127, "2", "2020-09-06 16:07:55", 7, 5),
(128, "2", "2020-04-06 04:39:51", 11, 41),
(129, "2", "2020-06-11 08:36:39", 12, 6),
(130, "2", "2019-11-22 02:43:30", 5, 47),
(131, "2", "2020-09-19 02:35:21", 13, 21),
(132, "2", "2019-10-03 06:44:51", 22, 30),
(133, "2", "2020-08-09 19:33:36", 1, 31),
(134, "2", "2020-10-03 16:10:03", 28, 3),
(135, "2", "2019-11-12 01:49:00", 20, 49),
(136, "2", "2020-01-15 23:25:35", 12, 96),
(137, "2", "2019-12-30 01:54:40", 4, 3),
(138, "2", "2020-05-19 03:29:36", 29, 74),
(139, "2", "2019-12-18 14:36:39", 7, 10),
(140, "2", "2020-09-02 10:58:55", 4, 4),
(141, "2", "2020-11-01 05:21:26", 28, 98),
(142, "2", "2020-07-04 14:09:55", 24, 43),
(143, "2", "2020-01-19 16:58:12", 7, 91),
(144, "2", "2019-12-03 20:09:35", 21, 38),
(145, "2", "2020-04-07 08:31:25", 24, 11),
(146, "2", "2019-11-11 04:41:16", 23, 76),
(147, "2", "2020-02-14 06:34:57", 30, 39),
(148, "2", "2020-09-21 15:05:26", 25, 15),
(149, "2", "2020-09-26 11:59:45", 22, 71),
(150, "2", "2020-03-06 17:32:46", 9, 93),
(151, "2", "2020-09-03 11:55:22", 4, 25),
(152, "2", "2019-12-02 03:09:01", 3, 51),
(153, "2", "2020-11-02 06:35:51", 21, 50),
(154, "2", "2020-06-26 13:30:28", 13, 6),
(155, "2", "2019-12-20 12:22:33", 20, 99),
(156, "2", "2020-09-01 03:07:13", 21, 31),
(157, "2", "2020-03-17 08:20:05", 5, 82),
(158, "2", "2019-10-16 08:11:20", 14, 54),
(159, "2", "2020-03-28 19:56:41", 9, 57),
(160, "2", "2020-07-01 03:55:31", 3, 9),
(161, "2", "2020-10-03 11:09:49", 2, 43),
(162, "2", "2020-09-23 09:34:43", 28, 33),
(163, "2", "2020-08-25 08:52:38", 22, 8),
(164, "2", "2020-03-23 12:01:57", 19, 3),
(165, "2", "2019-11-13 10:21:53", 11, 34),
(166, "2", "2020-05-02 21:44:49", 15, 21),
(167, "2", "2020-06-22 06:53:20", 10, 20),
(168, "2", "2020-06-19 00:26:13", 17, 96),
(169, "2", "2020-08-18 16:40:57", 14, 61),
(170, "2", "2020-11-03 04:12:52", 15, 1),
(171, "2", "2020-03-24 19:58:23", 11, 92),
(172, "2", "2019-12-21 12:04:58", 27, 89),
(173, "2", "2020-10-02 22:59:20", 3, 60),
(174, "2", "2019-11-03 00:03:06", 14, 28),
(175, "2", "2019-12-19 09:24:28", 6, 20),
(176, "2", "2020-01-29 15:45:40", 17, 62),
(177, "2", "2020-11-12 13:17:53", 16, 6),
(178, "2", "2019-11-24 14:25:07", 6, 82),
(179, "2", "2019-10-15 03:50:05", 19, 77),
(180, "2", "2020-04-27 22:39:41", 9, 68),
(181, "2", "2020-05-13 03:15:19", 3, 61),
(182, "2", "2020-01-31 09:02:09", 16, 95),
(183, "2", "2020-01-22 08:52:08", 24, 48),
(184, "2", "2020-02-01 11:00:34", 24, 15),
(185, "2", "2020-04-28 12:21:43", 19, 83),
(186, "2", "2019-11-10 16:02:56", 7, 32),
(187, "2", "2019-11-24 04:52:20", 2, 58),
(188, "2", "2020-04-19 23:07:41", 16, 21),
(189, "2", "2019-11-13 07:58:49", 6, 56),
(190, "2", "2019-12-21 22:44:24", 30, 95),
(191, "2", "2020-03-12 17:10:31", 25, 56),
(192, "2", "2020-10-13 14:52:14", 11, 13),
(193, "2", "2020-11-16 21:24:55", 4, 32),
(194, "2", "2020-10-10 22:19:29", 18, 64),
(195, "2", "2020-08-20 00:08:23", 17, 79),
(196, "2", "2020-08-30 06:47:32", 15, 18),
(197, "2", "2020-09-26 14:09:22", 11, 46),
(198, "2", "2020-03-07 20:11:30", 25, 45),
(199, "2", "2020-02-01 13:36:30", 7, 5),
(200, "2", "2020-08-10 04:20:59", 26, 60);


select *
from movimentacoes_produtos
;

insert into movimentacoes (cd_movimento, cd_tipo_movimento, dt_movimento, cd_estabelecimento, cd_fornecedor)
values (201, "3", "2019-10-27 19:41:30", 27, 1),
(202, "3", "2020-04-25 08:48:39", 14, 2),
(203, "3", "2020-07-31 02:59:28", 21, 3),
(204, "3", "2019-12-04 19:45:55", 9, 4),
(205, "3", "2020-10-08 06:58:16", 26, 5),
(206, "3", "2020-01-25 13:14:43", 7, 6),
(207, "3", "2020-09-27 20:17:59", 6, 7),
(208, "3", "2020-02-26 17:37:47", 23, 8),
(209, "3", "2020-05-13 06:10:24", 17, 9),
(210, "3", "2020-07-31 07:40:21", 1, 10);


insert into movimentacoes (cd_movimento, cd_tipo_movimento, dt_movimento, cd_estabelecimento)
values (211, "4", "2020-05-20 16:44:34", 18),
(212, "4", "2020-08-06 20:42:14", 18),
(213, "4", "2020-04-04 13:03:29", 7),
(214, "4", "2020-10-17 14:01:05", 15),
(215, "4", "2020-03-08 08:20:55", 1),
(216, "4", "2020-05-09 00:34:35", 1),
(217, "4", "2019-11-21 02:12:32", 20),
(218, "4", "2019-11-16 19:17:01", 15),
(219, "4", "2020-07-31 03:37:54", 7),
(220, "4", "2020-02-05 22:39:42", 6);





select *
from movimentacoes_produtos;

#--> INSERÇÃO DE REGISTROS ENTIDADE "MOVIMENTACOES_PRODUTOS"
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('201', '1', '1', '5');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('201', '10', '1', '1');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('201', '25', '1', '20');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('201', '13', '1', '10');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('202', '10', '2', '21');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('202', '11', '2', '32');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('202', '12', '2', '19');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('203', '50', '3', '1');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('203', '49', '3', '2');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('203', '48', '3', '3');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('204', '45', '4', '5');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('204', '46', '4', '9');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('205', '21', '5', '5');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('205', '22', '5', '5');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('205', '23', '5', '5');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('206', '29', '6', '10');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('206', '28', '6', '10');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('207', '31', '7', '1');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('207', '32', '7', '1');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('207', '33', '7', '1');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('208', '36', '8', '6');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('208', '37', '8', '7');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('209', '24', '9', '100');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('210', '7', '10', '5');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('210', '9', '10', '7');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('210', '17', '10', '31');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('210', '25', '10', '54');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `CD_FORNECEDOR`, `QT_PRODUTO`) VALUES ('210', '48', '10', '10');

INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('211', '1', '1');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('211', '2', '2');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('212', '3', '3');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('212', '4', '4');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('213', '5', '5');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('213', '6', '6');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('214', '7', '7');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('214', '8', '8');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('214', '9', '9');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('215', '10', '10');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('215', '11', '11');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('215', '12', '12');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('216', '13', '13');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('216', '14', '14');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('216', '15', '15');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('217', '16', '16');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('217', '17', '17');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('217', '18', '18');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('218', '19', '19');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('218', '20', '20');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('218', '21', '21');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('219', '22', '22');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('219', '23', '23');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('219', '24', '24');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('220', '25', '25');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('220', '26', '26');
INSERT INTO `parque_db`.`movimentacoes_produtos` (`CD_MOVIMENTO`, `CD_PRODUTO`, `QT_PRODUTO`) VALUES ('220', '27', '27');



#--> INSERÇÃO DE REGISTROS ENTIDADE "MOVIMENTACOES_PRODUTOS"
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (1,5,27,"2020/10/25");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (2,1,10,"2020/10/25");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (3,8,13,"2020/10/08");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (4,13,23,"2020/10/31");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (5,6,15,"2020/10/11");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (6,9,6,"2020/10/20");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (7,6,29,"2020/10/26");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (8,3,13,"2020/10/25");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (9,11,2,"2020/10/03");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (10,13,16,"2020/10/29");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (11,3,4,"2020/10/04");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (12,10,2,"2020/10/10");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (13,10,25,"2020/10/27");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (14,7,15,"2020/10/31");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (15,1,12,"2020/10/15");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (16,6,17,"2020/10/23");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (17,6,23,"2020/10/14");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (18,11,28,"2020/10/18");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (19,12,17,"2020/10/12");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (20,11,8,"2020/10/29");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (21,9,26,"2020/10/20");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (22,15,20,"2020/10/29");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (23,2,18,"2020/10/14");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (24,7,2,"2020/10/31");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (25,1,16,"2020/10/04");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (26,12,29,"2020/10/23");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (27,13,8,"2020/10/16");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (28,6,24,"2020/10/26");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (29,12,8,"2020/10/10");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (30,15,25,"2020/10/10");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (31,6,25,"2020/10/28");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (32,1,25,"2020/10/17");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (33,13,19,"2020/10/22");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (34,9,19,"2020/10/03");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (35,13,2,"2020/10/02");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (36,9,20,"2020/10/12");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (37,2,23,"2020/10/25");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (38,2,27,"2020/10/12");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (39,15,25,"2020/10/29");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (40,4,26,"2020/10/07");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (41,4,26,"2020/10/10");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (42,15,2,"2020/10/03");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (43,5,28,"2020/10/08");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (44,1,22,"2020/10/07");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (45,14,5,"2020/10/05");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (46,5,20,"2020/10/14");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (47,3,25,"2020/10/28");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (48,8,29,"2020/10/16");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (49,9,7,"2020/10/11");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_estabelecimento,dt_horario_turno) VALUES (50,7,12,"2020/10/04");

INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (51,26,4,"2020/10/22");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (52,20,1,"2020/10/25");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (53,20,10,"2020/10/01");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (54,17,2,"2020/10/04");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (55,22,7,"2020/10/07");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (56,28,13,"2020/10/06");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (57,16,13,"2020/10/25");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (58,25,9,"2020/10/01");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (59,28,16,"2020/10/21");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (60,23,18,"2020/10/03");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (61,25,8,"2020/10/19");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (62,16,3,"2020/10/06");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (63,24,3,"2020/10/23");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (64,18,8,"2020/10/27");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (65,28,18,"2020/10/10");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (66,21,7,"2020/10/09");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (67,23,11,"2020/10/13");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (68,29,4,"2020/10/06");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (69,18,20,"2020/10/29");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (70,17,4,"2020/10/01");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (71,26,12,"2020/10/09");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (72,21,18,"2020/10/03");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (73,26,12,"2020/10/01");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (74,30,6,"2020/10/28");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (75,17,8,"2020/10/01");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (76,26,7,"2020/10/30");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (77,20,10,"2020/10/16");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (78,21,10,"2020/10/09");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (79,20,19,"2020/10/29");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (80,18,8,"2020/10/01");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (81,30,20,"2020/10/08");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (82,22,17,"2020/10/08");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (83,22,3,"2020/10/18");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (84,25,5,"2020/10/06");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (85,25,8,"2020/10/13");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (86,28,6,"2020/10/22");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (87,22,20,"2020/10/08");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (88,29,4,"2020/10/27");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (89,27,18,"2020/10/06");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (90,29,11,"2020/10/02");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (91,19,18,"2020/10/19");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (92,20,16,"2020/10/17");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (93,18,18,"2020/10/31");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (94,27,16,"2020/10/07");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (95,22,3,"2020/10/09");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (96,30,19,"2020/10/14");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (97,29,19,"2020/10/06");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (98,29,12,"2020/10/04");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (99,21,17,"2020/10/16");
INSERT INTO horarios_turnos (cd_horario_turno,cd_funcionario,cd_atracao,dt_horario_turno) VALUES (100,29,14,"2020/10/30");















