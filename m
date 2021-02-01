Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E496630A48C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhBAJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232919AbhBAJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612172418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxqdfqW2coC69nGfoNGf/0rHSJtuxDNJRnNza9iJd/Q=;
        b=QBi9zVdjRDl7llFEr8NkWZ79+5Wi1mzb+jAXDr0+xxhNAMZYPKhxVZz4P2xRyGMcH4Uyhi
        2ZIHagKvbFzLF0sKXq2u17UEgtq1NBjEchsjePrkfUbNegD2rGbpn837OJdBGVDUW8GnJU
        a8FarfcTD/e8JObtMgK4sE6jUGPtCIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-Cq9-A-LAMPeTQ12BQbf8zQ-1; Mon, 01 Feb 2021 04:40:15 -0500
X-MC-Unique: Cq9-A-LAMPeTQ12BQbf8zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CEE71005D4F;
        Mon,  1 Feb 2021 09:40:13 +0000 (UTC)
Received: from localhost (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6373A5F705;
        Mon,  1 Feb 2021 09:40:00 +0000 (UTC)
Date:   Mon, 1 Feb 2021 17:39:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 2/2] mm: fix initialization of struct page for holes
 in memory layout
Message-ID: <20210201093958.GD28734@MiWiFi-R3L-srv>
References: <20210111194017.22696-1-rppt@kernel.org>
 <20210111194017.22696-3-rppt@kernel.org>
 <fe30ad3e-fab8-f9c6-b0ad-0d1d1a8e2807@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe30ad3e-fab8-f9c6-b0ad-0d1d1a8e2807@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/21 at 10:14am, David Hildenbrand wrote:
