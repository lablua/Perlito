# Do not edit this file - Generated by MiniPerl6 4.1
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
our $MATCH = MiniPerl6::Match->new();
{
package Python;
sub new { shift; bless { @_ }, "Python" }
sub tab { my $level = $_[0]; ('    ' x $level) }
}

{
package MiniPerl6::Python::LexicalBlock;
sub new { shift; bless { @_ }, "MiniPerl6::Python::LexicalBlock" }
sub block { $_[0]->{block} };
sub needs_return { $_[0]->{needs_return} };
sub top_level { $_[0]->{top_level} };
my  $ident;
my  $List_anon_block;
sub push_stmt { my $block = $_[0]; push( @{$List_anon_block}, $block ) };
sub get_ident { ($ident = ($ident + 1)); return($ident) };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; my  $List_s; my  $List_tmp; for my $stmt ( @{$List_anon_block} ) { push( @{$List_tmp}, $stmt ) }; for my $decl ( @{$self->{block}} ) { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my'))) { push( @{$List_s}, $decl->emit_python_init($level) ) } else {  };if ((Main::isa($decl, 'Bind') && (Main::isa($decl->parameters(), 'Decl') && ($decl->parameters()->decl() eq 'my')))) { push( @{$List_s}, $decl->parameters()->emit_python_init($level) ) } else {  } }; my  $last_statement; if ($self->{needs_return}) { ($last_statement = pop( @{$self->{block}} )) } else {  }; for my $stmt ( @{$self->{block}} ) { ($List_anon_block = []);(my  $s2 = $stmt->emit_python_indented($level));for my $stmt ( @{$List_anon_block} ) { push( @{$List_s}, $stmt->emit_python_indented($level) ) };push( @{$List_s}, $s2 ) }; if (($self->{needs_return} && $last_statement)) { ($List_anon_block = []);my  $s2;if (Main::isa($last_statement, 'If')) { (my  $cond = $last_statement->cond());(my  $body = $last_statement->body());(my  $otherwise = $last_statement->otherwise());(my  $has_otherwise = ($otherwise ? 1 : 0));($body = MiniPerl6::Python::LexicalBlock->new( 'block' => $body,'needs_return' => 1, ));($otherwise = MiniPerl6::Python::LexicalBlock->new( 'block' => $otherwise,'needs_return' => 1, ));($s2 = Python::tab($level) . 'if ' . $cond->emit_python() . ':
' . $body->emit_python_indented(($level + 1)));if ($has_otherwise) { ($s2 = $s2 . '
' . Python::tab($level) . 'else:
' . $otherwise->emit_python_indented(($level + 1))) } else {  } } else { if ((Main::isa($last_statement, 'Return') || Main::isa($last_statement, 'For'))) { ($s2 = $last_statement->emit_python_indented($level)) } else { ($s2 = Python::tab($level) . 'return ' . $last_statement->emit_python()) } };for my $stmt ( @{$List_anon_block} ) { push( @{$List_s}, $stmt->emit_python_indented($level) ) };push( @{$List_s}, $s2 ) } else {  }; ($List_anon_block = $List_tmp); return(Main::join($List_s, '
')) }
}

{
package CompUnit;
sub new { shift; bless { @_ }, "CompUnit" }
sub name { $_[0]->{name} };
sub attributes { $_[0]->{attributes} };
sub methods { $_[0]->{methods} };
sub body { $_[0]->{body} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; (my  $block = MiniPerl6::Python::LexicalBlock->new( 'block' => $self->{body}, )); Python::tab($level) . 'class ' . $self->{name} . ':
' . $block->emit_python_indented(($level + 1)) . '
' }
}

{
package Val::Int;
sub new { shift; bless { @_ }, "Val::Int" }
sub int { $_[0]->{int} };
sub emit_python { my $self = $_[0]; $self->{int} };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . $self->{int} }
}

{
package Val::Bit;
sub new { shift; bless { @_ }, "Val::Bit" }
sub bit { $_[0]->{bit} };
sub emit_python { my $self = $_[0]; $self->{bit} };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . $self->{bit} }
}

{
package Val::Num;
sub new { shift; bless { @_ }, "Val::Num" }
sub num { $_[0]->{num} };
sub emit_python { my $self = $_[0]; $self->{num} };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . $self->{num} }
}

{
package Val::Buf;
sub new { shift; bless { @_ }, "Val::Buf" }
sub buf { $_[0]->{buf} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . '"""' . $self->{buf} . '"""' }
}

