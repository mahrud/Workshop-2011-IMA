restart
installPackage "Graphs"
installPackage( "GraphicalModels", RemakeAllDocumentation=>true)

uninstallPackage "GraphicalModels"


viewHelp "GraphicalModels"

------------------------------------------------------------
---gaussianRing:
gaussianRing 3 
gaussianRing 4
gaussianRing (4, sVariableName=>t)
S=gaussianRing 4
covarianceMatrix S
--peek gaussianRingList

G = mixedGraph(digraph {{b,{c,d}},{c,{d}}},bigraph {{a,d}})
gaussianRing G --passing a graph gives the variable names l's and p's

--gaussianRing does not take undirected graphs as input. It should:
G = graph({{a,b},{d,a},{b,c},{c,d}}) 
gaussianRing G --this now works!

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
I=gaussianVanishingIdeal (R,G)   -- works now, may take a while for larger G.
numgens I

--by the way:
m=R#numberOfEliminationVariables

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
VarNames = {c,d,e,f}
Stmts = { {{c,d},{e},{}}, {{d,e},{c},{f}}}
conditionalIndependenceIdeal(R,VarNames,Stmts)
--conditionalIndependenceIdeal(R,Stmts)

restart
uninstallPackage "GraphicalModels"
installPackage( "GraphicalModels", RemakeAllDocumentation=>true)
G = graph({{a,b},{b,c},{c,d},{d,e},{e,a}}) 
G = digraph {{a,{b,c}}, {b,{c,d}}, {c,{}}, {d,{}}}
R = markovRing (2,2,2,2)
R.markovRing
R.markov
R.markovVariables
conditionalIndependenceIdeal(R,G)
gens R

S = gaussianRing 4
S#gaussianRing
if (not R.?markov) then error "expected a ring created with markovRing"

R = gaussianRing G
R = gaussianRing 4
Stmts = {{{1,2},{3},{4}}, {{1},{3},{}}}
gaussianMatrices (R,globalMarkov G)
