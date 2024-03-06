-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BANCOSUE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BANCOSUE
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BANCOSUE` DEFAULT CHARACTER SET utf8 ;
USE `BANCOSUE` ;

-- -----------------------------------------------------
-- Table `BANCOSUE`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Usuario` (
  `idUsuario` INT NULL,
  `Nome` VARCHAR(45) NULL,
  `CPF` INT(11) NULL,
  `Telefone` INT(13) NULL,
  `DataNascimento` DATE NULL,
  `CEP` INT NULL,
  `Rua` VARCHAR(45) NULL,
  `NumeroCasa` INT NULL,
  `Bairro` VARCHAR(45) NULL,
  `Cidade` VARCHAR(45) NULL,
  `Estado` VARCHAR(45) NULL,
  `Complemento` VARCHAR(100) NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Aluno` (
  `idAluno` INT NOT NULL AUTO_INCREMENT,
  `Alunocol` VARCHAR(45) NULL,
  `Usuario_idUsuario` INT NULL,
  PRIMARY KEY (`idAluno`),
  INDEX `fk_Aluno_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `BANCOSUE`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BANCOSUE`.`Coordenador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Coordenador` (
  `idCoordenador` INT NULL,
  `Usuario_idUsuario` INT NULL,
  PRIMARY KEY (`idCoordenador`, `Usuario_idUsuario`),
  INDEX `fk_Coordenador_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Coordenador_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `BANCOSUE`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Curso` (
  `idCurso` INT NULL,
  `Nome` VARCHAR(45) NULL,
  `Coordenador_idCoordenador` INT NULL,
  `Coordenador_Usuario_idUsuario` INT NULL,
  PRIMARY KEY (`idCurso`, `Coordenador_idCoordenador`, `Coordenador_Usuario_idUsuario`),
  INDEX `fk_Curso_Coordenador1_idx` (`Coordenador_idCoordenador` ASC, `Coordenador_Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_Coordenador1`
    FOREIGN KEY (`Coordenador_idCoordenador` , `Coordenador_Usuario_idUsuario`)
    REFERENCES `BANCOSUE`.`Coordenador` (`idCoordenador` , `Usuario_idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`Turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Turma` (
  `idTurma` INT NOT NULL,
  `Turno` VARCHAR(45) NULL,
  `Curso_idCurso` INT NULL,
  PRIMARY KEY (`idTurma`, `Curso_idCurso`),
  INDEX `fk_Turma_Curso1_idx` (`Curso_idCurso` ASC) VISIBLE,
  CONSTRAINT `fk_Turma_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `BANCOSUE`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`Matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Matricula` (
  `Aluno_idAluno` INT NULL,
  `Turma_idTurma` INT NULL,
  `idMatricula` INT NULL,
  INDEX `fk_Aluno_has_Turma_Turma1_idx` (`Turma_idTurma` ASC) VISIBLE,
  INDEX `fk_Aluno_has_Turma_Aluno_idx` (`Aluno_idAluno` ASC) VISIBLE,
  PRIMARY KEY (`Aluno_idAluno`, `Turma_idTurma`),
  CONSTRAINT `fk_Aluno_has_Turma_Aluno`
    FOREIGN KEY (`Aluno_idAluno`)
    REFERENCES `BANCOSUE`.`Aluno` (`idAluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_has_Turma_Turma1`
    FOREIGN KEY (`Turma_idTurma`)
    REFERENCES `BANCOSUE`.`Turma` (`idTurma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Disciplina` (
  `idDisciplina` INT NULL,
  `Nome` VARCHAR(45) NULL,
  `CargaHoraria` INT NULL,
  PRIMARY KEY (`idDisciplina`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`Turma_has_Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Turma_has_Disciplina` (
  `Turma_idTurma` INT NULL,
  `Disciplina_idDisciplina` INT NULL,
  PRIMARY KEY (`Turma_idTurma`, `Disciplina_idDisciplina`),
  INDEX `fk_Turma_has_Disciplina_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  INDEX `fk_Turma_has_Disciplina_Turma1_idx` (`Turma_idTurma` ASC) VISIBLE,
  CONSTRAINT `fk_Turma_has_Disciplina_Turma1`
    FOREIGN KEY (`Turma_idTurma`)
    REFERENCES `BANCOSUE`.`Turma` (`idTurma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `BANCOSUE`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Professor` (
  `idProfessor` INT NULL,
  `Titulo` VARCHAR(80) NULL,
  `Usuario_idUsuario` INT NULL,
  PRIMARY KEY (`idProfessor`, `Usuario_idUsuario`),
  INDEX `fk_Professor_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Professor_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `BANCOSUE`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`Professor_has_Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Professor_has_Disciplina` (
  `Professor_idProfessor` INT NULL,
  `Disciplina_idDisciplina` INT NULL,
  PRIMARY KEY (`Professor_idProfessor`, `Disciplina_idDisciplina`),
  INDEX `fk_Professor_has_Disciplina_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  INDEX `fk_Professor_has_Disciplina_Professor1_idx` (`Professor_idProfessor` ASC) VISIBLE,
  CONSTRAINT `fk_Professor_has_Disciplina_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `BANCOSUE`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professor_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `BANCOSUE`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`Curso_has_Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Curso_has_Disciplina` (
  `Curso_idCurso` INT NULL,
  `Disciplina_idDisciplina` INT NULL,
  PRIMARY KEY (`Curso_idCurso`, `Disciplina_idDisciplina`),
  INDEX `fk_Curso_has_Disciplina_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  INDEX `fk_Curso_has_Disciplina_Curso1_idx` (`Curso_idCurso` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_has_Disciplina_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `BANCOSUE`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Curso_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `BANCOSUE`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`ResponsavelFinanceiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`ResponsavelFinanceiro` (
  `idResponsavelFinanceiro` INT NULL,
  `idUsuario` INT NULL,
  `ResponsavelFinanceirocol` VARCHAR(45) NULL,
  `Usuario_idUsuario` INT NULL,
  PRIMARY KEY (`idResponsavelFinanceiro`, `Usuario_idUsuario`),
  INDEX `fk_ResponsavelFinanceiro_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_ResponsavelFinanceiro_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `BANCOSUE`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BANCOSUE`.`DescricaoPagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`DescricaoPagamento` (
  `idDescricaoPagamento` INT NULL,
  `idPagamento` INT NULL,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idDescricaoPagamento`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BANCOSUE`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BANCOSUE`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `idResponsavel` INT NULL,
  `DataVencimento` DATE NULL,
  `ValorPrevisto` DOUBLE NULL,
  `idCurso` INT NULL,
  `idDescricaoPagamento` INT NULL,
  `ValorPago` DOUBLE NULL,
  `DataPagamento` DATE NULL,
  `NumeroParcelas` INT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_ResponsavelFinanceiro1_idx` (`idResponsavel` ASC) VISIBLE,
  INDEX `fk_Pagamento_Curso1_idx` (`idCurso` ASC) VISIBLE,
  INDEX `fk_Pagamento_DescricaoPagamento1_idx` (`idDescricaoPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_ResponsavelFinanceiro1`
    FOREIGN KEY (`idResponsavel`)
    REFERENCES `BANCOSUE`.`ResponsavelFinanceiro` (`idResponsavelFinanceiro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagamento_Curso1`
    FOREIGN KEY (`idCurso`)
    REFERENCES `BANCOSUE`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagamento_DescricaoPagamento1`
    FOREIGN KEY (`idDescricaoPagamento`)
    REFERENCES `BANCOSUE`.`DescricaoPagamento` (`idDescricaoPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

