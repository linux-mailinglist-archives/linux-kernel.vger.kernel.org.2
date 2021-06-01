Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D79396CB3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhFAFSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:18:31 -0400
Received: from foss.arm.com ([217.140.110.172]:39644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhFAFSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:18:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CCA11FB;
        Mon, 31 May 2021 22:16:49 -0700 (PDT)
Received: from [10.163.82.105] (unknown [10.163.82.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C7523F774;
        Mon, 31 May 2021 22:16:46 -0700 (PDT)
Subject: Re: [PATCH] mm,memory_hotplug: Drop unneeded locking
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210531093958.15021-1-osalvador@suse.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <679d311a-8ad4-bb53-18f0-11190a2bf1b5@arm.com>
Date:   Tue, 1 Jun 2021 10:47:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210531093958.15021-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/21 3:09 PM, Oscar Salvador wrote:
> Currently, memory-hotplug code takes zone's span_writelock
> and pgdat's resize_lock when resizing the node/zone's spanned
> pages via {move_pfn_range_to_zone(),remove_pfn_range_from_zone()}
> and when resizing node and zone's present pages via
> adjust_present_page_count().
> 
> These locks are also taken during the initialization of the system
> at boot time, where it protects parallel struct page initialization,
> but they should not really be needed in memory-hotplug where all
> operations are a) synchronized on device level and b) serialized by
> the mem_hotplug_lock lock.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 075b34803fec..9edbc57055bf 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -329,7 +329,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  	unsigned long pfn;
>  	int nid = zone_to_nid(zone);
>  
> -	zone_span_writelock(zone);
>  	if (zone->zone_start_pfn == start_pfn) {
>  		/*
>  		 * If the section is smallest section in the zone, it need
> @@ -362,7 +361,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  			zone->spanned_pages = 0;
>  		}
>  	}
> -	zone_span_writeunlock(zone);
>  }
>  
>  static void update_pgdat_span(struct pglist_data *pgdat)
> @@ -424,10 +422,8 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
>  
>  	clear_zone_contiguous(zone);
>  
> -	pgdat_resize_lock(zone->zone_pgdat, &flags);
>  	shrink_zone_span(zone, start_pfn, start_pfn + nr_pages);
>  	update_pgdat_span(pgdat);
> -	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>  
>  	set_zone_contiguous(zone);
>  }
> @@ -638,15 +634,10 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  
>  	clear_zone_contiguous(zone);
>  
> -	/* TODO Huh pgdat is irqsave while zone is not. It used to be like that before */
> -	pgdat_resize_lock(pgdat, &flags);
> -	zone_span_writelock(zone);
>  	if (zone_is_empty(zone))
>  		init_currently_empty_zone(zone, start_pfn, nr_pages);
>  	resize_zone_range(zone, start_pfn, nr_pages);
> -	zone_span_writeunlock(zone);
>  	resize_pgdat_range(pgdat, start_pfn, nr_pages);
> -	pgdat_resize_unlock(pgdat, &flags);
>  
>  	/*
>  	 * Subsection population requires care in pfn_to_online_page().
> @@ -739,9 +730,7 @@ void adjust_present_page_count(struct zone *zone, long nr_pages)
>  	unsigned long flags;
>  
>  	zone->present_pages += nr_pages;
> -	pgdat_resize_lock(zone->zone_pgdat, &flags);
>  	zone->zone_pgdat->node_present_pages += nr_pages;
> -	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>  }
>  
>  int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
> 

Should also just drop zone_span_write[lock|unlock]() helpers as there
are no users left ?
