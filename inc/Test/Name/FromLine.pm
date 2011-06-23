#line 1
package Test::Name::FromLine;

use strict;
use warnings;

our $VERSION = '0.01';

use Test::Builder;
use File::Slurp;

no warnings 'redefine';
my $ORIGINAL_ok = \&Test::Builder::ok;
*Test::Builder::ok = sub {
	my %filecache;
	$_[2] ||= do {
		my ($package, $filename, $line) = caller($Test::Builder::Level);
		my $file = $filecache{$filename} ||= [ read_file($filename) ];
		my $lnum = $line;
		$line = $file->[$lnum-1];
		$line =~ s{^\s+|\s+$}{}g;
		"L$lnum: $line";
	};
	goto &$ORIGINAL_ok;
};


1;
__END__

=encoding utf8

#line 64
