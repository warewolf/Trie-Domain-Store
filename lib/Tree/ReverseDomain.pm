package Tree::ReverseDomain;
# vim: foldmethod=marker
use strict;
use warnings;

sub new {  # {{{
  my ($class) = @_;
  my $self = {};
  $self->{'root'} = { '.' => {} };
  bless $self, $class;
} # }}}

sub seek { # {{{
  my ( $self, $domain ) = @_;
  my $s = $self->{'root'};
  my @ret = map { $s = exists $$s{$_} ? $$s{$_} : undef; $s->{'.'} } reverse( split( m/\./, $domain ) );
  return wantarray ? reverse $self->{'root'}->{'.'}, @ret : $s->{'.'};
} # }}}

sub add { # {{{
  my ( $self, $domain ) = @_;
  my $s = $self->{'root'};
  my @ret = map { $$s{$_} = $$s{$_} || {}; $s = $$s{$_}; } reverse( split( m/\./, $domain ) );
  # create our end structure
  $s->{'.'} = {};
  return wantarray ? reverse $self->{'root'}->{'.'}, @ret : $s->{'.'};
} # }}}

sub root { # {{{
  my ($self) = @_;
  return $self->{'root'};
} # }}}

sub names { # {{{
  my ($self) = shift;
  my $s = $self->{'root'};
  my @ret;

  my $recurse;

  $recurse = sub { # {{{
    my ($key,$s) = @_;
    my @ret;

    my @keys = grep { $_ ne "." } keys %$s;
     
    foreach my $subkey ( grep { $_ ne "." } keys %$s ) {#{{{

      my $subref = $$s{$subkey};

      if (exists($$subref{'.'})) { 
        push @ret, { "$subkey.$key" => $subref->{'.'} };
      }

      push @ret, $recurse->("$subkey.$key",$subref);

    }#}}}

    return @ret;
  }; # }}}

  foreach my $key (grep { $_ ne "." } keys %$s) {
    push @ret,$recurse->($key,$$s{$key});
  }

  return @ret;
} # }}}

sub names_reverse { # {{{
  my ($self) = shift;
  my $s = $self->{'root'};
  my @ret;

  my $recurse;

  $recurse = sub { # {{{
    my ($key,$s) = @_;
    my @ret;

    my @keys = grep { $_ ne "." } keys %$s;
     
    foreach my $subkey ( grep { $_ ne "." } keys %$s ) {#{{{

      my $subref = $$s{$subkey};

      if (exists($$subref{'.'})) { 
        push @ret, { "$key.$subkey" => $subref->{'.'} };
      }

      push @ret, $recurse->("$key.$subkey",$subref);

    }#}}}

    return @ret;
  }; # }}}

  foreach my $key (grep { $_ ne "." } keys %$s) {
    push @ret,$recurse->($key,$$s{$key});
  }

  return @ret;
} # }}}
!!"mtfnpy!!";
