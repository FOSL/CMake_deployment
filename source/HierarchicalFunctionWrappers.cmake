if(NOT  HIERARCHICAL_FOSL_PROJECT)
	set(HIERARCHICAL_FOSL_PROJECT TRUE)
	macro(project) # {{{
		set(ARGV_list ${ARGV})
		pre_project()
		_project(${ARGV_list})
		post_project()
	endmacro(project) # }}}
	macro(add_library) # {{{
		set(ARGV_list ${ARGV})
		pre_add_library()
		if(NOT ARGV_list STREQUAL "!")
			_add_library(${ARGV_list})
			post_add_library()
		endif()
	endmacro() # }}}
	macro(add_executable) # {{{
		set(ARGV_list ${ARGV})
		pre_add_executable()
		_add_executable(${ARGV_list})
		post_add_executable()
	endmacro() # }}}
	macro(target_sources) # {{{
		set(ARGV_list ${ARGV})
		pre_target_sources()
		_target_sources(${ARGV_list})
		post_target_sources()
	endmacro() # }}}
	macro(target_include_directories) # {{{
		set(ARGV_list ${ARGV})
		pre_target_include_directories()
		_target_include_directories(${ARGV_list})
		post_target_include_directories()
	endmacro() # }}}
	macro(target_link_libraries) # {{{
		set(ARGV_list ${ARGV})
		pre_target_link_libraries()
		_target_link_libraries(${ARGV_list})
		post_target_link_libraries()
	endmacro() # }}}
	macro(target_compile_definition) # {{{
		set(ARGV_list ${ARGV})
		pre_target_compile_definition()
		_target_compile_definition(${ARGV_list})
		post_target_compile_definition()
	endmacro() # }}}
	macro(set_target_properties) # {{{
		set(ARGV_list ${ARGV})
		pre_set_target_properties()
		_set_target_properties(${ARGV_list})
		post_set_target_properties()
	endmacro() # }}}
	macro(add_test) # {{{
		set(ARGV_list ${ARGV})
		pre_add_test()
		_add_test(${ARGV_list})
		post_add_test()
	endmacro() # }}}
endif()

include(HierarchicalDefaultFunctionWrapperCallbacks)
