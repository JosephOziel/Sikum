:- module(midi, [create_midi/1, add_note/7, prog_change/5, add_tempo/4, write_file/2]).
:- use_module(library(janus)).

% you need midiutil installed
% pip install midiutil

:- table create_midi/1, add_note/7, prog_change/5, add_tempo/4, write_file/2.

create_midi(MIDI) :-
    py_call(midiutil:'MIDIFile'(1), MIDI).

add_note(MIDI, Track, Chan, Pitch, Time, Dur, Vol) :-
   py_call(MIDI:addNote(Track, Chan, Pitch, Time, Dur, Vol)).

prog_change(MIDI, Track, Chan, Time, Instr) :-
    py_call(MIDI:addProgramChange(Track, Chan, Time, Instr)).

add_tempo(MIDI, Track, Time, Tempo) :-
    py_call(MIDI:addTempo(Track, Time, Tempo)).

write_file(MIDI, FileName) :-
    py_call(open(FileName, "wb"), File, [py_object(true)]),
    py_call(MIDI:writeFile(File)),
    py_call(File:close()).
