% Ivan Bratko, "PROLOG, Programming for Artificial Intelligence"
% Figure 1.8   The family program.
% (the original code is slightly modified to comply with SWI-Prolog.)

:- dynamic(parent/2).

parent( pam, bob).       % Pam is a parent of Bob
parent( tom, bob).
parent( tom, liz).
parent( bob, ann).
parent( bob, pat).
parent( pat, jim).
parent( mary, pam).

female( pam).            % Pam is female
female( liz).
female( ann).
female( pat).
female( mary).

male( jim).
male( tom).              % Tom is male
male( bob).

offspring( Y, X)  :-     % Y is an offspring of X if
   parent( X, Y).        % X is a parent of Y

mother( X, Y)  :-        % X is the mother of Y if
   parent( X, Y),        % X is a parent of Y and
   female( X).           % X is female


father( X, Y) :- parent( X, Y), male(X).

grandparent( X, Z)  :-   % X is a grandparent of Z if
   parent( X, Y),        % X is a parent of Y and
   parent( Y, Z).        % Y is a parent of Z

sister( X, Y)  :-        % X is a sister of Y if
   parent( Z, X),
   parent( Z, Y),        % X and Y have the same parent and
   female( X),           % X is female and
   different( X, Y).     % X and Y are different

predecessor( X, Z)  :-   % Rule prl: X is a predecessor of Z
   parent( X, Z).

predecessor( X, Z)  :-   % Rule pr2: X is a predecessor of Z
   parent( X, Y),
   predecessor( Y, Z).

different( X, X) :- !, fail.
different( _, _) :- true.


related(X, Y) :- predecessor(X, Y); predecessor(Y, X).
related(X, Y) :- predecessor(Z, X), predecessor(Z, Y).

notmember(_, []).
notmember(X, [H | T]) :- different(X, H), notmember(X, T).


