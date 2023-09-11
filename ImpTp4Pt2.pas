{2. Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN -1. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.}

program biblioteca;
type
	prestamo=record
		ISBN:integer;
		numsocio:integer;
		dia:integer;
		mes:integer;
		cantdias:integer;
	end;
	
	Lprestamos=^libro;
	
	libro = record
		dato:prestamo;
		sig:Lprestamos;
	end;

	arbol1= ^nodoarbol1;
	nodoarbol1 = record
		dato:prestamo;
		HI:arbol1;
		HD:arbol1;
	end;
	
	arbol2=^nodoarbol2;
	nodoarbol2= record
		dISBN:integer;
		dato: Lprestamos;
		HI:arbol2;
		HD:arbol2;
	end;
	
	datos=record
		ISBN:integer;
		cantidad:integer;
	end;
	
	LISBN=^ISBNreg;
	ISBNreg=record
		elem:datos;
		sig:LISBN;
	end;
	
procedure LeerPrestamo (var p:prestamo);
	begin
		writeln ('ISBN del libro');
		readln(p.ISBN);
		if (p.ISBN<>-1) then begin
		writeln ('numero de socio');
		readln(p.numsocio);
		writeln ('dia');
		readln(p.dia);
		writeln ('mes');
		readln(p.mes);
		writeln ('cantidad de dias prestado');
		readln(p.cantdias);
		end;
	end;
	
procedure AgregarAdelante (var Lp:Lprestamos; p:prestamo);
	var
		nuevo:Lprestamos;
	begin
		new (nuevo);
		nuevo^.dato:=p;
		nuevo^.sig:=Lp;
		Lp:=nuevo;
	end;
	
procedure Agregar1 (var a1:arbol1; p:prestamo);
	begin
		if (a1=nil) then begin
			new (a1);
			a1^.dato:=p;
			a1^.HI:=nil;
			a1^.HD:=nil;
		end
		else if (a1^.dato.ISBN >= p.ISBN) then 
			Agregar1(a1^.HI,p)
			else Agregar1(a1^.HD,p);
	end;
	
procedure Agregar2 (var a2:arbol2; p:prestamo);
	begin
		if (a2=nil) then begin
			new (a2);
			a2^.dato:=nil;
			a2^.dISBN:=p.ISBN;
			AgregarAdelante(a2^.dato,p);
			a2^.HI:=nil;
			a2^.HD:=nil;
		end
		else if (a2^.dISBN > p.ISBN) then 
			Agregar2(a2^.HI,p)
			else if (a2^.dato^.dato.ISBN = p.ISBN) then AgregarAdelante(a2^.dato,p)
			else Agregar2(a2^.HD,p);
	end;

procedure CargarArbol1y2(var a1:arbol1; var a2:arbol2);  //a
	var P:prestamo;
	begin
		LeerPrestamo(p);
		while (p.ISBN<>-1) do begin
			Agregar1(a1,p);
			Agregar2(a2,p);
			LeerPrestamo(p);
		end;
	end;
	
{b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.}
procedure RetornarISBNMayor (a1:arbol1);
	function ISBNmayor (a1:arbol1):integer;
		begin
			if (a1^.HD<>nil) then
				ISBNmayor:=ISBNmayor(a1^.HD)
				else
				ISBNmayor:=a1^.dato.ISBN;
			end;
	begin
		if (a1=nil) then writeln ('el arbol no tiene elementos')
		else
			writeln ('el mayor ISBN del arbol 1 fue     ',ISBNmayor(a1));
	end;
	
{c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.}
procedure RetornarISBNMenor (a2:arbol2);
	function ISBNmenor (a2:arbol2):integer;
		begin
			if (a2^.HI<>nil) then 
				ISBNmenor:=ISBNmenor(a2^.HI)
				else ISBNmenor:= a2^.dISBN;
		end;
	begin
		if (a2=nil) then writeln ('el arbol no tiene elementos')
		else writeln ('el menor ISBN del arbol 2 es      ',ISBNmenor(a2));
	end;

{d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.}
procedure RetornarCantPrestamosAUnSocio (a1:arbol1);
	procedure Cantidad (a1:arbol1;socio:integer; var cant:integer);
			begin
				if (a1<>nil) then begin
					if (a1^.dato.numsocio=socio) then cant:=cant+1;
					Cantidad(a1^.HI,socio,cant);
					Cantidad(a1^.HD,socio,cant);
				end;
			end;
	var socio:integer;cant:integer;
	begin
		cant:=0;
		writeln('ingresar numero de socio a contar cantidad de prestamos');
		readln (socio);
		if (a1=nil) then writeln ('arbol sin elementos')
		else
		Cantidad(a1,socio,cant);
		writeln ('la cantidad de prestamos sacados por el socio   ',socio,'  fue de  ',Cant);
	end;

{e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.}

