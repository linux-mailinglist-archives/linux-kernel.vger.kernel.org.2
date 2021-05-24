Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6294C38E2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhEXJI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:08:58 -0400
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:45925 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232362AbhEXJI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:08:56 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 5D31BFA88F
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:07:28 +0100 (IST)
Received: (qmail 10052 invoked from network); 24 May 2021 09:07:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 May 2021 09:07:28 -0000
Date:   Mon, 24 May 2021 10:07:26 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] mm/page_alloc: Adjust pcp->high after CPU hotplug
 events
Message-ID: <20210524090726.GB30378@techsingularity.net>
References: <20210521102826.28552-1-mgorman@techsingularity.net>
 <20210521102826.28552-4-mgorman@techsingularity.net>
 <add15859-31e2-1688-3d8c-26e2579e9a57@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <add15859-31e2-1688-3d8c-26e2579e9a57@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:13:35PM -0700, Dave Hansen wrote:
> On 5/21/21 3:28 AM, Mel Gorman wrote:
> > The PCP high watermark is based on the number of online CPUs so the
> > watermarks must be adjusted during CPU hotplug. At the time of
> > hot-remove, the number of online CPUs is already adjusted but during
> > hot-add, a delta needs to be applied to update PCP to the correct
> > value. After this patch is applied, the high watermarks are adjusted
> > correctly.
> > 
> >   # grep high: /proc/zoneinfo  | tail -1
> >               high:  649
> >   # echo 0 > /sys/devices/system/cpu/cpu4/online
> >   # grep high: /proc/zoneinfo  | tail -1
> >               high:  664
> >   # echo 1 > /sys/devices/system/cpu/cpu4/online
> >   # grep high: /proc/zoneinfo  | tail -1
> >               high:  649
> 
> This is actually a comment more about the previous patch, but it doesn't
> really become apparent until the example above.
> 
> In your example, you mentioned increased exit() performance by using
> "vm.percpu_pagelist_fraction to increase the pcp->high value".  That's
> presumably because of the increased batching effects and fewer lock
> acquisitions.
> 

Yes

> But, logically, doesn't that mean that, the more CPUs you have in a
> node, the *higher* you want pcp->high to be?  If we took this to the
> extreme and had an absurd number of CPUs in a node, we could end up with
> a too-small pcp->high value.
> 

I see your point but I don't think increasing pcp->high for larger
numbers of CPUs is the right answer because then reclaim can be
triggered simply because too many PCPs have pages.

To address your point requires much deeper surgery. zone->lock would have
to be split to being a metadata lock and a free page lock. Then the free
areas would have to be split based on some factor -- number of CPUs or
memory size. That gets complex because then the page allocator loop needs
to walk multiple arenas as well as multiple zones as well as consider which
arena should be examined first. Fragmentation should also be considered
because a decision would need to be made on whether a pageblock should
fragment or whether other local areans should be examined. Anything that
walks PFNs such as compaction would also need to be aware of arenas and
their associated locks. Finally every acquisition of zone->lock would
have to be audited to determine exactly what it is protecting. Even with
all that, it still makes sense to disassociate pcp->high from pcp->batch
as this series does.

There is value to doing something like this but it's beyond what this
series is trying to do and doing the work without introducing regressions
would be very difficult.

> Also, do you worry at all about a zone with a low min_free_kbytes seeing
> increased zone lock contention?
> 
> ...
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index bf5cdc466e6c..2761b03b3a44 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6628,7 +6628,7 @@ static int zone_batchsize(struct zone *zone)
> >  #endif
> >  }
> >  
> > -static int zone_highsize(struct zone *zone)
> > +static int zone_highsize(struct zone *zone, int cpu_online)
> >  {
> >  #ifdef CONFIG_MMU
> >  	int high;
> > @@ -6640,7 +6640,7 @@ static int zone_highsize(struct zone *zone)
> >  	 * CPUs local to a zone. Note that early in boot that CPUs may
> >  	 * not be online yet.
> >  	 */
> > -	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone))));
> > +	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone)))) + cpu_online;
> >  	high = low_wmark_pages(zone) / nr_local_cpus;
> 
> Is this "+ cpu_online" bias because the CPU isn't in cpumask_of_node()
> when the CPU hotplug callback occurs?  If so, it might be nice to mention.

Fixed.

-- 
Mel Gorman
SUSE Labs
