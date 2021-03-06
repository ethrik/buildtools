#!/usr/bin/env perl

# check - A tool to check Perl programs against Perl::Critic
# Copyright (c) 2010 Ethrik Project

use strict;
use warnings;
use Perl::Critic;
my $level;

if (!defined $ARGV[0])
{
  print "usage: $0 <file> [level]\n";
  exit 0;
}

if (!-e $ARGV[0])
{
  print "$0: could not find $ARGV[0]\n";
  print "usage: $0 <file> [level]\n";
  exit 0;
}

if ($ARGV[1] and $ARGV[1] =~ m/(5|4|3|2|1|gentle|stern|harsh|cruel|brutal)/xsm) {
	$level = $ARGV[1];
}
else {
	$level = 1;
}


my $critic = Perl::Critic->new(-severity => $level);
my @violations = $critic->critique($ARGV[0]);

if (!defined $violations[0])
{
  print "$ARGV[0] passed (no violations)\n";
  exit 0;
}

print "Violations:\n";
my $count = 0;
print "$_\n" and $count++ foreach (@violations);
print "Errors: $count\n";