procedure RetornarCantPrestamosAUnSocio2 (a2:arbol2);   //e
	procedure cantidad2 (a2:arbol2; socio:integer; var cant:integer);
		begin
			if (a2<>nil) then begin
				while (a2^.dato<>nil) do begin
					if (a2^.dato^.dato.numsocio=socio) then
						cant:=cant+1;
					a2^.dato:=a2^.dato^.sig;
					end;
				cantidad2(a2^.HI,socio,cant);
				cantidad2(a2^.HD,socio,cant);
			end;
		end;
	var 
		cant:integer; socio:integer;
	begin
		writeln('ingresar un numero de socio a buscar');
		readln (socio);
		cant:=0;
		cantidad2(a2,socio,cant);
		if (a2=nil) then writeln ('el arbol no contiene elementos')
		else
			writeln('el arbol 2, tiene''   ' , cant,'   ''de prestamos a nombre del socio ',socio);
	end;

{g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.}
procedure InsertarOrdenado (var LI:LISBN; d:datos);
	var
		act,ant,nuevo:LISBN;
	begin
		new (nuevo);
		nuevo^.elem:=d;
		act:=LI;
		while (act<>nil) and (act^.elem.ISBN<d.ISBN) do begin
			ant:=act;
			act:=act^.sig;
			end;
			if (act=LI) then
				LI:=nuevo
				else 
					ant^.sig:=nuevo;
			nuevo^.sig:=act;
	end;

procedure NuevaEstructura (a2:arbol2);
		procedure Cargar(var LI:LISBN; a2:arbol2);
			var d:datos;
			begin
				d.cantidad:=0;
				if (a2<>nil) then begin
					d.ISBN:=a2^.dISBN;
					while(a2^.dato<>nil) do begin
						d.cantidad:=d.cantidad+1;
						a2^.dato:=a2^.dato^.sig; end;
					InsertarOrdenado(LI,d);
					Cargar(LI,a2^.HI);
					Cargar(LI,a2^.HD);
				end;
			end;
	var 
		LI:LISBN;
	begin
		LI:=nil;
		Cargar(LI,a2);
	end;
			
procedure InformarEntreDos (a1:arbol1);
	procedure Recursivo (a1:arbol1; valor1:integer; valor2:integer);
		begin
			if (a1<>nil) then begin
				if (a1^.dato.ISBN>valor1) then
					if (a1^.dato.ISBN<valor2) then begin
						writeln (a1^.dato.ISBN);
						Recursivo(a1^.HI,valor1,valor2);
						Recursivo(a1^.HD,valor1,valor2);end
					else
						Recursivo(a1^.HI,valor1,valor2)
				else 
					Recursivo(a1^.HD,valor1,valor2);
			end;
		end;
		
	var valor1,valor2:integer;
	begin
		writeln ('ingresar un valor minimo a comparar');
		readln (valor1);
		writeln('ingresar un valor mayor a comparar');
		readln(valor2);
		if (a1=nil) then writeln ('el arbol no contiene elementos')
		else
			Recursivo(a1,valor1,valor2);
	end;
	
procedure InformarMenorAUnValor (a1:arbol1);
	procedure Recursivo1 (a1:arbol1; valor2:integer);
		begin
			if (a1<>nil) then begin
					if (a1^.dato.ISBN<valor2) then begin
						writeln (a1^.dato.ISBN);
						Recursivo1(a1^.HI,valor2);
						Recursivo1(a1^.HD,valor2);end
					else
						Recursivo1(a1^.HI,valor2)
			end;
		end;
		
	var valor2:integer;
	begin
		writeln('ingresar un valor para buscar minimos');
		readln(valor2);
		if (a1=nil) then writeln ('el arbol no contiene elementos')
		else
			Recursivo1(a1,valor2);
	end;
	
procedure InformarMayoresAUnValor (a1:arbol1);
	procedure Recursivo2 (a1:arbol1; valor1:integer);
		begin
			if (a1<>nil) then begin
				if (a1^.dato.ISBN>valor1) then begin
						writeln (a1^.dato.ISBN);
						Recursivo2(a1^.HI,valor1);
						Recursivo2(a1^.HD,valor1);end
				else 
					Recursivo2(a1^.HD,valor1);
			end;
		end;
		
	var valor1:integer;
	begin
		writeln ('ingresar un valor minimo a comparar');
		readln (valor1);
		if (a1=nil) then writeln ('el arbol no contiene elementos')
		else
			Recursivo2(a1,valor1);
	end;
	
	
	
var 
	a1:arbol1; a2:arbol2;
begin
	a1:=nil;
	a2:=nil;
	CargarArbol1y2 (a1,a2);
	RetornarISBNMayor(a1);
	RetornarISBNMenor(a2);
	RetornarCantPrestamosAUnSocio(a1);
	RetornarCantPrestamosAUnSocio2(a2);
	NuevaEstructura(a2);
	InformarEntreDos(a1);
	InformarMenorAUnValor(a1);
	InformarMayoresAUnValor(a1);
end.
