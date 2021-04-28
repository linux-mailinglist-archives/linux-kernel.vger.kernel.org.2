Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7936D0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 05:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhD1Dlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 23:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhD1Dlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 23:41:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7BFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:41:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n4-20020a05600c4f84b029013151278decso7883422wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unJ/nW7IwIPU8FuEPxu2WTBi2sq/u62GKZm9+1iXWxg=;
        b=QZH1yvadssNTkCLMPr/YyOHxUqvnHGZdJCeQ0QG07wZ0c8v0Tq0mdqoauuoTNo8c5t
         52FJF+EF5/YcdSBwaM+q6wczSHVyrqMzy7KO8c6WMEyJ5VU2ugjm8CcPR2jttv1T/2O6
         OQX7EngW1Kd701aUoIHwM9CM6zKwoGh0O7QqHeOzcDnsSBDAxguVsEwXzdNPa965DUQx
         uNdKG3sM+V3YHeIQciUPGRNi+aEFtzAjLBmOvqJwb43mMmKtUGURK7e1fhZdAufBrwdf
         9VRI74ZT2q5ZsWsHB9vphithqi77n7VEtA8rNG3EUPgub2WbkFATcl1aDrnfbtmPUPpO
         g+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unJ/nW7IwIPU8FuEPxu2WTBi2sq/u62GKZm9+1iXWxg=;
        b=PcLjwTPovO5VQ9mqy6PDrnzKmeroUnCfX2sNHZk7QZiE6OYLqGDnuGSrYJ2ZbW8Rv4
         21FEcOQQlQGNDCHNqgfDMhi5nLbGhBhSwqreV6iiRnrOKNfgKk0j7LmW13sYjpDFVtcS
         S96I9kDn0oI9etAfSpqe5ma2sfCYGKGRu0ul5STniQzkZdiV9UnPxeU6m8D0+YDLuyUt
         2ohzqSElI50HN5IAg4PQ1s2s+/Krst2anL0ETqym5H4pSoBQOsRHvtaynGeqneyn2psu
         lSmcij2vdq34K2QkM2qMS0O0lMPIAIgwX6uqtEITXB0IMyGOMiVzDVtVnn/rSWWAnsc6
         H/2w==
X-Gm-Message-State: AOAM5300Up4jyg2GC3iTNI4Qc3Es0GIwCd6oUbb0H4FiXd7hk+1TbljC
        xDhqA+GL4sUqzpqBYNmm0FAGZ3yRPb7uriRy1VLrEQ==
X-Google-Smtp-Source: ABdhPJzI3LHtQ4OsT4z7dItzbxcMlwFjrS5Ewft66N9Bnj+ahbwhYUYdFV/mrMnOfwdZlsG+w0ppsAHoZ3+66SZ6bpk=
X-Received: by 2002:a7b:c348:: with SMTP id l8mr1765461wmj.152.1619581262305;
 Tue, 27 Apr 2021 20:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210428033415.107756-1-palmer@dabbelt.com>
In-Reply-To: <20210428033415.107756-1-palmer@dabbelt.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 28 Apr 2021 09:10:51 +0530
Message-ID: <CAAhSdy3Qnx+3tCecXLDw=1m45zMU67n3K4_YTYA2127mZm+Kfg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Always define XIP_FIXUP
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Greentime Hu <greentime.hu@sifive.com>, 0x7f454c46@gmail.com,
        chenhuang5@huawei.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 9:05 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> XIP depends on MMU, but XIP_FIXUP is defined throughout the kernel in
> order to avoid excessive ifdefs.  This just makes sure to always define
> XIP_FIXIP, which will fix MMU=n builds.
>
> Fixes: 44c922572952 ("RISC-V: enable XIP")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/pgtable.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 2f1384e14e31..fd749351f432 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -73,18 +73,6 @@
>  #endif
>  #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>
> -#ifdef CONFIG_XIP_KERNEL
> -#define XIP_OFFSET             SZ_8M
> -#define XIP_FIXUP(addr) ({                                                     \
> -       uintptr_t __a = (uintptr_t)(addr);                                      \
> -       (__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?  \
> -               __a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
> -               __a;                                                            \
> -       })
> -#else
> -#define XIP_FIXUP(addr)                (addr)
> -#endif /* CONFIG_XIP_KERNEL */
> -
>  #endif
>
>  #ifndef __ASSEMBLY__
> @@ -101,6 +89,18 @@
>  #include <asm/pgtable-32.h>
>  #endif /* CONFIG_64BIT */
>
> +#ifdef CONFIG_XIP_KERNEL
> +#define XIP_OFFSET             SZ_8M
> +#define XIP_FIXUP(addr) ({                                                     \
> +       uintptr_t __a = (uintptr_t)(addr);                                      \
> +       (__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?  \
> +               __a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
> +               __a;                                                            \
> +       })
> +#else
> +#define XIP_FIXUP(addr)                (addr)
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  #ifdef CONFIG_MMU
>  /* Number of entries in the page global directory */
>  #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
