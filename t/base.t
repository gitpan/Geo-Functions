#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: base.t,v 0.1 2006/02/21 eserte Exp $
# Author: Michael R. Davis
#

=head1 Test Examples

base.t has good examples concerning how to use this module

=cut

use strict;
use lib q{lib};
use lib q{../lib};
use constant NEAR_DEFAULT => 7;

sub near {
  my $x=shift();
  my $y=shift();
  my $p=shift()||NEAR_DEFAULT;
  if (($x-$y)/$y < 10**-$p) {
    return 1;
  } else {
    return 0;
  }
}

BEGIN {
    if (!eval q{
	use Test;
	1;
    }) {
	print "1..0 # tests only works with installed Test module\n";
	exit;
    }
}

BEGIN { plan tests => 28 }

# just check that all modules can be compiled
ok(eval {require Geo::Functions; 1}, 1, $@);

my $o = Geo::Functions->new();
ok(ref $o, "Geo::Functions");

ok ($o->deg_rad(atan2(1,1)), 45);
ok ($o->deg_dms(40,42,46.5,"N"), 40+(42+46.5/60)/60);
ok ($o->rad_deg(45), atan2(1,1));

use Geo::Functions qw{deg_rad deg_dms rad_deg round};

ok (deg_rad(atan2(1,1)), 45);
ok (deg_dms(40,42,46.5,"s"), -1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5,"S"), -1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5,"w"), -1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5,"W"), -1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5,-1), -1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5,-40), -1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5,"N"), 1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5,"n"), 1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5,""), 1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5,undef), 1*(40+(42+46.5/60)/60));
ok (deg_dms(40,42,46.5), 1*(40+(42+46.5/60)/60));
ok (rad_deg(45), atan2(1,1));
ok (rad_deg(90), atan2(1,0));
ok (rad_deg(180), atan2(0,-1));
ok (rad_deg(-90), atan2(-1,0));
ok (round(0), 0);
ok (round(5.1), 5);
ok (round(5.5), 6);
ok (round(5.6), 6);
ok (round(-5.1), -5);
ok (round(-5.5), -6);
ok (round(-5.6), -6);
