Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8DC37F2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhEMGP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:15:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40370 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhEMGPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620886456; x=1652422456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sTz+TcVaBK2RWdCNW1dipKXarOjZN/MtDz2wPayOlIM=;
  b=tg0fizSQlxFlLntYqSH1ZGXu9Y4EQBrnqmHkCTEsZbmMljxYFfSxH3+T
   C0Ag1gGPxVzMwo+Q7sgHf1yiAiOyxjAL7oRjjglkIXkD/FuWTxApxtCTl
   hTBJr8IadoCgM6WwMcuvC74BsSIJedX/urLFVmjP0oiX3clsp17lTdQfi
   0S7KCSUeM3CpGWYm3+YI+RUWNwveLe/JoptQLxa6/cpXYOBXehGSCnPmm
   vzeLlvF027hyamXVJVkUwvIz8uvjRZEp01VzuKCzZVfnIZvp+PaRt3Xn4
   Ty6m/ob1q7hovmzC/vIDMjiWSJPY9y+2+A4yXN0UU69J21E3Uz/0QyQ8p
   g==;
IronPort-SDR: QnxxiPGG6x8n+TS/sEJErS/a3+codokNcn11nKlK2ajYV5/blvOcEsf4rjHOEGmupOvR2tCpMD
 QOB4WJZiDIyRk2kO/20HacDXc7AzxpMWn+R5ZRsIMebbbB9rxH9jVPsqQFA1abTKy7roaUkB4U
 GZNKfCpiJpi7IAytn3WYNH06BZWSSNXV2OdqwdimttldOFTMX+nuVdLxFyDdfZQ8O+pYiXEFxE
 tyWP6u5pQVcm+6pLrOmaWV6jkPJ4SU/oOLuB+qrrVlC+JGljRHvMTdnegk5CIFGqZ5khBWv9aN
 5JQ=
X-IronPort-AV: E=Sophos;i="5.82,296,1613458800"; 
   d="scan'208";a="127869629"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2021 23:14:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 23:14:15 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 12 May 2021 23:14:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 3/4] ARM: configs: at91: add defconfig for sama7 family of SoCs
Date:   Thu, 13 May 2021 09:13:53 +0300
Message-ID: <20210513061354.138158-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210513061354.138158-1-eugen.hristev@microchip.com>
References: <20210513061354.138158-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add defconfig for sama7 SoC family.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[claudiu.beznea@microchip.com: add clocks, ethernet, timers, power]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
[codrin.ciubotariu@microchip.com: add audio]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 213 +++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)
 create mode 100644 arch/arm/configs/sama7_defconfig

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
new file mode 100644
index 000000000000..79f5b80e3555
--- /dev/null
+++ b/arch/arm/configs/sama7_defconfig
@@ -0,0 +1,213 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_DEBUG=y
+CONFIG_NAMESPACES=y
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_FHANDLE is not set
+# CONFIG_IO_URING is not set
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_SLAB=y
+CONFIG_ARCH_AT91=y
+CONFIG_SOC_SAMA7G5=y
+CONFIG_ATMEL_CLOCKSOURCE_TCB=y
+# CONFIG_CACHE_L2X0 is not set
+# CONFIG_ARM_PATCH_IDIV is not set
+# CONFIG_CPU_SW_DOMAIN_PAN is not set
+CONFIG_FORCE_MAX_ZONEORDER=15
+CONFIG_UACCESS_WITH_MEMCPY=y
+CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk ignore_loglevel"
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPUFREQ_DT=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_KERNEL_MODE_NEON=y
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_COREDUMP is not set
+# CONFIG_COMPACTION is not set
+CONFIG_CMA=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_INET_DIAG is not set
+CONFIG_IPV6_SIT_6RD=y
+CONFIG_BRIDGE=m
+CONFIG_BRIDGE_VLAN_FILTERING=y
+CONFIG_NET_DSA=m
+CONFIG_VLAN_8021Q=m
+CONFIG_CAN=y
+CONFIG_CAN_M_CAN=y
+CONFIG_CAN_M_CAN_PLATFORM=y
+CONFIG_BT=y
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=y
+CONFIG_BT_HCIBTUSB=y
+CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_H4=y
+CONFIG_BT_HCIVHCI=y
+CONFIG_CFG80211=m
+# CONFIG_CFG80211_DEFAULT_PS is not set
+CONFIG_CFG80211_DEBUGFS=y
+CONFIG_CFG80211_WEXT=y
+CONFIG_MAC80211=m
+CONFIG_MAC80211_LEDS=y
+CONFIG_RFKILL=y
+CONFIG_RFKILL_INPUT=y
+CONFIG_PCCARD=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=1
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_EEPROM_AT24=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_NETDEVICES=y
+CONFIG_MACB=y
+CONFIG_MICREL_PHY=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_LEGACY_PTY_COUNT=4
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+CONFIG_HW_RANDOM=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_AT91=y
+CONFIG_SPI=y
+CONFIG_SPI_MEM=y
+CONFIG_SPI_ATMEL=y
+CONFIG_PINCTRL_AT91=y
+CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_AT91_RESET=y
+CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_SAMA5D4_WATCHDOG=y
+CONFIG_MFD_ATMEL_FLEXCOM=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_MCP16502=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_SUPPORT_FILTER=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_PLATFORM_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_IMX219=m
+CONFIG_VIDEO_IMX274=m
+CONFIG_VIDEO_OV5647=m
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_ATMEL_SOC=y
+CONFIG_SND_SOC_MIKROE_PROTO=m
+CONFIG_SND_MCHP_SOC_I2S_MCC=y
+CONFIG_SND_MCHP_SOC_SPDIFTX=y
+CONFIG_SND_MCHP_SOC_SPDIFRX=y
+CONFIG_SND_SOC_PCM5102A=y
+CONFIG_SND_SOC_SPDIF=y
+CONFIG_SND_SIMPLE_CARD=y
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_DYNAMIC_MINORS=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_UAS=y
+CONFIG_USB_GADGET=y
+CONFIG_U_SERIAL_CONSOLE=y
+CONFIG_USB_ATMEL_USBA=m
+CONFIG_USB_CONFIGFS=y
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_UVC=y
+CONFIG_USB_G_SERIAL=m
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_AT91=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+# CONFIG_RTC_NVMEM is not set
+CONFIG_RTC_DRV_AT91RM9200=y
+CONFIG_RTC_DRV_AT91SAM9=y
+CONFIG_DMADEVICES=y
+CONFIG_AT_XDMAC=y
+CONFIG_DMATEST=y
+CONFIG_STAGING=y
+CONFIG_MICROCHIP_PIT64B=y
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_ATMEL_EBI is not set
+CONFIG_IIO=y
+CONFIG_IIO_SW_TRIGGER=y
+CONFIG_AT91_SAMA5D2_ADC=y
+CONFIG_PWM=y
+CONFIG_PWM_ATMEL=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+CONFIG_FANOTIFY=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
+CONFIG_LSM="N"
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_CCITT=y
+CONFIG_CRC_ITU_T=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=32
+CONFIG_CMA_ALIGNMENT=9
+# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_DEBUG_MISC is not set
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_STACKTRACE=y
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_USER=y
+# CONFIG_RUNTIME_TESTING_MENU is not set
-- 
2.25.1

