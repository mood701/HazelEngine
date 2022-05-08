#pragma once
#include "stdio.h"
#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreateApplication();

int main(int argc, char** argv){
	Hazel::Log::Init();
	HZ_CORE_WARN("Warn");
	HZ_CORE_INFO("hello{0}", 5);
	auto app = Hazel::CreateApplication();
	app->Run();
	delete app;
	return 0;
}

#endif