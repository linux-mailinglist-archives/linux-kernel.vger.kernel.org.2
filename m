Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C61944E669
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhKLMh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhKLMhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:37:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 181C560F70;
        Fri, 12 Nov 2021 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636720474;
        bh=Km0Qj/C2HMPSq6M4sHLzSwyndnOPG+XNEqv0q7Y6RLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYhlKauXpBMhRIbZ/ZwmFge2ez7YiQx6MV/14L5hS3uqcH+wSWuJ6mo+41qcIzpud
         vluXvs20KKkXQ/AsjBziXb840+P1/GUSk0PBiecRgEOBfEu5zuUPupNokCL3nFH7eF
         JaYKcCFz+7rT3+LFlkwqeGZsR8TghV4xV211ylEkrkN8ZW1JwqyNGWHIFTW0ccEHWK
         f8yR6VPfFRsu5P52XmbP/6LzNN2HyZmeSHU6Yi7dZql7kZGW/NDWZFr2Dgm7JU98n7
         QlYpqPaWkIYGU1yAvD0kN6BO+gUPev5hw9J2NUssw8Mx7im/X4Pt1PeZ4CGQAVLHx5
         LJrPWt2IzmeDg==
Date:   Fri, 12 Nov 2021 14:34:27 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Finn Thain <fthain@linux-m68k.org>, Sam Creasey <sammy@sammy.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] m68k: Enable memtest functionality
Message-ID: <YY5fU8Hq8fq7HtJJ@kernel.org>
References: <1a89fd7d58f22e4817cf5bb406cc191dc0bc9325.1636677401.git.fthain@linux-m68k.org>
 <CAMuHMdXsVvXCbmrdukLCd-AXrqT-LmCz427BdNNCbDUw9vmL1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXsVvXCbmrdukLCd-AXrqT-LmCz427BdNNCbDUw9vmL1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 09:05:31AM +0100, Geert Uytterhoeven wrote:
> Hi Finn,
> 
> On Fri, Nov 12, 2021 at 1:37 AM Finn Thain <fthain@linux-m68k.org> wrote:
> > Enable the memtest functionality and rearrange some code to prevent it
> > from clobbering the initrd.
> >
> > The CONFIG_BLK_DEV_INITRD symbol was conditional on !defined(CONFIG_SUN3).
> > For simplicity, remove that test on the basis that m68k_ramdisk.size == 0
> > on Sun 3.
> >
> > The SLIME source code at
> > http://sammy.net/sun3/ftp/pub/m68k/sun3/slime/slime-2.0.tar.gz
> > indicates that no BI_RAMDISK entry is ever passed to the kernel due
> > to #ifdef 0 around the relevant code.
> >
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Sam Creasey <sammy@sammy.net>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> 
> Thanks for your patch!
> 
> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -9,6 +9,7 @@ config M68K
> >         select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
> >         select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
> >         select ARCH_NO_PREEMPT if !COLDFIRE
> > +       select ARCH_USE_MEMTEST
> 
> if MMU_MOTOROLA?
> 
> >         select ARCH_WANT_IPC_PARSE_VERSION
> >         select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
> >         select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
> > diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> > index 4b51bfd38e5f..49e573b94326 100644
> > --- a/arch/m68k/kernel/setup_mm.c
> > +++ b/arch/m68k/kernel/setup_mm.c
> > @@ -338,13 +338,6 @@ void __init setup_arch(char **cmdline_p)
> >                 panic("No configuration setup");
> >         }
> >
> > -       paging_init();
> > -
> > -#ifdef CONFIG_NATFEAT
> > -       nf_init();
> > -#endif
> > -
> > -#ifndef CONFIG_SUN3
> >  #ifdef CONFIG_BLK_DEV_INITRD
> >         if (m68k_ramdisk.size) {
> >                 memblock_reserve(m68k_ramdisk.addr, m68k_ramdisk.size);
> 
> Does this still work, given the initrd is part of memory that used
> to be added before (in paging_init(), but now is added later?
> (I'm no memblock expert, so that might be a silly question ;-)

memblock allows reserving non-existing memory just fine. 
 
> > @@ -354,6 +347,12 @@ void __init setup_arch(char **cmdline_p)
> >         }
> >  #endif
> >
> > +       paging_init();
> > +
> > +#ifdef CONFIG_NATFEAT
> > +       nf_init();
> > +#endif
> > +
> >  #ifdef CONFIG_ATARI
> >         if (MACH_IS_ATARI)
> >                 atari_stram_reserve_pages((void *)availmem);
> > @@ -364,8 +363,6 @@ void __init setup_arch(char **cmdline_p)
> >         }
> >  #endif
> >
> > -#endif /* !CONFIG_SUN3 */
> > -
> >  /* set ISA defs early as possible */
> >  #if defined(CONFIG_ISA) && defined(MULTI_ISA)
> >         if (MACH_IS_Q40) {
> > diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> > index 9f3f77785aa7..5b6575eb6d02 100644
> > --- a/arch/m68k/mm/motorola.c
> > +++ b/arch/m68k/mm/motorola.c
> > @@ -455,6 +455,8 @@ void __init paging_init(void)
> >
> >         flush_tlb_all();
> >
> > +       early_memtest(min_addr, max_addr);
> 
> So this is available only if MMU_MOTOROLA, not for Sun-3, Coldfire,
> or nommu.
> 
> > +
> >         /*
> >          * initialize the bad page table and bad page to point
> >          * to a couple of allocated pages
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Sincerely yours,
Mike.
