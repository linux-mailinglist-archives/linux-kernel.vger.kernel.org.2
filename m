Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C73B1A75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhFWMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:49:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA23C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:46:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e20so1728440pgg.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Hvf40VXXqsCPVGi0brARNsNARbp18VS1fRrQ6xN2glY=;
        b=BdqoiU/72hOIebU4EZ7osgIM+KMpu5bgBqiUf4dBQGku4tkLgIZSm/oLLA2Yv8qZtO
         BINdK3r/T9/n6Q2hHn8UH/nWhWmQPt6Ki26a0ZfMfBgz45dnEIY1D9MGv+m8Q5Bfig5U
         k2hSldqeCb1HYbivoHKNWQDno18AfjKWNlowGxBSKIja7G1hZACDw9prztLppQWy5crR
         xNLhfgdCyqK6hP/zMFV7xwvXIqTPJoXuNX39Yjh3/hk37pCDjivBNuWDcKljtrLxdyNI
         MH8fdOjzRthwzN0c01i8HLYY1duLqqN9pY9aI7W3C+i7DIVPmK1e7WPIIbpg6Hr0Wdwp
         wsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hvf40VXXqsCPVGi0brARNsNARbp18VS1fRrQ6xN2glY=;
        b=FXDVnq3etHZApBP7m4gjDg9mqUtJ/XPFVzL8+Cj70BnuW6dUve9T/GPwGcD4CKozZK
         kLkkWNjlHp9kCy/hJnOaWD4AeDh5A3aKJqFngNfAZR3SE100uKprNM7mCmeZleOtylXl
         i73dMSe1ZcQFV+zQsssSOGVjk6VN64DuRSZ/GO0/NRSXXaRSOV7RWzR1L9u6xdd2Bd+O
         lkVt2g4LWTth+p6KGAZ4AQ/LgEjrnBpB3KevgZXQd5Q1RREbLAmHTkx4c0Wl45TLxF7U
         bMRCaZm/bQeeiRCUPldV1+POvBT+Y0SUEA4hNBph8pBGRj0f9kXLkOLQnm5bBYt5lvSV
         si8g==
X-Gm-Message-State: AOAM5326EAtoINCmfL6bhg5URyP/yy00ESodmMRDrJ22iFlHaH3wrR8q
        gWap1mylIMazrS4GRhvmeynjmavCfbs4kCYf
X-Google-Smtp-Source: ABdhPJycIdBusQpQLW4EZbTiP8NuwXqRAO7/O0/9QK6C0yeudoQfB8QIWOEnCiP6LV+ZGlFyqP2c4A==
X-Received: by 2002:a63:2cc4:: with SMTP id s187mr3757396pgs.233.1624452417865;
        Wed, 23 Jun 2021 05:46:57 -0700 (PDT)
Received: from [192.168.1.153] (163.128.178.217.shared.user.transix.jp. [217.178.128.163])
        by smtp.gmail.com with ESMTPSA id h18sm23144634pgl.87.2021.06.23.05.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 05:46:57 -0700 (PDT)
Subject: [PATCH 1/1] config: Enable jh7100 SoC
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <f22f6d7e-97ab-85db-5448-c2bcef0ea0e7@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <82328d90-2769-6bd0-a28e-b501fba63d76@gmail.com>
Date:   Wed, 23 Jun 2021 21:46:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f22f6d7e-97ab-85db-5448-c2bcef0ea0e7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/configs/defconfig | 105 +++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 1f2be234b11c..e07d26d2743c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -138,3 +138,108 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 CONFIG_MEMTEST=y
 # CONFIG_SYSFS_SYSCALL is not set
 CONFIG_EFI=y
