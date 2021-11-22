Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA428458AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbhKVJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhKVJHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:07:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5568D60E96
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637571855;
        bh=fXKN597XNbUtRH+hAGAQVfaZ5XTxTXHatuHrZG1Fg6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GnPuiTADp49D11R+t74RPLHbKuNm7IKKdElAttAZwhIF574/phI6ty8HdlDNl1486
         9ZiK7wVkszULwTeTHayPhVGal3DHFMnKhNFrLGAKsqXvlFTZUSQbkborx5Uvr5ZWvI
         22OCYfGONDdSOeQxsPOkIxDnIZeJhQHbHXaRgNG+XcDxOtq41mqcgDdTlCmWiiOSXd
         KI/mek4ANF38W2sViTbkfw6beaLmwChlVv2YhXwYDeGGNSn0parKHq/JzBkW5fQx+o
         M3PU8DOeqlnB+p+G3o5k4aKaEdTZDKfaF6cGUu35tRwOw9mYUOd9zD2ZK87kUGPyi9
         eADExBW0UJt8g==
Received: by mail-ot1-f47.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so27839078otg.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:04:15 -0800 (PST)
X-Gm-Message-State: AOAM533L69P5cyL3M/sMJ9zN52Yb02nakL/LmQwGik1imepvACTiyT1S
        F43eJcY4+J/tVGThxpCj+mhKnwSOt02WEFXy9Bs=
X-Google-Smtp-Source: ABdhPJyo5sPuzpswORjyfVfDrpryB081gsvDqCV46kCIcb+FjMoa4+pMo4KNvVcy8qDe4fG0VQMez6ORTECR/L2575k=
X-Received: by 2002:a9d:6c54:: with SMTP id g20mr23797554otq.30.1637571854589;
 Mon, 22 Nov 2021 01:04:14 -0800 (PST)
MIME-Version: 1.0
References: <1637558929-22971-1-git-send-email-huangzhaoyang@gmail.com>
 <CAMj1kXGvVkMtZrKYpr8SP8YSvUuWnyQ2i67riHBdQgfDy_0e1A@mail.gmail.com> <CAGWkznHA_y1YmjOFc9UnxtW_TN3PiCP2bbuqgn+-mz6LjSXFAQ@mail.gmail.com>
In-Reply-To: <CAGWkznHA_y1YmjOFc9UnxtW_TN3PiCP2bbuqgn+-mz6LjSXFAQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 Nov 2021 10:04:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGzz8HsDs0zsMVGC3Jb3aT9vs9fHGHJzFS1mM0ZhpK1Jw@mail.gmail.com>
Message-ID: <CAMj1kXGzz8HsDs0zsMVGC3Jb3aT9vs9fHGHJzFS1mM0ZhpK1Jw@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: arm64: introduce RODATA_FULL_USE_PTE_CONT
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
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

On Mon, 22 Nov 2021 at 10:00, Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Mon, Nov 22, 2021 at 4:52 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 22 Nov 2021 at 06:29, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> > >
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Kernel linear mapping will be split to the smallest granularity when
> > > RODATA_FULL applied, which could lead to TLB pressure. Introduce a method
> > > to apply PTE_CONT on pte.
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > How would this lead to TLB pressure, and how does the use of
> > contiguous mappings mitigate that? The linear mapping of the kernel is
> > rarely used, as all normal accesses to it go via the vmalloc region,
> > so in which case would TLB entries be allocated for this region in a
> > way that could cause a measurable performance impact?
> In fact, the patch is about to use PTE_CONT *OUT OF* the range of
> kernel text.

OK, I had missed that, apologies.

> Would you please have a look at the code. It apply
> PTE_CONT during map_mem and then clear it when load_module change the
> corresponding linear mapping to the area it use in vmalloc area.

You cannot change the PTE_CONT attribute on live mappings.

> >
> >
> > > ---
> > >  arch/arm64/Kconfig       |  9 +++++++++
> > >  arch/arm64/mm/mmu.c      | 10 ++++++++--
> > >  arch/arm64/mm/pageattr.c |  9 +++++++++
> > >  3 files changed, 26 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index fee914c..3f8fbf0 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -1198,6 +1198,15 @@ config RODATA_FULL_DEFAULT_ENABLED
> > >           This requires the linear region to be mapped down to pages,
> > >           which may adversely affect performance in some cases.
> > >
> > > +config RODATA_FULL_USE_PTE_CONT
> > > +       bool "Apply PTE_CONT when RODATA_FULL_DEFAULT_ENABLED enabled"
> > > +       depends on RODATA_FULL_DEFAULT_ENABLED
> > > +       default y
> > > +       help
> > > +         Apply PTE_CONT on linear mapping as much as we can when
> > > +         RODATA_FULL_DEFAULT_ENABLED enabled which could decrease the
> > > +         impaction on performance by small pte granularity.
> > > +
> > >  config ARM64_SW_TTBR0_PAN
> > >         bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
> > >         help
> > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > index cfd9deb..8017b17 100644
> > > --- a/arch/arm64/mm/mmu.c
> > > +++ b/arch/arm64/mm/mmu.c
> > > @@ -124,15 +124,21 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
> > >          * The following mapping attributes may be updated in live
> > >          * kernel mappings without the need for break-before-make.
> > >          */
> > > +#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
> > >         pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
> > > +#else
> > > +       pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG | PTE_CONT;
> > > +#endif

What justifies this change? Why is it ok in certain cases to update
the PTE_CONT attribute without BBM?

> > >
> > >         /* creating or taking down mappings is always safe */
> > >         if (old == 0 || new == 0)
> > >                 return true;
> > >
> > >         /* live contiguous mappings may not be manipulated at all */
> > > -       if ((old | new) & PTE_CONT)
> > > +#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
> > > +       if (old | new) & PTE_CONT)
> > >                 return false;
> > > +#endif
> > >
> > >         /* Transitioning from Non-Global to Global is unsafe */
> > >         if (old & ~new & PTE_NG)
> > > @@ -206,7 +212,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> > >
> > >                 /* use a contiguous mapping if the range is suitably aligned */
> > >                 if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> > > -                   (flags & NO_CONT_MAPPINGS) == 0)
> > > +                   (IS_ENABLED(CONFIG_RODATA_FULL_USE_PTE_CONT) || (flags & NO_CONT_MAPPINGS) == 0))
> > >                         __prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> > >
> > >                 init_pte(pmdp, addr, next, phys, __prot);
> > > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > > index a3bacd7..88a87eb 100644
> > > --- a/arch/arm64/mm/pageattr.c
> > > +++ b/arch/arm64/mm/pageattr.c
> > > @@ -99,6 +99,15 @@ static int change_memory_common(unsigned long addr, int numpages,
> > >         if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
> > >                             pgprot_val(clear_mask) == PTE_RDONLY)) {
> > >                 for (i = 0; i < area->nr_pages; i++) {
> > > +#ifdef CONFIG_RODATA_FULL_USE_PTE_CONT
> > > +                       unsigned long cont_pte_low_bound;
> > > +                       unsigned long addr;
> > > +
> > > +                       addr = (u64)page_address(area->pages[i]);
> > > +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> > > +                       __change_memory_common(cont_pte_low_bound,
> > > +                                              (~CONT_PTE_MASK + 1), __pgprot(0) , __pgprot(PTE_CONT));
> > > +#endif
> > >                         __change_memory_common((u64)page_address(area->pages[i]),
> > >                                                PAGE_SIZE, set_mask, clear_mask);
> > >                 }
> > > --
> > > 1.9.1
> > >
