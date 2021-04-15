Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64136081B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhDOLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbhDOLU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618485603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sheADQUeBo5yuHEij7C4j0pwAlHIfFWeMORBbPtinU=;
        b=UhlN1pZ/Z/ErspiJ2JRtSmNlSDfyzOGeDwUYWREoBSQpjD5N9shwDN/E46+S540rzJR3hd
        brgerNYh2jGZCOWnipNlgpGri/9ZavJKRHjpqDNAb+/8ZhLYOyQcL6bGUHv3NpuzNARzwR
        liXW/M74VA6UCO0YRbHGZjcdKJmwBXk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-338IBRr3Ne2EbgosHG8v1A-1; Thu, 15 Apr 2021 07:20:02 -0400
X-MC-Unique: 338IBRr3Ne2EbgosHG8v1A-1
Received: by mail-wr1-f70.google.com with SMTP id s9-20020a5d51090000b02901028ea30da6so2595878wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 04:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9sheADQUeBo5yuHEij7C4j0pwAlHIfFWeMORBbPtinU=;
        b=luzIijiyNcIxdW8gs6GuZDM0iapWUrWlkyfA/hyHlTLCgqwxpADJHCAVECbShHXbTV
         kKCWg3/h74ULGb3Z08YVOaO5uNXiBXd6Dfd3oET/Mr4fpCP3ETlpzX+U4sdVBdwKFugO
         q7P+tpDDkqp728TMmeLex4fS/vxbf+NylJHAEpD8jbUhNYPEH6EXrt88gWNHBxLUOtIv
         CpWX6O1nrW/DMFRvgBC05BEKDJnvLNEj8hGBEFIDu2TMwC9km2r9fbZXyUJRFSgQIwNm
         1RE5zW7p6jArHyToJrmSz+m1olMN4164Ng4gU7n99gNWK4wGE1Gk8TzaeNiPWXIY2o5s
         prNA==
X-Gm-Message-State: AOAM532F/x1N93rNHoJLttmbULhSbxnkYEh0hZZUKN50LjXmNwjEcJog
        sV7in8N5kvUxkY0LHB91Wic+U6oYuXtO/chSDd36fOn7dhHkHNsw1WOsqUaDdf6VBn6QH8/rdXb
        dVOMC4nNEaM6U4wYOdhAYAf4YbC5PHoAozlMm+rXjLW9u0iNalNrsutBv28yh7MKdtlT6oEAC
X-Received: by 2002:a5d:4b81:: with SMTP id b1mr2917114wrt.243.1618485600953;
        Thu, 15 Apr 2021 04:20:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+rhU5G5K6ftzgu4Po2sB5eFU+NHlz9MrWl+BeAIyTrHSLkurmRgZ6RkIUdttREpDYvCXD0w==
X-Received: by 2002:a5d:4b81:: with SMTP id b1mr2917072wrt.243.1618485600621;
        Thu, 15 Apr 2021 04:20:00 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6392.dip0.t-ipconnect.de. [91.12.99.146])
        by smtp.gmail.com with ESMTPSA id p18sm2407995wrs.68.2021.04.15.04.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 04:20:00 -0700 (PDT)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210408121804.10440-1-osalvador@suse.de>
 <20210408121804.10440-5-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <54bed4d3-631f-7d30-aa2c-f8dd2f2c6804@redhat.com>
Date:   Thu, 15 Apr 2021 13:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210408121804.10440-5-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.21 14:18, Oscar Salvador wrote:
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
>   - vmemmap_init_space: Initializes vmemmap pages by calling move_pfn_range_to_zone(),
> 		       calls kasan_add_zero_shadow() or the vmemmap range and marks
> 		       online as many sections as vmemmap pages fully span.
>   - vmemmap_adjust_pages: Accounts/substract vmemmap_pages to node and zone
> 			 present_pages
>   - vmemmap_deinit_space: Undoes what vmemmap_init_space does.
> 

