Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B04B457AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhKTECD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbhKTECB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:02:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C48C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 19:58:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so8935854wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 19:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZYiApMduuSUSVo0a5ZI0oTWJ8xtKLdFelQTyemXbbQ=;
        b=5c6GORhf+WRLkc/gfr4y8e7I7nMGDHfnIYlS2jTIE8hbYuu7+jRGuXTpGHtjDS4aii
         O4vjrKpTO9e8YaO3rR/ezslgjA3pEoTswecPQOWSi4fMFVmREEon8nJJrJt31EqGAfZz
         SGZfMzbvui2C+03yudQ3ZhRqoi7C+9PqAFC2Asu6OrN7UYdyoBEncqC8iZ4qaCS836sm
         WBfWk5nDr0jUvCano/3mlwxu7fOksfi2aNi7lbql+r4xcVFBipz6yDWQLj3LSSrgcfH0
         C35zlAApYcaWCKS4xBN9bCpVyAJl0T9ZrV5eMhNXAq8adL5jHNhQjSKxYf4v7jiidzqF
         TPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZYiApMduuSUSVo0a5ZI0oTWJ8xtKLdFelQTyemXbbQ=;
        b=CzjG6pwujNHmgI18o2qVe/YUzWYazQD3LDAh62LZJbVnD2yyysVN3u60xraik23JzB
         2bAiZ2qc2r6TYkCLlbAegJqcBPtFBsmH6pZAzbjfbBPXcQuukDDdSJFGrUZva6zPrZiG
         uXnBGN9iXKZiGB9HTSUIMtvU78izlyrhV/LQpcKNqCRYAQAqGKXmTytKoHAbylQCTL21
         +lsImwq88WWU7rMAI/2YcPvh+KQ7tR32a0V7bJNap2DHHu7xagUV1eBFNrXrXDdK8bST
         a0MxDMTFK2yUxP0erMJ2fWCYLDJwALGOShwoUkGloNqNAeX0BsDgVSeT4+WDJGC6yDLc
         f3zg==
X-Gm-Message-State: AOAM530SjFX87qfXq1ZFND9aX7LEU2txAA8RRe/Hb/oSl6gnQAIMIR5R
        sMgz69V95jwt6uhi7GGXLJzxgu+TOz5+GpqzaeY/tdXfQlPEMA==
X-Google-Smtp-Source: ABdhPJyDN2ljnvSNv27TGYtAXhgwHlWULEDydkRR1sAalj1nRiTC2Oq+RxdD2dlTq1ZgCWiqzJ0zDASWV0+gp++akbQ=
X-Received: by 2002:a1c:20cc:: with SMTP id g195mr6455534wmg.137.1637380737029;
 Fri, 19 Nov 2021 19:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-5-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-5-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:28:45 +0530
Message-ID: <CAAhSdy1Yx0NzqCzyHeGfa_be+w0xZLMotp7n9+nq415_u+v_FA@mail.gmail.com>
Subject: Re: [PATCH 04/12] RISC-V: defconfigs: Sort CONFIG_SYSFS_SYSCALL
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atish.patra@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>, axboe@kernel.dk,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:15 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This should have no functional change, it just sorts
> CONFIG_SYSFS_SYSCALL the same way savedefconfig does.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/defconfig      | 2 +-
>  arch/riscv/configs/rv32_defconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index a6cb99cf4d3c..96c2a3615bcd 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -14,6 +14,7 @@ CONFIG_USER_NS=y
>  CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> +# CONFIG_SYSFS_SYSCALL is not set
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_SOC_MICROCHIP_POLARFIRE=y
> @@ -143,5 +144,4 @@ CONFIG_RCU_EQS_DEBUG=y
>  # CONFIG_FTRACE is not set
>  # CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_MEMTEST=y
> -# CONFIG_SYSFS_SYSCALL is not set
>  CONFIG_EFI=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 8a57c940d5ef..1f6808aa1261 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -14,6 +14,7 @@ CONFIG_USER_NS=y
>  CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> +# CONFIG_SYSFS_SYSCALL is not set
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y
> @@ -133,4 +134,3 @@ CONFIG_RCU_EQS_DEBUG=y
>  # CONFIG_FTRACE is not set
>  # CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_MEMTEST=y
> -# CONFIG_SYSFS_SYSCALL is not set
> --
> 2.32.0
>
