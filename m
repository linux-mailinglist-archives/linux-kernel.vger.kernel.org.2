Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D404391491
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhEZKNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:13:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34078 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbhEZKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622023932; x=1653559932;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bW7n+e/OD7pmzw3aMWUasZ8+LI/KzJIeuHujrcb/OMg=;
  b=pjFJRDUQHXEfk9m8qoj4+v5Y+E6DgYamRqEhEF2JlBAO6XfrvdxfdJWe
   Zu0TelOFaO8fkpkl1yiTrrezQkQ1GmQ7tHRnbcpsfL7FbYxZ1Mhh49pLR
   TEKEA4JloEtkh2rHMiI93i78SuTty2C+I3H8z4WtxmGjO86lMQuUJqZ6C
   hdPUxwI5+XPAT/4f/KiguC75Pb5jVCzbeWDHu5Q/RBU16Ww1eYUTxRe2+
   jOB9qDMIIqY5Ht6RVdYg7OV9v2GzKrZmirbNXNb5r2cmm4xP50acY4+Dl
   xCrQYCRgNzR37yjxY1zZvCn50fWjthI2uPTGkzdJ0fEG04rBKv/xkSUok
   w==;
IronPort-SDR: MJyK+05kzakQRDQxGD4T97lBYXr2d6S6hgEFyacTyKWFTFGHE9+hJqD7coOtYPzrGXMQzuKoIB
 QEy4YOxM41vKcLxROqg4fTPXlpEaJQOxLN1uPXgm2SxwiZw8kd5NhKnYOxX7UZkFTX8ZFrNHC1
 ZkREipfOHdE/tUYQpOpClBKrrKtdUSDdzLaYL1Yxl5wvVSOi5K/SapXT8Yx1FB6tlt96TCa554
 ZdbgxFGaxzpq6tDrlTZbeNOE1BF5kTEJkBUsrhd+rXU8JgHE6op0Cld7X79vaT8gzmMcVwvCjQ
 j/4=
X-IronPort-AV: E=Sophos;i="5.82,331,1613458800"; 
   d="scan'208";a="122436595"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2021 03:12:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 03:12:10 -0700
Received: from [10.12.72.167] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 26 May 2021 03:12:08 -0700
Subject: Re: [PATCH v4 3/4] ARM: configs: at91: add defconfig for sama7 family
 of SoCs
To:     Eugen Hristev <eugen.hristev@microchip.com>, <robh+dt@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <tudor.ambarus@microchip.com>
References: <20210514082151.178571-1-eugen.hristev@microchip.com>
 <20210514082151.178571-3-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <f2e1c939-5569-c93c-3a0f-2ac80f021843@microchip.com>
Date:   Wed, 26 May 2021 12:12:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210514082151.178571-3-eugen.hristev@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2021 at 10:21, Eugen Hristev wrote:
> Add defconfig for sama7 SoC family.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> [claudiu.beznea@microchip.com: add clocks, ethernet, timers, power]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> [codrin.ciubotariu@microchip.com: add audio]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

We'll need to add:


@@ -24,6 +24,7 @@ CONFIG_ATMEL_CLOCKSOURCE_TCB=y 
 

  # CONFIG_CPU_SW_DOMAIN_PAN is not set
  CONFIG_FORCE_MAX_ZONEORDER=15
  CONFIG_UACCESS_WITH_MEMCPY=y
+# CONFIG_ATAGS is not set 
 

  CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk ignore_loglevel"
  CONFIG_CPU_FREQ=y
  CONFIG_CPU_FREQ_STAT=y
@@ -87,6 +88,7 @@ CONFIG_DEVTMPFS_MOUNT=y 
 

  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
  # CONFIG_ALLOW_DEV_COREDUMP is not set
  CONFIG_MTD=y
+CONFIG_MTD_TESTS=m 
 

  CONFIG_MTD_CMDLINE_PARTS=y
  CONFIG_BLK_DEV_LOOP=y
  CONFIG_BLK_DEV_RAM=y
@@ -111,6 +113,7 @@ CONFIG_I2C_AT91=y 
 

  CONFIG_SPI=y
  CONFIG_SPI_MEM=y
  CONFIG_SPI_ATMEL=y
+CONFIG_SPI_GPIO=y 
 

  CONFIG_PINCTRL_AT91=y
  CONFIG_PINCTRL_AT91PIO4=y
  CONFIG_GPIO_SYSFS=y

to match recent changes to other at91 defconfigs.


