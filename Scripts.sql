
-- 1 CREAR BASE DE DATOS Y LUEGO UTILIZARLA
create database DDCrudAngular

go
use DDCrudAngular

go

-- 2 CREAR TABLAS DENTRO DE NUESTRA BASE DE DATOS


create table Empleado(
IdEmpleado int primary key identity,
NombreCompleto varchar(50),
Correo varchar(50),
Sueldo decimal(10,2),
FechaContrato date
)

go
insert into Empleado(NombreCompleto,Correo,Sueldo,FechaContrato)
values
('Maria Mendez','maria@gmail.com',4500,'2024-01-12')
select * from Empleado

go


create procedure sp_listaEmpleados
as
begin
	
	select 
	IdEmpleado,
	NombreCompleto,
	Correo,
	Sueldo,
	convert(char(10),FechaContrato,103)[FechaContrato]
	from Empleado 
	
end

go

create procedure sp_obtenerEmpleado
(
@IdEmpleado int
)
as
begin
	
	select 
	IdEmpleado,
	NombreCompleto,
	Correo,
	Sueldo,
	convert(char(10),FechaContrato,103)[FechaContrato]
	from Empleado where IdEmpleado = @IdEmpleado
	
end

go

create procedure sp_crearEmpleado(
@NombreCompleto varchar(50),
@Correo varchar(50),
@Sueldo decimal(10,2),
@FechaContrato varchar(10)
)
as
begin
	set dateformat dmy

	insert into Empleado
	(
	NombreCompleto,
	Correo,
	Sueldo,
	FechaContrato
	)
	values
	(
	@NombreCompleto,
	@Correo,
	@Sueldo,
	convert(date,@FechaContrato)
	)
end

go

create procedure sp_editarEmpleado(
@IdEmpleado int,
@NombreCompleto varchar(50),
@Correo varchar(50),
@Sueldo decimal(10,2),
@FechaContrato varchar(10)
)
as
begin
	set dateformat dmy

	update Empleado
	set
	NombreCompleto = @NombreCompleto,
	Correo = @Correo,
	Sueldo = @Sueldo,
	FechaContrato = convert(date,@FechaContrato)
	where IdEmpleado = @IdEmpleado
end

go

create procedure sp_eliminarEmpleado(
@IdEmpleado int
)
as
begin
	delete from Empleado where IdEmpleado = @IdEmpleado
end
