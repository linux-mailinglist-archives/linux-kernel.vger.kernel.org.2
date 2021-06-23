Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B03D3B1B11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFWNa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhFWNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:30:25 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09DF4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=+lQ6Po73kJPldOOOfGRLWkFbWwU19QQ4Ur
        nstRWRYAw=; b=CxXolodC+R9lbXbrg57c+osOUIequi520KgCNrm40kQx0Cc4ii
        KnjQroADUmR9zGhTtZzONOEr9KU/eVmBd8cthxVX4hy+MFfoGydfOj4esBtUbPYs
        BbV0T36vCCD8uapE3aO9JJxy2qJ4LbSPiOhY+hTzJTu97K8Lk62gGKokE=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAXHIi+NtNgt1wkAQ--.17384S2;
        Wed, 23 Jun 2021 21:27:26 +0800 (CST)
Date:   Wed, 23 Jun 2021 21:21:45 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] config: Enable jh7100 SoC
Message-ID: <20210623212145.498a8cd8@xhacker>
In-Reply-To: <82328d90-2769-6bd0-a28e-b501fba63d76@gmail.com>
References: <f22f6d7e-97ab-85db-5448-c2bcef0ea0e7@gmail.com>
        <82328d90-2769-6bd0-a28e-b501fba63d76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAXHIi+NtNgt1wkAQ--.17384S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4xJF18Ww1DKr4rKr15Jwb_yoWrArW7p3
        W8Jrs8Jw18Jw17WrW7AF4vgrZ8trsrJFWUJr47JF1UJr1kGw45Jr1Yyr1UJrnrXF1DXr4r
        XFn7Xrnakr15JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j189NUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akira,

On Wed, 23 Jun 2021 21:46:54 +0900
Akira Tsukamoto <akira.tsukamoto@gmail.com> wrote:

It's better to add some descriptions here.

> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
> ---
>  arch/riscv/configs/defconfig | 105 +++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
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
> +CONFIG_HW_RANDOM_STARFIVE_VIC=y

I'm not sure which tree is this patch based. These config options are not
defined. I also see undefined options below. For example, SOC_STARFIVE_VIC7100
SOC_STARFIVE_VIC7100_I2C_GPIO and so on

> +CONFIG_SOC_STARFIVE_VIC7100=y
> +CONFIG_FPGA_GMAC_FLUSH_DDR=y
> +CONFIG_MMC_DW_FLUSH_DDR=y
> +CONFIG_USB_CDNS3_HOST_FLUSH_DMA=y
> +CONFIG_SOC_STARFIVE_VIC7100_I2C_GPIO=y
> +CONFIG_VIDEO_STARFIVE_VIN=y
> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_IMX219=y
> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_OV5640=y
> +CONFIG_VIDEO_STARFIVE_VIN_SENSOR_SC2235=y
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