Regards,
   Nicolas

> ---
>   arch/arm/configs/sama7_defconfig | 213 +++++++++++++++++++++++++++++++
>   1 file changed, 213 insertions(+)
>   create mode 100644 arch/arm/configs/sama7_defconfig
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> new file mode 100644
> index 000000000000..79f5b80e3555
> --- /dev/null
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -0,0 +1,213 @@
> +# CONFIG_LOCALVERSION_AUTO is not set
> +# CONFIG_SWAP is not set
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_LOG_BUF_SHIFT=16
> +CONFIG_CGROUPS=y
> +CONFIG_CGROUP_DEBUG=y
> +CONFIG_NAMESPACES=y
> +CONFIG_SYSFS_DEPRECATED=y
> +CONFIG_SYSFS_DEPRECATED_V2=y
> +CONFIG_BLK_DEV_INITRD=y
> +# CONFIG_FHANDLE is not set
> +# CONFIG_IO_URING is not set
> +CONFIG_KALLSYMS_ALL=y
> +CONFIG_EMBEDDED=y
> +# CONFIG_VM_EVENT_COUNTERS is not set
> +CONFIG_SLAB=y
> +CONFIG_ARCH_AT91=y
> +CONFIG_SOC_SAMA7G5=y
> +CONFIG_ATMEL_CLOCKSOURCE_TCB=y
> +# CONFIG_CACHE_L2X0 is not set
> +# CONFIG_ARM_PATCH_IDIV is not set
> +# CONFIG_CPU_SW_DOMAIN_PAN is not set
> +CONFIG_FORCE_MAX_ZONEORDER=15
> +CONFIG_UACCESS_WITH_MEMCPY=y
> +CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk ignore_loglevel"
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPUFREQ_DT=y
> +CONFIG_VFP=y
> +CONFIG_NEON=y
> +CONFIG_KERNEL_MODE_NEON=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_FORCE_LOAD=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_MODULE_FORCE_UNLOAD=y
> +# CONFIG_BLK_DEV_BSG is not set
> +CONFIG_PARTITION_ADVANCED=y
> +# CONFIG_EFI_PARTITION is not set
> +# CONFIG_COREDUMP is not set
> +# CONFIG_COMPACTION is not set
> +CONFIG_CMA=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +CONFIG_IP_MULTICAST=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +# CONFIG_INET_DIAG is not set
> +CONFIG_IPV6_SIT_6RD=y
> +CONFIG_BRIDGE=m
> +CONFIG_BRIDGE_VLAN_FILTERING=y
> +CONFIG_NET_DSA=m
> +CONFIG_VLAN_8021Q=m
> +CONFIG_CAN=y
> +CONFIG_CAN_M_CAN=y
> +CONFIG_CAN_M_CAN_PLATFORM=y
> +CONFIG_BT=y
> +CONFIG_BT_RFCOMM=y
> +CONFIG_BT_RFCOMM_TTY=y
> +CONFIG_BT_BNEP=y
> +CONFIG_BT_BNEP_MC_FILTER=y
> +CONFIG_BT_BNEP_PROTO_FILTER=y
> +CONFIG_BT_HIDP=y
> +CONFIG_BT_HCIBTUSB=y
> +CONFIG_BT_HCIUART=y
> +CONFIG_BT_HCIUART_H4=y
> +CONFIG_BT_HCIVHCI=y
> +CONFIG_CFG80211=m
> +# CONFIG_CFG80211_DEFAULT_PS is not set
> +CONFIG_CFG80211_DEBUGFS=y
> +CONFIG_CFG80211_WEXT=y
> +CONFIG_MAC80211=m
> +CONFIG_MAC80211_LEDS=y
> +CONFIG_RFKILL=y
> +CONFIG_RFKILL_INPUT=y
> +CONFIG_PCCARD=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +# CONFIG_STANDALONE is not set
> +# CONFIG_PREVENT_FIRMWARE_BUILD is not set
> +# CONFIG_ALLOW_DEV_COREDUMP is not set
> +CONFIG_MTD=y
> +CONFIG_MTD_CMDLINE_PARTS=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_COUNT=1
> +CONFIG_BLK_DEV_RAM_SIZE=8192
> +CONFIG_EEPROM_AT24=y
> +CONFIG_SCSI=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_NETDEVICES=y
> +CONFIG_MACB=y
> +CONFIG_MICREL_PHY=y
> +CONFIG_INPUT_EVDEV=y
> +CONFIG_KEYBOARD_GPIO=y
> +# CONFIG_INPUT_MOUSE is not set
> +CONFIG_LEGACY_PTY_COUNT=4
> +CONFIG_SERIAL_ATMEL=y
> +CONFIG_SERIAL_ATMEL_CONSOLE=y
> +CONFIG_HW_RANDOM=y
> +CONFIG_I2C=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_AT91=y
> +CONFIG_SPI=y
> +CONFIG_SPI_MEM=y
> +CONFIG_SPI_ATMEL=y
> +CONFIG_PINCTRL_AT91=y
> +CONFIG_PINCTRL_AT91PIO4=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_POWER_RESET=y
> +CONFIG_POWER_RESET_AT91_RESET=y
> +CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC=y
> +# CONFIG_HWMON is not set
> +CONFIG_WATCHDOG=y
> +CONFIG_SAMA5D4_WATCHDOG=y
> +CONFIG_MFD_ATMEL_FLEXCOM=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_MCP16502=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_SUPPORT_FILTER=y
> +# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_MEDIA_PLATFORM_SUPPORT=y
> +CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_VIDEO_IMX219=m
> +CONFIG_VIDEO_IMX274=m
> +CONFIG_VIDEO_OV5647=m
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_ATMEL_SOC=y
> +CONFIG_SND_SOC_MIKROE_PROTO=m
> +CONFIG_SND_MCHP_SOC_I2S_MCC=y
> +CONFIG_SND_MCHP_SOC_SPDIFTX=y
> +CONFIG_SND_MCHP_SOC_SPDIFRX=y
> +CONFIG_SND_SOC_PCM5102A=y
> +CONFIG_SND_SOC_SPDIF=y
> +CONFIG_SND_SIMPLE_CARD=y
> +CONFIG_USB=y
> +CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> +CONFIG_USB_DYNAMIC_MINORS=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_UAS=y
> +CONFIG_USB_GADGET=y
> +CONFIG_U_SERIAL_CONSOLE=y
> +CONFIG_USB_ATMEL_USBA=m
> +CONFIG_USB_CONFIGFS=y
> +CONFIG_USB_CONFIGFS_ACM=y
> +CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> +CONFIG_USB_CONFIGFS_F_UVC=y
> +CONFIG_USB_G_SERIAL=m
> +CONFIG_MMC=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_OF_AT91=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_RTC_CLASS=y
> +# CONFIG_RTC_NVMEM is not set
> +CONFIG_RTC_DRV_AT91RM9200=y
> +CONFIG_RTC_DRV_AT91SAM9=y
> +CONFIG_DMADEVICES=y
> +CONFIG_AT_XDMAC=y
> +CONFIG_DMATEST=y
> +CONFIG_STAGING=y
> +CONFIG_MICROCHIP_PIT64B=y
> +# CONFIG_IOMMU_SUPPORT is not set
> +# CONFIG_ATMEL_EBI is not set
> +CONFIG_IIO=y
> +CONFIG_IIO_SW_TRIGGER=y
> +CONFIG_AT91_SAMA5D2_ADC=y
> +CONFIG_PWM=y
> +CONFIG_PWM_ATMEL=y
> +CONFIG_EXT2_FS=y
> +CONFIG_EXT3_FS=y
> +CONFIG_FANOTIFY=y
> +CONFIG_VFAT_FS=y
> +CONFIG_TMPFS=y
> +CONFIG_NFS_FS=y
> +CONFIG_ROOT_NFS=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_CODEPAGE_850=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_NLS_UTF8=y
> +CONFIG_LSM="N"
> +CONFIG_CRYPTO_DEFLATE=y
> +CONFIG_CRYPTO_LZO=y
> +# CONFIG_CRYPTO_HW is not set
> +CONFIG_CRC_CCITT=y
> +CONFIG_CRC_ITU_T=y
> +CONFIG_DMA_CMA=y
> +CONFIG_CMA_SIZE_MBYTES=32
> +CONFIG_CMA_ALIGNMENT=9
> +# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
> +CONFIG_DEBUG_FS=y
> +# CONFIG_DEBUG_MISC is not set
> +# CONFIG_SCHED_DEBUG is not set
> +CONFIG_STACKTRACE=y
> +# CONFIG_FTRACE is not set
> +CONFIG_DEBUG_USER=y
> +# CONFIG_RUNTIME_TESTING_MENU is not set
> 


-- 
Nicolas Ferre
