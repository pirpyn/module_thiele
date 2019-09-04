# Description

Ce programme Fortran 2003 calcul un module de Thiele selon plusieurs paramètres.
Le module de Thiele est la solution `phi` de l'équation où `a,f,z` sont des paramètres à définir

    f = a*cosh(phi*z)/cosh(phi)

* `z` reprèsente la distance relative dans le pore. Par convention l'entrée est en `z=1` et le milieu en `z=0`.
* `a` reprèsente l'épaisseur du dépot en micron à l'entrée du pore.
* `f` represente l'épaisseur du dépot en micron en `z`.

On reformule ce problème pour la méthode Newton:
Trouver `phi` tel que `g(phi) = 0` où
    
    g(phi) = phi - acosh( a/f*cosh(phi*z) )

# Limites
Ce programme est basé sur un méthode de Newton. 
Celle-ci peut échouer pour plusieurs raisons:
* Les paramètres `a,f,z` sont tels que la fonction `g` n'a pas de zéro au seuil de tolérance. Dans ce cas, l’algorithme donne le `phi` le plus proche.
* La fonction à une dérivée quasi nulle autour du zéro. Dans ce cas, l'algorithme peut ne pas converger dans la limite du nombre d'itérations.

# Le tester en ligne
Ce code est disponible sur [http://tpcg.io/5QC2CL](CodingGrouds). 
Il est nécessaire d'autoriser les fonctionnalités Fortran 2003, donc il faut supprimer l'option `-std=f95` dans *Project->Compile Options* en haut à droite.
Il faut fournir les paramètres dans l'onglet `STDIN` en haut à gauche.

# Le tester en local
Ce code compile sur une compilateur récent ( testé `gfortran 7.4.0` ). Un makefile simple est fourni.
Il faut fournir les paramètres de puis l'entrée standard.

Supposons que `test.txt` contient ces derniers alors le programme peut être exécuté comme suit

    make run ARG=test.txt

ou
   
    cat test.txt | bin/newton



