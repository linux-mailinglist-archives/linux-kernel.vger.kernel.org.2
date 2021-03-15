Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECB33AFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhCOKWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:22:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhCOKWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:22:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC76DAD72;
        Mon, 15 Mar 2021 10:22:32 +0000 (UTC)
Date:   Mon, 15 Mar 2021 11:22:29 +0100
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
Message-ID: <20210315102224.GA24699@linux>
References: <20210309175546.5877-1-osalvador@suse.de>
 <20210309175546.5877-2-osalvador@suse.de>
 <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 08:06:53PM +0100, David Hildenbrand wrote:
> This looks essentially good to me, except some parts in
> mhp_supports_memmap_on_memory()
> 
> > +bool mhp_supports_memmap_on_memory(unsigned long size)
> > +{
> > +	unsigned long pageblock_size = PFN_PHYS(pageblock_nr_pages);
> > +	unsigned long remaining_mem = size - PMD_SIZE;

Hi David, thanks for the review!

> This looks weird. I think what you want to test is that
> 
> 
> a) "nr_vmemmap_pages * sizeof(struct page)" spans complete PMDs (IOW, we
> won't map too much via the altmap when populating a PMD in the vmemmap)
> 
> b) "remaining = size - nr_vmemmap_pages * sizeof(struct page)" spans
> complete pageblock.

We do not know the nr_vmemmap_pages at this point in time, although it is
easy to pre-compute.

For every section we populate, we use PMD_SIZE. So, PMD_SIZE/PAGE_SIZE lays
the nr_vmemmap_pages that are used for populating a single section.

But let me explain the reasoning I use in the current code:

I will enumarate the assumptions that must hold true in order to support the
feature together with their check:

- We span a single memory block

  size == memory_block_size_bytes()

- The vmemmap pages span a complete PMD and no more than a PMD.

  !(PMD_SIZE % sizeof(struct page))

- The vmemmap pages and the pages exposed to the buddy have to cover full
  pageblocks

  remaining_mem = size - PMD_SIZE;
  IS_ALIGNED(remaining_mem, pageblock_size)

  Although this check only covers the range without the vmemmap pages, one could
  argue that since we use only a PMD_SIZE at a time, we know that PMD_SIZE is
  pageblock aligned, so the vmemmap range is PMD_SIZE as well.

Now, I see how this might be confusing and rather incomplete.
So I guess a better and more clear way to write it would be:

 bool mhp_supports_memmap_on_memory(unsigned long size)
 {
         unsigned long nr_vmemmap_pages = PMD_SIZE / PAGE_SIZE;
         unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
         unsigned long remaining_size = size - vmemmap_size;

         return memmap_on_memory &&
                IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
                size == memory_block_size_bytes() &&
                !(PMD_SIZE % vmemmap_size) &&
                IS_ALIGNED(vmemmap_size, pageblock_size) &&
                remaining_size &&
                IS_ALIGNED(remaining_size, pageblock_size);
  }
                
Note that above check is only for a single section, but if assumptions hold true
for a single section, it will for many as well.
We could be orthodox and do:

 bool mhp_supports_memmap_on_memory(unsigned long size)
 {
         unsigned long nr_sections = (1ULL << SECTION_SHIFT) / memory_block_size_bytes;
         unsigned long nr_vmemmap_pages = (PMD_SIZE / PAGE_SIZE) * nr_sections;
         unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
         unsigned long remaining_size = size - vmemmap_size;

         return memmap_on_memory &&
                IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
                size == memory_block_size_bytes() &&
                !(PMD_SIZE % vmemmap_size) &&
                IS_ALIGNED(vmemmap_size, pageblock_size) &&
                remaining_size &&
                IS_ALIGNED(remaining_size, pageblock_size);
  }
        
to check for all sections, but I do not think it is necessary.

What do you think?
	
> I suggest a restructuring, compressing the information like:
> 
> "
> Besides having arch support and the feature enabled at runtime, we need a
> few more assumptions to hold true:
> 
> a) We span a single memory block: memory onlining/offlining happens in
> memory block granularity. We don't want the vmemmap of online memory blocks
> to reside on offline memory blocks. In the future, we might want to support
> variable-sized memory blocks to make the feature more versatile.
> 
> b) The vmemmap pages span complete PMDs: We don't want vmemmap code to
> populate memory from the altmap for unrelated parts (i.e., other memory
> blocks).
> 
> c) The vmemmap pages (and thereby the pages that will be exposed to the
> buddy) have to cover full pageblocks: memory onlining/offlining code
> requires applicable ranges to be page-aligned, for example, to set the
> migratetypes properly.
> "

I am fine with the above, I already added it, thanks.

> Do we have to special case / protect against the vmemmap optimization for
> hugetlb pages? Or is that already blocked somehow and I missed it?

Yes, hugetlb-vmemmap feature disables vmemmap on PMD population [1]

[1] https://patchwork.kernel.org/project/linux-mm/patch/20210308102807.59745-7-songmuchun@bytedance.com/


-- 
Oscar Salvador
SUSE L3
