Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0BD458B35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbhKVJUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKVJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:20:54 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02810C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:17:48 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id n15so15958403qta.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNk9AvIUG3nSldGQQKqTpubI/KNmMnFk9sAVMdVoa/g=;
        b=lny072LuhQ0Lkgl+X0xJam5iiuyvUM5fb+hKco7V8b8WemAcrO32LeZd5jJPHrQP73
         PEnDr3Q3kx0qK6NdlxwmMKcRCOOBKh9koGjnRF+Q3W8E1hvtI2TJC75XBOQGulWhPjb3
         suBQWbYzhsqfTVZvn+fvkzGfYAnLkHn7ECUUn3NrCY8US66BPsuZ3kWFiRuBmxUcnSBp
         fooQzewalQDnSglrr4isIDwUzfvFjXilDaGIjfBHCslXtqNAzhM9Ugjgmy0MhqZgIASt
         0QomSYAFEe37njcGMlki0iTqtprIMKXoS8Dl38DcjHWpP0+5w86owbsuOThX0UZX0Jn3
         +CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNk9AvIUG3nSldGQQKqTpubI/KNmMnFk9sAVMdVoa/g=;
        b=rr2uPEooT9HT7GrFXk17Ga6538kHZknmIJNuGjOr9yuiDQbn5x4zDFlLbRG8rRXxgf
         uu9k4mVi8DWVy2orgV4z9Ky3brpQO5KrWMSiCZ/n1ThVwhnlem4R2kmEydUkGPkz6y1m
         MwsE8FVADsOB4ymwIFgtYxKqqJfaYh+j8zl5h8X70ZwqiCJc7hqKbJSQpIZhWRk/5IQM
         6YukCcJ3p3sBNDuyb1+uw94S2dbOUSwDG27E5JiScfolwh0udARNauu7RPT1xQkIFOa8
         hqzJpmxW4O4HJOhS8lwb3b+dgO+2jxkRYRGGdIYE0x4LnapMOT4awnpdcmIysjI8JqSY
         15KQ==
X-Gm-Message-State: AOAM533pIlSNqqki4P2yQoOH3PKR2myqi0vLjr6oQCa/ZTm3oZkNnDyZ
        mpQT3rYoTxjJTfU6t42gDwerYG761X/3KWYQwNgUapqtv62Qqg==
X-Google-Smtp-Source: ABdhPJy4nFBt+/aRd/2RXSe4ZodQ8MrQBuebeoTeJJkcdLrDSnkb9qdxCUqIcl0SdpS1c8E5VVbRiOLQ6lhAICFTlRA=
X-Received: by 2002:a05:622a:587:: with SMTP id c7mr29051151qtb.354.1637572667206;
 Mon, 22 Nov 2021 01:17:47 -0800 (PST)
MIME-Version: 1.0
References: <1637558929-22971-1-git-send-email-huangzhaoyang@gmail.com>
 <CAMj1kXGvVkMtZrKYpr8SP8YSvUuWnyQ2i67riHBdQgfDy_0e1A@mail.gmail.com>
 <CAGWkznHA_y1YmjOFc9UnxtW_TN3PiCP2bbuqgn+-mz6LjSXFAQ@mail.gmail.com> <CAMj1kXGzz8HsDs0zsMVGC3Jb3aT9vs9fHGHJzFS1mM0ZhpK1Jw@mail.gmail.com>