This is a bit asynchronous; and the function names are not really expressing what is being done :) I'll try to come up with better names below.

It is worth mentioning that the real "mess" is that we want offline_pages() to properly handle zone->present_pages going to 0. Therefore, we want to manually mess with the present page count.


> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   drivers/base/memory.c          |  64 ++++++++++++++--
>   include/linux/memory.h         |   8 +-
>   include/linux/memory_hotplug.h |  13 ++++
>   include/linux/memremap.h       |   2 +-
>   include/linux/mmzone.h         |   7 +-
>   mm/Kconfig                     |   5 ++
>   mm/memory_hotplug.c            | 162 ++++++++++++++++++++++++++++++++++++++++-
>   mm/sparse.c                    |   2 -
>   8 files changed, 247 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f209925a5d4e..a5e536a3e9a4 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -173,16 +173,65 @@ static int memory_block_online(struct memory_block *mem)
>   {
>   	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>   	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> +	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
> +	int ret;
> +
> +	/*
> +	 * Although vmemmap pages have a different lifecycle than the pages
> +	 * they describe (they remain until the memory is unplugged), doing
> +	 * its initialization and accounting at hot-{online,offline} stage
> +	 * simplifies things a lot
> +	 */

I suggest detecting the zone in here and just passing it down to online_pages().

> +	if (nr_vmemmap_pages) {
> +		ret = vmemmap_init_space(start_pfn, nr_vmemmap_pages, mem->nid,
> +					 mem->online_type);
> +		if (ret)
> +			return ret;
> +	}
>   
> -	return online_pages(start_pfn, nr_pages, mem->online_type, mem->nid);
> +	ret = online_pages(start_pfn + nr_vmemmap_pages,
> +			   nr_pages - nr_vmemmap_pages, mem->online_type,
> +			   mem->nid);
> +
> +	/*
> +	 * Undo the work if online_pages() fails.
> +	 */
> +	if (ret && nr_vmemmap_pages) {
> +		vmemmap_adjust_pages(start_pfn, -nr_vmemmap_pages);
> +		vmemmap_deinit_space(start_pfn, nr_vmemmap_pages);
> +	}
> +
> +	return ret;
>   }

My take would be doing the present page adjustment after onlining succeeded:

static int memory_block_online(struct memory_block *mem)
{
	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
	struct zone *zone;
	int ret;

	zone = mhp_get_target_zone(mem->nid, mem->online_type);

	if (nr_vmemmap_pages) {
		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
		if (ret)
			return ret;
	}

	ret = online_pages(start_pfn + nr_vmemmap_pages, nr_pages - nr_vmemmap_pages, zone);
	if (ret) {
		if (nr_vmemmap_pages)
			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
		return ret;
	}

	/*
	 * Account once onlining succeeded. If the page was unpopulated,
	 * it is now already properly populated.
	 */
	if (nr_vmemmap_pages)
		adjust_present_page_count(zone, nr_vmemmap_pages);
	return 0;		
}

And the opposite:

static int memory_block_offline(struct memory_block *mem)
{
	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
	struct zone *zone;
	int ret;

	zone = page_zone(pfn_to_page(start_pfn));


	/*
	 * Unaccount before offlining, such that unpopulated zones can
	 * properly be torn down in offline_pages().
	 */
	if (nr_vmemmap_pages)
		adjust_present_page_count(zone, -nr_vmemmap_pages);

	ret = offline_pages(start_pfn + nr_vmemmap_pages, nr_pages - nr_vmemmap_pages);
	if (ret) {
		if (nr_vmemmap_pages)
			adjust_present_page_count(zone, +nr_vmemmap_pages);
		return ret;
	}

	if (nr_vmemmap_pages)
		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
	return 0;		
}

Having to do the present page adjustment manually is not completely nice,
but it's easier than manually having to mess with zones becomming populated/unpopulated
outside of online_pages()/offline_pages().


-- 
Thanks,

David / dhildenb

