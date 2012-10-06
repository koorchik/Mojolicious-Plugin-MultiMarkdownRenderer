package Mojolicious::Plugin::MultiMarkdownRenderer;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';
 
use warnings;
use strict;
use v5.10;

use Text::MultiMarkdown;
 
 
sub register {
    my ($self, $app, $options) = @_;
 
    $options ||= {};

    my $markdown = Text::MultiMarkdown->new(%$options);
 
    # Add "md" handler
    $app->renderer->add_handler(md => sub {
        my ($r, $c, $output, $options) = @_;
        $$output = '';

        my $md_source = '';
        GET_CONTENT: {
            # Check for appropriate template in DATA section
            $md_source = $r->get_data_template($options);
            last GET_CONTENT if $md_source;

            # Check for absolute template path
            my $fname = $r->template_path($options);
            if (-f $fname) {
                open(my $fh, '<', $fname);
                $md_source = do { local $/; <$fh> };
                close $fh;
                last GET_CONTENT;
            }
        }

        utf8::decode($md_source);
        $$output = $markdown->markdown($md_source)
    });
}
 

1;
__END__

=head1 NAME

Mojolicious::MultiMarkdownRenderer - Markdown and MultiMarkdown templates for Mojolicious

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('MarkdownRenderer', \%options);

  # Mojolicious::Lite
  plugin 'MarkdownRenderer';

  # in Controller to render /templates/my_template.html.md
  $self->render('my_template', handler => 'md', format => 'html');

=head1 DESCRIPTION

L<Mojolicious::MultiMarkdownRenderer> adds support of markdown file to your templates.

=head1 METHODS

L<Mojolicious::MultiMarkdownRenderer> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 C<register>

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
