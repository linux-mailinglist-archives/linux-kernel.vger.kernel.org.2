Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F053655AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhDTJqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:46:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:47304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDTJq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:46:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618911955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=14X461r6HBwVx+hhqwaqj6dMjiJR1g/Aupr5pNSp110=;
        b=pS/ibClZ+PdVBaXkraMfXYWWZyknMiWXYB0cOI3dg24PtHbbhEV2BLo3bWAsUSvzYYUhYS
        qu0SkdwpWsw4gquNGRqcNTtcrDSM5/NnKQqa8pNXEgkkqnOZNJE0SHgCKIX/LACaiMQUhp
        nsSi7QSEcymIN3J4n/1qtCZpvXkdUeo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCB0AADD7;
        Tue, 20 Apr 2021 09:45:55 +0000 (UTC)
Date:   Tue, 20 Apr 2021 11:45:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/8] mm,memory_hotplug: Factor out adjusting present
 pages into adjust_present_page_count()
Message-ID: <YH6i09ieDte+xog8@dhcp22.suse.cz>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416112411.9826-4-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-04-21 13:24:06, Oscar Salvador wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Let's have a single place (inspired by adjust_managed_page_count()) where
> we adjust present pages.
> In contrast to adjust_managed_page_count(), only memory onlining/offlining
> is allowed to modify the number of present pages.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Not sure self review counts ;)

Acked-by: Michal Hocko <mhocko@suse.com>

Btw. I strongly suspect the resize lock is quite pointless here.
Something for a follow up patch.

> ---
>  mm/memory_hotplug.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 25e59d5dc13c..d05056b3c173 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -829,6 +829,16 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
>  	return default_zone_for_pfn(nid, start_pfn, nr_pages);
>  }
>  
> +static void adjust_present_page_count(struct zone *zone, long nr_pages)
> +{
> +	unsigned long flags;
> +
> +	zone->present_pages += nr_pages;
> +	pgdat_resize_lock(zone->zone_pgdat, &flags);
> +	zone->zone_pgdat->node_present_pages += nr_pages;
> +	pgdat_resize_unlock(zone->zone_pgdat, &flags);
> +}
> +
>  int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  		       int online_type, int nid)
>  {
> @@ -882,11 +892,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	}
>  
>  	online_pages_range(pfn, nr_pages);
> -	zone->present_pages += nr_pages;
> -
> -	pgdat_resize_lock(zone->zone_pgdat, &flags);
> -	zone->zone_pgdat->node_present_pages += nr_pages;
> -	pgdat_resize_unlock(zone->zone_pgdat, &flags);
> +	adjust_present_page_count(zone, nr_pages);
>  
>  	node_states_set_node(nid, &arg);
>  	if (need_zonelists_rebuild)
> @@ -1701,11 +1707,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  
>  	/* removal success */
>  	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
> -	zone->present_pages -= nr_pages;
> -
> -	pgdat_resize_lock(zone->zone_pgdat, &flags);
> -	zone->zone_pgdat->node_present_pages -= nr_pages;
> -	pgdat_resize_unlock(zone->zone_pgdat, &flags);
> +	adjust_present_page_count(zone, -nr_pages);
>  
>  	init_per_zone_wmark_min();
>  
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
