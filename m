Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4773A3770AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhEHIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 04:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 04:31:10 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C81AC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 01:30:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so3696974oth.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHWD9J6ofLEJEBPQ1owqvKysj/6TUwLubW0zYntQWn4=;
        b=dZdBMLYgAigD1CqNxf6YBFHDAPSBKHRMkHGbzd3aLFVUccCVbaX2zvdoOIGP3gH4sQ
         Ua9OJC0czYfg/l4IvsLCzHBdz681/Vpe/4Ww2cVSjrSPv84/152BRCkcmbJZQeijqg+Q
         csm9TUMgBZ3IxQgHZkRP1buVQAdlmX2ARVeyiwbg8wIRHbS4L2WG0TUjU/7xSIb9u18t
         viwUnlZfEVTj/m2VEWC19lqt0BjhOaFif6xNuR0E2yub//sjCd0Z9ZCljcGBVcacSg1j
         ix9EVtmEtY0JBPinRwJOiL8WeBtMZZH+y9+3DcTuAe+cPMiY4iiohsnBgR1q4O3wtEsT
         9+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHWD9J6ofLEJEBPQ1owqvKysj/6TUwLubW0zYntQWn4=;
        b=Pj6pujhM8fvg6y+MURvvnPZKGyXazhlBkJa8m7XWglhkGhDjdKJOvghMZdoZJyXnp/
         WluitcC4dujr7Wh4EPRHyb4Mp3EyfL9RGl6RZwvev64zaw0WAV84SZLLofjmlc3Id5yz
         2GZuDZQH1C50Sb42IgKt/bCGv4z2cYYiGAm0yQBo0pTBNaJEC4MxgUhLN92Oua15YiOk
         KlsFqZKYfizUKbudPIoHpV+FZphLrvAuWplsxjze63xPnAMSvlHSt69AvSChrEWBGeHi
         tZ0veVYV7LpBHVwZNoaaPcVH0b+Mu0Bgst7JrhdqbkUzHEwtwFZP2V+t2QgbSHVIGU5d
         JWtA==
X-Gm-Message-State: AOAM530Dn4F9hVKni1pGZzzdfP58B39+RWs9johtzAFO74+v/onUO1xZ
        8yRI8feeZZzm2TMOgwAv0h1PhgfbPHJlFHMXiLUhCQ==
X-Google-Smtp-Source: ABdhPJw9n+5UK5135MXj2DGo1mIATAjRHZ9GUm5rP6s1FqJ+mCaL9iDvQgZHtcre2zC7F2ebShO4XavGUaTcY6Rofys=
X-Received: by 2002:a9d:1ea9:: with SMTP id n38mr12276751otn.233.1620462608813;
 Sat, 08 May 2021 01:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210508032912.2693212-1-liushixin2@huawei.com>
In-Reply-To: <20210508032912.2693212-1-liushixin2@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 8 May 2021 10:29:56 +0200
Message-ID: <CANpmjNP_ybX6eK=AqGNCBfVSLtOxzihQpNGL95s8itOS=eCdfQ@mail.gmail.com>
Subject: Re: [RFC] riscv: Enable KFENCE for riscv64
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

On Sat, 8 May 2021 at 04:56, Liu Shixin <liushixin2@huawei.com> wrote:
>
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the riscv64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>.

Nice to see KFENCE on more architectures.

> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the kfence pool to be mapped at
> page granularity.
>
> I tested this patch using the testcases in kfence_test.c and all passed.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
[...]
> diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
> new file mode 100644
> index 000000000000..590c5b7e3514
> --- /dev/null
> +++ b/arch/riscv/include/asm/kfence.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_RISCV_KFENCE_H
> +#define _ASM_RISCV_KFENCE_H
> +
> +#include <linux/pfn.h>
> +#include <linux/slab.h>
> +#include <linux/kfence.h>
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
> +               pte = kmalloc(PAGE_SIZE, GFP_ATOMIC);

Using kmalloc() to allocate pte looks weird. Does riscv have helpers
for allocating pte? Otherwise, __get_free_page() perhaps?

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
[...]
