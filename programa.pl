% Aquí va el código.
necesidad(respiracion, fisiologico).
necesidad(alimentacion, fisiologico).
necesidad(descanso, fisiologico).
necesidad(reproduccion, fisiologico).

necesidad(integridad_fisica, seguridad).
necesidad(empleo, seguridad).
necesidad(salud , seguridad).

necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad , social).

necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).

necesidad(besar_a_messi, autorrealizacion).
necesidad(ganarMundial, autorrealizacion).

nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social, seguridad).
nivelSuperior(seguridad, fisiologico).

separacionDeNivelEntreSuperiorEInferior(Necesidad1,Necesidad2, Separacion):-
    necesidad(Necesidad1,Nivel1),
    necesidad(Necesidad2,Nivel2),
    separacionEntreNiveles(Nivel1,Nivel2,Separacion).




separacionEntreNiveles(Nivel,Nivel,0).
separacionEntreNiveles(Nivel,OtroNivel, 1):-
    nivelSuperior(Nivel, OtroNivel).
separacionEntreNiveles(Nivel,OtroNivel, Separacion):-
    nivelSuperior(Nivel, NivelIntermedio),
    separacionEntreNiveles(NivelIntermedio, OtroNivel, SeparacionFinal),
    Separacion is SeparacionFinal + 1.

necesidadesASatisfacer(carla, alimentacion).
necesidadesASatisfacer(carla, descanso).
necesidadesASatisfacer(carla, empleo).
necesidadesASatisfacer(juan , afecto).
necesidadesASatisfacer(juan , exito).
necesidadesASatisfacer(roberto, amistad).
necesidadesASatisfacer(manuel , respeto).
necesidadesASatisfacer(charly,salud).
necesidadesASatisfacer(charly,integridad_fisica).

necesidadDeMayorJerarquia(Persona, Necesidad):-
    necesidadesASatisfacer(Persona,Necesidad),
    not(tieneUnaNecesidadSuperior(Persona,Necesidad)).

tieneUnaNecesidadSuperior(Persona,Necesidad):-
    necesidadesASatisfacer(Persona,Necesidad),
    necesidadesASatisfacer(Persona, OtraNecesidad),
    Necesidad\=OtraNecesidad,
    separacionDeNivelEntreSuperiorEInferior(OtraNecesidad,Necesidad, Separacion),
    Separacion>0.

nivelSatisfecho(Persona, Nivel):-
    necesidadesASatisfacer(Persona,_),
    necesidad(_,Nivel),
    not(tieneNecesidadesEnNivel(Persona,Nivel)),
    not(tieneNecesidadesEnNivelPrevio(Persona,Nivel)).

tieneNecesidadesEnNivelPrevio(Persona,Nivel):-
    necesidadesASatisfacer(Persona,Necesidad),
    necesidad(Necesidad,NivelInferior),
    separacionEntreNiveles(Nivel,NivelInferior,Separacion),
    Separacion>0.

tieneNecesidadesEnNivel(Persona,Nivel):-
    necesidadesASatisfacer(Persona,Necesidad),
    necesidad(Necesidad, Nivel).

maslowNoTiraLaPosta(Persona):-
    necesidadesASatisfacer(Persona,Necesidad),
    necesidadesASatisfacer(Persona,OtraNecesidad),
    separacionDeNivelEntreSuperiorEInferior(Necesidad,OtraNecesidad,Separacion),
    Separacion>0.
    

