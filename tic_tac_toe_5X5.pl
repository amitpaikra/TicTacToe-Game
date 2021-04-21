% Utility function, find all permutation
del(X,[X|L1],L1).
del(X,[Y|L1],[Y|L2]):-
    del(X,L1,L2).
permute([],[]).
permute(L,[X|P]):-
    del(X,L,L1),
    permute(L1,P).

ordered_line( 1, 2, 3, 4 ). 
ordered_line(2, 3, 4, 5). 
ordered_line(6 ,7, 8, 9).
ordered_line(7, 8, 9, 10).
ordered_line(11, 12, 13, 14).
ordered_line(12, 13, 14, 15 ).
ordered_line(16, 17, 18, 19).
ordered_line(17, 18, 19, 20).
ordered_line(21, 22, 23, 24).
ordered_line(22, 23, 24, 25 ).
ordered_line( 1, 6, 11, 16 ). 
ordered_line(6, 11, 16, 21).
ordered_line(2, 7, 12, 17).
ordered_line(7, 12, 17, 22).
ordered_line(3, 8, 13, 18).
ordered_line(8, 13, 18, 23).
ordered_line(4, 9, 14, 19).
ordered_line(9, 14, 19, 24).
ordered_line(5, 10, 15, 20).
ordered_line(10, 15, 20, 25).
ordered_line(2, 3, 4, 5).
ordered_line( 16 , 12 , 8 , 4). 
ordered_line( 21 , 17 , 13 , 9  ).
ordered_line( 17 , 13 , 9 , 5  ).
ordered_line( 22 , 18 , 14 , 10).
ordered_line( 2,8,14,20).
ordered_line( 1 , 7 ,13,19 ).
ordered_line( 7 , 13 , 19 , 24).
ordered_line( 6 , 12 , 18 , 24).

line( A , B , C , D ):- permute( [ A , B , C , D ], [ Aans , Bans , Cans , Dans   ] ) , ordered_line( Aans , Bans , Cans , Dans ).


full(A) :- x(A).
full(A) :- o(A). 
empty(A) :- \+(full(A)).

same(A, A). different(A, B) :- \+(same(A, B)).
move(CurrPos , A) :- bestMove(CurrPos , A )/*good(A)*/, empty(A), !.

getXrange( CurrPos , Ans ):-  Ans is CurrPos - ((CurrPos-1) mod 5 ).
getYrange( CurrPos , Ans ):-  Ans is CurrPos + 4 - ((CurrPos-1) mod 5 ).  
bestMove(CurrPos , A ) :- 
    A is CurrPos-1 , getXrange(CurrPos , R1 ) , getYrange( CurrPos , R2 ), R1 =< A , R2 >= A
    ;
    A is CurrPos+1  , getXrange( CurrPos , R1) , getYrange( CurrPos , R2 ), R1 =< A , R2 >= A 
    ;
    A is CurrPos-1-5, getXrange(CurrPos , R1 ) , getYrange( CurrPos , R2 ), R1-5 =< A , R2-5 >= A , A >= 1 , A =< 25 
    ;
    A is CurrPos-5 , getXrange(CurrPos , R1 ) , getYrange( CurrPos , R2 ), R1-5 =< A , R2-5 >= A , A >= 1 , A =< 25 
    ;
    A is CurrPos+1-5 , getXrange(CurrPos , R1 ) , getYrange( CurrPos , R2 ), R1-5 =< A , R2-5 >= A , A >= 1 , A =< 25 
    ;
    A is CurrPos-1+5 , getXrange(CurrPos , R1 ) , getYrange( CurrPos , R2 ), R1+5 =< A , R2+5 >= A , A >= 1 , A =< 25 
    ;
    A is CurrPos+5 , getXrange(CurrPos , R1 ) , getYrange( CurrPos , R2 ), R1+5 =< A , R2+5 >= A , A >= 1 , A =< 25
    ;
    A is CurrPos+1+5 , getXrange(CurrPos , R1 ) , getYrange( CurrPos , R2 ), R1+5 =< A , R2+5 >= A , A >= 1 , A =< 25 
    ;
    good(A) .

good(5).
good(1).
good(3). 
good(7). 
good(9). 
good(2). 
good(4).
good(6). 
good(8). 
good(10).
good(11).
good(12).
good(13).
good(14).
good(15).
good(16).
good(17).
good(18).
good(19).
good(20).
good(21).
good(22).
good(23).
good(24).
good(25).

all_full :- full(1), full(2), full(3), full(4), full(5),
full(6), full(7), full(8), full(9), full(10),
full(11), full(12), full(13), full(14), full(15),
full(16), full(17), full(18), full(19), full(20),
full(21), full(22), full(23), full(24), full(25).

done :- ordered_line(A, B, C , D ), x(A), x(B), x(C), x(D) ,  write('I won.'), nl.
done :- all_full, write('Draw.'), nl.

getmove(X) :- repeat, write('Please enter a move: '), read(X), empty(X), assert(o(X)).

makemove(CurrPos) :- move(CurrPos , X), !, assert(x(X)).
makemove(_CurrPos) :- all_full.

printsquare(N) :- o(N), write(' o ').
printsquare(N) :- x(N), write(' x ').
printsquare(N) :- empty(N), write('   ').
printboard :- printsquare(1), printsquare(2), printsquare(3), printsquare(4) , printsquare(5), nl,
printsquare(6), printsquare(7), printsquare(8), printsquare(9) , printsquare(10), nl,
printsquare(11), printsquare(12), printsquare(13), printsquare(14) , printsquare(15), nl,
printsquare(16), printsquare(17), printsquare(18), printsquare(19) , printsquare(20), nl,
printsquare(21), printsquare(22), printsquare(23), printsquare(24) , printsquare(25), nl.

clear :- retractall(x(_)), retractall(o(_)).
% main
play :- random(1 , 3  , Ans ), startgame(Ans).
startgame(1) :- write("Computer take first"), nl , clear , repeat,  random(1 , 26 , X), ! ,assert(x(X)) , printboard ,getmove(CurrPos), respond(CurrPos). %human
startgame(2) :- write("Human take first") , nl , clear, repeat, getmove(X), respond(X). %computer

respond(_CurrPos) :- ordered_line(A, B, C , D  ), o(A), o(B), o(C), o(D),
printboard, write('You won.'), nl. 
respond(CurrPos) :- makemove(CurrPos), printboard, done.