{
package Val::Undef;
sub new { shift; bless { @_ }, "Val::Undef" }
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . 'mp6_Undef()' }
}

{
package Val::Object;
sub new { shift; bless { @_ }, "Val::Object" }
sub class { $_[0]->{class} };
sub fields { $_[0]->{fields} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . Main::perl($self->{class}, ) . '(' . Main::perl($self->{fields}, ) . ')' }
}

{
package Lit::Array;
sub new { shift; bless { @_ }, "Lit::Array" }
sub array1 { $_[0]->{array1} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . '[' . Main::join([ map { $_->emit_python() } @{ $self->{array1} } ], ', ') . ']' }
}

{
package Lit::Hash;
sub new { shift; bless { @_ }, "Lit::Hash" }
sub hash1 { $_[0]->{hash1} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; (my  $fields = $self->{hash1}); my  $List_dict; for my $field ( @{$fields} ) { push( @{$List_dict}, $field->[0]->emit_python() . ':' . $field->[1]->emit_python() ) }; Python::tab($level) . '{' . Main::join($List_dict, ', ') . '}' }
}

{
package Lit::Code;
sub new { shift; bless { @_ }, "Lit::Code" }
1
}

{
package Lit::Object;
sub new { shift; bless { @_ }, "Lit::Object" }
sub class { $_[0]->{class} };
sub fields { $_[0]->{fields} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; (my  $fields = $self->{fields}); (my  $str = ''); for my $field ( @{$fields} ) { ($str = $str . $field->[0]->emit_python() . ' = ' . $field->[1]->emit_python() . ',') }; Python::tab($level) . $self->{class} . '( ' . $str . ' )' }
}

{
package Index;
sub new { shift; bless { @_ }, "Index" }
sub obj { $_[0]->{obj} };
sub index_exp { $_[0]->{index_exp} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . $self->{obj}->emit_python() . '[' . $self->{index_exp}->emit_python() . ']' }
}

{
package Lookup;
sub new { shift; bless { @_ }, "Lookup" }
sub obj { $_[0]->{obj} };
sub index_exp { $_[0]->{index_exp} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . $self->{obj}->emit_python() . '[' . $self->{index_exp}->emit_python() . ']' }
}

{
package Var;
sub new { shift; bless { @_ }, "Var" }
sub sigil { $_[0]->{sigil} };
sub twigil { $_[0]->{twigil} };
sub name { $_[0]->{name} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; (my  $table = { '$' => '','@' => 'List_','%' => 'Hash_','&' => 'Code_', }); return(Python::tab($level) . (($self->{twigil} eq '.') ? 'self.' . $self->{name} : (($self->{name} eq '/') ? $table->{$self->{sigil}} . 'MATCH' : $table->{$self->{sigil}} . $self->{name}))) };
sub name { my $self = $_[0]; $self->{name} }
}

{
package Bind;
sub new { shift; bless { @_ }, "Bind" }
sub parameters { $_[0]->{parameters} };
sub arguments { $_[0]->{arguments} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . $self->{parameters}->emit_python() . ' = ' . $self->{arguments}->emit_python() }
}

{
package Proto;
sub new { shift; bless { @_ }, "Proto" }
sub name { $_[0]->{name} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . $self->{name} }
}

