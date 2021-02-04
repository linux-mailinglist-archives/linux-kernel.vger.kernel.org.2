Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA730F839
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhBDQlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237010AbhBDO4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:56:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D40264DBA;
        Thu,  4 Feb 2021 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612450554;
        bh=gJBWS+RDASWfFxTsTMTHeqe/fRxDGgTZWYX8LP56QXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7nY5mV5TDyeWRHBNdaAPYZGrAmUJ9OVl1GnIoM6FJSErf2tfxQMmLmQhLcWr+GP7
         yrk2646E8w5/Le8UItOJgJh5I/esEUF4+G6fbi74EYA1+lB8/t5Oc+5bTbgLLQBbol
         KzJ3vu8utyERGuJfiAPQE9ZR0h8hp2Vuat+6e+f+Io4kSlobHDOhfO5RH+VZcPGamq
         aJ9WxHEQG0b2nSmT7anK+yHenIOKCVVPuGU71Pb2/buwav1JGJbQMMEIUvnVbw0wki
         Mb7R0ePnIW7Hmf6l7rNSgyX5wNqdK6wBbl8hxI6zb24BrfV5EaCbJl65UDBpCc7GnA
         uIkvChaFE+vRg==
Date:   Thu, 4 Feb 2021 14:55:48 +0000
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
Subject: Re: [PATCH v2 2/4] arm64: kasan: abstract _text and _end to
 KERNEL_START/END
Message-ID: <20210204145547.GD20815@willie-the-truck>
References: <20210204124658.GB20468@willie-the-truck>
 <20210204145127.75856-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204145127.75856-1-lecopzer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:51:27PM +0800, Lecopzer Chen wrote:
> > On Sat, Jan 09, 2021 at 06:32:50PM +0800, Lecopzer Chen wrote:
> > > Arm64 provide defined macro for KERNEL_START and KERNEL_END,
> > > thus replace them by the abstration instead of using _text and _end.
> > > 
> > > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > > ---
> > >  arch/arm64/mm/kasan_init.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > > index 39b218a64279..fa8d7ece895d 100644
> > > --- a/arch/arm64/mm/kasan_init.c
> > > +++ b/arch/arm64/mm/kasan_init.c
> > > @@ -218,8 +218,8 @@ static void __init kasan_init_shadow(void)
> > >  	phys_addr_t pa_start, pa_end;
> > >  	u64 i;
> > >  
> > > -	kimg_shadow_start = (u64)kasan_mem_to_shadow(_text) & PAGE_MASK;
> > > -	kimg_shadow_end = PAGE_ALIGN((u64)kasan_mem_to_shadow(_end));
> > > +	kimg_shadow_start = (u64)kasan_mem_to_shadow(KERNEL_START) & PAGE_MASK;
> > > +	kimg_shadow_end = PAGE_ALIGN((u64)kasan_mem_to_shadow(KERNEL_END));
> > >  
> > >  	mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
> > >  	mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
> > > @@ -241,7 +241,7 @@ static void __init kasan_init_shadow(void)
> > >  	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
> > >  
> > >  	kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
> > > -			   early_pfn_to_nid(virt_to_pfn(lm_alias(_text))));
> > > +			   early_pfn_to_nid(virt_to_pfn(lm_alias(KERNEL_START))));
> > 
> > To be honest, I think this whole line is pointless. We should be able to
> > pass NUMA_NO_NODE now that we're not abusing the vmemmap() allocator to
> > populate the shadow.
> 
> Do we need to fix this in this series? it seems another topic.
> If not, should this patch be removed in this series?

Since you're reposting anyway, you may as well include a patch doing that.
If you don't, then I will.

Will
