Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7488361A86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbhDPH0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:26:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:43588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhDPH0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:26:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C30C5AD22;
        Fri, 16 Apr 2021 07:25:58 +0000 (UTC)
Date:   Fri, 16 Apr 2021 09:25:56 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YHk8BCKwpKY0TM6p@localhost.localdomain>
References: <20210408121804.10440-1-osalvador@suse.de>
 <20210408121804.10440-5-osalvador@suse.de>
 <54bed4d3-631f-7d30-aa2c-f8dd2f2c6804@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54bed4d3-631f-7d30-aa2c-f8dd2f2c6804@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 01:19:59PM +0200, David Hildenbrand wrote:
> > Implementation wise we will reuse vmem_altmap infrastructure to override
> > the default allocator used by __populate_section_memmap.
> > Part of the implementation also relies on memory_block structure gaining
> > a new field which specifies the number of vmemmap_pages at the beginning.
> > This patch also introduces the following functions:
> > 
> >   - vmemmap_init_space: Initializes vmemmap pages by calling move_pfn_range_to_zone(),
> > 		       calls kasan_add_zero_shadow() or the vmemmap range and marks
> > 		       online as many sections as vmemmap pages fully span.
> >   - vmemmap_adjust_pages: Accounts/substract vmemmap_pages to node and zone
> > 			 present_pages
> >   - vmemmap_deinit_space: Undoes what vmemmap_init_space does.
> > 
> 
> This is a bit asynchronous; and the function names are not really expressing what is being done :) I'll try to come up with better names below.

Yeah, was not happy either with the names but at that time I could not
come up with anything better.

> It is worth mentioning that the real "mess" is that we want offline_pages() to properly handle zone->present_pages going to 0. Therefore, we want to manually mess with the present page count.

This should be explained by this:

"On offline, memory_block_offline() calls vmemmap_adjust_pages() prior to calling
offline_pages(), because offline_pages() performs the tearing-down of kthreads
and the rebuilding of the zonelists if the node/zone become empty."

Is not that clear?

> I suggest detecting the zone in here and just passing it down to online_pages().

Ok, makes sense.

> My take would be doing the present page adjustment after onlining succeeded:
> 
> static int memory_block_online(struct memory_block *mem)
> {
> 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> 	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
> 	struct zone *zone;
> 	int ret;
> 
> 	zone = mhp_get_target_zone(mem->nid, mem->online_type);
> 
> 	if (nr_vmemmap_pages) {
> 		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	ret = online_pages(start_pfn + nr_vmemmap_pages, nr_pages - nr_vmemmap_pages, zone);
> 	if (ret) {
> 		if (nr_vmemmap_pages)
> 			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
> 		return ret;
> 	}
> 
> 	/*
> 	 * Account once onlining succeeded. If the page was unpopulated,
> 	 * it is now already properly populated.
> 	 */
> 	if (nr_vmemmap_pages)
> 		adjust_present_page_count(zone, nr_vmemmap_pages);
> 	return 0;		
> }
> 
> And the opposite:
> 
> static int memory_block_offline(struct memory_block *mem)
> {
> 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> 	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
> 	struct zone *zone;
> 	int ret;
> 
> 	zone = page_zone(pfn_to_page(start_pfn));
> 
> 
> 	/*
> 	 * Unaccount before offlining, such that unpopulated zones can
> 	 * properly be torn down in offline_pages().
> 	 */
> 	if (nr_vmemmap_pages)
> 		adjust_present_page_count(zone, -nr_vmemmap_pages);
> 
> 	ret = offline_pages(start_pfn + nr_vmemmap_pages, nr_pages - nr_vmemmap_pages);
> 	if (ret) {
> 		if (nr_vmemmap_pages)
> 			adjust_present_page_count(zone, +nr_vmemmap_pages);
> 		return ret;
> 	}
> 
> 	if (nr_vmemmap_pages)
> 		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
> 	return 0;		
> }
> 
> Having to do the present page adjustment manually is not completely nice,
> but it's easier than manually having to mess with zones becomming populated/unpopulated
> outside of online_pages()/offline_pages().

Ok, I like this, and the naming is much better.
I will work on this shortly.

thanks David!

-- 
Oscar Salvador
SUSE L3
