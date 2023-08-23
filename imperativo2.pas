program propiedades;
type
	cadena20=string[20];
	z=1..5;
	almacenar=record
		cod:integer;
		tipo:cadena20;
		preciototal:real;
	end;
		
	propiedad=record
		zona:z;
		cod:integer;
		tipo:cadena20;
		mtcuadrado:integer;
		preciometro:real;
	end;
	
	lalmacenar=^alm;
	
	alm=record
		dato:almacenar;
		sig:lalmacenar;
	end;
	
	lpropiedades=^prop;
	
	prop=record
		dato:propiedad;
		sig:lpropiedades;
	end;
	
	vpropiedades=array[z]of lalmacenar;
	
procedure LeerPropiedad (var p:propiedad);
	begin
		writeln('zona');
		readln(p.zona);
		writeln('codigo de propiedad');
		readln(p.cod);
		writeln('tipo de propiedad');
		readln(p.tipo);
		writeln('metro cuadrado');
		readln(p.mtcuadrado);
		writeln('precio por metro');
		readln(p.preciometro);
	end;
	
procedure Insertar (var la:lalmacenar; elem:almacenar);
	var
		nuevo, ant, act: lalmacenar;
	begin
		new (nuevo);
		nuevo^.dato:=elem;
		act:=la;
		while (act<>nil) and (act^.dato.tipo<elem.tipo) do
			begin
				ant:=act;
				act:=act^.sig
			end;
		if (act=la) then
			la:=nuevo
		else
			ant^.sig:=nuevo;
		nuevo^.sig:=act;
	end;
	
procedure Agregar (var lp:lpropiedades; elemprop:propiedad);
	var
		nuevo:lpropiedades;
	begin
		new (nuevo);
		nuevo^.dato:=elemprop;
		nuevo^.sig:=lp;
		lp:=nuevo;
	end;
	
procedure CargarPropiedades (var lp:lpropiedades);
	var
		p:propiedad;
	begin
		LeerPropiedad(p);
		while (p.preciometro<>-1) do
			begin
				Agregar(lp,p);
				LeerPropiedad(p);
			end;
	end;

procedure almacenar2 (var la1,la2,la3,la4,la5:lalmacenar; lp:lpropiedades);
	var
		zona:z; elem:almacenar; total:real;
	begin
		while (lp<>nil) do begin
			total:=lp^.dato.preciometro * lp^.dato.mtcuadrado;
			elem.cod:=lp^.dato.cod;
			elem.tipo:=lp^.dato.tipo;
			elem.preciototal:=total;
			zona:=lp^.dato.zona;
			case (zona) of
				1:Insertar (la1,elem);
				2:Insertar (la2,elem);
				3:Insertar (la3,elem);
				4:Insertar (la4,elem);
				5:Insertar (la5,elem);
			end;
			lp:=lp^.sig;
		end;
	end;
	

procedure Inicializar (var lp:lpropiedades; var l1,l2,l3,l4,l5:lalmacenar);
	begin
		lp:=nil;
		l1:=nil;
		l2:=nil;
		l3:=nil;
		l4:=nil;
		l5:=nil;
	end;
	
procedure CargarVector (var vp:vpropiedades;l1,l2,l3,l4,l5:lalmacenar);
	begin
		vp[1]:=l1;
		vp[2]:=l2;
		vp[3]:=l3;
		vp[4]:=l4;
		vp[5]:=l5;
	end;
	
{b) Implementar un módulo que reciba la estructura generada en a), un número de zona y un tipo de 
propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo recibido. }

procedure Recibo (vp:vpropiedades;numzona:z;tipoprop:cadena20);
	var
		i:integer;
	begin
		while (vp[numzona]<>nil) do begin
			writeln('los codigos de las propiedades de la zona',numzona,'son', vp[numzona]^.dato.cod);
			vp[numzona]:=vp[numzona]^.sig;
		end;
		for i:=1 to 5 do
			while (vp[i]<>nil)and (vp[i]^.dato.tipo=tipoprop) do begin
				writeln('los codigos de las propiedades del tipo',tipoprop,'son', vp[i]^.dato.cod);
				vp[i]:=vp[i]^.sig;
			end;
	end;

	var
		la1:lalmacenar;
		la2:lalmacenar;
		la3:lalmacenar;
		la4:lalmacenar;
		la5:lalmacenar;
		lp:lpropiedades;
		vp:vpropiedades;
		tipoprop:cadena20;
		numzona:z;
	begin
		Inicializar(lp,la1,la2,la3,la4,la5);
		CargarPropiedades(lp);
		almacenar2(la1,la2,la3,la4,la5,lp);
		CargarVector(vp,la1,la2,la3,la4,la5);
		writeln('zona recibida');
		readln (numzona);
		writeln ('tipo de propiedad');
		readln (tipoprop);
		Recibo(vp,numzona,tipoprop);
	end.
