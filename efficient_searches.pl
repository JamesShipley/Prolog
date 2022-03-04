dfs(Paths, Solution):-
  choose(Paths, Node),
	goal(Node),
	reverse(Paths, Solution).

dfs(Paths, Solution):-
	expands(Paths, NewNode),
	\+ member(NewNode, Paths),
  combine(Paths, NewNode, FinalPath),
	dfs(FinalPath, Solution).


dldfs(Paths, Depth, Solution):-
  choose(Paths, Node),
  goal(Node),
  length(Paths,Length),
  Length - 1 =< Depth,
  reverse(Paths, Solution).

dldfs(Paths, Depth, Solution):-
	expands(Paths, NewNode),
	\+ member(NewNode, Paths),
  combine(Paths, NewNode, FinalPath),
	dldfs(FinalPath, Depth, Solution).


ids(Paths,CurDepth,MaxDepth,X):-dldfs(Paths,CurDepth,X).
ids(Paths,CurDepth,MaxDepth,X):-CurDepth < MaxDepth, ids(Paths,CurDepth+1,MaxDepth,X).

idsh(Paths,Depth,[],X):- dldfs(Paths,Depth,Y),idsh(Paths,Depth+1,[Y],X).
idsh(Paths,Depth,[Y | H],X):- dldfs(Paths,Depth,Y), any([Y|H],X).
idsh(Paths,Depth,[Y | H],X):-dldfs(Paths,Depth,Z), Z=\=Y,idsh(Paths,Depth,[Z,Y|H],X).
any([A|R],A).
any([A|R],X):-any(R,X).


expands([Node|_], NewNode):-
	arc(Node, NewNode).

choose(Paths, Node):-
  nth0(0,Paths,Node).

combine(CurrentPaths, NewNode, Paths):-
  append([NewNode],CurrentPaths,Paths).

nth0(0,[L|List],Elem):- L==Elem.
nth0(Index,[L|List],Elem):-Index>0,Sub is Index-1, nth0(Sub,List,Elem).
