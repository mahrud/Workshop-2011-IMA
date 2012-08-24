quit
restart
uninstallPackage "GraphicalModels"
installPackage( "GraphicalModels", RemakeAllDocumentation=>true)
viewHelp "GraphicalModels"

--- running tests:
check "GraphicalModels"


uninstallPackage "Graphs"
installPackage ("Graphs", RemakeAllDocumentation=>true)



viewHelp "GraphicalModels"

------------------------------------------------------------
---gaussianRing:
gaussianRing 3 
gaussianRing 4
peek oo
gaussianRing (4, sVariableName=>t)
S=gaussianRing 4
covarianceMatrix S
--peek gaussianRingList

G = mixedGraph(digraph {{b,{c,d}},{c,{d}}},bigraph {{a,d}})
R = gaussianRing G --passing a graph gives the variable names l's and p's
covarianceMatrix R
R#gaussianRing
R = gaussianRing 4

H = digraph {{b,{c,d}},{c,{d}}}

trekIdeal(R,G)
trekIdeal(S,G)

--gaussianRing does not take undirected graphs as input. It should:
G = graph({{a,b},{d,a},{b,c},{c,d}}) 
Rg= gaussianRing G --this now works!

Rg.graph
Rg.digraph
Rg.mixedGraph

gaussianRing (G, Coefficients=>ZZ)
gaussianRing (G, VariableName=>{getSymbol "seth"}) -- this does NOT do what it's supposed to,
gaussianRing (G, kVariableName=>Seth)
transpose vars oo

--
G = graph({{a,b},{b,c},{c,d},{a,d}}) 
R=gaussianRing G 
M=undirectedEdgesMatrix(R,G)

-- to get the adjoint:
-- to be invertible needs to be promoted to fraction field:
adjK = sub(det(M)* inverse(sub(M,frac R)), R)
cov=covarianceMatrix(R)--,G) -- now works for undirected graphs
flatten  entries( t*cov - adjK) 
t*det(M)-1
     
G = graph({{a,b},{b,c},{c,d},{a,d}}) 
R=gaussianRing G 
I=gaussianVanishingIdeal R   -- works now, may take a while for larger G.
numgens I

--by the way:
m=R#numberOfEliminationVariables

restart
loadPackage "GraphicalModels"
--trying to modify gaussianVanishingIdeal:
G = graph({{a,b},{b,c},{c,d},{a,d}}) 
R=gaussianRing G 

 pairMarkov G
localMarkov G 


G = graph({{a,b},{b,c},{c,d},{d,e},{e,a}}) 
gaussianRing G

globalMarkov G

R=QQ[a,b]
gaussianVanishingIdeal(R,G) --demonstrating the error message. :)



G = graph({{a,b},{b,c},{c,d},{d,a}})
R=gaussianRing G 
I=conditionalIndependenceIdeal (R,G)

------------------------------------------------------------
---gaussianMatrices:
--needs to be able to only take as input only a ring R and a set of CI statements S, 
--not necessarily a graph G.

--there is no such function for MixedGraphs: its code is embedded inside trekIdeal(Ring,MixedGraph,List)


------------------------------------------------------------
-- want to be able to give the ring R and the list of CI statements S, 
--and have it spit out the ideal generated by the minors of matrices.
restart
loadPackage "GraphicalModels"
       G = digraph {{a,{b,c}}, {b,{c,d}}, {c,{}}, {d,{}}}
       R = gaussianRing G
  conditionalIndependenceIdeal(R,G)
       S = covarianceMatrix R
G1 = digraph {{a,{b,c}}, {b,{c,d}}, {c,{}}, {d,{}}, {e,{a,b}}}
R1 = gaussianRing G1
peek R1
S1=covarianceMatrix R1
S2 = covarianceMatrix(R1,G1)
entries S1 === entries S2
S3=covarianceMatrix(R,G1)
entries S3===entries S2 ----THIS IS FALSE!!! SEE COMMENT IN CODE LINE no 586 (approximately).

n := R#gaussianRing; 
genericSymmetricMatrix(R,n) ==  S --true
genericSymmetricMatrix(R1,n) == S1 --false
--etc.

--let me fix the bug above:
G1 
vertices G1
vertices R.digraph
sort vertices G1 === sort vertices R.digraph--these 2 are not in the same gaussianRing
sort vertices G1 === sort vertices R1.digraph--these 2 are
--note that   G is a subgraph of G1.
--let's get the covariance matrix of the graph:
Rtemp:= gaussianRing G 
n:=Rtemp#gaussianRing
M:=genericSymmetricMatrix(Rtemp,n) 
sub(M,R1) --this returns the matrix for G but in the ring R1, even though it lives in the smaller ring R too. 
--if i don't want ot introduce this confusion in the code then i need an exampel like this in the documentation.

