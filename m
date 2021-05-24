Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC1A38E25D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhEXIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:34:31 -0400
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:55321 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232452AbhEXIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:34:26 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 6A929FA86B
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:32:57 +0100 (IST)
Received: (qmail 1134 invoked from network); 24 May 2021 08:32:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 May 2021 08:32:57 -0000
Date:   Mon, 24 May 2021 09:32:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] mm/page_alloc: Disassociate the pcp->high from
 pcp->batch
Message-ID: <20210524083238.GA30378@techsingularity.net>
References: <20210521102826.28552-1-mgorman@techsingularity.net>
 <20210521102826.28552-3-mgorman@techsingularity.net>
 <83ddf311-cdfb-34cf-d08f-70590420beff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <83ddf311-cdfb-34cf-d08f-70590420beff@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 02:52:39PM -0700, Dave Hansen wrote:
> On 5/21/21 3:28 AM, Mel Gorman wrote:
> > Note that in this patch the pcp->high values are adjusted after memory
> > hotplug events, min_free_kbytes adjustments and watermark scale factor
> > adjustments but not CPU hotplug events.
> 
> Not that it was a long wait to figure it out, but I'd probably say:
> 
> 	"CPU hotplug events are handled later in the series".
> 
> instead of just saying they're not handled.
> 
> > Before grep -E "high:|batch" /proc/zoneinfo | tail -2
> >               high:  378
> >               batch: 63
> > 
> > After grep -E "high:|batch" /proc/zoneinfo | tail -2
> >               high:  649
> >               batch: 63
> 
> You noted the relationship between pcp->high and zone lock contention.
> Larger ->high values mean less contention.  It's probably also worth
> noting the trend of having more logical CPUs per NUMA node.
> 

It's noted in the leader with "neither takes the zone size into account
or the number of CPUs local to a zone". Your point is valid but I'm not
doing much about the number of CPUs sharing a lock.

> I have the feeling when this was put in place it wasn't uncommon to have
> somewhere between 1 and 8 CPUs in a node pounding on a zone.
> 

True.

> Today, having ~60 is common.  I've occasionally resorted to recommending
> that folks enable hardware features like Sub-NUMA-Clustering [1] since
> it increases the number of zones and decreases the number of CPUs
> pounding on each zone lock.
> 

Enabling SNC to reduce concention is very unfortunate. It potentially
causes page age inversion issue as it's similar to specifying numa=fake=N

> 1.
> https://software.intel.com/content/www/us/en/develop/articles/intel-xeon-processor-scalable-family-technical-overview.html
> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index a48f305f0381..bf5cdc466e6c 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2163,14 +2163,6 @@ void __init page_alloc_init_late(void)
> >  	/* Block until all are initialised */
> >  	wait_for_completion(&pgdat_init_all_done_comp);
> >  
> > -	/*
> > -	 * The number of managed pages has changed due to the initialisation
> > -	 * so the pcpu batch and high limits needs to be updated or the limits
> > -	 * will be artificially small.
> > -	 */
> > -	for_each_populated_zone(zone)
> > -		zone_pcp_update(zone);
> > -
> >  	/*
> >  	 * We initialized the rest of the deferred pages.  Permanently disable
> >  	 * on-demand struct page initialization.
> > @@ -6594,13 +6586,12 @@ static int zone_batchsize(struct zone *zone)
> >  	int batch;
> >  
> >  	/*
> > -	 * The per-cpu-pages pools are set to around 1000th of the
> > -	 * size of the zone.
> > +	 * The number of pages to batch allocate is either 0.1%
> 
> Probably worth making that "~0.1%" just in case someone goes looking for
> the /1000 and can't find it.
> 

Done

> > +	 * of the zone or 1MB, whichever is smaller. The batch
> > +	 * size is striking a balance between allocation latency
> > +	 * and zone lock contention.
> >  	 */
> > -	batch = zone_managed_pages(zone) / 1024;
> > -	/* But no more than a meg. */
> > -	if (batch * PAGE_SIZE > 1024 * 1024)
> > -		batch = (1024 * 1024) / PAGE_SIZE;
> > +	batch = min(zone_managed_pages(zone) >> 10, (1024 * 1024) / PAGE_SIZE);
> >  	batch /= 4;		/* We effectively *= 4 below */
> >  	if (batch < 1)
> >  		batch = 1;
> > @@ -6637,6 +6628,27 @@ static int zone_batchsize(struct zone *zone)
> >  #endif
> >  }
> >  
> > +static int zone_highsize(struct zone *zone)
> > +{
> > +#ifdef CONFIG_MMU
> > +	int high;
> > +	int nr_local_cpus;
> > +
> > +	/*
> > +	 * The high value of the pcp is based on the zone low watermark
> > +	 * when reclaim is potentially active spread across the online
> > +	 * CPUs local to a zone. Note that early in boot that CPUs may
> > +	 * not be online yet.
> > +	 */
> 
> FWIW, I like the way the changelog talked about this a bit better, with
> the goal of avoiding background reclaim even in the face of a bunch of
> full pcp's.
> 
> > +	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone))));

Done.

> > +	high = low_wmark_pages(zone) / nr_local_cpus;
> 
> I'm a little concerned that this might get out of hand on really big
> nodes with no CPUs.  For persistent memory (which we *do* toss into the
> page allocator for volatile use), we can have multi-terabyte zones with
> no CPUs in the node.
> 

It should not get out of hand given that it's based on the low watermark,
at least for local CPus.

> Also, while the CPUs which are on the node are the ones *most* likely to
> be hitting the ->high limit, we do *keep* a pcp for each possible CPU.
> So, the amount of memory which can actually be sequestered is
> num_online_cpus()*high.  Right?
> 

Potentially yes for short durations but remote CPUs are drained every
few seconds by refresh_cpu_vm_stats so it's a transient problem.

> *That* might really get out of hand if we have nr_local_cpus=1.
> 
> We might want some overall cap on 'high', or even to scale it
> differently for the zone-local cpus' pcps versus remote.

I'm reluctant to prematurely set this because I don't have a test case
and machine where this has been demonstrated to be a problem but I would
not be opposed to a patch added on top which demonstrated a reasonable
case where too many pages are pinned on remote CPUs for too long. I would
imagine this involves a machine with large amounts of persistent memory
onlined as a memory-like device and using an interleave policy showing
that reclaim on the persistent memory node is triggered prematurely.

My initial thinking is that remote CPUs should simply clamp the remote
cpus on a static value such as pcp->batch << 1 but I would prefer this
was based on a real test.  I expect the check for a CPU being local to
a zone would be done in __zone_set_pageset_high_and_batch.

-- 
Mel Gorman
SUSE Labs
