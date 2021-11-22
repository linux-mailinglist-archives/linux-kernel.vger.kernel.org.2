Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F6458D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhKVL2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhKVL2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:28:07 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DEBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 03:25:01 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id g1so12165165qvd.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 03:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7GpUDxMNlsc+fb8R8i2IvrXfH6R7syAYUue6uwl3OU=;
        b=JZl0pEcSFxkldvAQRSkj3ZUPegR/ZVNwt4oYymj4AhOwfUvaFtIT8s/1iYuH07jzLb
         on2f+/z+e3kQ+kenDMKtpPiaFKrDDomicbRJHx/fhFIqxwRzyfTulHTcp+kRj6zQNXIA
         THL37L6orgPjrYVUsW65H+SbPJhYxUFddv2XAUVopZx6Ux5oV55FIqqZSj7wrRvk2omu
         rGQ+taLfOdmAr3In7TmEQm1irtY6xtYw+up86ISkLwlhrRc2yPrDa2FzDV5LpLjysKwO
         sz9AzZU48dS+edE62lvwbF16hrhkbXLZ+px+kp9nEhDJ9XtSRxmwxgw7eQviecytn7a+
         1tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7GpUDxMNlsc+fb8R8i2IvrXfH6R7syAYUue6uwl3OU=;
        b=kMAgooy4YDvKL6hb/SSgshKG9cRGBsaCGVmsX6U1LYrGV4TKj3OlEx7t/hajd7/e4f
         RJo8IITN4tcVeZQWgkcgdAq3Nvotj3rEmPupgg3ixKjGLUSLOTRvt1lulZI2rzaaefVV
         LRLF2OgF6san1dPdPI1Ty0SSHGOUovz/HG5gR4GNovVtzDfcfuTjxiexCQw886OJrHg2
         28uJ4vmoZfpXtPKtUyEO/bYVIRHIeNFRZNvgSD8vKd58Kq4UMqeRiI2epZX7iVTvsTtg
         AuBtJ9Sp2/rzj8ZLvD4hNubyn/BZyP0TPFonm4N/6AT70Q2ZVaSWe64Ouf/jZktm7sor
         WnAQ==
X-Gm-Message-State: AOAM532hmCFXLjyT1C5pPKkfupZQ+O2dYkfNsRsoOBfm+lLdny45DCfH
        yUxGXVAaKL1dBwguzRLXAfPvs4TLSkEWEVzvT8c=
X-Google-Smtp-Source: ABdhPJyqfr8HbC3TvbFrm6P9lZ+slO+iD6NyFrFJzVjqgNqRKecLFoFVVBlMx3wZoLFTM4OHuv9Ye6rgmREd/OigpTc=
X-Received: by 2002:a05:6214:d8e:: with SMTP id e14mr99344013qve.37.1637580300473;
 Mon, 22 Nov 2021 03:25:00 -0800 (PST)
MIME-Version: 1.0
References: <1637558929-22971-1-git-send-email-huangzhaoyang@gmail.com>
 <CAMj1kXGvVkMtZrKYpr8SP8YSvUuWnyQ2i67riHBdQgfDy_0e1A@mail.gmail.com>
 <CAGWkznHA_y1YmjOFc9UnxtW_TN3PiCP2bbuqgn+-mz6LjSXFAQ@mail.gmail.com>
 <CAMj1kXGzz8HsDs0zsMVGC3Jb3aT9vs9fHGHJzFS1mM0ZhpK1Jw@mail.gmail.com>
 <CAGWkznHK0pDQQOOg-zPnr42EB__X84MF0AHU=b8VL_yuhPOBbA@mail.gmail.com> <CAMj1kXEt0iOMwFGow-vbatmfzmEhe0kq6KDAfup_GtKXaZAjmg@mail.gmail.com>
In-Reply-To: <CAMj1kXEt0iOMwFGow-vbatmfzmEhe0kq6KDAfup_GtKXaZAjmg@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 22 Nov 2021 19:24:39 +0800
Message-ID: <CAGWkznFLNw=RBU=uGHXQLq6_dJQRqA0FKqN+SdvKszVhzCrNfA@mail.gmail.com>
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

