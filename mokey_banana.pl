/* 
   Monkey–Banana Problem
   state(MonkeyPosition, MonkeyStatus, BoxPosition, BananaStatus)
*/

% Initial state
initial_state(state(at_door, on_floor, at_window, hanging)).

% Goal state
goal_state(state(_, _, _, has_banana)).

% Monkey walks to a new position
move(
    state(MonkeyPos, on_floor, BoxPos, Banana),
    walk(MonkeyPos, NewPos),
    state(NewPos, on_floor, BoxPos, Banana)
).

% Monkey pushes the box (monkey and box must be at same place)
move(
    state(Pos, on_floor, Pos, Banana),
    push(Pos, NewPos),
    state(NewPos, on_floor, NewPos, Banana)
).

% Monkey climbs onto the box
move(
    state(Pos, on_floor, Pos, Banana),
    climb,
    state(Pos, on_box, Pos, Banana)
).

% Monkey grabs the banana
move(
    state(middle, on_box, middle, hanging),
    grab,
    state(middle, on_box, middle, has_banana)
).

% Solver
solve(State, []) :-
    goal_state(State).

solve(State, [Action | Rest]) :-
    move(State, Action, NewState),
    solve(NewState, Rest).

/*
   Run using:
   ?- initial_state(S), solve(S, Plan).
*/
