Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E947458AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbhKVIz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:55:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238930AbhKVIz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:55:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D989660F94
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637571139;
        bh=TT5Q1dHF8A9fdDRbtVqMw5X4w8flak1ZydSpvK2LRC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TUAc8UEjX+xSvkjnw6dvl2orDbyRe+FnqY5Hf1yTifmF1ZJ264/9bs12JOJiyG7mQ
         krK6wvjsMq70futQ2PiAtpYa9hsobec+DBvjlfAvp3FbtVBmgu224AK3XTRLY+aRfE
         AMussHhu+kehGf14YkV94DKLaNFHEaVWg7y0aIbEU+X3cjsS9hzzbPeafqXgHqwR1d
         1VjYdEYM1vmykQLKZyBrmzqtZxNfJlDj8GkDm66YpZf1Lj+O/5Z011oIyAtcXyMeTP
         sV78F6ZOZV1s1s/1HLJwkv4urZ8K/YlSQj0YmRysEIcfNGTaXxpBUxLHDNbQk9jz1A
         ALZTA44wwXtkA==
Received: by mail-ot1-f51.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso27812707otj.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 00:52:19 -0800 (PST)
X-Gm-Message-State: AOAM531dBsMj+0a61N/O6OqMIQ5qE7Mx4uvMbbfLqdh0FeIIp/Z85i9h
        KvHOicP9qSD7ZwcDSDk8h47k6K+ayQKttMljQnM=
X-Google-Smtp-Source: ABdhPJyKKlGQlXs5EgDWsBpOUnw4dWmAxDymGMze7dmR42Z3AZSEMIhL1C/dmFAsFOXi6VBU/afbBi2SzwiFnQ/fVMI=
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr22244429otp.147.1637571139101;
 Mon, 22 Nov 2021 00:52:19 -0800 (PST)
MIME-Version: 1.0
References: <1637558929-22971-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1637558929-22971-1-git-send-email-huangzhaoyang@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 Nov 2021 09:52:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGvVkMtZrKYpr8SP8YSvUuWnyQ2i67riHBdQgfDy_0e1A@mail.gmail.com>
Message-ID: <CAMj1kXGvVkMtZrKYpr8SP8YSvUuWnyQ2i67riHBdQgfDy_0e1A@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: arm64: introduce RODATA_FULL_USE_PTE_CONT
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 at 06:29, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Kernel linear mapping will be split to the smallest granularity when
> RODATA_FULL applied, which could lead to TLB pressure. Introduce a method
> to apply PTE_CONT on pte.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

How would this lead to TLB pressure, and how does the use of
contiguous mappings mitigate that? The linear mapping of the kernel is
rarely used, as all normal accesses to it go via the vmalloc region,
so in which case would TLB entries be allocated for this region in a
way that could cause a measurable performance impact?


> ---
>  arch/arm64/Kconfig       |  9 +++++++++
>  arch/arm64/mm/mmu.c      | 10 ++++++++--
>  arch/arm64/mm/pageattr.c |  9 +++++++++
>  3 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fee914c..3f8fbf0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1198,6 +1198,15 @@ config RODATA_FULL_DEFAULT_ENABLED
>           This requires the linear region to be mapped down to pages,
>           which may adversely affect performance in some cases.
>
> +config RODATA_FULL_USE_PTE_CONT
> +       bool "Apply PTE_CONT when RODATA_FULL_DEFAULT_ENABLED enabled"
> +       depends on RODATA_FULL_DEFAULT_ENABLED
> +       default y
> +       help
> +         Apply PTE_CONT on linear mapping as much as we can when
> +         RODATA_FULL_DEFAULT_ENABLED enabled which could decrease the
> +         impaction on performance by small pte granularity.
> +
>  config ARM64_SW_TTBR0_PAN
>         bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
>         help
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cfd9deb..8017b17 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -124,15 +124,21 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>          * The following mapping attributes may be updated in live
>          * kernel mappings without the need for break-before-make.
>          */
> +#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
>         pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
> +#else
> +       pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG | PTE_CONT;
> +#endif
>
>         /* creating or taking down mappings is always safe */
>         if (old == 0 || new == 0)
>                 return true;
>
>         /* live contiguous mappings may not be manipulated at all */
> -       if ((old | new) & PTE_CONT)
> +#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
> +       if (old | new) & PTE_CONT)
>                 return false;
> +#endif
>
>         /* Transitioning from Non-Global to Global is unsafe */
>         if (old & ~new & PTE_NG)
> @@ -206,7 +212,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>
>                 /* use a contiguous mapping if the range is suitably aligned */
>                 if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> -                   (flags & NO_CONT_MAPPINGS) == 0)
> +                   (IS_ENABLED(CONFIG_RODATA_FULL_USE_PTE_CONT) || (flags & NO_CONT_MAPPINGS) == 0))
>                         __prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>
>                 init_pte(pmdp, addr, next, phys, __prot);
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index a3bacd7..88a87eb 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -99,6 +99,15 @@ static int change_memory_common(unsigned long addr, int numpages,
>         if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>                             pgprot_val(clear_mask) == PTE_RDONLY)) {
>                 for (i = 0; i < area->nr_pages; i++) {
> +#ifdef CONFIG_RODATA_FULL_USE_PTE_CONT
> +                       unsigned long cont_pte_low_bound;
> +                       unsigned long addr;
> +
> +                       addr = (u64)page_address(area->pages[i]);
> +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> +                       __change_memory_common(cont_pte_low_bound,
> +                                              (~CONT_PTE_MASK + 1), __pgprot(0) , __pgprot(PTE_CONT));
> +#endif
>                         __change_memory_common((u64)page_address(area->pages[i]),
>                                                PAGE_SIZE, set_mask, clear_mask);
>                 }
> --
> 1.9.1
>
