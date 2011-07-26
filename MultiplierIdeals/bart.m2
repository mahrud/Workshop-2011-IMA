-- End functionality:
-- input: ring, sequence of integers, and a real number
-- output: multiplier ideal

-- Intermediate functionality (we need):
-- Symbolic power of I.
-- term ideal of the monomial ideal. DONE!
-- some intersection of the lattice points. 

-- This implementation is based on the algorithm given in
-- H.M. Thompson's paper: "Multiplier Ideals of Monomial Space
-- Curves."

restart
installPackage "MonomialMultiplierIdeals"
viewHelp MonomialMultiplierIdeals

R = QQ[x,y];
I = monomialIdeal(y^2,x^3);
monomialMultiplierIdeal(I,5/6)

KK = ZZ/101
R = KK[x,y,z]	    

-- the code for affineMonomialCurveIdeal is based off of the code for
-- monomialCurveideal

affineMonomialCurveIdeal = (S, a) -> (
     -- check that S is a polynomial ring over a field
     n := # a;
     if not all(a, i -> instance(i,ZZ) and i >= 1)
     then error "expected positive integers";
     t := symbol t;
     k := coefficientRing S;
     M1 := monoid [t];
     M2 := monoid [Variables=>n];
     R1 := k M1;
     R2 := k M2;
     t = R1_0;
     mm := matrix table(1, n, (j,i) -> t^(a#i));
     j := generators kernel map(R1, R2, mm);
     ideal substitute(j, submatrix(vars S, {0..n-1}))
     );

I = affineMonomialCurveIdeal(R,nn)


     
ord = (mm,p) -> (
     R := ring p;
     KK := coefficientRing R;
     A := KK[gens R,Degrees=>mm];
     first sort flatten apply(terms p, i -> degree sub(i,A))
     );


sortedff = (R,nn) -> (
     KK := coefficientRing R;
     A := KK[gens R,Degrees=>nn]; -- note if there are too many variables, an error will occur
     apply(flatten entries sort(gens affineMonomialCurveIdeal(A,nn),DegreeOrder=>Ascending), i-> sub(i,R))
     );

L = sortedff(R,{2,3,4})

--------------HERE

x^2 / 1

exceptionalDivisorValuation = (nn,mm,p) -> (
     R := ring p;
     ff := sortedff(R,nn);
     n := 0;
     while p % ff_0^n == 0 do n = n+1; 
     n = n-1;
     n*ord(mm,ff_1) + ord(mm,p/ff_0^n)
     );
exceptionalDivisorValuation({2,3,4},{1,1,1},(x^2-z)*x^2)

ord({1,1,1},x^2-z)

-- note that the term ideal is just the ideal generated by the terms, correct?

termIdeal = I -> monomialIdeal flatten apply(flatten entries gens I, i -> terms i);

termIdeal I

-- here we wish to compute the symbolic power I^(floor t). We'll use
-- the saturate command, but in the future there may be a better
-- option.

symbolicPowerCurveIdeal = (I,t) -> saturate(I^(floor t));






