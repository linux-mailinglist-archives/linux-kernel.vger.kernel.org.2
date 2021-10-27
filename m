Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C843D70D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJ0XDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhJ0XDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635375679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slhdlXIZouU3TKY0ZbemsIVdWTFlzqB2fSO2ZsS3sYo=;
        b=T+LZexvmA2XfP9C+RvwPZ0FK+TZSUihptO/wswj9QYjtt8+MeH0awNoTt5cF+88ChiLckN
        itegaHUWJ7HgeZOxtTv741RnahE8HV63duAtJUtoD8ROs87CcN1y8nlxAJTPOzL9/TCCx2
        YnagoMHWFYP9YADxgiqe15NKAmyGpCw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-pkPVptTvNeifLzpFHTXB1g-1; Wed, 27 Oct 2021 19:01:18 -0400
X-MC-Unique: pkPVptTvNeifLzpFHTXB1g-1
Received: by mail-ed1-f70.google.com with SMTP id x13-20020a05640226cd00b003dd4720703bso3747780edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=slhdlXIZouU3TKY0ZbemsIVdWTFlzqB2fSO2ZsS3sYo=;
        b=j5Nh01fb4zzOvyX0Gz0icDyET22o3O9STHarLlFq+Y/YzkVIDg9sdDrcxukGsJtZ7o
         g3yULiwnBMhZhYrRdyJGfMD38Wj0Zf+yMZCNvURN05qeLqiI8ZT7P9wHBcyHtdV1bZK0
         pPATpfaMNb5QUccZEJ5X5RUthj+19wQYIBlujZ8vKXEUN0ZnNc4Anm8LwHEcBklBJLHm
         RPqcuZd7Nj9ozb6rf1RBAmmSpf5aqdXZ7UU5je0Epuk5y6RT5bWa2F7w9DOE1oK5gWto
         NSElEAjosvAMww8Oqj5sPSBRibVSmBW04AK/atm1yqNJQPqUs50gtcPKJzU7Ahdsj4az
         /Puw==
X-Gm-Message-State: AOAM533e6LIrV3fRCSAnAHcITzUCfp11f4lwsUEdYHOd0s7t3kfqYfyu
        7R+IS0J+aiof1BXomyhWkEowqIOFys6ztqyqBvY7mVkkJ8glQ6eO29pmAbGgvjzJI8x2SUjfI9w
        egfQ700v1REblZOVH5GaTaNy+
X-Received: by 2002:a05:6402:35c5:: with SMTP id z5mr1051187edc.388.1635375676053;
        Wed, 27 Oct 2021 16:01:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5j9O0+MnaAbrieUDtYr3ch1nbMXWnRtZk1a1pXiQnGgA26y4bxzvvUHHCk6CBGPVv830i9A==
X-Received: by 2002:a05:6402:35c5:: with SMTP id z5mr1051145edc.388.1635375675781;
        Wed, 27 Oct 2021 16:01:15 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id h7sm696798edt.37.2021.10.27.16.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 16:01:14 -0700 (PDT)
Message-ID: <c8941c0a-959a-d6fc-fd9c-4c743371a733@redhat.com>
Date:   Thu, 28 Oct 2021 01:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/3] RISC-V: Enable KVM in RV64 and RV32 defconfigs as a
 module
