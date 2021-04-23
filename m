Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6497368EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241500AbhDWIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:32:48 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:52909 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230192AbhDWIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:32:47 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 56DD12458
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:32:10 +0100 (IST)
Received: (qmail 11135 invoked from network); 23 Apr 2021 08:32:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.248])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Apr 2021 08:32:09 -0000
Date:   Fri, 23 Apr 2021 09:32:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] mm/vmstat: Convert NUMA statistics to basic NUMA
 counters
Message-ID: <20210423083208.GB4239@techsingularity.net>
References: <20210422111441.24318-1-mgorman@techsingularity.net>
 <20210422111441.24318-4-mgorman@techsingularity.net>
 <ba72d967-aa4e-47e5-5f99-df3dd0bf21d2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ba72d967-aa4e-47e5-5f99-df3dd0bf21d2@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 05:18:38PM +0200, Vlastimil Babka wrote:
> > +
> > +#ifdef CONFIG_NUMA
> > +static void fold_vm_zone_numa_events(struct zone *zone)
> >  {
> > -	int i;
> > -	int changes = 0;
> > +	int zone_numa_events[NR_VM_NUMA_EVENT_ITEMS] = { 0, };
> 
> Should this be long? pzstats are, the global counters too, so seems weird to use
> int as intermediate sum counter.
> 

While overflow can happen eventually, unsigned long defers the problem
so yes, I'll make it unsigned long.

> >  #ifdef CONFIG_NUMA
> > -		for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
> > -			if (pzstats->vm_numa_stat_diff[i]) {
> > +		for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++) {
> > +			if (pzstats->vm_numa_event[i]) {
> >  				int v;
> 
> Also long?
> 

Same.

> >  /*
> > @@ -939,43 +914,36 @@ void cpu_vm_stats_fold(int cpu)
> >   */
> >  void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
> >  {
> > -	int i;
> > +	int i, v;
> 
> And the 'v' here. Maybe keep using local to each loop below and make it long for
> the NUMA one?
> 

I just made it unsigned long. There is no storage advantage to changing
type in a local scoped variable.

Thanks

-- 
Mel Gorman
SUSE Labs
