Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347653669FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhDULiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 07:38:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237540AbhDULh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 07:37:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619005043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDOuCC62jfsd2wkWQVjxeXTqXYlpQLnWV9cnsOipcpM=;
        b=HrKFqzU3wZvPg/mQzVI7H934OPbXXE+18K2hnfl7cE//AMcNvy7rOF5quwJMP6mpQd253v
        ZVJRlPpAaGZUS3C7H4b89+R+OBj/Zp9skIcFjApgzGck9b1xBPy6Golfb+2p4iM3YNEiwD
        NV1GgvVUWnzuPbMAIPtdgHgfMX98ZCg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 147B4AF1E;
        Wed, 21 Apr 2021 11:37:23 +0000 (UTC)
Date:   Wed, 21 Apr 2021 13:37:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 4/8] mm,memory_hotplug: Allocate memmap from the
 added memory range
Message-ID: <YIAOcrolk359gnOC@dhcp22.suse.cz>
References: <20210421102701.25051-1-osalvador@suse.de>
 <20210421102701.25051-5-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421102701.25051-5-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-04-21 12:26:57, Oscar Salvador wrote:
> Physical memory hotadd has to allocate a memmap (struct page array) for
> the newly added memory section. Currently, alloc_pages_node() is used
> for those allocations.
> 
> This has some disadvantages:
>  a) an existing memory is consumed for that purpose
>     (eg: ~2MB per 128MB memory section on x86_64)
>     This can even lead to extreme cases where system goes OOM because
>     the physically hotplugged memory depletes the available memory before
>     it is onlined.
>  b) if the whole node is movable then we have off-node struct pages
>     which has performance drawbacks.
>  c) It might be there are no PMD_ALIGNED chunks so memmap array gets
>     populated with base pages.
> 
> This can be improved when CONFIG_SPARSEMEM_VMEMMAP is enabled.
> 
> Vmemap page tables can map arbitrary memory. That means that we can
> reserve a part of the physically hotadded memory to back vmemmap page
> tables. This implementation uses the beginning of the hotplugged memory
> for that purpose.
> 
> There are some non-obviously things to consider though.  Vmemmap
> pages are allocated/freed during the memory hotplug events
> (add_memory_resource(), try_remove_memory()) when the memory is
> added/removed. This means that the reserved physical range is not online
> although it is used. The most obvious side effect is that pfn_to_online_page()
> returns NULL for those pfns. The current design expects that this
> should be OK as the hotplugged memory is considered a garbage until it
> is onlined. For example hibernation wouldn't save the content of those
> vmmemmaps into the image so it wouldn't be restored on resume but this
> should be OK as there no real content to recover anyway while metadata
> is reachable from other data structures (e.g. vmemmap page tables).
> 
> The reserved space is therefore (de)initialized during the {on,off}line
> events (mhp_{de}init_memmap_on_memory). That is done by extracting page
> allocator independent initialization from the regular onlining path.
> The primary reason to handle the reserved space outside of {on,off}line_pages
> is to make each initialization specific to the purpose rather than
> special case them in a single function.
> 
> As per above, the functions that are introduced are:
> 
>  - mhp_init_memmap_on_memory:
> 		       Initializes vmemmap pages by calling move_pfn_range_to_zone(),
> 		       calls kasan_add_zero_shadow(), and onlines as many sections
> 		       as vmemmap pages fully span.
>  - mhp_deinit_memmap_on_memory:
> 		       Offlines as many sections as vmemmap pages fully span,
> 		       removes the range from zhe zone by remove_pfn_range_from_zone(),
> 		       and calls kasan_remove_zero_shadow() for the range.
> 
> The new function memory_block_online() calls mhp_init_memmap_on_memory() before
> doing the actual online_pages(). Should online_pages() fail, we clean up
> by calling mhp_deinit_memmap_on_memory().
> Adjusting of present_pages is done at the end once we know that online_pages()
> succedeed.
> 
> On offline, memory_block_offline() needs to unaccount vmemmap pages from
> present_pages() before calling offline_pages().
> This is necessary because offline_pages() tears down some structures based
> on the fact whether the node or the zone become empty.
> If offline_pages() fails, we account back vmemmap pages.
> If it succeeds, we call mhp_deinit_memmap_on_memory().
> 
> Hot-remove:
> 
>  We need to be careful when removing memory, as adding and
>  removing memory needs to be done with the same granularity.
>  To check that this assumption is not violated, we check the
>  memory range we want to remove and if a) any memory block has
>  vmemmap pages and b) the range spans more than a single memory
>  block, we scream out loud and refuse to proceed.
> 
>  If all is good and the range was using memmap on memory (aka vmemmap pages),
>  we construct an altmap structure so free_hugepage_table does the right
>  thing and calls vmem_altmap_free instead of free_pagetable.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for updating the changelog.

Acked-by: Michal Hocko <mhocko@suse.com>

[...]
> @@ -648,9 +650,16 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
>  	 * decide to not expose all pages to the buddy (e.g., expose them
>  	 * later). We account all pages as being online and belonging to this
>  	 * zone ("present").
> +	 * When using memmap_on_memory, the range might not be aligned to
> +	 * MAX_ORDER_NR_PAGES - 1, but pageblock aligned. __ffs() will detect
> +	 * this and the first chunk to online will be pageblock_nr_pages.
>  	 */
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
> -		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
> +	for (pfn = start_pfn; pfn < end_pfn;) {
> +		int order = min(MAX_ORDER - 1UL, __ffs(pfn));
> +
> +		(*online_page_callback)(pfn_to_page(pfn), order);
> +		pfn += (1UL << order);
> +	}
>  
>  	/* mark all involved sections as online */
>  	online_mem_sections(start_pfn, end_pfn);

You have dropped the check for the overflow beyond end_pfn and this made
me think whether that is safe in general. It took me a while to realize
that end_pfn is always going to be within MAX_ORDER - 1 due to section
constrains (hopefully no surprises on some arches). Early init code is
in a much more complicated situation because the early memory maps can
have many oddities.

... just thinking out loud in case I need too to look that up again in
future...
-- 
Michal Hocko
SUSE Labs