Content-Language: en-US
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>, anup@brainfault.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-1044c135-bede-498b-b244-9f9c5f5ea89b@palmerdabbelt-glaptop>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <mhng-1044c135-bede-498b-b244-9f9c5f5ea89b@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/21 00:12, Palmer Dabbelt wrote:
> On Tue, 26 Oct 2021 10:01:34 PDT (-0700), Anup Patel wrote:
>> Let's enable KVM RISC-V in RV64 and RV32 defconfigs as module
>> so that it always built along with the default kernel image.
> 
> Turning on KVM in the defconfigs seems like the right way to go, but 
> this has more diff than just that.  Not sure if that's all just 
> savedefconfig stuff, I usually try and split out the non-functional 
> changes from anything that makes a change.
> 
> If you checked then
> 
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> assuming you want to keep these together.  LMK if you want me to take 
> this on its own (I'll split it up if you do).

I think it's easiest if you just merge it for -rc2 or something like that.

Paolo

>>
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> ---
>>  arch/riscv/configs/defconfig      | 15 +++++++--------
>>  arch/riscv/configs/rv32_defconfig |  8 ++++----
>>  2 files changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>> index 4ebc80315f01..40506dfab5cf 100644
>> --- a/arch/riscv/configs/defconfig
>> +++ b/arch/riscv/configs/defconfig
>> @@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
>>  CONFIG_POSIX_MQUEUE=y
>>  CONFIG_NO_HZ_IDLE=y
>>  CONFIG_HIGH_RES_TIMERS=y
>> +CONFIG_BPF_SYSCALL=y
>>  CONFIG_IKCONFIG=y
>>  CONFIG_IKCONFIG_PROC=y
>>  CONFIG_CGROUPS=y
>> @@ -13,12 +14,14 @@ CONFIG_USER_NS=y
>>  CONFIG_CHECKPOINT_RESTORE=y
>>  CONFIG_BLK_DEV_INITRD=y
>>  CONFIG_EXPERT=y
>> -CONFIG_BPF_SYSCALL=y
>> +# CONFIG_SYSFS_SYSCALL is not set
>> +CONFIG_SOC_MICROCHIP_POLARFIRE=y
>>  CONFIG_SOC_SIFIVE=y
>>  CONFIG_SOC_VIRT=y
>> -CONFIG_SOC_MICROCHIP_POLARFIRE=y
>>  CONFIG_SMP=y
>>  CONFIG_HOTPLUG_CPU=y
>> +CONFIG_VIRTUALIZATION=y
>> +CONFIG_KVM=m
>>  CONFIG_JUMP_LABEL=y
>>  CONFIG_MODULES=y
>>  CONFIG_MODULE_UNLOAD=y
>> @@ -68,14 +71,12 @@ CONFIG_HW_RANDOM=y
>>  CONFIG_HW_RANDOM_VIRTIO=y
>>  CONFIG_SPI=y
>>  CONFIG_SPI_SIFIVE=y
>> +# CONFIG_PTP_1588_CLOCK is not set
>>  CONFIG_GPIOLIB=y
>>  CONFIG_GPIO_SIFIVE=y
>> -# CONFIG_PTP_1588_CLOCK is not set
>> -CONFIG_POWER_RESET=y
>>  CONFIG_DRM=y
>>  CONFIG_DRM_RADEON=y
>>  CONFIG_DRM_VIRTIO_GPU=y
>> -CONFIG_FRAMEBUFFER_CONSOLE=y
>>  CONFIG_USB=y
>>  CONFIG_USB_XHCI_HCD=y
>>  CONFIG_USB_XHCI_PLATFORM=y
>> @@ -85,10 +86,10 @@ CONFIG_USB_OHCI_HCD=y
>>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>>  CONFIG_USB_STORAGE=y
>>  CONFIG_USB_UAS=y
>> +CONFIG_MMC=y
>>  CONFIG_MMC_SDHCI=y
>>  CONFIG_MMC_SDHCI_PLTFM=y
>>  CONFIG_MMC_SDHCI_CADENCE=y
>> -CONFIG_MMC=y
>>  CONFIG_MMC_SPI=y
>>  CONFIG_RTC_CLASS=y
>>  CONFIG_VIRTIO_PCI=y
>> @@ -139,5 +140,3 @@ CONFIG_RCU_EQS_DEBUG=y
>>  # CONFIG_FTRACE is not set
>>  # CONFIG_RUNTIME_TESTING_MENU is not set
>>  CONFIG_MEMTEST=y
>> -# CONFIG_SYSFS_SYSCALL is not set
>> -CONFIG_EFI=y
>> diff --git a/arch/riscv/configs/rv32_defconfig 
>> b/arch/riscv/configs/rv32_defconfig
>> index 434ef5b64599..44022e048efd 100644
>> --- a/arch/riscv/configs/rv32_defconfig
>> +++ b/arch/riscv/configs/rv32_defconfig
>> @@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
>>  CONFIG_POSIX_MQUEUE=y
>>  CONFIG_NO_HZ_IDLE=y
>>  CONFIG_HIGH_RES_TIMERS=y
>> +CONFIG_BPF_SYSCALL=y
>>  CONFIG_IKCONFIG=y
>>  CONFIG_IKCONFIG_PROC=y
>>  CONFIG_CGROUPS=y
>> @@ -13,12 +14,14 @@ CONFIG_USER_NS=y
>>  CONFIG_CHECKPOINT_RESTORE=y
>>  CONFIG_BLK_DEV_INITRD=y
>>  CONFIG_EXPERT=y
>> -CONFIG_BPF_SYSCALL=y
>> +# CONFIG_SYSFS_SYSCALL is not set
>>  CONFIG_SOC_SIFIVE=y
>>  CONFIG_SOC_VIRT=y
>>  CONFIG_ARCH_RV32I=y
>>  CONFIG_SMP=y
>>  CONFIG_HOTPLUG_CPU=y
>> +CONFIG_VIRTUALIZATION=y
>> +CONFIG_KVM=m
>>  CONFIG_JUMP_LABEL=y
>>  CONFIG_MODULES=y
>>  CONFIG_MODULE_UNLOAD=y
>> @@ -67,11 +70,9 @@ CONFIG_HW_RANDOM_VIRTIO=y
>>  CONFIG_SPI=y
>>  CONFIG_SPI_SIFIVE=y
>>  # CONFIG_PTP_1588_CLOCK is not set
>> -CONFIG_POWER_RESET=y
>>  CONFIG_DRM=y
>>  CONFIG_DRM_RADEON=y
>>  CONFIG_DRM_VIRTIO_GPU=y
>> -CONFIG_FRAMEBUFFER_CONSOLE=y
>>  CONFIG_USB=y
>>  CONFIG_USB_XHCI_HCD=y
>>  CONFIG_USB_XHCI_PLATFORM=y
>> @@ -130,4 +131,3 @@ CONFIG_RCU_EQS_DEBUG=y
>>  # CONFIG_FTRACE is not set
>>  # CONFIG_RUNTIME_TESTING_MENU is not set
>>  CONFIG_MEMTEST=y
>> -# CONFIG_SYSFS_SYSCALL is not set

