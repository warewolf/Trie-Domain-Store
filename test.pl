#!/usr/bin/perl
# vim: foldmethod=marker

use strict;
use warnings;
use lib qw(./lib);
use Trie::Domain::Store;
use Data::Dumper;
use List::UtilsBy qw(rev_sort_by);

my $tree = Trie::Domain::Store->new();

$tree->add("www.richardharman.com")->{count} = 3;
$tree->add("digg.com")->{count}              = 2;
$tree->add("www.digg.com")->{count}          = 1;

my (@names) = $tree->names();

foreach my $element ( rev_sort_by { my ($key) = %$_; $_->{$key}->{count} } @names ) {
  my ( $key, $ref ) = %$element;
  print "$key $ref->{count}\n";
}

