Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED52F3255FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhBYTAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:00:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233251AbhBYS7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614279488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lw++gPrd0qkbs0UPYsh3cqur+6MHk1b/4zyGUrpbpA0=;
        b=SJ4Ed+AM4cUQmiCrjkaAuhA34FCiAJ6k6dJL11fCOrmed7HTN/zriV6biGSPOWswvw3qlW
        TIuHeI0bTkp+QLCfdL+na4J83I/+4mSRbCGY/qoB4vjqdA4Gz2qLFHbvg3XRkHvWCVBbqm
        d+x6ZQZUQBI6VbH1cGIJIj1zyS5bntY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-d1IZYcFnNCe2TMVfs3IFVQ-1; Thu, 25 Feb 2021 13:58:06 -0500
X-MC-Unique: d1IZYcFnNCe2TMVfs3IFVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E8C21009615;
        Thu, 25 Feb 2021 18:58:04 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD3F56EF40;
        Thu, 25 Feb 2021 18:58:02 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v2 1/7] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <60afb5ca-230e-265f-9579-dac66a152c33@redhat.com>
Date:   Thu, 25 Feb 2021 19:58:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209133854.17399-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 14:38, Oscar Salvador wrote:
> Physical memory hotadd has to allocate a memmap (struct page array) for
> the newly added memory section. Currently, alloc_pages_node() is used
> for those allocations.
> 
> This has some disadvantages:
>   a) an existing memory is consumed for that purpose
>      (eg: ~2MB per 128MB memory section on x86_64)
>   b) if the whole node is movable then we have off-node struct pages
>      which has performance drawbacks.
>   c) It might be there are no PMD_ALIGNED chunks so memmap array gets
>      populated with base pages.
> 
> This can be improved when CONFIG_SPARSEMEM_VMEMMAP is enabled.
> 
> Vmemap page tables can map arbitrary memory.
> That means that we can simply use the beginning of each memory section and
> map struct pages there.
> struct pages which back the allocated space then just need to be treated
> carefully.
> 
> Implementation wise we will reuse vmem_altmap infrastructure to override
> the default allocator used by __populate_section_memmap.
> Part of the implementation also relies on memory_block structure gaining
> a new field which specifies the number of vmemmap_pages at the beginning.
> This comes in handy as in {online,offline}_pages, all the isolation and
> migration is being done on (buddy_start_pfn, end_pfn] range,
> being buddy_start_pfn = start_pfn + nr_vmemmap_pages.
> 
> In this way, we have:
> 
> (start_pfn, buddy_start_pfn - 1] = Initialized and PageReserved
> (buddy_start_pfn, end_pfn]       = Initialized and sent to buddy

nit: shouldn't it be

[start_pfn, buddy_start_pfn - 1]
[buddy_start_pfn, end_pfn - 1]

or

[start_pfn, buddy_start_pfn)
[buddy_start_pfn, end_pfn)

(I remember that "[" means inclusive and "(" means exclusive, I might be wrong :) )

I actually prefer the first variant.

> 
> Hot-remove:
> 
>   We need to be careful when removing memory, as adding and
>   removing memory needs to be done with the same granularity.
>   To check that this assumption is not violated, we check the
>   memory range we want to remove and if a) any memory block has
>   vmemmap pages and b) the range spans more than a single memory
>   block, we scream out loud and refuse to proceed.
> 
>   If all is good and the range was using memmap on memory (aka vmemmap pages),
>   we construct an altmap structure so free_hugepage_table does the right
>   thing and calls vmem_altmap_free instead of free_pagetable.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

[...]

>   /*
>    * online_page_callback contains pointer to current page onlining function.
>    * Initially it is generic_online_page(). If it is required it could be
> @@ -638,10 +640,20 @@ void generic_online_page(struct page *page, unsigned int order)
>   }
>   EXPORT_SYMBOL_GPL(generic_online_page);
>   
> -static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> +static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> +			       unsigned long buddy_start_pfn)
>   {
>   	const unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn;
> +	unsigned long pfn = buddy_start_pfn;
> +
> +	/*
> +	 * When using memmap_on_memory, the range might be unaligned as the
> +	 * first pfns are used for vmemmap pages. Align it in case we need to.
> +	 */
> +	if (pfn & ((1 << (MAX_ORDER - 1)) - 1)) {

if (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES))

> +		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
> +		pfn += 1 << pageblock_order;

pfn += pageblock_nr_pages;

Can you add a comment why we can be sure that we are off by  a single pageblock? What about s390x where a MAX_ORDER_NR_PAGES == 4 * pageblock_nr_pages?