{
package Call;
sub new { shift; bless { @_ }, "Call" }
sub invocant { $_[0]->{invocant} };
sub hyper { $_[0]->{hyper} };
sub method { $_[0]->{method} };
sub arguments { $_[0]->{arguments} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; (my  $invocant = $self->{invocant}->emit_python()); if ((($self->{method} eq 'perl') || (($self->{method} eq 'yaml') || (($self->{method} eq 'say') || (($self->{method} eq 'join') || (($self->{method} eq 'chars') || ($self->{method} eq 'isa'))))))) { if ($self->{hyper}) { return('map(lambda: Main.' . $self->{method} . '( self, ' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ', ') . ') , ' . $invocant . ')
') } else { return('Main.' . $self->{method} . '(' . $invocant . ', ' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ', ') . ')') } } else {  }; (my  $meth = $self->{method}); if (($meth eq 'postcircumfix:<( )>')) { ($meth = '') } else {  }; (my  $call = '.' . $meth . '(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ', ') . ')'); if ($self->{hyper}) { Python::tab($level) . '[ map { $_' . $call . ' } @{ ' . $invocant . ' } ]' } else { Python::tab($level) . $invocant . $call } }
}

{
package Apply;
sub new { shift; bless { @_ }, "Apply" }
sub code { $_[0]->{code} };
sub arguments { $_[0]->{arguments} };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . $self->emit_python() };
sub emit_python { my $self = $_[0]; (my  $code = $self->{code}); if (Main::isa($code, 'Str')) {  } else { return('(' . $self->{code}->emit_python() . ').(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ', ') . ')') }; if (($code eq 'self')) { return('self') } else {  }; if (($code eq 'say')) { return('mp6_say(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (($code eq 'print')) { return('mp6_print(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (($code eq 'warn')) { return('mp6_warn(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (($code eq 'array')) { return('[' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' ') . ']') } else {  }; if (($code eq 'prefix:<~>')) { return('("" . ' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' ') . ')') } else {  }; if (($code eq 'prefix:<!>')) { return('not (' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' ') . ')') } else {  }; if (($code eq 'prefix:<?>')) { return('not (not (' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' ') . '))') } else {  }; if (($code eq 'prefix:<$>')) { return('${' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' ') . '}') } else {  }; if (($code eq 'prefix:<@>')) { return('@{' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' ') . '}') } else {  }; if (($code eq 'prefix:<%>')) { return('%{' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' ') . '}') } else {  }; if (($code eq 'infix:<~>')) { return('(str(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ') + str(') . '))') } else {  }; if (($code eq 'infix:<+>')) { return('(float(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ') + float(') . '))') } else {  }; if (($code eq 'infix:<->')) { return('(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' - ') . ')') } else {  }; if (($code eq 'infix:<*>')) { return('(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' * ') . ')') } else {  }; if (($code eq 'infix:</>')) { return('(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' / ') . ')') } else {  }; if (($code eq 'infix:<&&>')) { return('(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' and ') . ')') } else {  }; if (($code eq 'infix:<||>')) { return('(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ' or ') . ')') } else {  }; if (($code eq 'infix:<eq>')) { return('(str(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ') == str(') . '))') } else {  }; if (($code eq 'infix:<ne>')) { return('(str(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ') != str(') . '))') } else {  }; if (($code eq 'infix:<==>')) { return('(float(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ') == float(') . '))') } else {  }; if (($code eq 'infix:<!=>')) { return('(float(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ') != float(') . '))') } else {  }; if (($code eq 'infix:<<>')) { return('(float(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ') < float(') . '))') } else {  }; if (($code eq 'infix:<>>')) { return('(float(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ') > float(') . '))') } else {  }; if (($code eq 'ternary:<?? !!>')) { (my  $ast = Do->new( 'block' => [If->new( 'cond' => $self->{arguments}->[0],'body' => [$self->{arguments}->[1]],'otherwise' => [$self->{arguments}->[2]], )], ));return($ast->emit_python()) } else {  }; $self->{code} . '(' . Main::join([ map { $_->emit_python() } @{ $self->{arguments} } ], ', ') . ')' };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . $self->emit_python() }
}

{
package Return;
sub new { shift; bless { @_ }, "Return" }
sub result { $_[0]->{result} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . 'return ' . $self->{result}->emit_python() }
}

