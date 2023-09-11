program practica;
const
	rob=5;
	cant=10;
	esq=100;
type
	robots=1..rob;
	fyp=0..cant;
	cya=1..esq;
	
	esqui = record
		calle: cya;
		avenida: cya;
	end;
	
	mensaje = record
		ID:robots;
		flores:fyp;
		Papeles:fyp;
		esquina:esqui;
	end;
	
	Lmensaje=^nodo;
	nodo = record
		dato: mensaje;
		sig:Lmensaje;
	end;
	
	avenida = record
		aven:cya;
		floresrec:integer;
		ceropapel:integer;
	end;
	
	Lavenida=^av;
	av=record
		dato:avenida;
		sig:Lavenida;
	end;
	
	arbol = ^nodoarbol;
	nodoarbol = record
		dato:avenida;
		HI:arbol;
		HD:arbol;
	end;
	
	Vmensajes = array [robots] of Lmensaje;
	
procedure LeerEsquina (var e:esqui);
	begin
		writeln('ingresar calle entre 1 y 100');
		readln (e.calle);
		writeln('ingresar avenida entre 1 y 100');
		readln (e.avenida);
	end;
	
procedure LeerMensaje (var m:mensaje);
	begin
		writeln('ingresar ID del robot entre 1 y 5');
		readln (m.ID);
		writeln('ingresar cantidad de flores recogidas entre 0 y 10');
		readln (m.flores);
		writeln('ingresar cantidad de papeles recogidas entre 0 y 10');
		readln(m.papeles);
		LeerEsquina(m.esquina);
	end;

procedure Insertar (var Lm:Lmensaje; m:mensaje);
	var
		nuevo,act,ant:Lmensaje;
	begin
		new (nuevo);
		nuevo^.dato:=m;
		act:=Lm;
		while (act <>nil) and (act^.dato.esquina.avenida<m.esquina.avenida) do begin
			ant:=act;
			act:=act^.sig;
		end;
			if (act=Lm) then
				Lm:=nuevo
				else
					ant^.sig:=nuevo;
		nuevo^.sig:=act;
	end;
	
procedure CargarVector (var Vm:Vmensajes; var Lm:lmensaje);  //a
	var
		m:mensaje; i:integer;
	begin
		for i:=1 to 100 do begin
			LeerMensaje (m);
			Insertar (Vm[m.ID],m);
		end;
	end;
	
procedure Insertar2 (var La:Lavenida; a:avenida);
	var
		nuevo,act,ant:Lavenida;
	begin
		new (nuevo);
		nuevo^.dato:=a;
		act:=La;
		while (act <>nil) and (act^.dato.aven<a.aven) do begin
			ant:=act;
			act:=act^.sig;
		end;
			if (act=La) then
				La:=nuevo
				else
					ant^.sig:=nuevo;
		nuevo^.sig:=act;
	end;
	
	procedure CargarAvenida (Vm:Vmensajes; var la:lavenida);  //b
	var a:avenida; i:integer;
	begin
		for i:=1 to 5 do begin
			a.floresrec:=0;
			a.ceropapel:=0;
			a.aven:= vm[i]^.dato.esquina.avenida;
			while (vm[i]<>nil) do begin
			a.floresrec:=vm[i]^.dato.flores+a.floresrec;
			if (vm[i]^.dato.papeles=0) then
				a.ceropapel:=a.ceropapel+1;
			vm[i]:=vm[i]^.sig;
			end;
			Insertar2(la,a);
		end;
	end;


procedure CargarArbol (var a:arbol; la:lavenida);   //c
		
procedure CrearArbol (var a:arbol; av:avenida); 
	begin
		if (a=nil) then begin
			new (a);
			a^.dato:= av;
			a^.HI:=nil;
			a^.HD:= nil;
		end	
		else
			if (a^.dato.floresrec>=av.floresrec) then CrearArbol(a^.HI,av)
			else CrearArbol(a^.HD,av);
	end;
	
	begin
		if (la<>nil) then begin
			CrearArbol(a,la^.dato);
			CargarArbol(a,la^.sig);
		end;
	end;
	
var a:arbol; la:lavenida; vm:vmensajes; Lm:lmensaje;
begin
	Lm:=nil;
	La:=nil;
	CargarVector(vm,lm);
	CargarAvenida(vm,la);
	CargarArbol(a,la);
end.


			
	
