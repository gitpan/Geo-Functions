require Exporter;
package Geo::Functions;

=head1 NAME

Geo::Functions - Perl package for standard Geo:: functions

=head1 SYNOPSIS

  use Geo::Functions qw{deg_rad deg_dms rad_deg}; #import into namespace
  print "Degrees: ", deg_rad(3.14/4), "\n";

  use Geo::Functions;
  my $obj = Geo::Functions->new;
  print "Degrees: ", $obj->deg_rad(3.14/2), "\n";

=head1 DESCRIPTION

=head1 CONVENTIONS

Function naming convention is "format of the return" underscore "format of the parameters."  For example, you can read the deg_rad function as "degrees given radians" or "degrees from radians".

=cut

use strict;
use vars qw($VERSION $PACKAGE @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
@ISA = qw(Exporter);
@EXPORT_OK = (qw{deg_rad rad_deg deg_dms rad_dms round});
$VERSION = sprintf("%d.%02d", q{Revision: 0.03} =~ /(\d+)\.(\d+)/);
use Geo::Constants qw{RAD DEG};

=head1 CONSTRUCTOR

=head2 new

The new() constructor

  my $obj = Geo::Functions->new();

=cut

sub new {
  my $this = shift();
  my $class = ref($this) || $this;
  my $self = {};
  bless $self, $class;
  $self->initialize(@_);
  return $self;
}

=head1 METHODS

=cut

sub initialize {
  my $self = shift();
  my $param = shift();
}

=head2 deg_dms

Degrees given degrees minutes seconds.

  my $deg=deg_dms(39, 29, 17.134);

  my $deg=deg_dms(39, 29, 17.134, 'N');

=cut

sub deg_dms {
  my $self=shift();
  my $d=ref($self) ? shift()||0 : $self;
  my $m=shift()||0;
  my $s=shift()||0;
  my $nsew=shift()||'N';
  my $sign = ($nsew=~m/[SW-]/i) ? -1 : 1; #matches "-" to support -1
  return $sign * ($d + ($m + $s/60)/60);
}

=head2 deg_rad

Degrees given radians.

  my $deg=deg_rad(3.14);

=cut

sub deg_rad {
  my $self=shift();
  my $rad=ref($self) ? shift() : $self;
  return $rad*DEG();
}

=head2 rad_deg

Radians given degrees.

  my $rad=rad_deg(90);

=cut

sub rad_deg {
  my $self=shift();
  my $deg=ref($self) ? shift() : $self;
  return $deg*RAD();
}

=head2 rad_dms

Radians given degrees minutes seconds.

  my $rad=rad_dms(45 30 20.0);

=cut

sub rad_dms {
  return rad_deg(deg_dms(@_));
}

=head2 round

Round to the nearest integer. This formula rounds toward +/- infinity.

  my $int=round(42.2);

=cut

sub round {
  my $self=shift();
  my $number=ref($self) ? shift() : $self;
  return int($number + 0.5 * ($number <=> 0));
}

1;

__END__

=head1 TODO

=head1 BUGS

=head1 LIMITS

=head1 AUTHOR

Michael R. Davis qw/perl michaelrdavis com/

=head1 LICENSE

Copyright (c) 2006 Michael R. Davis (mrdvt92)

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

Geo::Functions
Geo::Ellipsoids
