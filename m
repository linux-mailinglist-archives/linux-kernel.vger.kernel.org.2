Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E0361E01
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbhDPKeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235350AbhDPKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618569219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPxWXQjYmYAvrhIYXMRfmvVPZD5pNgtjy/TXa+spbAM=;
        b=Is6C+bJtgpO0uIxLS56wRq4EfcdBnpFzVcKuzWJmw5q0Z3jejjTYI447rvg4SCrGSP8eLL
        yetzmYS3j2TmFQLaRK/FVdOzJTm9M7oClQO59bebkYlkSxTqGArzbGoQiLB4OvwQw/OMXH
        V/6scm77t3LghrtRwKbWhCcBPEEx+iY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-F42fIc1BP8q8Ol20W2yLsw-1; Fri, 16 Apr 2021 06:33:37 -0400
X-MC-Unique: F42fIc1BP8q8Ol20W2yLsw-1
Received: by mail-wm1-f71.google.com with SMTP id k26-20020a7bc41a0000b0290125f388fcfbso4028988wmi.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HPxWXQjYmYAvrhIYXMRfmvVPZD5pNgtjy/TXa+spbAM=;
        b=WWQXoh5ALg842jjciDEmuHW9WTH/h8PRHijOAE8XyrGoptMA4XMPA4EtGvpGsPdoH2
         ++CweGfe2BzVbEtpggvYWPQoeuJk9f8wF1Vp0xLBMHN+xrC2H4Br1ySvzm9SBH4oecTF
         D7B7FM3VW8HmV1pQ9Tj1eGqEg4d7rts8fQruaNAqKDPE3IVhQ2FulCbtOf9dgcXUY338
         pkDnwaOmhgnZCcSJcn85sKOaFm5JunoLs52et0ujSujvNHlehI3vDpsWD3y7jbzGHPj9
         4VoCMMQqYmApPZm3B6gmhloqG+IcmqGL3Hf61aM96j7/xf4g7yLkUHRmTDwNuIp/a2bW
         ohWw==
X-Gm-Message-State: AOAM533+fJCG3GO/AcWVv97vqgwEbaKqLkW2V2P7virEb3k+zWRi7JGS
        CmQsB8uvd09TTxs52O9Fdks+vYgiIH/S0bxRSahdlH8v/M/tNEUA8VzKUYtlsOdRjl1/zrZ77bL
        0VDUXxz9Kwhgbb9X9Acr9+J3tPMUSkvAniQM9QGdg3wpunitMXMRSeFn+xiyIoS0Ijv0soGlT
X-Received: by 2002:adf:b1d3:: with SMTP id r19mr8568414wra.97.1618569215923;
        Fri, 16 Apr 2021 03:33:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIRplpL1O+iW76z0hJNj6szizw5N585pJVP/CAeqkoDjjPOi2Inf4or+qnplyqURwWofflmw==
X-Received: by 2002:adf:b1d3:: with SMTP id r19mr8568371wra.97.1618569215546;
        Fri, 16 Apr 2021 03:33:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fb.dip0.t-ipconnect.de. [91.12.100.251])
        by smtp.gmail.com with ESMTPSA id 2sm6558635wmi.19.2021.04.16.03.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 03:33:35 -0700 (PDT)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210416102153.8794-1-osalvador@suse.de>
 <20210416102153.8794-5-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <df8220ac-4214-5ff6-0048-35553fea8c8c@redhat.com>
