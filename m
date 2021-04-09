Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE1835A1C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhDIPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:13:16 -0400
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:37249 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233915AbhDIPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:13:15 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id 1CF3EFAE9F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 16:13:01 +0100 (IST)
Received: (qmail 19328 invoked from network); 9 Apr 2021 15:13:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2021 15:13:00 -0000
Date:   Fri, 9 Apr 2021 16:12:59 +0100
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
Message-ID: <20210409151259.GP3697@techsingularity.net>
References: <20210409120957.GM3697@techsingularity.net>
 <YHBL0e8s+EesIyDl@dhcp22.suse.cz>
 <YHBNDEAw1OqIWwb5@dhcp22.suse.cz>
 <20210409134221.GO3697@techsingularity.net>
 <YHBmxwH41WEHuVJj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YHBmxwH41WEHuVJj@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 04:37:59PM +0200, Michal Hocko wrote:
> > > > Yes, the synchronization aspect is bogus indeed.
> > > > 
> > > > > This patch reorders memory hotremove such that the PCP structures
> > > > > relevant to the zone are no longer reachable by the time the structures
> > > > > are freed.  With this reordering, no protection is required to prevent
> > > > > a use-after-free and the IRQs can be left enabled. zone_pcp_reset is
> > > > > renamed to zone_pcp_destroy to make it clear that the per-cpu structures
> > > > > are deleted when the function returns.
> > > > 
> > > > Wouldn't it be much easier to simply not destroy/reset pcp of an empty
> > > > zone at all? The whole point of this exercise seems to be described in
> > > > 340175b7d14d5. setup_zone_pageset can check for an already allocated pcp
> > > > and simply reinitialize it. 
> > > 
> > > I meant this
> > > 
> > 
> > It might be simplier but if the intention is to free as much memory
> > as possible during hot-remove, it seems wasteful to leave the per-cpu
> > structures behind if we do not have to.
> 
> We do leave the whole pgdat behind. I do not think pagesets really do
> matter.
> 

Probably not given that zone and node hotplug is fragile to say the least
with a low success rate. Still, it seems wasteful if we can preserve the
freeing part and the alternative fix is more subtle than it appears.

> > If a problem with my patch can
> > be spotted then I'm happy to go with an alternative fix but there are
> > two minor issues with your proposed fix.
> 
> I will not insist but this code has proven to bitrot and I just find it
> much simpler to drop it altogether rather than conserve it in some form.
> Not something I would insist though.
> 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index e6a602e82860..b0fdda77e570 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -6496,7 +6496,13 @@ void __meminit setup_zone_pageset(struct zone *zone)
> > >  	struct per_cpu_pageset *p;
> > >  	int cpu;
> > >  
> > > -	zone->pageset = alloc_percpu(struct per_cpu_pageset);
> > > +	/*
> > > +	 * zone could have gone completely offline during memory hotplug
> > > +	 * when the pgdat is left behind for simplicity. On a next onlining
> > > +	 * we do not need to reallocate pcp state.
> > > +	 */
> > > +	if (!zone->pageset)
> > > +		zone->pageset = alloc_percpu(struct per_cpu_pageset);
> > 
> > Should be "if (zone->pageset != &boot_pageset)" ?
> 
> Memory hotplug really wants the NULL
> check. it doesn't use boot_pageset (if we drop rest to boot_pageset).
> But you are right that the boot time initialization first sets
> boot_pageset (zone_pcp_init) and initializes real pagesets later
> (setup_per_cpu_pageset). But this can be handled at the memory hotplug
> layer I believe
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 754026a9164d..1cadfec323fc 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -883,7 +883,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	 */
>  	if (!populated_zone(zone)) {
>  		need_zonelists_rebuild = 1;
> -		setup_zone_pageset(zone);
> +		if (!zone->pageset)
> +			setup_zone_pageset(zone);
>  	}
> 

I think this will be fragile because it makes assumptions on how boot
works -- specifically that zone->pageset is left alone for unpopulated
zones. This will only work for zones in unpopulated *nodes* during boot
because of this sequence

free_area_init_core(pgdat)
  for (j = 0; j < MAX_NR_ZONES; j++) {
        ...
        zone_init_internals(zone)
  }
  -> zone_init_internals(zone)
     -> zone_pcp_init(zone)
        zone->pageset = &boot_pageset;

I think a NULL check will mean that hotplugging a previously unpopulated
zone will run the risk of using boot_pageset. That will likely explode
because IRQs disabled does not protect boot_pageset, it only works early
in boot or during the initial hotplug when it's not visible yet.

> > >  	for_each_possible_cpu(cpu) {
> > >  		p = per_cpu_ptr(zone->pageset, cpu);
> > >  		pageset_init(p);
> > > @@ -8803,25 +8809,6 @@ void zone_pcp_enable(struct zone *zone)
> > >  	mutex_unlock(&pcp_batch_high_lock);
> > >  }
> > >  
> > > -void zone_pcp_reset(struct zone *zone)
> > > -{
> > > -	unsigned long flags;
> > > -	int cpu;
> > > -	struct per_cpu_pageset *pset;
> > > -
> > > -	/* avoid races with drain_pages()  */
> > > -	local_irq_save(flags);
> > > -	if (zone->pageset != &boot_pageset) {
> > > -		for_each_online_cpu(cpu) {
> > > -			pset = per_cpu_ptr(zone->pageset, cpu);
> > > -			drain_zonestat(zone, pset);
> > > -		}
> > > -		free_percpu(zone->pageset);
> > > -		zone->pageset = &boot_pageset;
> > > -	}
> > > -	local_irq_restore(flags);
> > > -}
> > > -
> > 
> > zone_pcp_reset still needs to exist to drain the remaining vmstats or
> > it'll break 5a883813845a ("memory-hotplug: fix zone stat
> > mismatch").
> 
> Are you sure we are reseting vmstats in the hotremove. I do not see
> anything like that. Maybe this was needed at the time. I will double
> check.

zone_pcp_reset calls drain_zonestat to apply the per-cpu vmstat deltas
to the atomic per-zone and global stats.

If anything, the minimal "fix" is to simply delete IRQ disable/enable on
the grounds that IRQs protect nothing and assume the existing hotplug
paths guarantees the PCP cannot be used after zone_pcp_enable(). That
should be the case already because all the pages have been freed and
there is nothing to even put into the PCPs but I worried that the PCP
structure itself might still be reachable even if it's useless which is
why I freed the structure once they could not be reached via zonelists.

-- 
Mel Gorman
SUSE Labs
