# Copyright 2021 Best Practical Solutions, LLC <sales@bestpractical.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package App::AWS::CloudWatch::Monitor::Check::MailQueue;

use strict;
use warnings;

use parent 'App::AWS::CloudWatch::Monitor::Check';

our $VERSION = '0.01';

sub check {
    my $self = shift;
    my $arg  = shift;

    my @mailq_command = (qw{ /usr/bin/mailq });
    my ( $exit, $stdout, $stderr ) = $self->run_command( \@mailq_command );

    if ($exit) {
        die "$stderr\n";
    }

    return unless $stdout;

    my $mailq_count;
    foreach my $line ( @{$stdout} ) {
        if ( $line =~ /Mail queue is empty/ ) {
            $mailq_count = 0;
            last;
        }

        if ( $line =~ /in (\d+) Request/ ) {
            $mailq_count = $1;
            last;
        }
    }

    return [
        {   MetricName => 'mail-Queue',
            Unit       => 'Count',
            RawValue   => $mailq_count,
        },
    ];
}

1;

__END__

=pod

=head1 NAME

App::AWS::CloudWatch::Monitor::Check::MailQueue - gather mail queue count

=head1 SYNOPSIS

 my $plugin  = App::AWS::CloudWatch::Monitor::Check::MailQueue->new();
 my $metrics = $plugin->check();

 aws-cloudwatch-monitor --check MailQueue

=head1 DESCRIPTION

C<App::AWS::CloudWatch::Monitor::Check::MailQueue> is a L<App::AWS::CloudWatch::Monitor::Check> module which gathers current mail queue count.

=head1 METRICS

Data for this check is read from L<mailq(1)>.  The following metrics are returned.

=over

=item mail-Queue

=back

=head1 METHODS

=over

=item check

Gathers the metric data and returns an arrayref of hashrefs with keys C<MetricName>, C<Unit>, C<RawValue>.

=back

=head1 DEPENDENCIES

C<App::AWS::CloudWatch::Monitor::Check::MailQueue> depends on the external program, L<mailq(1)>.

=cut
