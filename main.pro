implement main
    open core

domains
    list = char*.

class predicates
    pars : (boolean [out]).
    nextChar : (char, char, list, boolean [out]).
    isI : (char, boolean [out]).
    isO : (char, boolean [out]).
    isN : (char, boolean [out]).
    add : (list, list [out]).
    pop : (list, list [out], boolean [out]).

class facts
    correct : (char, char).

clauses
    correct('(', 'O').

    correct(')', 'O').

    correct('I', 'O').

    correct('N', 'O').

    correct('O', '(').

    correct('O', 'I').

    correct('O', 'N').

    correct('(', 'I').

    correct('I', ')').

    correct('(', 'N').

    correct('N', ')').

    correct('(', '(').

    correct(')', ')').

    correct('N', 'N').

    correct('I', 'I').

    nextChar(Pred, Sym, L, IsCorrect) :-
        Sym = ' ',
        !,
        C = stdio::readChar(),
        nextChar(Pred, C, L, NIsCorrect),
        IsCorrect = NIsCorrect.

    nextChar(_Pred, Sym, L, IsCorrect) :-
        Sym = '.',
        pop(L, _NL, Res),
        Res = false,
        !,
        IsCorrect = true.

    nextChar(_Pred, Sym, L, IsCorrect) :-
        Sym = '.',
        pop(L, _NL, Res),
        Res = true,
        !,
        IsCorrect = false.

    nextChar(Pred, Sym, L, IsCorrect) :-
        isI(Sym, Res),
        Res = true,
        correct(Pred, 'I'),
        !,
        C = stdio::readChar(),
        nextChar('I', C, L, NIsCorrect),
        IsCorrect = NIsCorrect.

    nextChar(Pred, Sym, L, IsCorrect) :-
        isO(Sym, Res),
        Res = true,
        correct(Pred, 'O'),
        !,
        C = stdio::readChar(),
        nextChar('O', C, L, NIsCorrect),
        IsCorrect = NIsCorrect.

    nextChar(Pred, Sym, L, IsCorrect) :-
        isN(Sym, Res),
        Res = true,
        correct(Pred, 'N'),
        !,
        C = stdio::readChar(),
        nextChar('N', C, L, NIsCorrect),
        IsCorrect = NIsCorrect.

    nextChar(Pred, Sym, L, IsCorrect) :-
        Sym = ')',
        Pred <> 'O',
        pop(L, NL, Res),
        Res = true,
        !,
        C = stdio::readChar(),
        nextChar(')', C, NL, NIsCorrect),
        IsCorrect = NIsCorrect.

    nextChar(Pred, Sym, L, IsCorrect) :-
        Sym = '(',
        correct(Pred, Sym),
        !,
        add(L, NL),
        C = stdio::readChar(),
        nextChar('(', C, NL, NIsCorrect),
        IsCorrect = NIsCorrect.

    nextChar(_, _, _, false).

    pars(Result) :-
        C = stdio::readChar(),
        L = [],
        nextChar('(', C, L, Res),
        Result = Res.

    isI(Sym, Res) :-
        Sym >= 'a',
        Sym <= 'z',
        !,
        Res = true.

    isI(_, false).

    isN(Sym, Res) :-
        Sym >= '0',
        Sym <= '9',
        !,
        Res = true.

    isN(_, false).

    isO(Sym, Res) :-
        Sym = '-',
        !,
        Res = true.

    isO(Sym, Res) :-
        Sym = '+',
        !,
        Res = true.

    isO(Sym, Res) :-
        Sym = '*',
        !,
        Res = true.

    isO(Sym, Res) :-
        Sym = '/',
        !,
        Res = true.

    isO(_, false).

    add(L, ['(' | L]).

    pop([], [], false).

    pop([_X | L], L, true).

clauses
    run() :-
        pars(Res),
        console::write("Answer: "),
        console::write(Res),
        _ = console::readLine(),
        _ = console::readLine(),
        succeed.

end implement main

goal
    console::runUtf8(main::run).
