#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use v5.10;
use Getopt::Std;
#use List::Util qw(shuffle);
#use v6;

#stores a list in array1 and permutates $num amount of times prints out the number of matches per each permutation and total number of matches if -c option is used

  ######################################################################
  # Roy Nunez                                                          #
  # This script;                                                       #
  #  1) reads a list from <STDIN> in an array                          #
  #  2) permutates the array and generates a shuffled one              #
  #  3) compares arrays and reports back number of matches             #
  #  4) repeats 2 and 3 amount of times determined by command line arg #
  #                                                                    #
  ######################################################################


die "<< err:number of permutations >>\n" unless @ARGV>=1;
my $num = shift @ARGV; #first command line argument required for number of permutation

my (@array, @fisher_array, @shuffled_array);
my $ct; my $match_ct; 
my %opts;
getopts('c', \%opts);

#-----subroutines in program -----#
# -FisherYatesShuffle             #
# -GetMatches                     #
# -PrintArray                     #
#---------------------------------#

while (<>) {
    chomp;
    push @array, $_;
}

my $permutation = 0;
for (1...$num){
 #   print "Permutation ", $permutation+1,"\n";
    @shuffled_array= FisherYatesShuffle(@array);
    GetMatches(\@array, \@shuffled_array);
    $permutation++;
#    print 0, "\n" if (!$add_ct);
}  
print "\n";
print "Total are $match_ct matches in $permutation  permutations...\n" if ($opts{c}) && ($match_ct); #optional

exit;


sub FisherYatesShuffle {
    my @fisher_array = @_;
    my $i = @fisher_array;
    while ( --$i ) {
        my $j = int rand( $i+1 );
        @fisher_array[$i,$j] = @fisher_array[$j,$i];
    }
    return @fisher_array;
}

sub GetMatches {
    my ($array1_ref, $array2_ref) = @_;
    my @one = @{ $array1_ref };       # dereferencing and copying each array
    my @two = @{ $array2_ref };
    my $fine;
    my $found_match;
    for (my $i =0 ; $i <=$#one; $i++) {
#	print $one[$i], "\t", $two[$i],"\n";
	if ($one[$i] eq $two[$i]) {
	    $found_match++;
#	    print $one[$i], "\t", $two[$i],"\n";
#	    print $i, "\t", $i,"\n";
	    $match_ct++;
	    $fine=1;
	} 
    }   
    if (!$fine) { print 0, "\t";}
    else {print $found_match, "\t";}
}


sub PrintArray {
    die "missing an array buddy :/\n" unless @_;
    my @array_print = @_;
    foreach $a ( @array_print) {
	print $a, "\n" if $a;
    }
}
