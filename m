Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187F63B31C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhFXOwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhFXOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:51:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF2BC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:49:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h23so3623051pjv.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XnmckKq8dgTGOIdOM2n9ve+pT1O+xT/ae6PiB67Krp4=;
        b=J/46JE4rYBco92WvjIgWNLPt5sDHkTLgO3KgZB7D5WxI0D2I3RpbP76jJTLWJG6G7z
         oZglvt68ONuX7lq+LL6cgQd+Gh4KeXc+Y+PCO311v3/F9lwVJKgaLwHMxSreD7hwUvTR
         6c9jHrubOHxj/Aeb8J6tCM+gPFR2VG3fCWLbIw8I55TU9L75wxSlHc7pxyt/LtMgOvx1
         BDti8ety3D2nzzNn9yy68XyHiIZrWXc38RumKsRv6zl4gJcoGZixg3rfn3dgGhvZlOUx
         QGguV5xnp3QAoMOLgH/pmt+EVR40mK8nUdMPs88SPs0w6ASJ1Ecuefq9NrLoQa+9dCkB
         0/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XnmckKq8dgTGOIdOM2n9ve+pT1O+xT/ae6PiB67Krp4=;
        b=gJ75sLs1WuimTQYM5CP4jA8wVHA+caGppsQGrXt0YOH1GvwNYXnsBdjHbCMpAB+Hpn
         iXdb99kuNiV/dhg67aHEfz7mM+UjYFW7wqFIRCM5p7GpViMWhhjiK71rKKZUyaKL6hKv
         bDPt2vSgk8Zgmspp8iSJMJ6DNmoAGhdzcfyLlmgeAlwqAw6GVjtfVNyNPl5W4FYI5se1
         cHPwj1Sw6TnaSezMA/BAqrCMzgClKQ/EBQmLxpuZIF3Dc5B+qLteW85kx4dFmVkwYusQ
         ClCiM44dPtDhXIYOfKk6ZRCurXTNV3NE34vSW5Bo2238u4nWXn7LcbhcRC+Pc2oCHd8+
         q9FQ==
X-Gm-Message-State: AOAM533Xinr0e6en9ZD+r8BRkY38sZyLGoLr+ACYoOvYRsIArySOdIxt
        keMowKjT/uGkGQ4g6lRVbh6GphPpFHK3l39g
X-Google-Smtp-Source: ABdhPJxz982h5e4ZJSZq8f5nwVySEDe1bxRB41qoGssApXk372VWg37oK3TF7ih+CYYUkOQEBtLbGg==
X-Received: by 2002:a17:90a:8a13:: with SMTP id w19mr5799916pjn.227.1624546178622;
        Thu, 24 Jun 2021 07:49:38 -0700 (PDT)
Received: from [192.168.1.153] (163.128.178.217.shared.user.transix.jp. [217.178.128.163])
        by smtp.gmail.com with ESMTPSA id y21sm2836572pgc.93.2021.06.24.07.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 07:49:38 -0700 (PDT)
Subject: Re: [PATCH 1/1] config: Enable jh7100 SoC
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <f22f6d7e-97ab-85db-5448-c2bcef0ea0e7@gmail.com>
 <82328d90-2769-6bd0-a28e-b501fba63d76@gmail.com> <20210623190801.GB493015@x1>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <d84539b7-e46d-f767-246b-85c20899ab94@gmail.com>
Date:   Thu, 24 Jun 2021 23:49:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623190801.GB493015@x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2021 4:08 AM, Drew Fustini wrote:
> On Wed, Jun 23, 2021 at 09:46:54PM +0900, Akira Tsukamoto wrote:
>>
>> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
>> ---
>>  arch/riscv/configs/defconfig | 105 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>
>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> 
> Thanks for submitting this so we can review and discuss.
> 
>> index 1f2be234b11c..e07d26d2743c 100644
>> --- a/arch/riscv/configs/defconfig
>> +++ b/arch/riscv/configs/defconfig
>> @@ -138,3 +138,108 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
>>  CONFIG_MEMTEST=y
>>  # CONFIG_SYSFS_SYSCALL is not set
>>  CONFIG_EFI=y
>> +CONFIG_FB_STARFIVE=y
>> +CONFIG_FB_STARFIVE_HDMI_ADV7513=y
>> +CONFIG_FB_STARFIVE_HDMI_TDA998X=y
>> +CONFIG_FB_STARFIVE_SEEED5INCH=y
>> +CONFIG_FB_STARFIVE_VIDEO=y
> 
> These should be dropped as they are vendor drivers that will never be
> upstream as fbdev is deprecated [1]. StarFive is working on DRM driver
> but that is a couple months away from being ready.

