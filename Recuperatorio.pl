
%%% PUNTO 1


%vive(Nombre,casa(MetrosCuadrados))
%vive(Nombre,departamento(Ambientes,Banios))
%vive(Nombre,loft(Anio))

vive(juan,casa(120)).
vive(nico,departamento(3,2)).
vive(alf,departamento(3,1)).
vive(julian,loft(2000)).
vive(vale,departamento(4,1)).
vive(fer,casa(110)).

%barrio(almagro,[alf,nico,juan,julian]).
%barrio(flores,[vale,fer]).

barrio(almagro,alf).
barrio(almagro,nico).
barrio(almagro,juan).
barrio(almagro,julian).

barrio(flores,vale).
barrio(flores,fer).

%%% PUNTO 2

%supuse que vivenTodasPersonasCopadas(Barrio,Persona) tiene que ser inversible para Barrio y Persona. Y no solamente para Barrio. 

vivenTodasPersonasCopadas(Barrio,Persona):-
    barrio(Barrio,Persona),
    forall((barrio(Barrio,OtraPersona),vive(OtraPersona,Propiedad)),esCopada(Propiedad)).

esCopada(casa(MetrosCuadrados)):-
    MetrosCuadrados > 100.

esCopada(departamento(Ambientes,_)):-
    Ambientes > 3.

esCopada(departamento(_,Banios)):-
    Banios > 1.

esCopada(loft(Anio)):-
    Anio > 2015.

% esMayor(Numero , OtroNumero):-
%    Numero > OtroNumero.

% Podria utilizar es mayor para no repetir logica al momento de comparar con < y > pero en mi opinion queda mas
% declarativo si no lo hago, tampoco aporta mucha logica y tampoco estaria ocultando mucho detalle algoritmico.


%%% PUNTO 3

esBarrioCaro(Barrio):-
    barrio(Barrio,_),
    not(hayPropiedadBarataEn(Barrio)).


hayPropiedadBarataEn(Barrio):-
    barrio(Barrio,Persona),
    vive(Persona,Propiedad),
    esBarato(Propiedad).


esBarato(loft(Anio)):-
    Anio < 2005.

esBarato(casa(MetrosCuadrados)):-
    MetrosCuadrados < 90.

esBarato(departamento(1,_)).
esBarato(departamento(2,_)).



%%% PUNTO 4

precioDeLaPropiedadDe(juan,150000).
precioDeLaPropiedadDe(nico,80000).
precioDeLaPropiedadDe(alf,75000).
precioDeLaPropiedadDe(vale,95000).
precioDeLaPropiedadDe(fer,60000). % Entiendo que por mas que no sepan porque esta la casa de Fer, esta en nuiestra base de conocimientos y Fer tiene una casa, asi q no hay ningun empedimento

/*
sePuedeComprar(Plata,Propiedad,NuevoDinero):-
    vive(Persona,Propiedad),
    precioDeLaPropiedadDe(Persona,PrecioPropiedad),
    Plata >= PrecioPropiedad,
    NuevoDinero is Plata - PrecioPropiedad.


casasQuePodemosComprar(Plata,PropiedadesQuePuedeComprar):-
    sublista(Plata,PropiedadesQuePuedeComprar).


sublista([],[]).

sublista([_ | PlataQueQueda],Propiedades):-
    sublista(PlataQueQueda,Propiedades).

sublista([PlataInicial | PlataQueQueda],[Propiedad | Propiedades]):-
    sePuedeComprar(PlataInicial,Propiedad,PlataQueQueda),
    sublista(PlataQueQueda,Propiedades).

*/


casasQuePodemosComprar(Plata,Propiedad):-
    vive(_,Propiedad),
    findall(PrecioPropiedad,obtenerPrecioDePropiedad(_,Propiedad,PrecioPropiedad), PrecioPropiedades),
    sumlist(PrecioPropiedades, PrecioTotal),
    PrecioTotal =< Plata.



obtenerPrecioDePropiedad(Persona,Propiedad,PrecioPropiedad):-
    vive(Persona,Propiedad),
    precioDeLaPropiedadDe(Persona,PrecioPropiedad).

