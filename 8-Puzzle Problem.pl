/* 8-Puzzle Problem
   0 represents the blank tile
   State is a list of 9 elements
*/

% Goal state
goal([1,2,3,
      4,5,6,
      7,8,0]).

% Move definitions (blank moves)

move(State, NextState) :-
    swap(State, NextState, I, J),
    adjacent(I, J).

% Adjacent positions in 3x3 grid
adjacent(0,1). adjacent(1,2).
adjacent(3,4). adjacent(4,5).
adjacent(6,7). adjacent(7,8).

adjacent(0,3). adjacent(3,6).
adjacent(1,4). adjacent(4,7).
adjacent(2,5). adjacent(5,8).

adjacent(X,Y) :- adjacent(Y,X).

% Swap blank (0) with adjacent tile
swap(State, NewState, I, J) :-
    nth0(I, State, 0),
    nth0(J, State, X),
    X \= 0,
    replace(State, I, X, Temp),
    replace(Temp, J, 0, NewState).

% Replace element at index
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 0,
    I1 is I - 1,
    replace(T, I1, X, R).

% Depth-first search solver
solve(State, State, _, []) :-
    goal(State).

solve(State, Goal, Visited, [Next|Path]) :-
    move(State, Next),
    \+ member(Next, Visited),
    solve(Next, Goal, [Next|Visited], Path).

% Start solving
start(State, Path) :-
    goal(Goal),
    solve(State, Goal, [State], Path).
