THEOS_DEVICE_IP = 192.168.0.41
export ARCHS = arm64
export ADDITIONAL_OBJCFLAGS = -fobjc-arc
include theos/makefiles/common.mk
TWEAK_NAME = ccmodifier
ccmodifier_FILES = Tweak.xm
include $(THEOS_MAKE_PATH)/tweak.mk
#project_PRIVATE_FRAMEWORKS = Preferences

after-install::
	install.exec "killall -9 SpringBoard"
#SUBPROJECTS += prefs
#include $(THEOS_MAKE_PATH)/aggregate.mk
