Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B733F5E97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhHXNEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237225AbhHXNEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:04:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47B9C61374;
        Tue, 24 Aug 2021 13:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629810237;
        bh=I5P48pHDbekoWM3FCfggAy2SVmKCGZrPXmhmt9QLetY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F45Ll4lAYAyL/1NSli9JfI/dQx9BjUedzzm8XeIvqpXhFy2h0HH7zi42cUKRjd5Vd
         CidhcSEm3xcjNoiYDX+36vvJKmmpWSFnbRMncC/tzU2pHQP0s2Z3YUXjbIUrrE+Ksr
         UX7KMGpEMkO8gaFT9v1fsN+hnjoIl5LtOu2fk+a1fjYJborvjZVBlYc6dfCqBV95IC
         N2uEVyMSqT9WPasIMNRFYkrqwce/dAzSXLt8GYIsIL9UyPTGnStuu5Vht3OBi7NWUh
         r3on1fen+TqV0RP3El6kzEE+gbo/IrtFq1E/ksrCyOA0oGz8IaAZfVUkA+en6R7duj
         /UGhGnB45wIjA==
Date:   Tue, 24 Aug 2021 16:03:26 +0300
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
Subject: Re: [RFC PATCH 0/4] mm/page_alloc: cache pte-mapped allocations
Message-ID: <YSTuHr7d//L3Ysjx@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
 <1b49324674fd75294625f725c7f074efd8480efc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b49324674fd75294625f725c7f074efd8480efc.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 08:02:55PM +0000, Edgecombe, Rick P wrote:
>  Mon, 2021-08-23 at 16:25 +0300, Mike Rapoport wrote:
> > 
> > There are usecases that need to remove pages from the direct map or
> > at
> > least map them with 4K granularity. Whenever this is done e.g. with
> > set_memory/set_direct_map APIs, the PUD and PMD sized mappings in the
> > direct map are split into smaller pages.
> > 
> > To reduce the performance hit caused by the fragmentation of the
> > direct map
> > it make sense to group and/or cache the 4K pages removed from the
> > direct
> > map so that the split large pages won't be all over the place. 
> > 
> If you tied this into debug page alloc, you shouldn't need to group the
> pages. Are you thinking this PKS-less page table usage would be a
> security feature or debug time thing?

I consider the PKS-less page table protection as an example user of the
grouped pages/pte-mapped cache rather than an actual security feature or
even a debug thing.

With PKS we still have the same trade-off of allocation flexibility vs
direct map fragmentation and I hoped to focus the discussion of the mm part
of the series rather than on page table protection. Apparently it didn't
work :)
 
> > == TODOs ==
> > 
> > Whenever pte-mapped cache is being shrunk, it is possible to add some
> > kind
> > of compaction to move all the free pages into PMD-sized chunks, free
> > these
> > chunks at once and restore large page in the direct map.
>
> I had made a POC to do this a while back that hooked into the buddy
> code in the page allocator where this coalescing is already happening
> for freed pages. The problem was that most pages that get their direct
> map alias broken, end up using a page from the same 2MB page for the
> page table in the split. But then the direct map page table never gets
> freed so it never can restore the large page when checking the the
> allocation page getting freed. Grouping permissioned pages OR page
> tables would resolve that and it was my plan to try again after
> something like this happened. 

This suggests that one global cache won't be good enough, at least for the
case when page tables are taken from that cache.

> Was just an experiment, but can share if you are interested.
 
Yes, please.

> > == Alternatives ==
> > 
> > Current implementation uses a single global cache.
> > 
> > Another option is to have per-user caches, e.g one for the page
> > tables,
> > another for vmalloc etc.  This approach provides better control of
> > the
> > permissions of the pages allocated from these caches and allows the
> > user to
> > decide when (if at all) the pages can be accessed, e.g. for cache
> > compaction. The down side of this approach is that it complicates the
> > freeing path. A page allocated from a dedicated cache cannot be freed
> > with
> > put_page()/free_page() etc but it has to be freed with a dedicated
> > API or
> > there should be some back pointer in struct page so that page
> > allocator
> > will know what cache this page came from.
>
> This needs to reset the permissions before freeing, so doesn't seem too
> different than freeing them a special way.

Not quite. For instance, when freeing page table pages with mmu_gather, we
can reset the permission at or near pgtable_pxy_page_dtor() and continue to
the batched free.
 
> > Yet another possibility to make pte-mapped cache a migratetype of its
> > own.
> > Creating a new migratetype would allow higher order allocations of
> > pte-mapped pages, but I don't have enough understanding of page
> > allocator
> > and reclaim internals to estimate the complexity associated with this
> > approach. 
> > 
> I've been thinking about two categories of direct map permission
> usages.
> 
> One is limiting the use of the direct map alias when it's not in use
> and the primary alias is getting some other permission. Examples are
> modules, secretmem, xpfo, KVM guest memory unmapping stuff, etc. In
> this case re-allocations can share unmapped pages without doing any
> expensive maintenance and it helps to have one big cache. If you are
> going to convert pages to 4k and cache them, you might as well convert
> them to NP at the time, since it's cheap to restore them or set their
> permission from that state.
>
> Two is setting permissions on the direct map as the only alias to be
> used. This includes this rfc, some PKS usages, but also possibly some
> set_pages_uc() callers and the like. It seems that this category could
> still make use of a big unmapped cache of pages. Just ask for unmapped
> pages and convert them without a flush.
> 
> So like something would have a big cache of grouped unmapped pages 
> that category one usages could share. And then little category two
> allocators could have their own caches that feed on it too. What do you
> think? This is regardless if they live in the page allocator or not.

I can say I see how category two cache would use a global unmapped cache.
I would envision that these caches can share the implementation, but there
will be different instances - one for the global cache and another one (or
several) for users that cannot share the global cache for some reason.

-- 
Sincerely yours,
Mike.