Would it make thing simpler to just do a

while (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)) {
	(*online_page_callback)(pfn_to_page(pfn), 0);
	pfn++;
}

[...]


>   
>   	/*
>   	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
> @@ -1064,6 +1085,12 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>   	return device_online(&mem->dev);
>   }
>   
> +bool mhp_supports_memmap_on_memory(unsigned long size)
> +{
> +	return memmap_on_memory_enabled &&
> +	       size == memory_block_size_bytes();

Regarding my other comments as reply to the other patches, I'd move all magic you have when trying to enable right here.


>   
> -int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> +int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +			unsigned long nr_vmemmap_pages)
>   {
>   	const unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn, system_ram_pages = 0;
> +	unsigned long pfn, buddy_start_pfn, buddy_nr_pages, system_ram_pages = 0;
>   	unsigned long flags;
>   	struct zone *zone;
>   	struct memory_notify arg;
> @@ -1578,6 +1620,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
>   		return -EINVAL;
>   
> +	buddy_start_pfn = start_pfn + nr_vmemmap_pages;
> +	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
> +
>   	mem_hotplug_begin();
>   
>   	/*
> @@ -1613,7 +1658,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   	zone_pcp_disable(zone);
>   
>   	/* set above range as isolated */
> -	ret = start_isolate_page_range(start_pfn, end_pfn,
> +	ret = start_isolate_page_range(buddy_start_pfn, end_pfn,
>   				       MIGRATE_MOVABLE,
>   				       MEMORY_OFFLINE | REPORT_FAILURE);

Did you take care to properly adjust undo_isolate_page_range() as well? I can't spot it.


>   	if (ret) {
> @@ -1633,7 +1678,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   	}
>   
>   	do {
> -		pfn = start_pfn;
> +		pfn = buddy_start_pfn;
>   		do {
>   			if (signal_pending(current)) {
>   				ret = -EINTR;
> @@ -1664,18 +1709,18 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   		 * offlining actually in order to make hugetlbfs's object
>   		 * counting consistent.
>   		 */
> -		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
> +		ret = dissolve_free_huge_pages(buddy_start_pfn, end_pfn);
>   		if (ret) {
>   			reason = "failure to dissolve huge pages";
>   			goto failed_removal_isolated;
>   		}
>   
> -		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
> +		ret = test_pages_isolated(buddy_start_pfn, end_pfn, MEMORY_OFFLINE);
>   
>   	} while (ret);
>   
>   	/* Mark all sections offline and remove free pages from the buddy. */
> -	__offline_isolated_pages(start_pfn, end_pfn);
> +	__offline_isolated_pages(start_pfn, end_pfn, buddy_start_pfn);>   	pr_debug("Offlined Pages %ld\n", nr_pages);
>   
>   	/*
> @@ -1684,13 +1729,13 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   	 * of isolated pageblocks, memory onlining will properly revert this.
>   	 */
>   	spin_lock_irqsave(&zone->lock, flags);
> -	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
> +	zone->nr_isolate_pageblock -= buddy_nr_pages / pageblock_nr_pages;
>   	spin_unlock_irqrestore(&zone->lock, flags);
>   
>   	zone_pcp_enable(zone);
>   
>   	/* removal success */
> -	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
> +	adjust_managed_page_count(pfn_to_page(start_pfn), -buddy_nr_pages);
>   	zone->present_pages -= nr_pages;
>   
>   	pgdat_resize_lock(zone->zone_pgdat, &flags);
> @@ -1750,6 +1795,14 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
>   	return 0;
>   }
>   

[...]

> +static int get_nr_vmemmap_pages_cb(struct memory_block *mem, void *arg)
> +{
> +	unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
> +
> +	*nr_vmemmap_pages += mem->nr_vmemmap_pages;
> +	return mem->nr_vmemmap_pages;
> +}
> +

I think you can do this easier, all you want to know is if there
is any block that has nr_vmemmap_pages set - and return the value.

static int first_set_nr_vmemmap_pages_cb(struct memory_block *mem, void *arg)
{
	/* If not set, continue with the next block. */
	return mem->nr_vmemmap_pages;
}

...
> +		walk_memory_blocks(start, size, &nr_vmemmap_pages,
> +					 get_nr_vmemmap_pages_cb);

...

mem->nr_vmemmap_pages = walk_memory_blocks(start ...)



Looks quite promising, only a couple of things to fine-tune :) Thanks!

-- 
Thanks,

David / dhildenb

