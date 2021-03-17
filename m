Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A1133F24D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCQOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:09:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhCQOIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:08:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51B69ACA8;
        Wed, 17 Mar 2021 14:08:54 +0000 (UTC)
Date:   Wed, 17 Mar 2021 15:08:51 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210317140847.GA20407@linux>
References: <20210309175546.5877-1-osalvador@suse.de>
 <20210309175546.5877-2-osalvador@suse.de>
 <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
 <20210315102224.GA24699@linux>
 <a2bf7b25-1e7a-bb6b-2fcd-08a4f4636ed5@redhat.com>
 <a03fcbb3-5b77-8671-6376-13c360f5ae25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a03fcbb3-5b77-8671-6376-13c360f5ae25@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 06:45:17PM +0100, David Hildenbrand wrote:
> > I find that cross reference to vmemmap code a little hard to digest.
> > I would have assume that we don't have to care about PMDs in this
> > code here at all. The vmemmap population code should handle that.
> > 
> > I think I already mentioned that somewhere, I think it should be like this:
> > 
> > a) vmemmap code should *never* populate more memory than requested for
> > a single memory section when we are populating from the altmap.
> > If that cannot be guaranteed for PMDs, then we have to fallback
> > to populating base pages. Populating PMDs from an altmap with
> > sizeof(struct page) == 64 is highly dangerous.

I guess you meant sizeof(struct page) != 64

But other usecases of using altmap (ZONE_DEVICE stuff) might not care whether
they have sub-populated PMDs when populating sections from altmap?

Current vmemmap code populates PMD with PMD_SIZE if empty, and with basepages
if there are still holes.

> > Assume we have sizeof(struct page) == 56. A 128 MiB section
> > spans 32768 pages -  we need 32768 * sizeof(struct page)
> > space for the vmemmap.
> > With 64k pages we *can* use exactly one PMD. With 56k pages
> > we need 448 individual (full!) pages for the vmemmap.
> > 
> > IOW, we don't care how vmemmap code will do the mapping.
> > vmemmap code has to get it right. IMHO, asserting it in
> > this code is wrong.
> > 
> > 
> > b) In this code, we really should only care about what
> > memory onlining/offlining code can or can't do.
> > We really only care that
> > 
> > 1) size == memory_block_size_bytes()
> > 2) remaining_size
> > 3) IS_ALIGNED(remaining_size, pageblock_size);

I agree with the above, but see below:

> > Okay, please document the statement about single sections, that's
> > important to understand what's happening.
> > 
> > My take would be
> > 
> > bool mhp_supports_memmap_on_memory(unsigned long size)
> > {
> > 	/*
> > 	 * Note: We calculate for a single memory section. The calculation
> > 	 */
> > 	unsigned long nr_vmemmap_pages = SECTION_SIZE / PAGE_SIZE;
> > 	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
> > 	unsigned long remaining_size = size - vmemmap_size;

While it might be true that we need to back off from populating with altmap in
case PMDs are not going to be fully populated because of the size of the struct
page (I am not still not sure though as I said above, other usecases might not
care at all), I would go __for now__ with placing vmemmap_size == PMD_SIZE in
the check below as well.

If the check comes true, we know that we fully populate PMDs when populating
sections, so the feature can be used.

Then I commit to have a look whether we need to back off in vmemmap-populating
code in case altmap && !NOT_FULLY_POPULATED_PMDS. 

What do you think?

-- 
Oscar Salvador
SUSE L3