> On 11.01.21 20:40, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > There could be struct pages that are not backed by actual physical memory.
> > This can happen when the actual memory bank is not a multiple of
> > SECTION_SIZE or when an architecture does not register memory holes
> > reserved by the firmware as memblock.memory.
> > 
> > Such pages are currently initialized using init_unavailable_mem() function
> > that iterates through PFNs in holes in memblock.memory and if there is a
> > struct page corresponding to a PFN, the fields if this page are set to
> > default values and the page is marked as Reserved.
> > 
> > init_unavailable_mem() does not take into account zone and node the page
> > belongs to and sets both zone and node links in struct page to zero.
> > 
> > On a system that has firmware reserved holes in a zone above ZONE_DMA, for
> > instance in a configuration below:
> > 
> > 	# grep -A1 E820 /proc/iomem
> > 	7a17b000-7a216fff : Unknown E820 type
> > 	7a217000-7bffffff : System RAM
> > 
> > unset zone link in struct page will trigger
> > 
> > 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
> > 
> > because there are pages in both ZONE_DMA32 and ZONE_DMA (unset zone link in
> > struct page) in the same pageblock.
> > 
> > Update init_unavailable_mem() to use zone constraints defined by an
> > architecture to properly setup the zone link and use node ID of the
> > adjacent range in memblock.memory to set the node link.
> > 
> > Fixes: 73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather that check each PFN")
> > Reported-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >   mm/page_alloc.c | 84 +++++++++++++++++++++++++++++--------------------
> >   1 file changed, 50 insertions(+), 34 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index bdbec4c98173..0b56c3ca354e 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7077,23 +7077,26 @@ void __init free_area_init_memoryless_node(int nid)
> >    * Initialize all valid struct pages in the range [spfn, epfn) and mark them
> >    * PageReserved(). Return the number of struct pages that were initialized.
> >    */
> > -static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
> > +static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn,
> > +					 int zone, int nid)
> >   {
> > -	unsigned long pfn;
> > +	unsigned long pfn, zone_spfn, zone_epfn;
> >   	u64 pgcnt = 0;
> > +	zone_spfn = arch_zone_lowest_possible_pfn[zone];
> > +	zone_epfn = arch_zone_highest_possible_pfn[zone];
> > +
> > +	spfn = clamp(spfn, zone_spfn, zone_epfn);
> > +	epfn = clamp(epfn, zone_spfn, zone_epfn);
> > +
> >   	for (pfn = spfn; pfn < epfn; pfn++) {
> >   		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> >   			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> >   				+ pageblock_nr_pages - 1;
> >   			continue;
> >   		}
> > -		/*
> > -		 * Use a fake node/zone (0) for now. Some of these pages
> > -		 * (in memblock.reserved but not in memblock.memory) will
> > -		 * get re-initialized via reserve_bootmem_region() later.
> > -		 */
> > -		__init_single_page(pfn_to_page(pfn), pfn, 0, 0);
> > +
> > +		__init_single_page(pfn_to_page(pfn), pfn, zone, nid);
> >   		__SetPageReserved(pfn_to_page(pfn));
> >   		pgcnt++;
> >   	}
> > @@ -7102,51 +7105,64 @@ static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
> >   }
> >   /*
> > - * Only struct pages that are backed by physical memory are zeroed and
> > - * initialized by going through __init_single_page(). But, there are some
> > - * struct pages which are reserved in memblock allocator and their fields
> > - * may be accessed (for example page_to_pfn() on some configuration accesses
> > - * flags). We must explicitly initialize those struct pages.
> > + * Only struct pages that correspond to ranges defined by memblock.memory
> > + * are zeroed and initialized by going through __init_single_page() during
> > + * memmap_init().
> > + *
> > + * But, there could be struct pages that correspond to holes in
> > + * memblock.memory. This can happen because of the following reasons:
> > + * - phyiscal memory bank size is not necessarily the exact multiple of the
> > + *   arbitrary section size
> > + * - early reserved memory may not be listed in memblock.memory
> > + * - memory layouts defined with memmap= kernel parameter may not align
> > + *   nicely with memmap sections
> >    *
> > - * This function also addresses a similar issue where struct pages are left
> > - * uninitialized because the physical address range is not covered by
> > - * memblock.memory or memblock.reserved. That could happen when memblock
> > - * layout is manually configured via memmap=, or when the highest physical
> > - * address (max_pfn) does not end on a section boundary.
> > + * Explicitly initialize those struct pages so that:
> > + * - PG_Reserved is set
> > + * - zone link is set accorging to the architecture constrains
> > + * - node is set to node id of the next populated region except for the
> > + *   trailing hole where last node id is used
> >    */
> > -static void __init init_unavailable_mem(void)
> > +static void __init init_zone_unavailable_mem(int zone)
> >   {
> > -	phys_addr_t start, end;
> > -	u64 i, pgcnt;
> > -	phys_addr_t next = 0;
> > +	unsigned long start, end;
> > +	int i, nid;
> > +	u64 pgcnt;
> > +	unsigned long next = 0;
> >   	/*
> > -	 * Loop through unavailable ranges not covered by memblock.memory.
> > +	 * Loop through holes in memblock.memory and initialize struct
> > +	 * pages corresponding to these holes
> >   	 */
> >   	pgcnt = 0;
> > -	for_each_mem_range(i, &start, &end) {
> > +	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid) {
> >   		if (next < start)
> > -			pgcnt += init_unavailable_range(PFN_DOWN(next),
> > -							PFN_UP(start));
> > +			pgcnt += init_unavailable_range(next, start, zone, nid);
> >   		next = end;
> >   	}
> >   	/*
> > -	 * Early sections always have a fully populated memmap for the whole
> > -	 * section - see pfn_valid(). If the last section has holes at the
> > -	 * end and that section is marked "online", the memmap will be
> > -	 * considered initialized. Make sure that memmap has a well defined
> > -	 * state.
> > +	 * Last section may surpass the actual end of memory (e.g. we can
> > +	 * have 1Gb section and 512Mb of RAM pouplated).
> > +	 * Make sure that memmap has a well defined state in this case.
> >   	 */
> > -	pgcnt += init_unavailable_range(PFN_DOWN(next),
> > -					round_up(max_pfn, PAGES_PER_SECTION));
> > +	end = round_up(max_pfn, PAGES_PER_SECTION);
> > +	pgcnt += init_unavailable_range(next, end, zone, nid);
> >   	/*
> >   	 * Struct pages that do not have backing memory. This could be because
> >   	 * firmware is using some of this memory, or for some other reasons.
> >   	 */
> >   	if (pgcnt)
> > -		pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcnt);
> > +		pr_info("Zone %s: zeroed struct page in unavailable ranges: %lld pages", zone_names[zone], pgcnt);
> > +}
> > +
> > +static void __init init_unavailable_mem(void)
> > +{
> > +	int zone;
> > +
> > +	for (zone = 0; zone < ZONE_MOVABLE; zone++)
> > +		init_zone_unavailable_mem(zone);
> 
> Why < ZONE_MOVABLE?
> 
> I remember we can have memory holes inside the movable zone when messing
> with "movablecore" cmdline parameter.

Maybe because we haven't initialized MOABLE zone info at this time.