g = graph({{a,b},{b,c},{c,d},{d,e},{e,a}}) 
r=gaussianRing g
covarianceMatrix r
--OMG THIS IS JUST like:
genericSymmetricMatrix (r,r#gaussianRing#0)  ---- but shifted to ignore the k variables!

-------------------------------------------------
-------------------------------------------------

R = markovRing (2,2,2,2)
vars R
--R.markov
--#R.markov
VarNames = {c,d,e,f}
Stmts = { {{c,d},{e},{}}, {{d,e},{c},{f}}}
conditionalIndependenceIdeal(R,VarNames,Stmts)
--conditionalIndependenceIdeal(R,Stmts)

restart
uninstallPackage "GraphicalModels"
installPackage( "GraphicalModels", RemakeAllDocumentation=>true)
G = graph({{a,b},{b,c},{c,d},{d,e},{e,a}}) 

H = digraph {{a,{b,c}}, {b,{c,d}}, {c,{}}, {d,{}}}
H=digraph{{1,{2,3}},{2,{3,4}}}
R = markovRing (2,2,2,2)
markovMatrices(R,globalMarkov H)
(topSort H)#map

R.markovRing
R.markov
R.markovVariables
conditionalIndependenceIdeal(R,G)
gens R

S = gaussianRing 4
S#gaussianRing
if (not R.?markov) then error "expected a ring created with markovRing"


R = gaussianRing G
R = gaussianRing H
R.graph
R.digraph
R#gaussianRing
describe R
R = gaussianRing 4


printWidth = 80
s = {{{1},{2},{3}}}
R=markovRing(2,2,2)
gens R
conditionalIndependenceIdeal(R,s)
 betti oo
markovMatrices (R,s)
 
G = graph({{a,b},{b,c}})
st=pairMarkov G

undirectedEdgesMatrix (gaussianRing G)

--seth's example:
G = digraph{{a,{d}},{b,{d}},{c,{d,e}},{d,{e}}}
R = gaussianRing G
vars R
I = conditionalIndependenceIdeal(R,globalMarkov(G));
J = gaussianVanishingIdeal(R);
mingens I
J=ideal mingens J
betti J
degrees mingens J

flatten degrees J
flatten degrees I
betti I

gens R
directedEdgesMatrix R
undirectedEdgesMatrix R
break 







help markovRing
markovRing((1,2),VariableName=> getSymbol "tr")
markovRing((1,2),VariableName=> "tr")
markovRing((1,2),VariableName=> tr)
tr_(1,1)

R=gaussianRing G
conditionalIndependenceIdeal(R,st)
gaussianMatrices (R,st)

 
 
gaussianMatrices (R,globalMarkov G)

R = QQ[x,y,z]
I = ideal(0_R) + 0
M = matrix{{x,y,z}}
J = minors(2,M)
I == J
R#gaussianRing
trekIdeal(R,H)


G = mixedGraph(digraph {{b,{c,d}},{c,{d}}},bigraph {{a,d}})
R = gaussianRing G

peek R
keys R

conditionalIndependenceIdeal (R,Stmts)

--- running tests:
check "GraphicalModels"


R = markovRing (2,2,2,2)
H = digraph {{a,{b,c}}, {b,{c,d}}, {c,{}}, {d,{}}}
rH = gaussianRing H
rH.digraph

R = QQ[a11,a12,a21,a22,p111,p112,p121,p122,p211,p212,p221,p222,  MonomialOrder => Eliminate 4]

I = ideal(
     p111 - (p111 + p112)*a11, p112 - (p111 + p112)*a12, 
     p121 - (p121 + p122)*a21, p122 - (p121 + p122)*a22, 
     p211 - (p211 + p212)*a11, p212 - (p211 + p212)*a12, 
     p221 - (p221 + p222)*a21, p222 - (p221 + p222)*a22,
     a11+a12 -1, a21 + a22-1
     );
selectInSubring(1,gens gb I)
 
 
--- here is a digraph with a directed cycle:
loadPackage "GraphicalModels"
       G = digraph {{a,{b}}, {b,{c}}, {c,{d}}, {d,{a}}}
--let's test functions to see which ones need exceptions added: 
     R = gaussianRing G --OK
pairMarkov G  --bad due to nondescentents -FIXED
localMarkov G  --bad --FIXED
     globalMarkov G --OK
     trekIdeal(R,G) --OK, it seems.
     gaussianMatrices(R,{{{a},{c},{d,b}}}) --OK
     gaussianVanishingIdeal R --OK already has the error becaues uses topSort 
     conditionalIndependenceIdeal(R,globalMarkov G) --OK

--here is what I want to insert:
if isCyclic G then error("digraph must be acyclic");
 

H = digraph {{a,{b,c}}, {b,{c,d}}, {d,{}}, {c,{}}}

shuffle=apply(vertices H, v-> (topSort H)#map#v)
shuffle = values (topSort H)#map --this results in the same permutation as above! duh.

ind=shuffle-toList(4:1)
d=(2,3,4,5)
d_ind

pos = (h, x) -> position(h, i->i===x)
position(d,3)
help position
pos(d,5)
n=#d
apply(1..n,i-> pos(shuffle,i) )
