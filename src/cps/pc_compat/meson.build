_flex_version = '>= 2.6'
_bison_version = '>= 2.6'
if meson.version().version_compare('>= 1.10.0')
  codegen = import('unstable-codegen')
  lex = codegen.lex(
    implementations : ['win_flex', 'flex'],
    flex_version : _flex_version,
    win_flex_version : _flex_version,
  )
  yacc = codegen.yacc(
    implementations : ['win_bison', 'bison'],
    bison_version : _bison_version,
    win_bison_version : _bison_version,
  )

  pc_scanner = lex.generate(
    'pc.l', source : '@BASENAME@.scanner.cpp', header : '@BASENAME@.scanner.hpp')

  pc_parser = yacc.generate(
    'pc.y', source : '@BASENAME@.parser.cpp', header : '@BASENAME@.parser.hpp')
else
  prog_flex = find_program('', required : false)
  flex_args = []
  prog_bison = find_program('', required : false)
  if host_machine.system() == 'windows'
    prog_flex = find_program('win_flex', required : false, version : _flex_version)
    if prog_flex.found()
      # This uses <io.h> instead of <unistd.h>
      flex_args = ['--wincompat']
    endif

    prog_bison = find_program('win_bison', required : false, version : _bison_version)
  endif
  if not prog_flex.found()
    prog_flex = find_program('flex', version : _flex_version)
  endif
  if not prog_bison.found()
    prog_bison = find_program('bison', version : _bison_version)
  endif

  pc_scanner = custom_target(
    'pc_scanner',
    command : [prog_flex, flex_args, '--outfile=@OUTPUT0@', '--header-file=@OUTPUT1@', '@INPUT@'],
    input : 'pc.l',
    output : ['@BASENAME@.scanner.cpp', '@BASENAME@.scanner.hpp'],
  )

  pc_parser = custom_target(
    'pc_parser',
    command : [prog_bison, '-d', '@INPUT@', '-v', '--output=@OUTPUT0@', '--defines=@OUTPUT1@'],
    input : 'pc.y',
    output : ['@BASENAME@.parser.cpp', '@BASENAME@.parser.hpp', 'locations.hpp']
  )
endif
