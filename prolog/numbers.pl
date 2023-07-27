%  Translate written numbers into digits.
%  Try:
%     ?- run.
%
% or something like:
%     ?- number(N, [three,hundred,forty,five], []), roman(N, R, []).
%     N = 345,
%     R = [c, c, c, x, l, v] .
%
%     ?- number(N, [four,hundred,forty,nine], []), roman(N, R, []).
%     N = 449,
%     R = [c, d, x, l, i, x] 

run :- read(Sentence),
	number(N, Sentence, []),
	write(N), nl,
	run.

d2s(N) :- number(N, L, []), !, d2sprint(L).
d2sprint([]) :- nl.
d2sprint([H|T]) :- write(H), d2sprint(T).

number(N) -->  number3(N); number2(N).

number2(N) --> %% numbers less than 100
     tenths_digit(N);
     digit(N);
     ten(N);
     tenths(N);
     teens(N).

number3(N) --> digit(H), [hundred], number2(D), {N is H*100+D}.


%%tenths_digit(N, L, R) :- tenths_digit2(T, D, L, R), N is T+D.
%%tenths_digit2(T, D) --> tenths(T), digit(D).
tenths_digit(N) --> tenths(T), digit(D), {N is T+D}.

digit(1) --> [one].
digit(2) --> [two].
digit(3) --> [three].
digit(4) --> [four].
digit(5) --> [five].
digit(6) --> [six].
digit(7) --> [seven].
digit(8) --> [eight].
digit(9) --> [nine].

ten(10) --> [ten].

teens(11) --> [eleven].
teens(12) --> [twelve].
teens(13) --> [thirteen].
teens(14) --> [fourteen].
teens(15) --> [fifteen].
teens(16) --> [sixteen].
teens(17) --> [seventeen].
teens(18) --> [eighteen].
teens(19) --> [nineteen].

tenths(20) --> [twenty].
tenths(30) --> [thirty].
tenths(40) --> [forty].
tenths(50) --> [fifty].
tenths(60) --> [sixty].
tenths(70) --> [seventy].
tenths(80) --> [eighty].
tenths(90) --> [ninety].


% Roman Numerals
% https://stackoverflow.com/questions/14897872/prolog-roman-numerals-attribute-grammars
%
roman(N) -->
    group(c, d, m, 100, H),
    group(x, l, c,  10, T),
    group(i, v, x,   1, U),
    {N is H+T+U}.
group(A,B,C, Scale, Value) -->
    (   g3(A, T)
    ;   [A, B], {T = 4}
    ;   [B], g3(A, F), {T is 5+F}
    ;   [B], {T is 5}
    ;   [A, C], {T = 9}
    ;   {T = 0}
    ),  {Value is Scale * T}.


g3(C, 1) --> [C].
g3(C, 2) --> [C,C].
g3(C, 3) --> [C,C,C].
