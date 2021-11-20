Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA1457B0A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhKTELH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhKTELF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:11:05 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25613C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:08:03 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n29so21437979wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4ydXLmENcWqIX+Tlurw+hnOBKkomj9PPrQ5ZVgaUww=;
        b=zGxiXe93hdqAChtKAjR6w68ZB/NJH2v2WqscZef8UWGzXCwDcaid8rvU39O4RycozU
         PT3kpjB+NJL1C/cCbfMvnIqv/4GLo85TUu4eWjyPPoWTbGeaXBlYmOcHkzYLv5h3qT/A
         n4/qhNMzs1x+MGohfF0TyyuRJdfkT3aZ+C74fORUxJLRGzu4quCDM0nnzefTl6A2ub2W
         V1yDBYlT6FakvZleNo5ztgrIRS6yZHO1wMV3P989NT/Q7oP0mpDS/QvUnDXfjQAEUGgP
         C9vTS12S6GngnMY4dJl9ws1TchUveIYbjsxkKkGDgHa6CFhGJUiOnZZQwr5X1vIp7d3c
         wUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4ydXLmENcWqIX+Tlurw+hnOBKkomj9PPrQ5ZVgaUww=;
        b=dToKoDop23CoHYELnhdRRzxOuRSz+kTxgo71+XBTuOWt9MH7iJb/1whUkGALt2Y8cs
         O2NnT0JF9lrHSUYWtSmHW5e5l6Qkuxp94Zd2BGAgwLVvxV+aoGWT1+AFySl5PNxZAuN0
         blvyJaYibGXFz2gkSLVfJC+3sSTP54cV2gTYOssmx73usaAb1xIeT/8sZ29tU+7cvYxc
         OMT18ZSc9kJJCm2W4MJasmSeJR8kvAdUepzRyNTSm2nsbluzgqLUWROjAm696dxugvs2
         JShrqC+Fd6j77zjjYIHX+XD9TO9oIiVMZ7GNEm8H7kPygHQHaoMKBukGqgy/s8om8fvK
         WLQQ==
X-Gm-Message-State: AOAM531Bz+kMPvcHL8GjqsZsOWc8jMA3VIbbHkbn0+hKm/OER0j9JQdS
        w4CpYdilMPlAb1vhB5IvaSoi2oH9Y36tnDqJHkBOuuE3T8TZbw==
X-Google-Smtp-Source: ABdhPJwRiFtmtNChRRr+VVtCV80D8ZI1iEww8eLto+FUM2ylA1gIZdXZWWpnjBnLpz4b7NtJL1nKHnZYigdsm+rGlnc=
X-Received: by 2002:a5d:4846:: with SMTP id n6mr13686700wrs.249.1637381281578;
 Fri, 19 Nov 2021 20:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-13-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-13-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:37:50 +0530
Message-ID: <CAAhSdy0-KDtUM7Oot=FBdRtRbYGk8D1jxkH0XZ1iw237jnXUKA@mail.gmail.com>
Subject: Re: [PATCH 12/12] RISC-V: defconfigs: Remove redundant K210 DT source
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
> The "k210_generic" DT has been the default in Kconfig since 7d96729a9e7
> ("riscv: Update Canaan Kendryte K210 device tree"), so drop it from the
> defconfigs to avoid diff with savedefconfig.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/nommu_k210_defconfig        | 1 -
>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
> index 89ab76349ea8..e8ceab678e8b 100644
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -29,7 +29,6 @@ CONFIG_EMBEDDED=y
>  CONFIG_SLOB=y
>  # CONFIG_MMU is not set
>  CONFIG_SOC_CANAAN=y
> -CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
>  CONFIG_MAXPHYSMEM_2GB=y
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=2
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> index 84b87f8bfc8f..46aa3879f19c 100644
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -21,7 +21,6 @@ CONFIG_EMBEDDED=y
>  CONFIG_SLOB=y
>  # CONFIG_MMU is not set
>  CONFIG_SOC_CANAAN=y
> -CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
>  CONFIG_MAXPHYSMEM_2GB=y
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=2
> --
> 2.32.0
>