I will remove fbdev. And enable DRM driver only when them become ready.

> 
>> +CONFIG_HW_RANDOM_STARFIVE_VIC=y
>> +CONFIG_SOC_STARFIVE_VIC7100=y
> 
> Before this gets merged upstream, we need to switch over to using JH7100
> instead of VIC.
> 
> For those not familiar, VIC was the StarFive internal project name but
> the product is named JH7100 [2].

I will wait to enable the configs above until the patches rename them
and become upstream ready.

> 
>> +CONFIG_FPGA_GMAC_FLUSH_DDR=y
>> +CONFIG_MMC_DW_FLUSH_DDR=y
>> +CONFIG_USB_CDNS3_HOST_FLUSH_DMA=y
>> +CONFIG_SOC_STARFIVE_VIC7100_I2C_GPIO=y
> 
> This config is being used in as a vendor hack in i2c_dw_configure_gpio()
> drivers/i2c/busses/i2c-designware-master.c [3].
> 
> It's possible we may be able to eliminate this once I have completed
> gpio and pinctrl drivers. Either way, this option will never be used in
> an upstream kernel.

Sure, I will remove them and try it since I think your drivers were
in the Esmil branch.

> 
>> +CONFIG_VIDEO_STARFIVE_VIN=y
>> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_IMX219=y
>> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_OV5640=y
>> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_SC2235=y
> 
> These should be dropped as they are vendor drivers that do not use V4L2
> and are not upstreamable [4]. StarFive is working on proper V4L2 drivers
> but that is a couple months away from being ready.

Thanks, I will also wait for the v4l2 being ready.

Akira

