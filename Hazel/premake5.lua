workspace "Hazel"
    architecture "x64"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }
    startproject "SandBox"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Hazel/vendor/GLFW/include"
IncludeDir["Glad"] = "Hazel/vendor/Glad/include"
IncludeDir["ImGui"] = "Hazel/vendor/imgui"
IncludeDir["glm"] = "Hazel/vendor/glm"

group "Dependencies"
	include "Hazel/vendor/GLFW"
	include "Hazel/vendor/Glad"
	include "Hazel/vendor/imgui"

group ""


project "Hazel"
    location "Hazel"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
	staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "hzpch.h"
    pchsource "Hazel/src/hzpch.cpp"

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl",
    }

    defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

    includedirs
    {
        "%{wks.location}/Hazel/src",
		"%{wks.location}/Hazel/vendor/spdlog/include",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}"
    }

    links 
	{ 
		"GLFW",
        "Glad",
        "ImGui",
        "opengl32.lib"
	}

    filter "system:windows"
        systemversion "latest"

        defines
        {
            "HZ_BUILD_DLL",
            "HZ_PLATFORM_WINDOWS",
            "GLFW_INCLUDE_NONE"
        }
    
    filter "configurations:Debug"
        defines "HZ_DEBUG"
		runtime "Debug"
        symbols "on"
    
    filter "configurations:Release"
        defines "HZ_RELEASE"
		runtime "Release"
        optimize "on"
    
    filter "configurations:Dist"
        defines "HZ_DIST"
		runtime "Release"
        symbols "on"

project "SandBox"
    location "SandBox"
    kind "ConsoleApp"
    language "C++"
	cppdialect "C++17"
	staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "%{wks.location}/Hazel/vendor/spdlog/include",
		"%{wks.location}/Hazel/src",
		"%{wks.location}/Hazel/vendor",
		"%{IncludeDir.glm}"
    }

    links
    {
        "Hazel"
    }

    filter "system:windows"
        systemversion "latest"

        defines
        {
            "HZ_PLATFORM_WINDOWS"
        }
    
    filter "configurations:Debug"
        defines "HZ_DEBUG"
		runtime "Debug"
        symbols "on"
    
    filter "configurations:Release"
        defines "HZ_RELEASE"
		runtime "Release"
        optimize "on"
    
    filter "configurations:Dist"
        defines "HZ_DIST"
		runtime "Release"
        symbols "on"
    
