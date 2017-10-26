#BoardConfig.mk by IceMan

LOCAL_PATH := device/Xiaomi/ido
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/kernel
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery.fstab

# type (yes if MTK - no if other)
MEDIATEK_TYPE := no

# type (yes if LZMA - no if GZ)
LZMA_TYPE := no

# type (yes if QUALCOMM - no if other)
QUALCOMM_TYPE := yes

# type (yes if KIRIN - no if other)
KIRIN_TYPE := no

# support 64bit (yes if 64bit - no if 32bit)
BIT64_SUPPORT := yes

# Use separated dt.img (true if Existing - false if Not existing)
BOARD_KERNEL_SEPARATED_DT := false

# Sdcard external (yes if Existing - no if Not existing)
SDCARD_EXTERNAL := yes

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := msm8916
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := msm8916
TARGET_BOARD_PLATFORM_GPU := qcom-adreno405
###TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/

# Architecture
ifneq ($(BIT64_SUPPORT),yes)
# Architecture 32bit
ARCH := arm
TARGET_ARCH := arm
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_VARIANT := generic

TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI),$(TARGET_2ND_CPU_ABI),$(TARGET_2ND_CPU_ABI2)
TARGET_CPU_ABI_LIST_32_BIT := $(TARGET_2ND_CPU_ABI),$(TARGET_2ND_CPU_ABI2)
TARGET_CPU_ABI_LIST_64_BIT := $(TARGET_CPU_ABI)

else
# Architecture 64bit
ARCH := arm64
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := armeabi-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI),$(TARGET_2ND_CPU_ABI),$(TARGET_2ND_CPU_ABI2)
TARGET_CPU_ABI_LIST_32_BIT := $(TARGET_2ND_CPU_ABI),$(TARGET_2ND_CPU_ABI2)
TARGET_CPU_ABI_LIST_64_BIT := $(TARGET_CPU_ABI)
endif

# Target kernel
ifneq ($(BIT64_SUPPORT),yes)
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_HEADER_ARCH := arm
else
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
endif

# Flags
###TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
###TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

##########################################################################################################
# Partitions & Kernel CALCOLO AUTOMATICO

BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2415919104
BOARD_CACHEIMAGE_PARTITION_SIZE := 274726912
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12066978816
BOARD_KERNEL_CMDLINE := console=115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 androidboot.selinux=permissive
BOARD_KERNEL_PAGESIZE := 2048	
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_TAGS_OFFSET := 0x00000100
BOARD_KERNEL_BASE := 0x80000000
##########################################################################################################

ifneq ($(BOARD_KERNEL_SEPARATED_DT),true)
BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_TAGS_OFFSET) --base $(BOARD_KERNEL_BASE) --cmdline "$(BOARD_KERNEL_CMDLINE)"
else
BOARD_MKBOOTIMG_ARGS := --dt $(LOCAL_PATH)/dt.img --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_TAGS_OFFSET) --base $(BOARD_KERNEL_BASE) --cmdline "$(BOARD_KERNEL_CMDLINE)"
TARGET_KMODULES := true
endif

ifneq ($(LZMA_TYPE),yes)
# LZMA compression for recovery's & kernel ramdisk....
#BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/custombootimg.mk
#BOARD_CANT_BUILD_RECOVERY_FROM_BOOT_PATCH := true
else
# LZMA compression for recovery's & kernel ramdisk....
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/custombootimg.mk
BOARD_CANT_BUILD_RECOVERY_FROM_BOOT_PATCH := true
endif

# Mediatek flags
ifneq ($(MEDIATEK_TYPE),yes)
BOARD_CUSTOM_BOOTIMG := false
else
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/mkmtkbootimg.mk
BOARD_HAS_MTK_HARDWARE := true
MTK_HARDWARE := true
BOARD_USES_LEGACY_MTK_AV_BLOB := true
endif

# Qualcomm flags
ifneq ($(QUALCOMM_TYPE),yes)
#
else
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_HW_DISK_ENCRYPTION := true
endif

# TWRP
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file
#TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone1/temp
#TWHAVE_SELINUX := true
TW_NO_USB_STORAGE := false
TW_USE_TOOLBOX := false

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Others TWRP Configuration
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_SCREEN_BLANK_ON_BOOT := true

# CUSTOMIZATION by IceMan

# Sdcard External
ifneq ($(SDCARD_EXTERNAL),yes)
BOARD_HAS_NO_REAL_SDCARD := true
TW_DEFAULT_EXTERNAL_STORAGE := false
else
BOARD_HAS_NO_REAL_SDCARD := false
TW_DEFAULT_EXTERNAL_STORAGE := true
endif

# Disable Mouse Cursor
TW_INPUT_BLACKLIST := "hbtp_vm"

# Asian region languages
TW_EXTRA_LANGUAGES := true

# Exclude Supersu
TW_EXCLUDE_SUPERSU := false

# Encryption
TW_INCLUDE_CRYPTO := true

# View button bootloader
TW_NO_REBOOT_BOOTLOADER := false

# View button downloadmode - true only samsung
TW_HAS_DOWNLOAD_MODE := false

# Default Brightness (TW_DEFAULT_BRIGHTNESS=255-->100%; TW_DEFAULT_BRIGHTNESS=218-->85%)
TW_DEFAULT_BRIGHTNESS := 255
TW_MAX_BRIGHTNESS := 255

# Use ro.product.model
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true

# NTFS support
TW_INCLUDE_NTFS_3G := true

# Exfat support
TW_NO_EXFAT := false
TW_NO_EXFAT_FUSE := false

# Set language default
TW_DEFAULT_LANGUAGE := en

# For Version TWRP
TW_SPECIFIC_VERSION_STR := "3.1.1"
TW_DEVICE_VERSION := "for ido by IceMan"

# For time custom
TW_SPECIFIC_TIME_ZONE_VAR := "CET-1CEST,M3.5.0,M10.5.0"
TW_SPECIFIC_TIME_ZONE_GUISEL := "CET-1;CEST,M3.5.0,M10.5.0"

# For H24 hours
TW_SPECIFIC_MILITARY_TIME := "1"

# For Screen_timeout_secs
TW_SCREEN_TIMEOUT_SECS := "120"

#For reverse navbar (default "0")
TW_SPECIFIC_SAMSUNG_NAVBAR := "0"

ifneq ($(BIT64_SUPPORT),yes)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.zygote=zygote32
else
PRODUCT_COPY_FILES += system/core/rootdir/init.zygote64_32.rc:root/init.zygote64_32.rc
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.zygote=zygote64_32
endif