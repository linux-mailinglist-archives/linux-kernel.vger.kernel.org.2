Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B0443D658
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJ0WPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJ0WO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:14:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DC8C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:12:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id l203so4069683pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jtJ9mg6mkCM+HyrDKkQPfKHujvrubHvnFkuczrG0f/A=;
        b=QA2fDubt5NaeGhrWm07+haXkSxZJhyCdcj21Eb4WlFrgc01AqnujVk23mCJV9laDho
         MC6Uf1sny7w3wVylEiC14zzEOL4YXypzokzBi9lXvq8cWfceuSYo/GsqycUycrKzNE0c
         ZCO+cznB9wY82LJxTVtGup8imD2JiIiZfJj5R9w84XTfC7FrBZDhExGd350jWyvGhX4i
         HAc85WleWILO9PuOH4YlqtBYVPKhhOQVwRpPpx9I5C6+xNdJ6v2CweyeGJ+4AxP+/XTu
         B0pjyWNcgggv2yhZGinGixQadSrCpbfU49Mi/+SjT5zSvskh1WykthGG7R/4HK7NuaQU
         fgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jtJ9mg6mkCM+HyrDKkQPfKHujvrubHvnFkuczrG0f/A=;
        b=8Nw1QKqdBQQFSIA9Uiv73PENiwMmLbVIvO+vmxftcXsK2mqt4AqJJdbvObzo4sb+Ov
         zHIyvOV4yvH9LN8D03Bv2HvZCrccQZvkgrweTf/vG7k6j0IzjNA8tDb9FWqZvZcWa71y
         yVhEUcsyY3pSn/2k767DxPBdC4LzTbNzVpKYOHwzUoXAQZOWsfphd3vZHRklO3Gfhd4w
         qvpLpxa5Uv62EFQwL6BBMwzRoY9umvzRc9/Kb8Zy8Okig+uaWuvL8sVO29XhmSgsbj6X
         T6oyauNZxctFcVhgDiBfkcbV92EchrBkMltICMwovfYIEe269PimDxgYh8jvCfABDJKm
         Xn1Q==
X-Gm-Message-State: AOAM533C5WM9fnV+PJLKc/PmrbOe10JhOXUllQXU5xaCIOhImn6kPGLo
        DYldWPA02NliyARdg7mG9U5OfQ==
X-Google-Smtp-Source: ABdhPJwpI8y3nmvTnJXqOogIABbrz/ln1LK+9cVYlo5HciH5w8jSWsImVENT3vlg6zCh2DvtDvFuiQ==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr333092pgv.370.1635372751485;
        Wed, 27 Oct 2021 15:12:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:d96b:421d:2a73:9190])
        by smtp.gmail.com with ESMTPSA id o22sm952535pfu.50.2021.10.27.15.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:12:30 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:12:30 -0700 (PDT)
X-Google-Original-Date: Wed, 27 Oct 2021 14:34:17 PDT (-0700)
Subject:     Re: [PATCH 1/3] RISC-V: Enable KVM in RV64 and RV32 defconfigs as a module
In-Reply-To: <20211026170136.2147619-2-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        pbonzini@redhat.com, Atish Patra <Atish.Patra@wdc.com>,
        anup@brainfault.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-1044c135-bede-498b-b244-9f9c5f5ea89b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 10:01:34 PDT (-0700), Anup Patel wrote:
> Let's enable KVM RISC-V in RV64 and RV32 defconfigs as module
> so that it always built along with the default kernel image.

Turning on KVM in the defconfigs seems like the right way to go, but 
this has more diff than just that.  Not sure if that's all just 
savedefconfig stuff, I usually try and split out the non-functional 
changes from anything that makes a change.

If you checked then

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

assuming you want to keep these together.  LMK if you want me to take 
this on its own (I'll split it up if you do).

>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/configs/defconfig      | 15 +++++++--------
>  arch/riscv/configs/rv32_defconfig |  8 ++++----
>  2 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4ebc80315f01..40506dfab5cf 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BPF_SYSCALL=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_CGROUPS=y
> @@ -13,12 +14,14 @@ CONFIG_USER_NS=y
>  CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> -CONFIG_BPF_SYSCALL=y
> +# CONFIG_SYSFS_SYSCALL is not set
> +CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
> -CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
> +CONFIG_VIRTUALIZATION=y
> +CONFIG_KVM=m
>  CONFIG_JUMP_LABEL=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> @@ -68,14 +71,12 @@ CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
>  CONFIG_SPI=y
>  CONFIG_SPI_SIFIVE=y
> +# CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SIFIVE=y
> -# CONFIG_PTP_1588_CLOCK is not set
> -CONFIG_POWER_RESET=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RADEON=y
>  CONFIG_DRM_VIRTIO_GPU=y
> -CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_PLATFORM=y
> @@ -85,10 +86,10 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
> +CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_CADENCE=y
> -CONFIG_MMC=y
>  CONFIG_MMC_SPI=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_VIRTIO_PCI=y
> @@ -139,5 +140,3 @@ CONFIG_RCU_EQS_DEBUG=y
>  # CONFIG_FTRACE is not set
>  # CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_MEMTEST=y
> -# CONFIG_SYSFS_SYSCALL is not set
> -CONFIG_EFI=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 434ef5b64599..44022e048efd 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BPF_SYSCALL=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_CGROUPS=y
> @@ -13,12 +14,14 @@ CONFIG_USER_NS=y
>  CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> -CONFIG_BPF_SYSCALL=y
> +# CONFIG_SYSFS_SYSCALL is not set
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
> +CONFIG_VIRTUALIZATION=y
> +CONFIG_KVM=m
>  CONFIG_JUMP_LABEL=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> @@ -67,11 +70,9 @@ CONFIG_HW_RANDOM_VIRTIO=y
>  CONFIG_SPI=y
>  CONFIG_SPI_SIFIVE=y
>  # CONFIG_PTP_1588_CLOCK is not set
> -CONFIG_POWER_RESET=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RADEON=y
>  CONFIG_DRM_VIRTIO_GPU=y
> -CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_PLATFORM=y
> @@ -130,4 +131,3 @@ CONFIG_RCU_EQS_DEBUG=y
>  # CONFIG_FTRACE is not set
>  # CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_MEMTEST=y
> -# CONFIG_SYSFS_SYSCALL is not set
