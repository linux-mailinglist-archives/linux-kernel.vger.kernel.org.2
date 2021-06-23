Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB93B20CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 21:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFWTKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWTKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 15:10:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DDEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 12:08:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e22so2562936pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=txv0mg8hNV4LnPNcH/0dMBSXo2LJjKpiSwWFkWZWzM0=;
        b=jppkvK1NGriJQkiOs1sxqUdmIiL7xjASHl9uqvN1uR7Fw3J9VRfiGHYuSjx16ObWT6
         yL/vqSelXdmKUyDAoSe2wSAv4edNcfph+vLza2uux/BS0rhLnum1mB5Hk+7lyouTAUfH
         PB9Oi3EqxN8cLCYPljM45znx2zmgGI6u1MVp0Q9KNfb55NSv2Q4wScEClFuGzngmcuJv
         /j152bNOLV7K/w2muvDs5F5QBhWkg2UpR+vRbb7z1jx5ytTeD1t+O4qCHc9wbtye1DLC
         Xy9npBik3M0/sSL6xtqNnt4qQOsaJnZETXFTd9ypZVcxbhDCMfjQXqEsuOUb0NwQoKvi
         pNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=txv0mg8hNV4LnPNcH/0dMBSXo2LJjKpiSwWFkWZWzM0=;
        b=fYMILrkkQSHYfTMWVsELIN/SKqhDGe89vl9qaQX58jZ26kXLVFWUr01bGaVVnylOMY
         Lfri+KDs9jb81nM79oaAhwKG4gsNIjwQ+v6Y7Nglu40yv3xEJX7eWeVSeiNOFYbtwuzK
         B2UO+kpiqqUxertLD4KB7un5eYJUl2gs/35j8Wg9PHWQpodIIN3jp2yZd2/wjIi0A8da
         umH4NVqUyfJga/W95vj2iQ/FYAjtZKtqP71lOPPh1j2YtpzCz6G6eC7H5d/Ix9tcxBvY
         nZiDtplqBNHAIoEiUjl3Kz1RD7zb3r9W2Qx10yVSGVP0DR/drmpiCAKjLxoTQtyBEm20
         mzoQ==
X-Gm-Message-State: AOAM531r4eFn37FvcZUsxtX3YQYf/zCeijUsjXIBa8YixfsEx/9DlWma
        w0KbulVdmuXugbw9fLYoHv624A==
X-Google-Smtp-Source: ABdhPJxJxcXqTvZMK6ST7HFpAiLBiDRa3Sh/XPUVK9nqUKm55SHUY7/KuvA3x5J2mDmH4lV9tpucTQ==
X-Received: by 2002:a65:4242:: with SMTP id d2mr862669pgq.243.1624475284079;
        Wed, 23 Jun 2021 12:08:04 -0700 (PDT)
Received: from x1 ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id o7sm611165pgs.45.2021.06.23.12.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:08:03 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:08:01 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] config: Enable jh7100 SoC
Message-ID: <20210623190801.GB493015@x1>
References: <f22f6d7e-97ab-85db-5448-c2bcef0ea0e7@gmail.com>
 <82328d90-2769-6bd0-a28e-b501fba63d76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82328d90-2769-6bd0-a28e-b501fba63d76@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 09:46:54PM +0900, Akira Tsukamoto wrote:
> 
> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
> ---
>  arch/riscv/configs/defconfig | 105 +++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig

Thanks for submitting this so we can review and discuss.

> index 1f2be234b11c..e07d26d2743c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -138,3 +138,108 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
>  CONFIG_MEMTEST=y
>  # CONFIG_SYSFS_SYSCALL is not set
>  CONFIG_EFI=y
> +CONFIG_FB_STARFIVE=y
> +CONFIG_FB_STARFIVE_HDMI_ADV7513=y
> +CONFIG_FB_STARFIVE_HDMI_TDA998X=y
> +CONFIG_FB_STARFIVE_SEEED5INCH=y
> +CONFIG_FB_STARFIVE_VIDEO=y

These should be dropped as they are vendor drivers that will never be
upstream as fbdev is deprecated [1]. StarFive is working on DRM driver
but that is a couple months away from being ready.

> +CONFIG_HW_RANDOM_STARFIVE_VIC=y
> +CONFIG_SOC_STARFIVE_VIC7100=y

Before this gets merged upstream, we need to switch over to using JH7100
instead of VIC.

For those not familiar, VIC was the StarFive internal project name but
the product is named JH7100 [2].

> +CONFIG_FPGA_GMAC_FLUSH_DDR=y
> +CONFIG_MMC_DW_FLUSH_DDR=y
> +CONFIG_USB_CDNS3_HOST_FLUSH_DMA=y
> +CONFIG_SOC_STARFIVE_VIC7100_I2C_GPIO=y

This config is being used in as a vendor hack in i2c_dw_configure_gpio()
drivers/i2c/busses/i2c-designware-master.c [3].

It's possible we may be able to eliminate this once I have completed
gpio and pinctrl drivers. Either way, this option will never be used in
an upstream kernel.

> +CONFIG_VIDEO_STARFIVE_VIN=y
> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_IMX219=y
> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_OV5640=y
> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_SC2235=y

