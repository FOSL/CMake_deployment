if(NOT HIERARCHICAL_FOSL_PROJECT)
	set(HIERARCHICAL_FOSL_PROJECT TRUE)
	include(HierarchicalFunctionWrappers)
endif()
include(HierarchicalDefaultFunctionWrapperCallbacks)

macro(pre_project) # {{{
	list(POP_FRONT ARGV_list TEST_NAME)
	if(NOT FOSL)
		list(PREPEND ARGV_list "${PROJECT_NAMESPACE}-${PROJECT_COMPONENT}-test_${TEST_NAME}")
	else()
		list(PREPEND ARGV_list                      "${PROJECT_COMPONENT}-test_${TEST_NAME}")
	endif()
endmacro() # }}}
macro(post_project) # {{{
	set(PROJECT_SOURCE_DIR "${PROJECT_SOURCE_DIR}/source")
endmacro() # }}}

macro(pre_add_executable) # {{{
	list(POP_FRONT ARGV_list TEST_NAME)
	if(NOT FOSL)
		list(PREPEND ARGV_list "${PROJECT_NAMESPACE}-${PROJECT_COMPONENT}-test_${TEST_NAME}")
	else()
		list(PREPEND ARGV_list                      "${PROJECT_COMPONENT}-test_${TEST_NAME}")
	endif()
endmacro() # }}}
macro(post_add_executable) # {{{
	set_target_properties(${PROJECT_NAME} PROPERTIES
		RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}"
		OUTPUT_NAME main.elf
	)
endmacro() # }}}

macro(pre_target_sources) # {{{
	list(POP_FRONT ARGV_list TEST_NAME)
	if(NOT FOSL)
		list(PREPEND ARGV_list "${PROJECT_NAMESPACE}-${PROJECT_COMPONENT}-test_${TEST_NAME}")
	else()
		list(PREPEND ARGV_list                      "${PROJECT_COMPONENT}-test_${TEST_NAME}")
	endif()
endmacro() # }}}
macro(pre_target_include_directories) # {{{
	list(POP_FRONT ARGV_list TEST_NAME)
	if(NOT FOSL)
		list(PREPEND ARGV_list "${PROJECT_NAMESPACE}-${PROJECT_COMPONENT}-test_${TEST_NAME}")
	else()
		list(PREPEND ARGV_list                      "${PROJECT_COMPONENT}-test_${TEST_NAME}")
	endif()
endmacro() # }}}
macro(pre_target_link_libraries) # {{{
	list(POP_FRONT ARGV_list TEST_NAME)
	if(NOT FOSL)
		list(PREPEND ARGV_list "${PROJECT_NAMESPACE}-${PROJECT_COMPONENT}-test_${TEST_NAME}")
	else()
		list(PREPEND ARGV_list                      "${PROJECT_COMPONENT}-test_${TEST_NAME}")
	endif()
endmacro() # }}}
