Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C502F457B05
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhKTEH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbhKTEHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:07:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:04:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t30so21424228wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wiAofShoflFRKsOulYdKPfpTNOMSTtibqGr9qj/HKf8=;
        b=qYseHheU1ajfn0MXG0G6P7Eim3CJLt/vMnbfK4soLkBEIsyYSnF09fVZFFO3h14RVl
         SbHhA5PbWdIEAu4JB0eoKFd44F+L65+9m2nzmrgkcQ9kBJVeY0XjHM65h+t2Zz03aiWD
         8X114ZVR83Q/Az0VbLRd+k/scChulSG5smRHi51ekJAloZyDWe1ZjrPwkK6SOIBeTXOU
         EVbItPI7kCKD7N5ZBIBTEJPvppbvsx4m9G/AX+f++2o9MFVy3mY9SV8RDGW6jVeCGi0w
         iEvoP9yLU6quE8cXZ4SVghhSY+5PSLnBa0B3Dcd0tj29JuYSCHMYGStQ1iENYugVJjIQ
         nPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wiAofShoflFRKsOulYdKPfpTNOMSTtibqGr9qj/HKf8=;
        b=peBubMz4wzkxv8UQE0LS0wjdH9BMj9Ut2D8D3Nyk+turoxrmKO7Fduw75+1B7tRfc1
         gB1VL0mSgpUPb0fXlNH9CJJpSIUVAI4POa+FXn5RMKCQJYWDkvGHy8LLcYTZWEAAoVnt
         fre4RYbtCVcALgDA/1dj83cR7MEONNBVa7sSpa0UgaCKncfGY7QmmXuvVob6i/HLcXt4
         zMwxc5n6QS0c5lliC4QdM5bsude/VI/q0fjPSA1Nk+se09dAGG28W8RxEBja+ZXwIROo
         lic/7dcqxDfC9TBRzAp7SeHOlU9RUQ3xgJgK5jpkfDARrWWJkvDrtJj+wmlmjd9CiP0D
         J3oQ==
X-Gm-Message-State: AOAM532b2PR13TX0uR56h5uAOUILDMECUncZbwIexP29UGr2paVtM3J9
        57gTwnLoe++5+f3ceD/YiBzhYN47ZKjZ5y3ysaiDjg==
X-Google-Smtp-Source: ABdhPJyFfJrkGZNjGeUeF/l6fgipWtxjoJgXY6uHnnO2N/X1ozSiBmva0AE0wluGiGz+TA2EjxUnIAjANwKYCuRyfjQ=
X-Received: by 2002:a05:6000:1a45:: with SMTP id t5mr14114433wry.306.1637381053913;
 Fri, 19 Nov 2021 20:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-10-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-10-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:34:02 +0530
Message-ID: <CAAhSdy2ssiMAVhPvhTSmR2LtD_qBXENV_of0ytjsrmt7gV9Lxg@mail.gmail.com>
Subject: Re: [PATCH 09/12] RISC-V: defconfigs: Sort CONFIG_BLK_DEV_BSG
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Bin Meng <bin.meng@windriver.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>, axboe@kernel.dk,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:15 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This should have no functional change, it just sorts CONFIG_BLK_DEV_BSG
> the same way savedefconfig does.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
>  arch/riscv/configs/nommu_virt_defconfig        | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> index 690460f79925..84b87f8bfc8f 100644
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -30,7 +30,6 @@ CONFIG_CMDLINE_FORCE=y
>  # CONFIG_SECCOMP is not set
>  # CONFIG_STACKPROTECTOR is not set
>  # CONFIG_GCC_PLUGINS is not set
> -# CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_MQ_IOSCHED_DEADLINE is not set
>  # CONFIG_MQ_IOSCHED_KYBER is not set
>  CONFIG_BINFMT_FLAT=y
> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
> index e046a0babde4..385cca741b01 100644
> --- a/arch/riscv/configs/nommu_virt_defconfig
> +++ b/arch/riscv/configs/nommu_virt_defconfig
> @@ -32,7 +32,6 @@ CONFIG_SMP=y
>  CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
>  CONFIG_CMDLINE_FORCE=y
>  CONFIG_JUMP_LABEL=y
> -# CONFIG_BLK_DEV_BSG is not set
>  CONFIG_PARTITION_ADVANCED=y
>  # CONFIG_MSDOS_PARTITION is not set
>  # CONFIG_EFI_PARTITION is not set
> --
> 2.32.0
>