On Mon, Nov 22, 2021 at 5:23 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 22 Nov 2021 at 10:17, Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Mon, Nov 22, 2021 at 5:04 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 22 Nov 2021 at 10:00, Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 22, 2021 at 4:52 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Mon, 22 Nov 2021 at 06:29, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> > > > > >
> > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > >
> > > > > > Kernel linear mapping will be split to the smallest granularity when
> > > > > > RODATA_FULL applied, which could lead to TLB pressure. Introduce a method
> > > > > > to apply PTE_CONT on pte.
> > > > > >
> > > > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > How would this lead to TLB pressure, and how does the use of
> > > > > contiguous mappings mitigate that? The linear mapping of the kernel is
> > > > > rarely used, as all normal accesses to it go via the vmalloc region,
> > > > > so in which case would TLB entries be allocated for this region in a
> > > > > way that could cause a measurable performance impact?
> > > > In fact, the patch is about to use PTE_CONT *OUT OF* the range of
> > > > kernel text.
> > >
> > > OK, I had missed that, apologies.
> > >
> > > > Would you please have a look at the code. It apply
> > > > PTE_CONT during map_mem and then clear it when load_module change the
> > > > corresponding linear mapping to the area it use in vmalloc area.
> > >
> > > You cannot change the PTE_CONT attribute on live mappings.
> > Is it an inner constraint from ASIC perspective? PTE_CONT is different
> > to other attributes?
>
> The PTE_CONT attributes on live translation entries must always be in
> sync in all entries covering the same contiguous group, or you might
> cause TLB conflict aborts.
>
> > >
> > > > >
> > > > >
> > > > > > ---
> > > > > >  arch/arm64/Kconfig       |  9 +++++++++
> > > > > >  arch/arm64/mm/mmu.c      | 10 ++++++++--
> > > > > >  arch/arm64/mm/pageattr.c |  9 +++++++++
> > > > > >  3 files changed, 26 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > > index fee914c..3f8fbf0 100644
> > > > > > --- a/arch/arm64/Kconfig
> > > > > > +++ b/arch/arm64/Kconfig
> > > > > > @@ -1198,6 +1198,15 @@ config RODATA_FULL_DEFAULT_ENABLED
> > > > > >           This requires the linear region to be mapped down to pages,
> > > > > >           which may adversely affect performance in some cases.
> > > > > >
> > > > > > +config RODATA_FULL_USE_PTE_CONT
> > > > > > +       bool "Apply PTE_CONT when RODATA_FULL_DEFAULT_ENABLED enabled"
> > > > > > +       depends on RODATA_FULL_DEFAULT_ENABLED
> > > > > > +       default y
> > > > > > +       help
> > > > > > +         Apply PTE_CONT on linear mapping as much as we can when
> > > > > > +         RODATA_FULL_DEFAULT_ENABLED enabled which could decrease the
> > > > > > +         impaction on performance by small pte granularity.
> > > > > > +
> > > > > >  config ARM64_SW_TTBR0_PAN
> > > > > >         bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
> > > > > >         help
> > > > > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > > > > index cfd9deb..8017b17 100644
> > > > > > --- a/arch/arm64/mm/mmu.c
> > > > > > +++ b/arch/arm64/mm/mmu.c
> > > > > > @@ -124,15 +124,21 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
> > > > > >          * The following mapping attributes may be updated in live
> > > > > >          * kernel mappings without the need for break-before-make.
> > > > > >          */
> > > > > > +#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
> > > > > >         pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
> > > > > > +#else
> > > > > > +       pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG | PTE_CONT;
> > > > > > +#endif
> > >
> > > What justifies this change? Why is it ok in certain cases to update
> > > the PTE_CONT attribute without BBM?
> > BBM?
> > I am not sure if it is ok here, but I just find nobody else change
> > PTE_CONT so far other than this commit.
>
> No it is not ok. BBM == break before make, which means you need to
> install invalid entries for the entire contiguous group before you can
> change the PTE_CONT attributes. As other CPUs may be accessing the
> same region, there is no safe way to do this, which is why we don't
> permit PTE_CONT to be changed at all.
ok, got it. But from practical scenario perspective, could we assume
that the corresponding linear map of the vmalloc area would NOT be
accessed at all. If it does so, could we just clear PTE_VALID on the
linear pte and leave PTE_CONT on the others' pte within the same
region. The linear mapping could be reestablished when vmalloc_free.
>
>
> > >
> > > > > >
> > > > > >         /* creating or taking down mappings is always safe */
> > > > > >         if (old == 0 || new == 0)
> > > > > >                 return true;
> > > > > >
> > > > > >         /* live contiguous mappings may not be manipulated at all */
> > > > > > -       if ((old | new) & PTE_CONT)
> > > > > > +#ifndef CONFIG_RODATA_FULL_USE_PTE_CONT
> > > > > > +       if ((old | new) & PTE_CONT)
> > > > > >                 return false;
> > > > > > +#endif
> > > > > >
> > > > > >         /* Transitioning from Non-Global to Global is unsafe */
> > > > > >         if (old & ~new & PTE_NG)
> > > > > > @@ -206,7 +212,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> > > > > >
> > > > > >                 /* use a contiguous mapping if the range is suitably aligned */
> > > > > >                 if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> > > > > > -                   (flags & NO_CONT_MAPPINGS) == 0)
> > > > > > +                   (IS_ENABLED(CONFIG_RODATA_FULL_USE_PTE_CONT) || (flags & NO_CONT_MAPPINGS) == 0))
> > > > > >                         __prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> > > > > >
> > > > > >                 init_pte(pmdp, addr, next, phys, __prot);
> > > > > > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > > > > > index a3bacd7..88a87eb 100644
> > > > > > --- a/arch/arm64/mm/pageattr.c
> > > > > > +++ b/arch/arm64/mm/pageattr.c
> > > > > > @@ -99,6 +99,15 @@ static int change_memory_common(unsigned long addr, int numpages,
> > > > > >         if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
> > > > > >                             pgprot_val(clear_mask) == PTE_RDONLY)) {
> > > > > >                 for (i = 0; i < area->nr_pages; i++) {
> > > > > > +#ifdef CONFIG_RODATA_FULL_USE_PTE_CONT
> > > > > > +                       unsigned long cont_pte_low_bound;
> > > > > > +                       unsigned long addr;
> > > > > > +
> > > > > > +                       addr = (u64)page_address(area->pages[i]);
> > > > > > +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> > > > > > +                       __change_memory_common(cont_pte_low_bound,
> > > > > > +                                              (~CONT_PTE_MASK + 1), __pgprot(0) , __pgprot(PTE_CONT));
> > > > > > +#endif
> > > > > >                         __change_memory_common((u64)page_address(area->pages[i]),
> > > > > >                                                PAGE_SIZE, set_mask, clear_mask);
> > > > > >                 }
> > > > > > --
> > > > > > 1.9.1
> > > > > >