In-Reply-To: <CAMj1kXGzz8HsDs0zsMVGC3Jb3aT9vs9fHGHJzFS1mM0ZhpK1Jw@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 22 Nov 2021 17:17:26 +0800
Message-ID: <CAGWkznHK0pDQQOOg-zPnr42EB__X84MF0AHU=b8VL_yuhPOBbA@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: arm64: introduce RODATA_FULL_USE_PTE_CONT
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Mon, Nov 22, 2021 at 5:04 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 22 Nov 2021 at 10:00, Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Mon, Nov 22, 2021 at 4:52 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 22 Nov 2021 at 06:29, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> > > >
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Kernel linear mapping will be split to the smallest granularity when
> > > > RODATA_FULL applied, which could lead to TLB pressure. Introduce a method
> > > > to apply PTE_CONT on pte.
> > > >
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > How would this lead to TLB pressure, and how does the use of
> > > contiguous mappings mitigate that? The linear mapping of the kernel is
> > > rarely used, as all normal accesses to it go via the vmalloc region,
> > > so in which case would TLB entries be allocated for this region in a
> > > way that could cause a measurable performance impact?
> > In fact, the patch is about to use PTE_CONT *OUT OF* the range of
> > kernel text.
>
> OK, I had missed that, apologies.
>
> > Would you please have a look at the code. It apply
> > PTE_CONT during map_mem and then clear it when load_module change the
> > corresponding linear mapping to the area it use in vmalloc area.
>
> You cannot change the PTE_CONT attribute on live mappings.
Is it an inner constraint from ASIC perspective? PTE_CONT is different
to other attributes?
>
> > >
> > >
> > > > ---
> > > >  arch/arm64/Kconfig       |  9 +++++++++
> > > >  arch/arm64/mm/mmu.c      | 10 ++++++++--
> > > >  arch/arm64/mm/pageattr.c |  9 +++++++++
> > > >  3 files changed, 26 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index fee914c..3f8fbf0 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -1198,6 +1198,15 @@ config RODATA_FULL_DEFAULT_ENABLED
> > > >           This requires the linear region to be mapped down to pages,
> > > >           which may adversely affect performance in some cases.
> > > >
> > > > +config RODATA_FULL_USE_PTE_CONT
> > > > +       bool "Apply PTE_CONT when RODATA_FULL_DEFAULT_ENABLED enabled"
> > > > +       depends on RODATA_FULL_DEFAULT_ENABLED
> > > > +       default y
> > > > +       help
> > > > +         Apply PTE_CONT on linear mapping as much as we can when
> > > > +         RODATA_FULL_DEFAULT_ENABLED enabled which could decrease the
> > > > +         impaction on performance by small pte granularity.
> > > > +
> > > >  config ARM64_SW_TTBR0_PAN
> > > >         bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
> > > >         help
> > > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > > index cfd9deb..8017b17 100644
> > > > --- a/arch/arm64/mm/mmu.c
> > > > +++ b/arch/arm64/mm/mmu.c
> > > > @@ -124,15 +124,21 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
> > > >          * The following mapping attributes may be updated in live
> > > >          * kernel mappings without the need for break-before-make.
> > > >          */
> > > > +#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
> > > >         pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
> > > > +#else
> > > > +       pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG | PTE_CONT;
> > > > +#endif
>
> What justifies this change? Why is it ok in certain cases to update
> the PTE_CONT attribute without BBM?
BBM?
I am not sure if it is ok here, but I just find nobody else change
PTE_CONT so far other than this commit.
>
> > > >
> > > >         /* creating or taking down mappings is always safe */
> > > >         if (old == 0 || new == 0)
> > > >                 return true;
> > > >
> > > >         /* live contiguous mappings may not be manipulated at all */
> > > > -       if ((old | new) & PTE_CONT)
> > > > +#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
> > > > +       if ((old | new) & PTE_CONT)
> > > >                 return false;
> > > > +#endif
> > > >
> > > >         /* Transitioning from Non-Global to Global is unsafe */
> > > >         if (old & ~new & PTE_NG)
> > > > @@ -206,7 +212,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> > > >
> > > >                 /* use a contiguous mapping if the range is suitably aligned */
> > > >                 if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> > > > -                   (flags & NO_CONT_MAPPINGS) == 0)
> > > > +                   (IS_ENABLED(CONFIG_RODATA_FULL_USE_PTE_CONT) || (flags & NO_CONT_MAPPINGS) == 0))
> > > >                         __prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> > > >
> > > >                 init_pte(pmdp, addr, next, phys, __prot);
> > > > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > > > index a3bacd7..88a87eb 100644
> > > > --- a/arch/arm64/mm/pageattr.c
> > > > +++ b/arch/arm64/mm/pageattr.c
> > > > @@ -99,6 +99,15 @@ static int change_memory_common(unsigned long addr, int numpages,
> > > >         if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
> > > >                             pgprot_val(clear_mask) == PTE_RDONLY)) {
> > > >                 for (i = 0; i < area->nr_pages; i++) {
> > > > +#ifdef CONFIG_RODATA_FULL_USE_PTE_CONT
> > > > +                       unsigned long cont_pte_low_bound;
> > > > +                       unsigned long addr;
> > > > +
> > > > +                       addr = (u64)page_address(area->pages[i]);
> > > > +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> > > > +                       __change_memory_common(cont_pte_low_bound,
> > > > +                                              (~CONT_PTE_MASK + 1), __pgprot(0) , __pgprot(PTE_CONT));
> > > > +#endif
> > > >                         __change_memory_common((u64)page_address(area->pages[i]),
> > > >                                                PAGE_SIZE, set_mask, clear_mask);
> > > >                 }
> > > > --
> > > > 1.9.1
> > > >
