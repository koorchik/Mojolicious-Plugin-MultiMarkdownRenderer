use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Mojolicious::MultiMarkdownRenderer',
    VERSION_FROM => 'lib/Mojolicious/Plugin/MultiMarkdownRenderer.pm',
    AUTHOR       => 'Viktor Turskyi <koorchik@cpan.org>',
    PREREQ_PM    => {
        'Mojolicious'         => '3.43',
        'Text::MultiMarkdown' => '0',
    },
    test         => {TESTS => 't/*.t'}
);