Date:   Fri, 16 Apr 2021 12:33:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210416102153.8794-5-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.21 12:21, Oscar Salvador wrote:
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
> This patch also introduces the following functions:
> 
>   - mhp_init_memmap_on_memory:
> 		       Initializes vmemmap pages by calling move_pfn_range_to_zone(),
> 		       calls kasan_add_zero_shadow(), and onlines as many sections
> 		       as vmemmap pages fully span.
>   - mhp_deinit_memmap_on_memory:
> 		       Undoes what mhp_init_memmap_on_memory.
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
> ---
>   drivers/base/memory.c          |  75 ++++++++++++++++--
>   include/linux/memory.h         |   8 +-
>   include/linux/memory_hotplug.h |  17 +++-
>   include/linux/memremap.h       |   2 +-
>   include/linux/mmzone.h         |   7 +-
>   mm/Kconfig                     |   5 ++
>   mm/memory_hotplug.c            | 171 ++++++++++++++++++++++++++++++++++++++---
>   mm/sparse.c                    |   2 -
>   8 files changed, 265 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f209925a5d4e..179857d53982 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -173,16 +173,76 @@ static int memory_block_online(struct memory_block *mem)
>   {
>   	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>   	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> +	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
> +	struct zone *zone;
> +	int ret;
> +
> +	zone = mhp_get_target_zone(start_pfn, nr_pages, mem->nid,
> +				   mem->online_type);
> +
> +	/*
> +	 * Although vmemmap pages have a different lifecycle than the pages
> +	 * they describe (they remain until the memory is unplugged), doing
> +	 * its initialization and accounting at hot-{online,offline} stage

s/its/their/

s/hot-{online,offline}/memory onlining/offlining stage/

> +	 * simplifies things a lot
> +	 */
> +	if (nr_vmemmap_pages) {
> +		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = online_pages(start_pfn + nr_vmemmap_pages,
> +			   nr_pages - nr_vmemmap_pages, zone);
> +	if (ret) {
> +		if (nr_vmemmap_pages)
> +			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Account once onlining succeeded. If the page was unpopulated, it is

s/page/zone/

> +	 * now already properly populated.
> +	 */
> +	if (nr_vmemmap_pages)
> +		adjust_present_page_count(zone, nr_vmemmap_pages);
>   
> -	return online_pages(start_pfn, nr_pages, mem->online_type, mem->nid);
> +	return ret;
>   }
>   
>   static int memory_block_offline(struct memory_block *mem)
>   {
>   	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>   	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> +	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
> +	struct zone *zone;
> +	int ret;
> +
> +	zone = page_zone(pfn_to_page(start_pfn));
>   
> -	return offline_pages(start_pfn, nr_pages);
> +	/*
> +	 * Unaccount before offlining, such that unpopulated zone and kthreads
> +	 * can properly be torn down in offline_pages().
> +	 */
> +	if (nr_vmemmap_pages)
> +		adjust_present_page_count(zone, -nr_vmemmap_pages);
> +
> +	ret = offline_pages(start_pfn + nr_vmemmap_pages,
> +			    nr_pages - nr_vmemmap_pages);
> +	if (ret) {
> +		/* offline_pages() failed. Account back. */
> +		if (nr_vmemmap_pages)
> +			adjust_present_page_count(zone, nr_vmemmap_pages);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Re-adjust present pages if offline_pages() fails.
> +	 */

That comment is stale. I'd just drop it.

> +	if (nr_vmemmap_pages)
> +		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
> +
> +	return ret;
>   }

[...]

> -static void adjust_present_page_count(struct zone *zone, long nr_pages)
> +/*
> + * This function should only be called by memory_block_{online,offline},
> + * and {online,offline}_pages.
> + */
> +void adjust_present_page_count(struct zone *zone, long nr_pages)
>   {
>   	unsigned long flags;
>   
> @@ -839,12 +850,64 @@ static void adjust_present_page_count(struct zone *zone, long nr_pages)
>   	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>   }
>   
> -int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> -		       int online_type, int nid)
> +struct zone *mhp_get_target_zone(unsigned long pfn, unsigned long nr_pages,
> +				 int nid, int online_type)
> +{
> +	return zone_for_pfn_range(online_type, nid, pfn, nr_pages);
> +}
> +

Oh, you can just use zone_for_pfn_range() directly for now. No need for 
mhp_get_target_zone(). Sorry for not realizing this.

> +int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
> +			      struct zone *zone)
> +{
> +	unsigned long end_pfn = pfn + nr_pages;
> +	int ret;
> +
> +	/*
> +	 * Initialize vmemmap pages with the corresponding node, zone links set.
> +	 */
> +	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
> +
> +	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
> +	if (ret) {
> +		remove_pfn_range_from_zone(zone, pfn, nr_pages);
> +		return ret;
> +	}

IIRC, we have to add the zero shadow first, before touching the memory. 
This is also what mm/memremap.c does.

In mhp_deinit_memmap_on_memory(), you already remove in the proper 
(reversed) order :)

> +
> +int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *zone)
>   {
>   	unsigned long flags;
> -	struct zone *zone;
>   	int need_zonelists_rebuild = 0;
> +	int nid;
>   	int ret;
>   	struct memory_notify arg;
>   
> @@ -860,8 +923,9 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>   
>   	mem_hotplug_begin();
>   
> +	nid = zone_to_nid(zone);

I'd do that right above

const int nid = zone_to_nid(zone);

[...]

-- 
Thanks,

David / dhildenb

