use Mojo::Base -strict;

use Test::More tests => 3;

use Mojolicious::Lite;
use Test::Mojo;

plugin 'MultiMarkdownRenderer';

get '/headers' => sub {
  my $self = shift;
  $self->render('headers', handler => 'md', format => 'html');
};


get '/list' => sub {
  my $self = shift;
  $self->render('list', handler => 'md', format => 'html');
};

my $t = Test::Mojo->new;
$t->get_ok('/headers')
  ->status_is(200)
  ->content_like(qr/h1.*Header1.*h1/is, "Page should contain H1 header")
  ->content_like(qr/h2.*Header2.*h2/is, "Page should contain H2 header")
  ->content_like(qr/h3.*Header3.*h3/is, "Page should contain H3 header");

$t->get_ok('/list')
  ->status_is(200)
  ->content_like(qr/ul.*li.*uitem1.*li.*ul/is, "Page should contain unordered list item 1")
  ->content_like(qr/ul.*li.*uitem2.*li.*ul/is, "Page should contain unordered list item 2")
  ->content_like(qr/ul.*li.*uitem3.*li.*ul/is, "Page should contain unordered list item 3")
  ->content_like(qr/ol.*li.*oitem1.*li.*ol/is, "Page should contain ordered list item 1")
  ->content_like(qr/ol.*li.*oitem2.*li.*ol/is, "Page should contain ordered list item 2")
  ->content_like(qr/ol.*li.*oitem3.*li.*ol/is, "Page should contain ordered list item 3");


__DATA__
@@ headers.html.md
# Header1
## Header2
### Header3

@@ list.html.md
* uitem1
* uitem2
* uitem3

1. oitem1
2. oitem2
3. oitem3