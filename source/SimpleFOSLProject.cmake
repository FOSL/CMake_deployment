set(PROJECT_NAMESPACE FOSL)

# Add path for custom modules. {{{
set(CMAKE_MODULE_PATH
	"${CMAKE_MODULE_PATH}"
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake"
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake/module"
) # }}}
# Include overrides for standard functions
include(HierarchicalProject)
if(FOSL)
	include(InstallProject)
endif()
