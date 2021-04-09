Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5C35A02E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhDINmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:42:40 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:57653 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233655AbhDINmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:42:36 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id D71E0FAD4C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 14:42:22 +0100 (IST)
Received: (qmail 15210 invoked from network); 9 Apr 2021 13:42:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2021 13:42:22 -0000
Date:   Fri, 9 Apr 2021 14:42:21 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm/memory_hotplug: Make unpopulated zones PCP structures
 unreachable during hot remove
Message-ID: <20210409134221.GO3697@techsingularity.net>
References: <20210409120957.GM3697@techsingularity.net>
 <YHBL0e8s+EesIyDl@dhcp22.suse.cz>
 <YHBNDEAw1OqIWwb5@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YHBNDEAw1OqIWwb5@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:48:12PM +0200, Michal Hocko wrote:
> On Fri 09-04-21 14:42:58, Michal Hocko wrote:
> > On Fri 09-04-21 13:09:57, Mel Gorman wrote:
> > > zone_pcp_reset allegedly protects against a race with drain_pages
> > > using local_irq_save but this is bogus. local_irq_save only operates
> > > on the local CPU. If memory hotplug is running on CPU A and drain_pages
> > > is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
> > > offers no protection.
> > 
> > Yes, the synchronization aspect is bogus indeed.
> > 
> > > This patch reorders memory hotremove such that the PCP structures
> > > relevant to the zone are no longer reachable by the time the structures
> > > are freed.  With this reordering, no protection is required to prevent
> > > a use-after-free and the IRQs can be left enabled. zone_pcp_reset is
> > > renamed to zone_pcp_destroy to make it clear that the per-cpu structures
> > > are deleted when the function returns.
> > 
> > Wouldn't it be much easier to simply not destroy/reset pcp of an empty
> > zone at all? The whole point of this exercise seems to be described in
> > 340175b7d14d5. setup_zone_pageset can check for an already allocated pcp
> > and simply reinitialize it. 
> 
> I meant this
> 

It might be simplier but if the intention is to free as much memory
as possible during hot-remove, it seems wasteful to leave the per-cpu
structures behind if we do not have to. If a problem with my patch can
be spotted then I'm happy to go with an alternative fix but there are
two minor issues with your proposed fix.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e6a602e82860..b0fdda77e570 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6496,7 +6496,13 @@ void __meminit setup_zone_pageset(struct zone *zone)
>  	struct per_cpu_pageset *p;
>  	int cpu;
>  
> -	zone->pageset = alloc_percpu(struct per_cpu_pageset);
> +	/*
> +	 * zone could have gone completely offline during memory hotplug
> +	 * when the pgdat is left behind for simplicity. On a next onlining
> +	 * we do not need to reallocate pcp state.
> +	 */
> +	if (!zone->pageset)
> +		zone->pageset = alloc_percpu(struct per_cpu_pageset);

Should be "if (zone->pageset != &boot_pageset)" ?


>  	for_each_possible_cpu(cpu) {
>  		p = per_cpu_ptr(zone->pageset, cpu);
>  		pageset_init(p);
> @@ -8803,25 +8809,6 @@ void zone_pcp_enable(struct zone *zone)
>  	mutex_unlock(&pcp_batch_high_lock);
>  }
>  
> -void zone_pcp_reset(struct zone *zone)
> -{
> -	unsigned long flags;
> -	int cpu;
> -	struct per_cpu_pageset *pset;
> -
> -	/* avoid races with drain_pages()  */
> -	local_irq_save(flags);
> -	if (zone->pageset != &boot_pageset) {
> -		for_each_online_cpu(cpu) {
> -			pset = per_cpu_ptr(zone->pageset, cpu);
> -			drain_zonestat(zone, pset);
> -		}
> -		free_percpu(zone->pageset);
> -		zone->pageset = &boot_pageset;
> -	}
> -	local_irq_restore(flags);
> -}
> -

zone_pcp_reset still needs to exist to drain the remaining vmstats or
it'll break 5a883813845a ("memory-hotplug: fix zone stat
mismatch").

-- 
Mel Gorman
SUSE Labs
