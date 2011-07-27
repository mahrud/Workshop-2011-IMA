restart
installPackage "Graphs"
installPackage "GraphicalModels"

------------------------------------------------------------
---gaussianRing:
gaussianRing 3 

G = mixedGraph(digraph {{b,{c,d}},{c,{d}}},bigraph {{a,d}})
gaussianRing G --passing a graph gives the variable names l's and p's

--gaussianRing does not take undirected graphs as input. It should:
G = graph({{a,b},{b,c},{c,d},{a,d}}) 
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
cov=covarianceMatrix(R,G) -- now works for undirected graphs
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
------------------------------------------------------------
---gaussianMatrices:
--needs to be able to only take as input only a ring R and a set of CI statements S, 
--not necessarily a graph G.

--there is no such function for MixedGraphs: its code is embedded inside trekIdeal(Ring,MixedGraph,List)


------------------------------------------------------------
-- want to be able to give the ring R and the list of CI statements S, 
--and have it spit out the ideal generated by the minors of matrices.
