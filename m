Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E680B3959CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhEaLjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:39:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhEaLjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:39:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622461043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tSnbJvwtWkKzbciU0FHdyWYcZOXXy1EHpV2IiYt+IQA=;
        b=tDS1/UUwOwLYrpv6/Huz+NCJm0mfet9iIylrmRXXXk2wN6o0uKv12nUL677U3VCq5Lxh2/
        3bvKu7t2+/gYGCRq68uyVkvABSZRRW1BICsfCS77LY8fEnQWZw0UeKcClt9hvRutBD7se7
        aHLu1jWc5n+EC6jUELa1oTwS3deTw/0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0EA76B4C4;
        Mon, 31 May 2021 11:37:23 +0000 (UTC)
Date:   Mon, 31 May 2021 13:37:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Drop unneeded locking
Message-ID: <YLTKcYZheltJgPKx@dhcp22.suse.cz>
References: <20210531093958.15021-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531093958.15021-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-05-21 11:39:58, Oscar Salvador wrote:
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

Thanks. I wanted to kill these locks quite some time ago (see the TODO
you are remonig ;)) but never got around to that.

Acked-by: Michal Hocko <mhocko@suse.com>

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
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