These should be dropped as they are vendor drivers that do not use V4L2
and are not upstreamable [4]. StarFive is working on proper V4L2 drivers
but that is a couple months away from being ready.

> +CONFIG_RCU_CPU_STALL_TIMEOUT=60
> +CONFIG_LOG_CPU_MAX_BUF_SHIFT=15
> +CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=12
> +CONFIG_PM=y
> +CONFIG_PM_CLK=y
> +CONFIG_EFI_BOOTLOADER_CONTROL=y
> +CONFIG_BLK_PM=y
> +CONFIG_IOSCHED_BFQ=y
> +CONFIG_KSM=y
> +CONFIG_CMA=y
> +CONFIG_CMA_AREAS=7
> +CONFIG_REGMAP_I2C=y
> +CONFIG_REGMAP_IRQ=y
> +CONFIG_MTD_OF_PARTS=y
> +CONFIG_MTD_BLKDEVS=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_PARTITIONED_MASTER=y
> +CONFIG_MTD_MAP_BANK_WIDTH_1=y
> +CONFIG_MTD_MAP_BANK_WIDTH_2=y
> +CONFIG_MTD_MAP_BANK_WIDTH_4=y
> +CONFIG_MTD_CFI_I1=y
> +CONFIG_MTD_CFI_I2=y
> +CONFIG_MTD_SPI_NOR=y
> +CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
> +CONFIG_BLK_DEV_NBD=y
> +CONFIG_INPUT_LEDS=y
> +CONFIG_INPUT_EVDEV=y
> +CONFIG_SERIAL_8250_DMA=y
> +CONFIG_SERIAL_8250_DWLIB=y
> +CONFIG_SERIAL_8250_DW=y
> +CONFIG_HW_RANDOM_VIRTIO=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_DESIGNWARE_CORE=y
> +CONFIG_I2C_DESIGNWARE_PLATFORM=y
> +CONFIG_SPI_MEM=y
> +CONFIG_SPI_CADENCE_QUADSPI=y
> +CONFIG_SPI_DESIGNWARE=y
> +CONFIG_SPI_DW_DMA=y
> +CONFIG_SPI_DW_MMIO=y
> +CONFIG_SPI_SPIDEV=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_GPIO_STARFIVE_VIC=y

I am working on upstreamable version of the GPIO driver and will submit
RFC soon. This will be called CONFIG_GPIO_STARFIVE_JH7100.

> +CONFIG_GPIO_TPS65086=y
> +CONFIG_POWER_RESET_TPS65086=y
> +CONFIG_MFD_TPS65086=y
> +CONFIG_USB_HID=y
> +CONFIG_USB_CDNS_SUPPORT=y
> +CONFIG_USB_CDNS_HOST=y
> +CONFIG_USB_CDNS3=y
> +CONFIG_USB_CDNS3_HOST=y
> +CONFIG_USB_ROLE_SWITCH=y
> +CONFIG_SDIO_UART=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_PLTFM=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_RTC_DRV_EFI=y
> +CONFIG_DMADEVICES=y
> +CONFIG_DMA_ENGINE=y
> +CONFIG_DMA_VIRTUAL_CHANNELS=y
> +CONFIG_DMA_OF=y
> +CONFIG_DW_AXI_DMAC=y
> +CONFIG_DW_AXI_DMAC_STARFIVE=y
> +CONFIG_COMMON_CLK_SI544=y
> +CONFIG_COMMON_CLK_PWM=y
> +CONFIG_SIFIVE_L2=y
> +CONFIG_SIFIVE_L2_FLUSH=y
> +CONFIG_SIFIVE_L2_FLUSH_START=0x80000000
> +CONFIG_SIFIVE_L2_FLUSH_SIZE=0x800000000
> +CONFIG_SIFIVE_L2_IRQ_DISABLE=y
> +CONFIG_PWM=y
> +CONFIG_PWM_SYSFS=y
> +CONFIG_PWM_SIFIVE_PTC=y
> +CONFIG_RESET_CONTROLLER=y
> +CONFIG_PROC_KCORE=y
> +CONFIG_EFIVAR_FS=y
> +CONFIG_ZLIB_DEFLATE=y
> +CONFIG_DMA_CMA=y
> +CONFIG_CMA_SIZE_MBYTES=640
> +CONFIG_CMA_SIZE_SEL_MBYTES=y
> +CONFIG_CMA_ALIGNMENT=8
> +CONFIG_NET_VENDOR_STMICRO=y
> +CONFIG_STMMAC_ETH=y
> +CONFIG_STMMAC_PLATFORM=y
> +CONFIG_DWMAC_GENERIC=y
> +CONFIG_MICREL_PHY=y
> -- 
> 2.17.1
> 
> 

Thanks,
Drew

[1] https://github.com/starfive-tech/linux/tree/beaglev/drivers/video/fbdev/starfive
[2] https://github.com/starfive-tech/beaglev_doc/
[3] https://github.com/starfive-tech/linux/blob/beaglev/drivers/i2c/busses/i2c-designware-master.c#L170
[4] https://github.com/starfive-tech/linux/tree/beaglev/drivers/media/platform/starfive
