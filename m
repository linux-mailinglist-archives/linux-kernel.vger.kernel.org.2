Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B022745B8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhKXLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:12:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhKXLMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:12:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEA1060FE7;
        Wed, 24 Nov 2021 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637752183;
        bh=41zgciMzsU/WGL2eXcT5uyWtfeDMyAoHglt43hOVqJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pA2hhq5PPgSmKwsmzklBNn32NvKRBTpmFuDKfG6QrpizpjDvEPMKZ3pBEyKHW5bQJ
         wak56bGBZud3Ah5LHf9sQj1RiaDFuxXp0TWDaQezEAA6C++ufoY46PUZwibV/CiDfq
         43G4BQ0+04l4uhg8hDVF1ZwhKkBSyZKceaESxmZ13oyRhCcsg+Rhb+iTaePQ3MY7Tp
         WFu5yMsJ1uZ2pt5H2dQQ3WRdZjwV6efdUfgIo9+KiVohS74zcnRKSKWKPLxsnBu1k/
         6VI4rO3j5JqzQE+8dHixo4kMrWKdIhwd4Nh18bTAVhYvBe/V9jyelZP5JyTHPoX5BR
         sIUoSULPjQp+Q==
Received: by mail-ua1-f45.google.com with SMTP id p2so4149000uad.11;
        Wed, 24 Nov 2021 03:09:42 -0800 (PST)
X-Gm-Message-State: AOAM530tDMHdk7czDmgs/UC7ggN9FH7igChKrHaKDF/xotdktOo2CuKf
        IiSjj7CEI62ouYH8HqEC63uUHKmR4WunyYQpDzI=
X-Google-Smtp-Source: ABdhPJzTuyEKKKaZ2LcGqhjM3jVJYYSZT8Y1cxKh57RdT3qFf8qbVy9ISGV/+lum3/DJXr9+QBIC10/gC754IRPPCz0=
X-Received: by 2002:a67:f415:: with SMTP id p21mr21771144vsn.50.1637752182081;
 Wed, 24 Nov 2021 03:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20211124060521.614015-1-guoren@kernel.org> <CAAhSdy1CZbdAPEYxFOhrn=wUcmc9Yea0ziMUmHjaudKdH2Yw1w@mail.gmail.com>
 <CAJF2gTRAXAmo4cVSfArf=eMU9CxXZr3kjaKcQ1u8764cnL+N_Q@mail.gmail.com> <CAAhSdy2_Vk5nPMUOni5JctV8Jd9NYh-WK=yZPXTN_yzaNdy-4g@mail.gmail.com>
In-Reply-To: <CAAhSdy2_Vk5nPMUOni5JctV8Jd9NYh-WK=yZPXTN_yzaNdy-4g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 24 Nov 2021 19:09:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0GeKRRzBdbgui8BVzf4TA=FT3Q3jPZaqXx=oFzD4GRQ@mail.gmail.com>
Message-ID: <CAJF2gTS0GeKRRzBdbgui8BVzf4TA=FT3Q3jPZaqXx=oFzD4GRQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup one-page wasting
To:     Anup Patel <anup@brainfault.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Patra <Atish.Patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 3:56 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Nov 24, 2021 at 12:52 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Wed, Nov 24, 2021 at 2:55 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Wed, Nov 24, 2021 at 11:35 AM <guoren@kernel.org> wrote:
> > > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > For small memory systems(Allwinner D1s/F133), one page size memory
> > > > cannot be ignored.
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Cc: Alexandre Ghiti <alex@ghiti.fr>
> > > > Cc: Anup Patel <anup@brainfault.org>
> > > > Cc: Atish Patra <Atish.Patra@wdc.com>
> > >
> > > This PATCH breaks the CPU hotplug functionality.
> > >
> > > When a CPU/HART is turned off and turned on at runtime, the
> > > low-level relocate() will be called to enable MMU on the CPU
> > > being brought-up which in-turn uses trampoline_pg_dir.
> > Yeah, I forgot that.
> >
> > How about removing trampoline_pg_dir totally and using
> > early_pg_dir/swapper_pg_dir for relocate directly?
>
> The trampoline_pg_dir is to handle the case when RAM is
> large enough such that RAM physical address range overlaps
> kernel virtual address range (i.e. VA >= PAGE_OFFSET). This
> is overlap of virtual address range and physical address range
> can be problematic for low-level code which is trying to enable
> MMU (such as the relocate() function).
>
> Here's a old kernel thread which tries to summarize this:
> https://lore.kernel.org/lkml/CAAhSdy3URWHVY_GPNb2yRBuctRELRtTTWPM2OpwUVSRFAyXyiA@mail.gmail.com/
Got it. Thank you so much for sharing.

I would use the patch as private for F133 memory saving.

>
> Regards,
> Anup
>
> >
> > >
> > > Regards,
> > > Anup
> > >
> > > > ---
> > > >  arch/riscv/mm/init.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > index 24b2b8044602..097bb3bc4020 100644
> > > > --- a/arch/riscv/mm/init.c
> > > > +++ b/arch/riscv/mm/init.c
> > > > @@ -241,9 +241,9 @@ unsigned long riscv_pfn_base __ro_after_init;
> > > >  EXPORT_SYMBOL(riscv_pfn_base);
> > > >
> > > >  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> > > > -pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> > > >  static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> > > >
> > > > +pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> > > >  pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> > > >  static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> > > >
> > > > --
> > > > 2.25.1
> > > >
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
