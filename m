Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8381380CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhENPVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhENPVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:21:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:20:23 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso26674289otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUtJdEoTp2E5reOLxrwFg0FEHgUh9mJq9am3px70vxo=;
        b=ExnpX06y3XJ21mt9usdh2O3KZNtrIa6RUkQ9fHy94A4+viP5UjetMSS6qHA1EYo66k
         i3ygvXWEryAT4ug2cUz7O5I3cRN9h85yc1iA8P5WpI+TywttwjJp3dTbVi8ziigv3mmW
         RWYFEH9bVv8rraoGl0YqpfkswuWNysT0tqf8F+1IpVJy+ixAxk0vvyN4SZM4QCTF6tqX
         ZCXiPDZ4L4Av5adpYkwF6OktOOEZe6r85PFRplgCSAkJRlaDn9+73axA7LVTUrlM2q+k
         71YSAy7s63SKfNcb0NqTsSXlO8xqBdvfbip66DSOd+pc2EKVfr0iMSNC2mi38uzwiFl8
         eYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUtJdEoTp2E5reOLxrwFg0FEHgUh9mJq9am3px70vxo=;
        b=lDuWpB3qatsPVVth/9DpTl9oOV9VUJLXw7NIMplToLH7EUQKjAb7bVrfqFXQx7ickj
         b2xHEPr1YF1r+ClgJeAyExqJmxToZy7ZbmQWlgcrnXF/FW70OtYxOBfYCEck8m4jc1CH
         LdzhciTUZtUA2eYkhuJbh6YuWUtCKEX2vi+Mjtq0XVORLsV5XMtecClPPhpzIEZ8isV+
         gz9/i3o6cL9MPi1DpQmBtZL3O4/24SlAhzAsn6fypKe+/d6kfxWwyGXI3ENNAx73oaIW
         sU9eA05QfO1h6a06argjndOc2910flGC9VA/s4QTHarD2LS3K3G3O8L7Urs03uAjtXXh
         9nbQ==
X-Gm-Message-State: AOAM531vZ2eBK6Z8ZiFlDA72dQ9OWMR9lSS6sY9anMarx76mFEoxfVc4
        SzcYkYu/A2usDJ69drG5x7VaAIUGPL72GOcLM6vlEw==
X-Google-Smtp-Source: ABdhPJxH9nGYBL/yhdfH66VQoMarpQjIrk9WZmG+j9VyZb+D8KSGVokvDOkMdGxcy48nFWyZ3phTrOFS+w2Z1Vq1lcM=
X-Received: by 2002:a9d:7a54:: with SMTP id z20mr25363513otm.17.1621005622590;
 Fri, 14 May 2021 08:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210514034432.2004082-1-liushixin2@huawei.com>
In-Reply-To: <20210514034432.2004082-1-liushixin2@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 14 May 2021 17:20:10 +0200
Message-ID: <CANpmjNMN2xQ28nsqUzE+XJ_muHUT+EGdCTCDhvLH2hMMxuTidQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2] riscv: Enable KFENCE for riscv64
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 at 05:11, Liu Shixin <liushixin2@huawei.com> wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the riscv64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>.
>
> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the kfence pool to be mapped at
> page granularity.
>
> I tested this patch using the testcases in kfence_test.c and all passed.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Marco Elver <elver@google.com>


> ---
> v1->v2: Change kmalloc() to pte_alloc_one_kernel() for allocating pte.
>
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/kfence.h | 51 +++++++++++++++++++++++++++++++++
>  arch/riscv/mm/fault.c           | 11 ++++++-
>  3 files changed, 62 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/kfence.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c426e7d20907..000d8aba1030 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -64,6 +64,7 @@ config RISCV
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_KASAN if MMU && 64BIT
>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
> +       select HAVE_ARCH_KFENCE if MMU && 64BIT
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_KGDB_QXFER_PKT
>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
> new file mode 100644
> index 000000000000..c25d67e0b8ba
> --- /dev/null
> +++ b/arch/riscv/include/asm/kfence.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_RISCV_KFENCE_H
> +#define _ASM_RISCV_KFENCE_H
> +
> +#include <linux/kfence.h>
> +#include <linux/pfn.h>
> +#include <asm-generic/pgalloc.h>
> +#include <asm/pgtable.h>
> +
> +static inline bool arch_kfence_init_pool(void)
> +{
> +       int i;
> +       unsigned long addr;
> +       pte_t *pte;
> +       pmd_t *pmd;
> +
> +       for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
> +            addr += PAGE_SIZE) {
> +               pte = virt_to_kpte(addr);
> +               pmd = pmd_off_k(addr);
> +
> +               if (!pmd_leaf(*pmd) && pte_present(*pte))
> +                       continue;
> +
> +               pte = pte_alloc_one_kernel(&init_mm);
> +               for (i = 0; i < PTRS_PER_PTE; i++)
> +                       set_pte(pte + i, pfn_pte(PFN_DOWN(__pa((addr & PMD_MASK) + i * PAGE_SIZE)), PAGE_KERNEL));
> +
> +               set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(pte)), PAGE_TABLE));
> +               flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +       }
> +
> +       return true;
> +}
> +
> +static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +{
> +       pte_t *pte = virt_to_kpte(addr);
> +
> +       if (protect)
> +               set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> +       else
> +               set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
> +
> +       flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +
> +       return true;
> +}
> +
> +#endif /* _ASM_RISCV_KFENCE_H */
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 096463cc6fff..aa08dd2f8fae 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -14,6 +14,7 @@
>  #include <linux/signal.h>
>  #include <linux/uaccess.h>
>  #include <linux/kprobes.h>
> +#include <linux/kfence.h>
>
>  #include <asm/ptrace.h>
>  #include <asm/tlbflush.h>
> @@ -45,7 +46,15 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
>          * Oops. The kernel tried to access some bad page. We'll have to
>          * terminate things with extreme prejudice.
>          */
> -       msg = (addr < PAGE_SIZE) ? "NULL pointer dereference" : "paging request";
> +       if (addr < PAGE_SIZE)
> +               msg = "NULL pointer dereference";
> +       else {
> +               if (kfence_handle_page_fault(addr, regs->cause == EXC_STORE_PAGE_FAULT, regs))
> +                       return;
> +
> +               msg = "paging request";
> +       }
> +
>         die_kernel_fault(msg, addr, regs);
>  }
>
> --
> 2.18.0.huawei.25
>
