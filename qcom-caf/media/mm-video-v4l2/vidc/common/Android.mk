ROOT_DIR := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_PATH:= $(ROOT_DIR)

# ---------------------------------------------------------------------------------
# 				Common definitons
# ---------------------------------------------------------------------------------

libmm-vidc-def := -g -O3 -Dlrintf=_ffix_r
libmm-vidc-def := -std=c++11
libmm-vidc-def += -D__align=__alignx
libmm-vidc-def += -D__alignx\(x\)=__attribute__\(\(__aligned__\(x\)\)\)
libmm-vidc-def += -DT_ARM
libmm-vidc-def += -Dinline=__inline
libmm-vidc-def += -D_ANDROID_
libmm-vidc-def += -Werror
libmm-vidc-def += -D_ANDROID_ICS_
ifeq ($(TARGET_KERNEL_VERSION), 4.9)
libmm-vidc-def += -D_TARGET_KERNEL_VERSION_49_
endif

# ---------------------------------------------------------------------------------
# 			Make the Shared library (libOmxVidcCommon)
# ---------------------------------------------------------------------------------

libmm-vidc-inc      := $(LOCAL_PATH)/inc
libmm-vidc-inc      += $(TOP)/system/core/libion/include
libmm-vidc-inc      += $(TOP)/system/core/libion/kernel-headers
libmm-vidc-inc      += $(QCOM_MEDIA_ROOT)/mm-core/inc
libmm-vidc-inc      += $(QCOM_MEDIA_ROOT)/mm-video-v4l2/vidc/vdec/inc
libmm-vidc-inc      += $(QCOM_MEDIA_ROOT)/mm-video-v4l2/vidc/venc/inc
libmm-vidc-inc      += $(QCOM_MEDIA_ROOT)/libc2dcolorconvert
ifeq ($(TARGET_COMPILE_WITH_MSM_KERNEL),true)
libmm-vidc-inc      += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
endif

LOCAL_MODULE                    := libOmxVidcCommon
LOCAL_MODULE_TAGS               := optional
LOCAL_VENDOR_MODULE             := true
LOCAL_CFLAGS                    := $(libmm-vidc-def)
LOCAL_C_INCLUDES                := $(libmm-vidc-inc)

LOCAL_PRELINK_MODULE      := false
LOCAL_SHARED_LIBRARIES    := liblog libcutils libdl

LOCAL_SRC_FILES   := src/extra_data_handler.cpp
LOCAL_SRC_FILES   += src/vidc_color_converter.cpp
LOCAL_HEADER_LIBRARIES := libhardware_headers \
                          libutils_headers \
                          libnativebase_headers \
                          media_plugin_headers \
                          display_headers

LOCAL_SRC_FILES   += src/vidc_vendor_extensions.cpp

include $(BUILD_STATIC_LIBRARY)

# ---------------------------------------------------------------------------------
# 					END
# ---------------------------------------------------------------------------------