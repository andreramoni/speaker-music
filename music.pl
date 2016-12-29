#!/usr/bin/perl
$pass = @ARGV[1] || 300 ;

%nota = ( "A"  => "440",
          "A#" => "466",
          "B"  => "493",
          "C"  => "523",
          "C#" => "554",
          "D"  => "587",
          "D#" => "622",
          "E"  => "659",
          "F"  => "698",
          "F#" => "739",
          "G"  => "783",
          "G#" => "830"
        );

sub metro:{
    print ("- Initial count... Prepare !\n");
    sleep 1;
    foreach ( 1 .. 4 ){
	&beep("A",0.5);
	&pause(0.5);
    }
    print ("- GO ! ! !\n");
    
}

sub pause:{
    my ($times,$lyric) = @_;
    my $msec = $pass * $times ; 
    my $sec = $msec / 1000;
    print("- Pausing $msec ms ($sec)           \t| $lyric\n");
    system("setterm -bfreq 0 -blength $msec ; echo -en \"\a\" ; sleep $sec");
}

sub beep:{
    my ($abr,$times,$lyric) = @_;
    $freq = $nota{$abr};
    my $msec = $pass * $times ; 
    my $sec = $msec / 1000;
    print("- $abr ($freq Hz) for $msec ms ($times * $pass)\t| $lyric\n");
    system("setterm -bfreq $freq -blength $msec ; echo -en \"\a\" ; sleep $sec");
}

open(FH,"@ARGV[0]");
@song = <FH>;
close(FH);

print "- Music On Speaker $ver \n";
print "- By Ramoni <ramoni\@databras.com.br>\n";
print "- Time Step is: $pass \n";
print "- Get ready for the methronome (in 3 seconds) ...\n";
#sleep 3;
&metro;
# lah 
foreach  (@song){
    chomp($_);
    next if "$_" eq "";
    if($_ =~ /^#/) { print "$_\n" ; next }
    my ($letter,$number,$lyric) = split(/\:/,"$_");

    if("$letter" eq "p") { &pause(1,"$lyric") }
    else {
	&beep("$letter",$number,"$lyric");
    }
}
print "- End of the song\n";
print "- Made by Ramoni <ramoni\@databras.com.br>\n";
print "- :-)\n";
