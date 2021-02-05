Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07789310E85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhBEPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233234AbhBEPh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:37:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0B5C64F2A;
        Fri,  5 Feb 2021 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612545546;
        bh=GD1HJWPDL+WDon52gpUBIOF+4zUWtcYiATH9iQBxbMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fynDnKT1Ph8pNPVtE+r4TaxtbWbISD93iQOUxv4KO0WokE4jpHIDc5+QI58U3LhKQ
         6MkPrX5qwJo0QSx/TsLiTb/lH+TgHhOWLnLQ/Uu2j/mWq/bEYVX1fv6dQ8OzKo2M/9
         5VjkT5TSKuLvHR8rYH95fb6LkpdIkkPRq4/I6ns3Jsr1R/jR07PUHdr2AEgGpe5nva
         iyKGnB5Opg5bShOZX0uPaaxnqrL8msH5GOMYBCSJxP/Pl7nX2AN4ffWatBfuLs8YeR
         DDgJmOrpi+bmXnOSgM850qIknyAZ3nCr9dNnBTkNEU2Y2p/eOtRWJg1rln3MIhy19d
         3QYZ+CtsToJFg==
Date:   Fri, 5 Feb 2021 17:18:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@google.com, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        catalin.marinas@arm.com, dan.j.williams@intel.com,
        dvyukov@google.com, glider@google.com, gustavoars@kernel.org,
        kasan-dev@googlegroups.com, lecopzer.chen@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
        linux@roeck-us.net, robin.murphy@arm.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, vincenzo.frascino@arm.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH v2 1/4] arm64: kasan: don't populate vmalloc area for
 CONFIG_KASAN_VMALLOC
Message-ID: <20210205171859.GE22665@willie-the-truck>
References: <20210204150100.GE20815@willie-the-truck>
 <20210204163721.91295-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204163721.91295-1-lecopzer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:37:21AM +0800, Lecopzer Chen wrote:
> 
> > On Thu, Feb 04, 2021 at 10:46:12PM +0800, Lecopzer Chen wrote:
> > > > On Sat, Jan 09, 2021 at 06:32:49PM +0800, Lecopzer Chen wrote:
> > > > > Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > > > > ("kasan: support backing vmalloc space with real shadow memory")
> > > > >
> > > > > Like how the MODULES_VADDR does now, just not to early populate
> > > > > the VMALLOC_START between VMALLOC_END.
> > > > > similarly, the kernel code mapping is now in the VMALLOC area and
> > > > > should keep these area populated.
> > > > >
> > > > > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > > > > ---
> > > > >  arch/arm64/mm/kasan_init.c | 23 ++++++++++++++++++-----
> > > > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > > > > index d8e66c78440e..39b218a64279 100644
> > > > > --- a/arch/arm64/mm/kasan_init.c
> > > > > +++ b/arch/arm64/mm/kasan_init.c
> > > > > @@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
> > > > >  {
> > > > >   u64 kimg_shadow_start, kimg_shadow_end;
> > > > >   u64 mod_shadow_start, mod_shadow_end;
> > > > > + u64 vmalloc_shadow_start, vmalloc_shadow_end;
> > > > >   phys_addr_t pa_start, pa_end;
> > > > >   u64 i;
> > > > >
> > > > > @@ -223,6 +224,9 @@ static void __init kasan_init_shadow(void)
> > > > >   mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
> > > > >   mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
> > > > >
> > > > > + vmalloc_shadow_start = (u64)kasan_mem_to_shadow((void *)VMALLOC_START);
> > > > > + vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
> > > > > +
> > > > >   /*
> > > > >    * We are going to perform proper setup of shadow memory.
> > > > >    * At first we should unmap early shadow (clear_pgds() call below).
> > > > > @@ -241,12 +245,21 @@ static void __init kasan_init_shadow(void)
> > > > >
> > > > >   kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
> > > > >                              (void *)mod_shadow_start);
> > > > > - kasan_populate_early_shadow((void *)kimg_shadow_end,
> > > > > -                            (void *)KASAN_SHADOW_END);
> > > > > + if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> > > >
> > > > Do we really need yet another CONFIG option for KASAN? What's the use-case
> > > > for *not* enabling this if you're already enabling one of the KASAN
> > > > backends?
> > >
> > > As I know, KASAN_VMALLOC now only supports KASAN_GENERIC and also
> > > KASAN_VMALLOC uses more memory to map real shadow memory (1/8 of vmalloc va).
> >
> > The shadow is allocated dynamically though, isn't it?
> 
> Yes, but It's still a cost.
> 
> > > There should be someone can enable KASAN_GENERIC but can't use VMALLOC
> > > due to memory issue.
> >
> > That doesn't sound particularly realistic to me. The reason I'm pushing here
> > is because I would _really_ like to move to VMAP stack unconditionally, and
> > that would effectively force KASAN_VMALLOC to be set if KASAN is in use.
> >
> > So unless there's a really good reason not to do that, please can we make
> > this unconditional for arm64? Pretty please?
> 
> I think it's fine since we have a good reason.
> Also if someone have memory issue in KASAN_VMALLOC,
> they can use SW_TAG, right?
> 
> However the SW_TAG/HW_TAG is not supported VMALLOC yet.
> So the code would be like
> 
> 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))

Just make this CONFIG_KASAN_VMALLOC, since that depends on KASAN_GENERIC.

> 		/* explain the relationship between 
> 		 * KASAN_GENERIC and KASAN_VMALLOC in arm64
> 		 * XXX: because we want VMAP stack....
> 		 */

I don't understand the relation with SW_TAGS. The VMAP_STACK dependency is:

	depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC

which doesn't mention SW_TAGS at all. So that seems to imply that SW_TAGS
and VMAP_STACK are mutually exclusive :(

Will
