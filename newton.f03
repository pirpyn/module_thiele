! POUR EXECUTER SUR  http://tpcg.io/5QC2CL, ENLEVER '-std=f95' DANS PROJECT->COMPILE OPTIONS

program newton
    use, intrinsic :: iso_fortran_env, only: real128
    implicit none

    integer, parameter :: wp = real128
    real(wp) :: a, f, z
    integer :: it, itmax
    real(wp) :: gn, dgn, xn, tol
    real(wp) :: best
    
    write(*,*) '[INFO] Programme pour résoudre par Newton f = a cosh(phi z) / cosh(phi), inconnue phi, le module de Thiele'
    write(*,*) "       On reformule le problème : on cherche le zero de la fonction"
    write(*,*) "              g(phi) = phi - acosh( a / f * cosh(phi z) )"
    write(*,*)
    write(*,*) "[INFO] Fournir depuis STDIN les valeurs numériques"
    write(*,*) "       a       Épaisseur du dépôt en micron à l'entrée du pore"
    write(*,*) "       f       Épaisseur du dépôt en micron en z"
    write(*,*) "       z       Distance relative entre l'entrée (z=1) et le milieu (z=0) du pore"
    write(*,*) "       tol     Tolérance: on accepte phi si g(phi) < tol. Mettre 1E-3 si inconnu "
    write(*,*) "       itmax   Nombre maximal d'itérations. Mettre 100 si inconnu. "
    write(*,*) "       phi0    Estimation grossière du module pour démarrer l'algo. Mettre 1 si inconnu."
    write(*,*)
    
    read(*,*) a
    if (a.lt.0.) then
      write(*,*) "[FAIL] a doit être positif"
      error stop
    end if
    read(*,*) f
    if (f.lt.0.) then
      write(*,*) "[FAIL] f doit être positif"
      error stop
    end if
    read(*,*) z
    if ((z.lt.0.).or.(z.gt.1.)) then
      write(*,*) "[FAIL] z doit être compris entre 0 et 1"
      error stop
    end if
    read(*,*) tol
    read(*,*) itmax
    read(*,*) xn

    it = 0
    best = xn
    gn = g(xn,a,f,z)
    dgn = dg(xn,a,f,z)

    write(*,*) "[INFO] Lancement de l'algorithme pour "
    write(*,'(7x,*(a16,1x))') 'a','f','z'
    write(*,'(7x,*(es16.9,1x))') a, f, z
    write(*,*) "       ..."
    do while ((abs(gn).gt.abs(tol)).and.(it.lt.itmax))
      gn = g(xn,a,f,z)
      dgn = dg(xn,a,f,z)
      if (abs(gn).lt.abs(g(best,a,f,z))) then
        best = xn
      end if
      ! write(*,'(i16,1x,3(es16.9,1x))') it, xn, gn, dgn
      xn = xn - gn/dgn
      it = it + 1
    end do
    if (it.lt.itmax) then
      write(*,*) "[OK]   L'algorithme a trouvé un zéro à la tolérance demandée."
    else
      write(*,*) "[FAIL] L'algorithme n'a pas fini dans le nombre maximal d'itérations autorisées."
      write(*,*) "       Peut être faut-il plus d'itérations ou une tolérance plus grande."
      write(*,*) "       Néanmoins, le meilleur phi était"
    end if
    write(*, '(1x,*(a,es12.5))') "phi = ", best, ', g(phi) = ',g(best,a,f,z)
    
contains

pure function g(phi,a,f,z)
  real(wp) :: g
  real(wp),intent(in) :: phi,a,f,z
  g = phi - acosh(a/f*cosh(phi*z))
end function

pure function dg(phi,a,f,z)
  real(wp) :: dg
  real(wp),intent(in) :: phi,a,f,z
  dg = 1._wp - (a*z*sinh(phi*z))/(f*sqrt((a*cosh(phi*z))/f - 1._wp)*sqrt((a*cosh(phi*z))/f + 1._wp))
end function
end program