#!/usr/local/bin/perl

use strict;
use warnings;

use File::Basename;

use Cwd;

my $src = $ARGV[0];
my $dst = $ARGV[1];
if ($dst eq "") {
    $dst = ".";
}

my @files = `adb shell < ls.txt`;

my $len = @files;
my $i = 1;
print "files len: $len\n";

foreach my $path (@files) {
    $path =~ s/^\.//;
    chomp($path);
    my $dir = dirname($path);

    system("mkdir -p ".$dst.$dir);
    system("adb pull \"$src$path\" \"$dst$dir/\">/dev/null");

    $i++;

    print "$i";
}

