
# use Data::Dumper;

print "1..12\n";

my $v;

@ARGV = ( "yy", "zz" );
my %h = (
    aa       => 123,
    bb       => 456,
    shift    => 789,
    'pop'    => 910,
    '+shift' => 101,
    '-shift' => 203,
    time     => 305,
    yy       => 444,
);

# print STDERR Dumper \%h;

$v = $ARGV[0];
print "not " if $v ne "yy";
print "ok 1 - shift is bareword # $v\n";

$v = $h{ +shift };
print "not " if $v ne "444";
print "ok 2 - +shift is not bareword # $v\n";

$v = $h{-shift};
print "not " if $v ne "203";
print "ok 3 - -shift is bareword # $v\n";

$v = $h{shift};
print "not " if $v ne "789";
print "ok 4 - shift is bareword # $v\n";

@ARGV = ( "yy", "zz" );
my %j = ( yy => 777, zz => 888, );
$j{time}     = 305;
$j{shift}    = 406;
$j{ +shift } = 507;
$j{-shift}   = 608;

# print STDERR Dumper \%j;

$v = $ARGV[0];
print "not " if $v ne "zz";
print "ok 5 - +shift is not bareword # $v\n";

$v = $j{ +shift };
print "not " if $v ne "888";
print "ok 6 - +shift is not bareword # $v\n";

@ARGV = ( "yy", "zz" );
my %h = (
    yy       => 444,
    zz       => 555,
    '+shift' => 678,
    '-shift' => 912,
    +shift   => 101,
    -shift   => 203,
);
# use Data::Dumper;
# print STDERR Dumper \%h;

$v = $ARGV[0];
print "not " if $v ne "yy";
print "ok 7 - shift  # $v\n";

$v = $h{ +shift };
print "not " if $v ne "444";
print "ok 8 - +shift is not bareword # $v\n";

$v = $h{-shift};
print "not " if $v ne "203";
print "ok 9 - -shift  # $v\n";

$v = $h{'shift'};
print "not " if $v ne "101";
print "ok 10 - +shift is bareword before '=>' # $v\n";

$v = $h{'+shift'};
print "not " if $v ne "678";
print "ok 11 - +shift as string # $v\n";

$v = $h{'-shift'};
print "not " if $v ne "203";
print "ok 12 - -shift as string # $v\n";