{
package If;
sub new { shift; bless { @_ }, "If" }
sub cond { $_[0]->{cond} };
sub body { $_[0]->{body} };
sub otherwise { $_[0]->{otherwise} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; (my  $has_body = (@{$self->{body}} ? 1 : 0)); (my  $has_otherwise = (@{$self->{otherwise}} ? 1 : 0)); (my  $body_block = MiniPerl6::Python::LexicalBlock->new( 'block' => $self->{body}, )); (my  $otherwise_block = MiniPerl6::Python::LexicalBlock->new( 'block' => $self->{otherwise}, )); (my  $s = Python::tab($level) . 'if ' . $self->{cond}->emit_python() . ':
' . $body_block->emit_python_indented(($level + 1))); if ($has_otherwise) { ($s = $s . '
' . Python::tab($level) . 'else:
' . $otherwise_block->emit_python_indented(($level + 1))) } else {  }; return($s) }
}

{
package For;
sub new { shift; bless { @_ }, "For" }
sub cond { $_[0]->{cond} };
sub body { $_[0]->{body} };
sub topic { $_[0]->{topic} };
sub emit_python { my $self = $_[0]; (my  $cond = $self->{cond}); if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) { ($cond = Apply->new( 'code' => 'prefix:<@>','arguments' => [$cond], )) } else {  }; 'do { for my ' . $self->{topic}->emit_python() . ' ( ' . $cond->emit_python() . ' ) { ' . Main::join([ map { $_->emit_python() } @{ $self->{body} } ], ';') . ' } }' }
}

{
package Decl;
sub new { shift; bless { @_ }, "Decl" }
sub decl { $_[0]->{decl} };
sub type { $_[0]->{type} };
sub var { $_[0]->{var} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; (my  $decl = $self->{decl}); (my  $name = $self->{var}->name()); Python::tab($level) . (($decl eq 'has') ? 'sub ' . $name . ' { ' . '@_ == 1 ' . '? ( $_[0]->{' . $name . '} ) ' . ': ( $_[0]->{' . $name . '} = $_[1] ) ' . '}' : ($self->{type} ? $self->{type} . ' ' . $self->{var}->emit_python() : $self->{var}->emit_python())) };
sub emit_python_init { my $self = $_[0]; my $level = $_[1]; if (($self->{decl} eq 'my')) { (my  $str = Python::tab($level) . $self->{var}->emit_python() . ' = ');if (($self->{var}->sigil() eq '%')) { ($str = $str . '{}') } else { if (($self->{var}->sigil() eq '@')) { ($str = $str . '[]') } else { ($str = $str . 'mp6_Undef()') } };return($str) } else { die('not implemented: Decl \'' . $self->{decl} . '\'') } }
}

{
package Sig;
sub new { shift; bless { @_ }, "Sig" }
sub invocant { $_[0]->{invocant} };
sub positional { $_[0]->{positional} };
sub named { $_[0]->{named} };
sub emit_python { my $self = $_[0]; ' print \'Signature - TODO\'; die \'Signature - TODO\'; ' };
sub invocant { my $self = $_[0]; $self->{invocant} };
sub positional { my $self = $_[0]; $self->{positional} }
}

{
package Method;
sub new { shift; bless { @_ }, "Method" }
sub name { $_[0]->{name} };
sub sig { $_[0]->{sig} };
sub block { $_[0]->{block} };
sub emit_python { my $self = $_[0]; (my  $sig = $self->{sig}); (my  $invocant = $sig->invocant()); (my  $pos = $sig->positional()); (my  $str = 'my $List__ = \\@_; '); (my  $pos = $sig->positional()); for my $field ( @{$pos} ) { ($str = $str . 'my ' . $field->emit_python() . '; ') }; (my  $bind = Bind->new( 'parameters' => Lit::Array->new( 'array' => $sig->positional(), ),'arguments' => Var->new( 'sigil' => '@','twigil' => '','name' => '_', ), )); ($str = $str . $bind->emit_python() . '; '); 'sub ' . $self->{name} . ' { ' . 'my ' . $invocant->emit_python() . ' = shift; ' . $str . Main::join([ map { $_->emit_python() } @{ $self->{block} } ], '; ') . ' }' }
}

{
package Sub;
sub new { shift; bless { @_ }, "Sub" }
sub name { $_[0]->{name} };
sub sig { $_[0]->{sig} };
sub block { $_[0]->{block} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; (my  $sig = $self->{sig}); (my  $pos = $sig->positional()); my  $List_args; for my $field ( @{$pos} ) { push( @{$List_args}, $field->emit_python() ) }; (my  $block = MiniPerl6::Python::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1, )); Python::tab($level) . 'def ' . $self->{name} . '(' . Main::join($List_args, ', ') . '):
' . $block->emit_python_indented(($level + 1)) }
}

{
package Do;
sub new { shift; bless { @_ }, "Do" }
sub block { $_[0]->{block} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; (my  $label = '_anon_' . MiniPerl6::Python::LexicalBlock::get_ident()); MiniPerl6::Python::LexicalBlock::push_stmt(Sub->new( 'name' => $label,'block' => $self->{block},'sig' => Sig->new( 'invocant' => (undef),'positional' => [],'named' => {  }, ), )); return(Python::tab($level) . $label . '()') }
}

{
package Use;
sub new { shift; bless { @_ }, "Use" }
sub mod { $_[0]->{mod} };
sub emit_python { my $self = $_[0]; $self->emit_python_indented(0) };
sub emit_python_indented { my $self = $_[0]; my $level = $_[1]; Python::tab($level) . 'from ' . $self->{mod} . 'import *' }
}

1;