> 
>> +CONFIG_RCU_CPU_STALL_TIMEOUT=60
>> +CONFIG_LOG_CPU_MAX_BUF_SHIFT=15
>> +CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=12
>> +CONFIG_PM=y
>> +CONFIG_PM_CLK=y
>> +CONFIG_EFI_BOOTLOADER_CONTROL=y
>> +CONFIG_BLK_PM=y
>> +CONFIG_IOSCHED_BFQ=y
>> +CONFIG_KSM=y
>> +CONFIG_CMA=y
>> +CONFIG_CMA_AREAS=7
>> +CONFIG_REGMAP_I2C=y
>> +CONFIG_REGMAP_IRQ=y
>> +CONFIG_MTD_OF_PARTS=y
>> +CONFIG_MTD_BLKDEVS=y
>> +CONFIG_MTD_BLOCK=y
>> +CONFIG_MTD_PARTITIONED_MASTER=y
>> +CONFIG_MTD_MAP_BANK_WIDTH_1=y
>> +CONFIG_MTD_MAP_BANK_WIDTH_2=y
>> +CONFIG_MTD_MAP_BANK_WIDTH_4=y
>> +CONFIG_MTD_CFI_I1=y
>> +CONFIG_MTD_CFI_I2=y
>> +CONFIG_MTD_SPI_NOR=y
>> +CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
>> +CONFIG_BLK_DEV_NBD=y
>> +CONFIG_INPUT_LEDS=y
>> +CONFIG_INPUT_EVDEV=y
>> +CONFIG_SERIAL_8250_DMA=y
>> +CONFIG_SERIAL_8250_DWLIB=y
>> +CONFIG_SERIAL_8250_DW=y
>> +CONFIG_HW_RANDOM_VIRTIO=y
>> +CONFIG_I2C_CHARDEV=y
>> +CONFIG_I2C_MUX=y
>> +CONFIG_I2C_DESIGNWARE_CORE=y
>> +CONFIG_I2C_DESIGNWARE_PLATFORM=y
>> +CONFIG_SPI_MEM=y
>> +CONFIG_SPI_CADENCE_QUADSPI=y
>> +CONFIG_SPI_DESIGNWARE=y
>> +CONFIG_SPI_DW_DMA=y
>> +CONFIG_SPI_DW_MMIO=y
>> +CONFIG_SPI_SPIDEV=y
>> +CONFIG_GPIO_SYSFS=y
>> +CONFIG_GPIO_STARFIVE_VIC=y
> 
> I am working on upstreamable version of the GPIO driver and will submit
> RFC soon. This will be called CONFIG_GPIO_STARFIVE_JH7100.
> 
>> +CONFIG_GPIO_TPS65086=y
>> +CONFIG_POWER_RESET_TPS65086=y
>> +CONFIG_MFD_TPS65086=y
>> +CONFIG_USB_HID=y
>> +CONFIG_USB_CDNS_SUPPORT=y
>> +CONFIG_USB_CDNS_HOST=y
>> +CONFIG_USB_CDNS3=y
>> +CONFIG_USB_CDNS3_HOST=y
>> +CONFIG_USB_ROLE_SWITCH=y
>> +CONFIG_SDIO_UART=y
>> +CONFIG_MMC_DW=y
>> +CONFIG_MMC_DW_PLTFM=y
>> +CONFIG_NEW_LEDS=y
>> +CONFIG_LEDS_CLASS=y
>> +CONFIG_LEDS_GPIO=y
>> +CONFIG_LEDS_TRIGGERS=y
>> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>> +CONFIG_RTC_DRV_EFI=y
>> +CONFIG_DMADEVICES=y
>> +CONFIG_DMA_ENGINE=y
>> +CONFIG_DMA_VIRTUAL_CHANNELS=y
>> +CONFIG_DMA_OF=y
>> +CONFIG_DW_AXI_DMAC=y
>> +CONFIG_DW_AXI_DMAC_STARFIVE=y
>> +CONFIG_COMMON_CLK_SI544=y
>> +CONFIG_COMMON_CLK_PWM=y
>> +CONFIG_SIFIVE_L2=y
>> +CONFIG_SIFIVE_L2_FLUSH=y
>> +CONFIG_SIFIVE_L2_FLUSH_START=0x80000000
>> +CONFIG_SIFIVE_L2_FLUSH_SIZE=0x800000000
>> +CONFIG_SIFIVE_L2_IRQ_DISABLE=y
>> +CONFIG_PWM=y
>> +CONFIG_PWM_SYSFS=y
>> +CONFIG_PWM_SIFIVE_PTC=y
>> +CONFIG_RESET_CONTROLLER=y
>> +CONFIG_PROC_KCORE=y
>> +CONFIG_EFIVAR_FS=y
>> +CONFIG_ZLIB_DEFLATE=y
>> +CONFIG_DMA_CMA=y
>> +CONFIG_CMA_SIZE_MBYTES=640
>> +CONFIG_CMA_SIZE_SEL_MBYTES=y
>> +CONFIG_CMA_ALIGNMENT=8
>> +CONFIG_NET_VENDOR_STMICRO=y
>> +CONFIG_STMMAC_ETH=y
>> +CONFIG_STMMAC_PLATFORM=y
>> +CONFIG_DWMAC_GENERIC=y
>> +CONFIG_MICREL_PHY=y
>> -- 
>> 2.17.1
>>
>>
> 
> Thanks,
> Drew
> 
> [1] https://github.com/starfive-tech/linux/tree/beaglev/drivers/video/fbdev/starfive
> [2] https://github.com/starfive-tech/beaglev_doc/
> [3] https://github.com/starfive-tech/linux/blob/beaglev/drivers/i2c/busses/i2c-designware-master.c#L170
> [4] https://github.com/starfive-tech/linux/tree/beaglev/drivers/media/platform/starfive
> 
