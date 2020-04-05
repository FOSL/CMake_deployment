if(NOT HIERARCHICAL_FOSL_PROJECT)
	set(HIERARCHICAL_FOSL_PROJECT TRUE)
	include(HierarchicalFunctionWrappers)
endif()
include(HierarchicalDefaultFunctionWrapperCallbacks)

macro(pre_project) # {{{
	if(NOT FOSL)
		list(POP_FRONT ARGV_list                         PROJECT_COMPONENT  )
		list(PREPEND   ARGV_list "${PROJECT_NAMESPACE}-${PROJECT_COMPONENT}")
	else()
		list(GET ARGV_list 0 PROJECT_COMPONENT)
	endif()

	string(TOUPPER "${PROJECT_NAMESPACE}" UPPERCASE_PROJECT_NAMESPACE)
	string(TOUPPER "${PROJECT_COMPONENT}" UPPERCASE_PROJECT_COMPONENT)

	if(FOSL)
		option(${UPPERCASE_PROJECT_NAMESPACE}_${UPPERCASE_PROJECT_COMPONENT}_INSTALL
			"Install ${PROJECT_NAMESPACE}::${PROJECT_COMPONENT}" ${UPPERCASE_PROJECT_NAMESPACE}_INSTALL)
	endif()
	option(${UPPERCASE_PROJECT_NAMESPACE}_${UPPERCASE_PROJECT_COMPONENT}_BUILD_TESTS
		"Build ${PROJECT_NAMESPACE}::${PROJECT_COMPONENT} tests" ${PROJECT_NAMESPACE}_BUILD_TESTS)
endmacro() # }}}
macro(post_project) # {{{
	set(PROJECT_SOURCE_DIR "${PROJECT_SOURCE_DIR}/source")
endmacro() # }}}

macro(pre_add_library) # {{{
	if(NOT ${UPPERCASE_PROJECT_NAMESPACE}_${UPPERCASE_PROJECT_COMPONENT}_ADDED)
		if(NOT FOSL)
			list(POP_FRONT ARGV_list                        LIBRARY_NAME )
			list(PREPEND   ARGV_list ${PROJECT_NAMESPACE}-${LIBRARY_NAME})
		endif()
	endif()
endmacro() # }}}
macro(post_add_library) # {{{
	if(NOT ${UPPERCASE_PROJECT_NAMESPACE}_${UPPERCASE_PROJECT_COMPONENT}_ADDED)
		set(${UPPERCASE_PROJECT_NAMESPACE}_${UPPERCASE_PROJECT_COMPONENT}_ADDED TRUE)
		if(NOT FOSL)
			add_library(${PROJECT_NAMESPACE}::${PROJECT_COMPONENT} ALIAS ${PROJECT_NAMESPACE}-${PROJECT_COMPONENT})
		else()
			add_library(${PROJECT_NAMESPACE}::${PROJECT_COMPONENT} ALIAS                      ${PROJECT_COMPONENT})
		endif()
	endif()
endmacro() # }}}

macro(pre_target_sources) # {{{
	if(NOT FOSL)
		list(POP_FRONT ARGV_list                        LIBRARY_NAME )
		list(PREPEND   ARGV_list ${PROJECT_NAMESPACE}-${LIBRARY_NAME})
	endif()
	list(POP_FRONT ARGV_list LIBRARY_NAME)
	set(filename_list ${ARGV_list})
	unset(ARGV_list)
	list(APPEND ARGV_list ${LIBRARY_NAME})
	foreach(FILENAME IN LISTS filename_list)
		if(NOT (FILENAME STREQUAL "PRIVATE"
		     OR FILENAME STREQUAL "PUBLIC"
		     OR FILENAME STREQUAL "INTERFACE"))
			list(APPEND ARGV_list "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/FOSL/${FILENAME}>")
			list(APPEND ARGV_list "$<INSTALL_INTERFACE:/include/FOSL/${FILENAME}>")
		else()
			list(APPEND ARGV_list ${FILENAME})
		endif()
	endforeach()
endmacro() # }}}
macro(pre_target_link_libraries) # {{{
	if(NOT FOSL)
		list(POP_FRONT ARGV_list                        LIBRARY_NAME )
		list(PREPEND   ARGV_list ${PROJECT_NAMESPACE}-${LIBRARY_NAME})
	endif()
endmacro() # }}}
macro(pre_target_include_directories) # {{{
	if(NOT FOSL)
		list(APPEND ARGV_list
			PUBLIC ${PROJECT_SOURCE_DIR}
			PUBLIC ${PROJECT_BINARY_DIR}
		)
	else()
		list(APPEND ARGV_list
			PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
			PUBLIC $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
			PUBLIC $<INSTALL_INTERFACE:include>
		)
	endif()
endmacro() # }}}

macro(pre_add_test) # {{{
	list(GET ARGV_list 1 TEST_NAME)
	list(REMOVE_AT ARGV_list 1)
	if(NOT FOSL)
		list(INSERT ARGV_list 1 "${PROJECT_NAMESPACE}::${PROJECT_COMPONENT}->${TEST_NAME}")
	else()
		list(INSERT ARGV_list 1                       "${PROJECT_COMPONENT}->${TEST_NAME}")
	endif()

	list(GET ARGV_list 3 TEST_COMMAND)
	list(REMOVE_AT ARGV_list 3)
	if(NOT FOSL)
		list(INSERT ARGV_list 3 "${PROJECT_BINARY_DIR}/test/${TEST_COMMAND}")
	else()
		list(INSERT ARGV_list 3 "${PROJECT_BINARY_DIR}/test/${TEST_COMMAND}")
	endif()
endmacro() # }}}
