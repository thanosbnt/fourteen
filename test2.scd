s.boot;

(
SynthDef( \sin, { | amp = 0.01, freq = 333, trig = 1 |
    var env, sig;
    env = EnvGen.kr( Env.asr( 0.001, 0.9, 0.001 ), trig, doneAction: 0 );
    sig = LFTri.ar( [ freq, freq * 0.999 ], 0.0, amp ) * env;
    Out.ar( [ 0 ], sig * 0.6 );
}).add;

h = Synth( \sin, [ \amp, 0.4 ] );

x = OSCFunc( { | msg, time, addr, port |
    var pyFreq;

    pyFreq = msg[1];
    ( "freq is " + pyFreq ).postln;
    // Synth( \sin, [ \amp, 0.4 ] ).set( \freq, pyFreq );
   	p =  pyFreq;
	b = Buffer.read(s, p);

	x = SynthDef(\help_Buffer, { arg out = 0, bufnum;
	    Out.ar( out,
	        FreeVerb.ar(PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)* (-7.midiratio), doneAction:2), 0.7,0.4, 0.9) ! 2
	    )
	}).play(s,[\bufnum, b]);

	x = SynthDef(\help_Buffer, { arg out = 0, bufnum;
	    Out.ar( out,
	        FreeVerb.ar(PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)* (-15.midiratio), doneAction:2), 0.7,0.9, 0.9) ! 2
	    )
	}).play(s,[\bufnum, b]);

    s.record(path: "/home/sclang/.local/share/SuperCollider/out.wav", duration: 5);

}, "/print" );

)