+CONFIG_FB_STARFIVE=y
+CONFIG_FB_STARFIVE_HDMI_ADV7513=y
+CONFIG_FB_STARFIVE_HDMI_TDA998X=y
+CONFIG_FB_STARFIVE_SEEED5INCH=y
+CONFIG_FB_STARFIVE_VIDEO=y
+CONFIG_HW_RANDOM_STARFIVE_VIC=y
+CONFIG_SOC_STARFIVE_VIC7100=y
+CONFIG_FPGA_GMAC_FLUSH_DDR=y
+CONFIG_MMC_DW_FLUSH_DDR=y
+CONFIG_USB_CDNS3_HOST_FLUSH_DMA=y
+CONFIG_SOC_STARFIVE_VIC7100_I2C_GPIO=y
+CONFIG_VIDEO_STARFIVE_VIN=y
+CONFIG_VIDEO_STARFIVE_VIN_SENSOR_IMX219=y
+CONFIG_VIDEO_STARFIVE_VIN_SENSOR_OV5640=y
+CONFIG_VIDEO_STARFIVE_VIN_SENSOR_SC2235=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+CONFIG_LOG_CPU_MAX_BUF_SHIFT=15
+CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=12
+CONFIG_PM=y
+CONFIG_PM_CLK=y
+CONFIG_EFI_BOOTLOADER_CONTROL=y
+CONFIG_BLK_PM=y
+CONFIG_IOSCHED_BFQ=y
+CONFIG_KSM=y
+CONFIG_CMA=y
+CONFIG_CMA_AREAS=7
+CONFIG_REGMAP_I2C=y
+CONFIG_REGMAP_IRQ=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_PARTITIONED_MASTER=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
+CONFIG_BLK_DEV_NBD=y
+CONFIG_INPUT_LEDS=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_SERIAL_8250_DMA=y
+CONFIG_SERIAL_8250_DWLIB=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_DESIGNWARE_CORE=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_SPI_MEM=y
+CONFIG_SPI_CADENCE_QUADSPI=y
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_DW_DMA=y
+CONFIG_SPI_DW_MMIO=y
+CONFIG_SPI_SPIDEV=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_STARFIVE_VIC=y
+CONFIG_GPIO_TPS65086=y
+CONFIG_POWER_RESET_TPS65086=y
+CONFIG_MFD_TPS65086=y
+CONFIG_USB_HID=y
+CONFIG_USB_CDNS_SUPPORT=y
+CONFIG_USB_CDNS_HOST=y
+CONFIG_USB_CDNS3=y
+CONFIG_USB_CDNS3_HOST=y
+CONFIG_USB_ROLE_SWITCH=y
+CONFIG_SDIO_UART=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_PLTFM=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_DRV_EFI=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_ENGINE=y
+CONFIG_DMA_VIRTUAL_CHANNELS=y
+CONFIG_DMA_OF=y
+CONFIG_DW_AXI_DMAC=y
+CONFIG_DW_AXI_DMAC_STARFIVE=y
+CONFIG_COMMON_CLK_SI544=y
+CONFIG_COMMON_CLK_PWM=y
+CONFIG_SIFIVE_L2=y
+CONFIG_SIFIVE_L2_FLUSH=y
+CONFIG_SIFIVE_L2_FLUSH_START=0x80000000
+CONFIG_SIFIVE_L2_FLUSH_SIZE=0x800000000
+CONFIG_SIFIVE_L2_IRQ_DISABLE=y
+CONFIG_PWM=y
+CONFIG_PWM_SYSFS=y
+CONFIG_PWM_SIFIVE_PTC=y
+CONFIG_RESET_CONTROLLER=y
+CONFIG_PROC_KCORE=y
+CONFIG_EFIVAR_FS=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=640
+CONFIG_CMA_SIZE_SEL_MBYTES=y
+CONFIG_CMA_ALIGNMENT=8
+CONFIG_NET_VENDOR_STMICRO=y
+CONFIG_STMMAC_ETH=y
+CONFIG_STMMAC_PLATFORM=y
+CONFIG_DWMAC_GENERIC=y
+CONFIG_MICREL_PHY=y
-- 
2.17.1


