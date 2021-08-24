Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE5C3F5E93
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbhHXNDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237225AbhHXNDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:03:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56BA06127B;
        Tue, 24 Aug 2021 13:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629810184;
        bh=cznsRp1PYJ7vKk8CM2WCQGPz3rkhE4CdDjsVOSgprUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrjUw3FQZY2HmcafO02kTsL7fR/3UgGFc3v0nzfmIlA5UXiD9MoHugb+nPNQfcr0E
         gxRTH0QKSOF+SsYcAGKmD81xe3+vmcH8TXWjzSp4wBwXAh2Aswz+ifMEXID9/hSFSU
         vkzp5ZvNhNtpUKVWO/52J3fqhE+sVDzju2je1NU+FVEH1tYIX+4AvmYNbaw5vmk/la
         Mzh8ok7jDwr3/LRN4x+1pN/IWO6wnL/zHb2qOzx5GzqC3vythT/a6IBA/BaKO/lAWX
         AJVdpzf10gOHCmX96auYrDm0/IexpkzlQdFIfRWBeGDLrr9qBVKd36gU9O7PlCDyTy
         MXLqg8WeS/HbA==
Date:   Tue, 24 Aug 2021 16:02:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "Lutomirski, Andy" <luto@kernel.org>
Subject: Re: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag
 to allocate pte-mapped pages
Message-ID: <YSTt9XEDfbPOpab4@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-4-rppt@kernel.org>
 <889bdfef8b4acbe840668f27782c3d39a987c368.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889bdfef8b4acbe840668f27782c3d39a987c368.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 08:29:49PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2021-08-23 at 16:25 +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > When __GFP_PTE_MAPPED flag is passed to an allocation request of
> > order 0,
> > the allocated page will be mapped at PTE level in the direct map.
> > 
> > To reduce the direct map fragmentation, maintain a cache of 4K pages
> > that
> > are already mapped at PTE level in the direct map. Whenever the cache
> > should be replenished, try to allocate 2M page and split it to 4K
> > pages
> > to localize shutter of the direct map. If the allocation of 2M page
> > fails,
> > fallback to a single page allocation at expense of the direct map
> > fragmentation.
> > 
> > The cache registers a shrinker that releases free pages from the
> > cache to
> > the page allocator.
> > 
> > The __GFP_PTE_MAPPED and caching of 4K pages are enabled only if an
> > architecture selects ARCH_WANTS_PTE_MAPPED_CACHE in its Kconfig.
> > 
> > [
> > cache management are mostly copied from 
> > 
> https://lore.kernel.org/lkml/20210505003032.489164-4-rick.p.edgecombe@intel.com/
> > ]
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/Kconfig                    |   8 +
> >  arch/x86/Kconfig                |   1 +
> >  include/linux/gfp.h             |  11 +-
> >  include/linux/mm.h              |   2 +
> >  include/linux/pageblock-flags.h |  26 ++++
> >  init/main.c                     |   1 +
> >  mm/internal.h                   |   3 +-
> >  mm/page_alloc.c                 | 261 +++++++++++++++++++++++++++++++-
> >  8 files changed, 309 insertions(+), 4 deletions(-)
 
...

> > +static void pte_mapped_cache_add_neighbour_pages(struct page *page)
> > +{
> > +#if 0
> > +	/*
> > +	 * TODO: if pte_mapped_cache_replenish() had to fallback to
> > order-0
> > +	 * allocation, the large page in the direct map will be split
> > +	 * anyway and if there are free pages in the same pageblock
> > they
> > +	 * can be added to pte_mapped cache.
> > +	 */
> > +	unsigned int order = (1 << HUGETLB_PAGE_ORDER);
> > +	unsigned int nr_pages = (1 << order);
> > +	unsigned long pfn = page_to_pfn(page);
> > +	struct page *page_head = page - (pfn & (order - 1));
> > +
> > +	for (i = 0; i < nr_pages; i++) {
> > +		page = page_head + i;
> > +		if (is_free_buddy_page(page)) {
> > +			take_page_off_buddy(page);
> > +			pte_mapped_cache_add(&pte_mapped_cache, page);
> > +		}
> > +	}
> > +#endif
> > +}
> > 
> This seems a nice benefit of doing this sort of stuff in the page
> allocator if it can work.

I didn't try enable it yet, but I don't see a fundamental reason why this
won't work.
 
> > +static struct page *alloc_page_pte_mapped(gfp_t gfp)
> >
> I'm a little disappointed building into the page allocator didn't
> automatically make higher order allocations easy. It seems this mostly
> bolts the grouped pages code on to the page allocator and splits out of
> the allocation/free paths to call into it?
>
> I was thinking the main benefit of handling direct map permissions in
> the page allocator would be re-using the buddy part to support high
> order pages, etc. Did you try to build it in like that? If we can't get
> that, what is the benefit to doing permission stuff in the pageallocator? 

The addition of grouped pages to page allocator the way I did is somewhat
intermediate solution between keeping such cache entirely separate from
page allocator vs making it really tightly integrated, e.g. using a new
migratetype or doing more intrusive changes to page allocator. One of the
reasons I did it this way is to present various trade-offs because, tbh,
I'm not yet sure what's the best way to move forward. [The other reason
being my laziness, dropping your grouped pages code into the page allocator
was the simplest thing to do ;-)].

The immediate benefit of having this code close to the page allocator is
the simplification of the free path. Otherwise we'd need a cache-specific
free method or some information in struct page about how to free a grouped
page. Besides, it is possible to put pages mapped as 4k into such cache at
boot time when page allocator is initialized.

Also, keeping a central cache for multiple users will improve memory
utilization and I believe it would require less splits of the direct map.
OTOH, keeping such caches per-user allows managing access policy per cache
which could be better from the security POV.

I'm also going to explore the possibilities of using a new migratetype or
SL*B as Dave suggested.
 
> > +{
> > +	struct pte_mapped_cache *cache = &pte_mapped_cache;
> > +	struct page *page;
> > +
> > +	page = pte_mapped_cache_get(cache);
> > +	if (page) {
> > +		prep_new_page(page, 0, gfp, 0);
> > +		goto out;
> > +	}
> > +
> > +	page = pte_mapped_cache_replenish(cache, gfp);
> > +
> > +out:
> > +	return page;
> > +}
> > +
> We probably want to exclude GFP_ATOMIC before calling into CPA unless
> debug page alloc is on, because it may need to split and sleep for the
> allocation. There is a page table allocation with GFP_ATOMIC passed actually.

Looking at the callers of alloc_low_pages() it seems that GFP_ATOMIC there
is stale...
 
> In my next series of this I added support for GFP_ATOMIC to this code,
> but that solution should only work for permission changing grouped page
> allocators in the protected page tables case where the direct map
> tables are handled differently. As a general solution though (that's
> the long term intention right?), GFP_ATOMIC might deserve some
> consideration.

... but for the general solution GFP_ATOMIC indeed deserves some
consideration.
 
> The other thing is we probably don't want to clean out the atomic
> reserves and add them to a cache just for one page. I opted to just
> convert one page in the GFP_ATOMIC case.
 
Do you mean to allocate one page in GFP_ATOMIC case and bypass high order
allocation?
But the CPA split is still necessary here, isn't it?

-- 
Sincerely yours,
Mike.
