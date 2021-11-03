Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2C4445D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhKCQZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhKCQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:25:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD54C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 09:22:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id ay20so2824701qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZPnOZF+hdJcYh9xZcdMkg788n+bV531uGLxTiw/5VE=;
        b=JqfEzbMmLVnAmQt8YW4PVvYxnfJUV8Cai7M2D4ZspxHxm1lmtt6uK3zATdc0OYPLM4
         2X19d2x4Ciuy1Dy/7vX456LcaGbJorR33cCf6HwCiQnw45OJCdRUOApWwKzv/5j4EQiE
         DNms+/gc0q8di8+bjhEePgjaNGQIvDnUAJuH7vJkbzZGiuHK0AbQNL1dIygvy64s2WWL
         +UYPQRAoZIWKeGkr4/FSLXM/Td2PA5mOSC8pyZtFNlraZNLh/NXraOPhGqaIwzKOPAFF
         5x/fIQoTU04MU0rfkSHgs8KyzsRLX6295Vukm+I5a8T9NPJ0xLKh9o6rxNQJA7YPH8Me
         8GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZPnOZF+hdJcYh9xZcdMkg788n+bV531uGLxTiw/5VE=;
        b=vOSSISmXjpRXgeSXKxxb7T7l2q3otq9pT6BeAve/Ku76cwbeYxI0PaDz2FkoL+Scnr
         NtlbpBCR1ILvZpmiN+Dec/GvJtc6GxQ6BpHCEOovXpGro1NNCJVHKP5gG7ts6yfbGOKr
         uMEgYU7EbMrBVQPFUmU+JQpaVU9cTrBTWFoX6lRFh9soAUqMwVuOmS8JW6MvTRX/+dxU
         aGJAay7tJhR3PNMDt9CjUBbPrduEdhXbGU7IiQYpyCDMkMtNHNfqVO5KC4hO88u5oPde
         J3gWU6JTVZIzQrG9AmAOLO5EuNHvReJ40dCFeNQmK2tg7YQbq/aK9W1bSZOrXBbEQcuX
         Nrqw==
X-Gm-Message-State: AOAM532Fw2USqxNcAOAKNX7UbRLZCVmGaHWwdF/b6bn/FfH0yyARKL+2
        KdMj+FXi/9AnezfZnZTonCPNeroswjSAcVvxQBbqvQ==
X-Google-Smtp-Source: ABdhPJx5lZogQ87N5gUovjxqWuQ3+NeVYuBkiZ1/0K4JNJhkFtmnPWn52A5kQ4fSucuhKO7quYGf8NBef2OVCYseSWc=
X-Received: by 2002:a05:620a:460e:: with SMTP id br14mr18034981qkb.16.1635956566938;
 Wed, 03 Nov 2021 09:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211103133845.78528-1-wangkefeng.wang@huawei.com> <20211103133845.78528-4-wangkefeng.wang@huawei.com>
In-Reply-To: <20211103133845.78528-4-wangkefeng.wang@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Nov 2021 17:22:10 +0100
Message-ID: <CAG_fn=WT9DzGmXrw97AhgCnyREQaACcgHg-3i62D-qNhUZ0xzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: Support KFENCE for ARM
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 2:26 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Add architecture specific implementation details for KFENCE and enable
> KFENCE on ARM. In particular, this implements the required interface in
>  <asm/kfence.h>.
>
> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the kfence pool to be mapped
> at page granularity.
>
> Testing this patch using the testcases in kfence_test.c and all passed
> with or without ARM_LPAE.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm/Kconfig              |  1 +
>  arch/arm/include/asm/kfence.h | 53 +++++++++++++++++++++++++++++++++++
>  arch/arm/mm/fault.c           | 19 ++++++++-----
>  3 files changed, 66 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/include/asm/kfence.h
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b9f72337224c..6d1f6f48995c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -69,6 +69,7 @@ config ARM
>         select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
>         select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> +       select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
>         select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>         select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> diff --git a/arch/arm/include/asm/kfence.h b/arch/arm/include/asm/kfence.h
> new file mode 100644
> index 000000000000..7980d0f2271f
> --- /dev/null
> +++ b/arch/arm/include/asm/kfence.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_ARM_KFENCE_H
> +#define __ASM_ARM_KFENCE_H
> +
> +#include <linux/kfence.h>
> +
> +#include <asm/pgalloc.h>
> +#include <asm/set_memory.h>
> +
> +static inline int split_pmd_page(pmd_t *pmd, unsigned long addr)
> +{
> +       int i;
> +       unsigned long pfn = PFN_DOWN(__pa(addr));
> +       pte_t *pte = pte_alloc_one_kernel(&init_mm);
> +
> +       if (!pte)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < PTRS_PER_PTE; i++)
> +               set_pte_ext(pte + i, pfn_pte(pfn + i, PAGE_KERNEL), 0);
> +       pmd_populate_kernel(&init_mm, pmd, pte);
> +
> +       flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +       return 0;
> +}
> +
> +static inline bool arch_kfence_init_pool(void)
> +{
> +       unsigned long addr;
> +       pmd_t *pmd;
> +
> +       for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
> +            addr += PAGE_SIZE) {
> +               pmd = pmd_off_k(addr);
> +
> +               if (pmd_leaf(*pmd)) {
> +                       if (split_pmd_page(pmd, addr & PMD_MASK))
> +                               return false;
> +               }
> +       }
> +
> +       return true;
> +}
> +
> +static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +{
> +       set_memory_valid(addr, 1, !protect);
> +
> +       return true;
> +}
> +
> +#endif /* __ASM_ARM_KFENCE_H */
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index f7ab6dabe89f..49148b675b43 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/debug.h>
>  #include <linux/highmem.h>
>  #include <linux/perf_event.h>
> +#include <linux/kfence.h>
>
>  #include <asm/system_misc.h>
>  #include <asm/system_info.h>
> @@ -99,6 +100,11 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
>  { }
>  #endif                                 /* CONFIG_MMU */
>
> +static inline bool is_write_fault(unsigned int fsr)
> +{
> +       return (fsr & FSR_WRITE) && !(fsr & FSR_CM);
> +}

Please don't increase the diff by moving the code around. Consider
putting is_write_fault() in the right place in "ARM: mm: Provide
is_write_fault()" instead.
