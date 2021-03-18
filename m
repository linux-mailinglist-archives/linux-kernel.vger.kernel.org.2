Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFD834038A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhCRKj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:39:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhCRKiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:38:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAD23AC1E;
        Thu, 18 Mar 2021 10:38:52 +0000 (UTC)
Date:   Thu, 18 Mar 2021 11:38:48 +0100
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
Message-ID: <YFMtuKZ8Ho66D8hN@localhost.localdomain>
References: <20210309175546.5877-1-osalvador@suse.de>
 <20210309175546.5877-2-osalvador@suse.de>
 <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
 <20210315102224.GA24699@linux>
 <a2bf7b25-1e7a-bb6b-2fcd-08a4f4636ed5@redhat.com>
 <a03fcbb3-5b77-8671-6376-13c360f5ae25@redhat.com>
 <20210317140847.GA20407@linux>
 <f996f570-eed9-509f-553c-280a62dc6d20@redhat.com>
 <YFMPBFSJPq2VEOk9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFMPBFSJPq2VEOk9@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:27:48AM +0100, Oscar Salvador wrote:
> > If we check for
> > 
> > IS_ALIGNED(nr_vmemmap_pages, PMD_SIZE), please add a proper TODO comment
> > that this is most probably the wrong place to take care of this.
> 
> Sure, I will stuff the check in there and place a big TODO comment so we
> do not forget about addressing this issue the right way.

Ok, I realized something while working on v5.

Here is what I have right now:

 bool mhp_supports_memmap_on_memory(unsigned long size)
 {
        /*
         * Note: We calculate for a single memory section. The calculation
         * implicitly covers memory blocks that span multiple sections.
         *
         * Not all archs define SECTION_SIZE, but MIN_MEMORY_BLOCK_SIZE always
         * equals SECTION_SIZE, so use that instead.
         */
        unsigned long nr_vmemmap_pages = MIN_MEMORY_BLOCK_SIZE / PAGE_SIZE;
        unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
        unsigned long remaining_size = size - vmemmap_size;
 
        /*
         * Besides having arch support and the feature enabled at runtime, we
         * need a few more assumptions to hold true:
         *
         * a) We span a single memory block: memory onlining/offlinin;g happens
         *    in memory block granularity. We don't want the vmemmap of online
         *    memory blocks to reside on offline memory blocks. In the future,
         *    we might want to support variable-sized memory blocks to make the
         *    feature more versatile.
         *
         * b) The vmemmap pages span complete PMDs: We don't want vmemmap code
         *    to populate memory from the altmap for unrelated parts (i.e.,
         *    other memory blocks)
         *
         * c) The vmemmap pages (and thereby the pages that will be exposed to
         *    the buddy) have to cover full pageblocks: memory onlining/offlining
         *    code requires applicable ranges to be page-aligned, for example, to
         *    set the migratetypes properly.
         *
         * TODO: Although we have a check here to make sure that vmemmap pages
         *       fully populate a PMD, it is not the right place to check for
         *       this. A much better solution involves improving vmemmap code
         *       to fallback to base pages when trying to populate vmemmap using
         *       altmap as an alternative source of memory, and we do not exactly
         *       populate a single PMD.
         */
        return memmap_on_memory &&
               IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
               size == memory_block_size_bytes() &&
               remaining_size &&
               IS_ALIGNED(remaining_size, pageblock_size) &&
               IS_ALIGNED(vmemmap_size, PMD_SIZE);
 }

 Assume we are on x86_64 to simplify the case.

 Above, nr_vmemmap_pages would be 32768 and vmemmap_size 2MB (exactly a
 PMD).

 Now, although correct, this nr_vmemmap_pages does not match with the
 altmap->alloc.

 static void * __meminit altmap_alloc_block_buf(unsigned long size,
  struct altmap)
 {
   ...
   ...
   nr_pfns = size >> PAGE_SHIFT; //size is PMD_SIZE
   altmap->alloc += nr_pfns;
 }

 altmap->alloc will be 512, 512 * 4K pages = 2MB.

Of course, the reason they do not match is because in one case, we are
saying a) how many pfns we need to cover a PMD_SIZE, while in the
other case we say b) how many pages we need to cover SECTION_SIZE

Then b) multiply for page_size to get the current size of it.

So, I have mixed feeling about this.
Would it be more clear to just do:

 bool mhp_supports_memmap_on_memory(unsigned long size)
 {
        /*
         * Note: We calculate for a single memory section. The calculation
         * implicitly covers memory blocks that span multiple sections.
         */
        unsigned long nr_vmemmap_pages = PMD_SIZE / PAGE_SIZE;
        unsigned long vmemmap_size = nr_vmemmap_pages * PAGE_SIZE;
        unsigned long remaining_size = size - vmemmap_size;
	...
	...


-- 
Oscar Salvador
SUSE L3
