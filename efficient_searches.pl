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


ids(Paths, 1, Max, Solution):-
  choose(Paths, Node),
  goal(Node),
  length(Paths,Length),
  Length - 1 =< Max,
  reverse(Paths, Solution).

ids(Paths, 1, Max, Solution):-
  expands(Paths, NewNode),
	\+ member(NewNode, Paths),
  combine(Paths, NewNode, FinalPath),
	ids(FinalPath, 1,, Solution).



expands([Node|_], NewNode):-
	arc(Node, NewNode).

choose(Paths, Node):-
  nth0(0,Paths,Node).

combine(CurrentPaths, NewNode, Paths):-
  append([NewNode],CurrentPaths,Paths).
