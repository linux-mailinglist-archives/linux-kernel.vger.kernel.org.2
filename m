Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D643B3178
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhFXOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFXOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:38:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4385FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:35:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so6058573pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xQjUbQButhibbxycyEoKhGLhEwWXr4D9Ex/GYx3Y3Js=;
        b=HHF7wfpYfcF7VvDC/veGMFqaV7NcnPO4cM4VAMUIX31K5q4g9c4/MuCUNWRgCtLARN
         c2ha2tVL3/qnMiF2djOzQkzpZRQfa8ERhlGF/b9OCXOejVKqOcAejHelxxms36IcCQp3
         BbV0/vHIOS/oUeb32ivbZWEg4NAD7roqTDGw8MAPDMwiS9smCn9Cr28cFNnYfd3jAqM0
         z3Qi7eStB2YZQ/8zFxhYwaD6BVelsrnAhsymGNbZNQWi9kfhMGzzSrQ9CqOx9TEqqo+B
         prWqScmnGxWYSNkxEuxoe4ASIwiqiX94fKRxH9EtJ134f7JLlClqUrF0sxW2/N0VIC1B
         4SqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQjUbQButhibbxycyEoKhGLhEwWXr4D9Ex/GYx3Y3Js=;
        b=AS+W8Ro3jEouVMu0Rd4FVgNxjSshwDgJXFjtbE1EzKGU1+g4qoze5goMNePNFZTm+L
         VtNR4cZYVK6+UGrSFCMPI0p9wZ46yKwkRP1MKuWJnW70hxFiXvJ3iOLFTXPKKghroTmr
         xgOKCgBWyZrceNtDMEcz89HGYTF6QTwB8QSCm9Jru1WzrnQVyJ0oXv3f7kYRMJFOD5cE
         AW1zGGzNcShLdLfUV55xBulKC6/6w/CZD6an/8WjK0+iaBU8Vr91cYBDc/5xBtD/4wlO
         sbKyO3PAqnrEoOlF8+YcqbDqZa9ShFJCA3TJLIPV/i852Mp0Rp5jRBa7o0q3z6lLmkiw
         5q4A==
X-Gm-Message-State: AOAM531Vb6muPuQRt1urq9JW5hA2exHlNBLo/2c06jy1qcIMfB9utEzA
        SwmlK5yNypKUCL2pnw1cz18XF6m+jPfbfPrq
X-Google-Smtp-Source: ABdhPJxXVMS6wroOr+XVkzR6Jm+WZBTfxesdgsDwt95Q/KPFv+h4RJh8GA5ujGtijFsQ+/9/EPAcHA==
X-Received: by 2002:a17:90a:db8a:: with SMTP id h10mr15838520pjv.50.1624545347330;
        Thu, 24 Jun 2021 07:35:47 -0700 (PDT)
Received: from [192.168.1.153] (163.128.178.217.shared.user.transix.jp. [217.178.128.163])
        by smtp.gmail.com with ESMTPSA id c5sm3153788pfi.81.2021.06.24.07.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 07:35:46 -0700 (PDT)
Subject: Re: [PATCH 1/1] config: Enable jh7100 SoC
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
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
 <82328d90-2769-6bd0-a28e-b501fba63d76@gmail.com>
 <20210623212145.498a8cd8@xhacker>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <6bccb054-06db-bfc3-bb7a-84f1b259c219@gmail.com>
Date:   Thu, 24 Jun 2021 23:35:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623212145.498a8cd8@xhacker>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/2021 10:21 PM, Jisheng Zhang wrote:
> Hi Akira,
> 
> On Wed, 23 Jun 2021 21:46:54 +0900
> Akira Tsukamoto <akira.tsukamoto@gmail.com> wrote:
> 
> It's better to add some descriptions here.

Thanks, I will add it when the RFC is over and ready to spin the patch.

Akira

> 
>> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
>> ---
>>  arch/riscv/configs/defconfig | 105 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>
>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
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
>> +CONFIG_HW_RANDOM_STARFIVE_VIC=y
> 
> I'm not sure which tree is this patch based. These config options are not
> defined. I also see undefined options below. For example, SOC_STARFIVE_VIC7100
> SOC_STARFIVE_VIC7100_I2C_GPIO and so on
> 
>> +CONFIG_SOC_STARFIVE_VIC7100=y
>> +CONFIG_FPGA_GMAC_FLUSH_DDR=y
>> +CONFIG_MMC_DW_FLUSH_DDR=y
>> +CONFIG_USB_CDNS3_HOST_FLUSH_DMA=y
>> +CONFIG_SOC_STARFIVE_VIC7100_I2C_GPIO=y
>> +CONFIG_VIDEO_STARFIVE_VIN=y
>> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_IMX219=y
>> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_OV5640=y
>> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_SC2235=y
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
> 
> 
