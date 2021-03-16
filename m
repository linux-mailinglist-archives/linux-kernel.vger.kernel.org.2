Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388A033CE21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhCPGx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:53:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:44339 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhCPGw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:52:58 -0400
IronPort-SDR: YYtSMubYJH3rGFCXv6CO6PC0L7AYtShhwdDWZvAPEAvdPKE0TW6Pqnqb9SeKNeum7QbHiJs2ci
 /TDx5HG6vL3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253227527"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="253227527"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:52:58 -0700
IronPort-SDR: LnjIfZaHmv9Bcz9AZRG7h/O8IeMPVbpPXUvyRxZdCw2D343gWtQr++qUoITiT7kMvuFxkONk+j
 GCBDUdJWej0g==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="412106243"
Received: from unknown (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:52:54 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH v1 10/14] mm: multigenerational lru: core
References: <87im5rsvd8.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YFA33n+zQb8oomjJ@google.com>
Date:   Tue, 16 Mar 2021 14:52:52 +0800
In-Reply-To: <YFA33n+zQb8oomjJ@google.com> (Yu Zhao's message of "Mon, 15 Mar
        2021 22:45:18 -0600")
Message-ID: <87wnu7y4hn.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Tue, Mar 16, 2021 at 10:08:51AM +0800, Huang, Ying wrote:
>> Yu Zhao <yuzhao@google.com> writes:
>> [snip]
>> 
>> > +/* Main function used by foreground, background and user-triggered aging. */
>> > +static bool walk_mm_list(struct lruvec *lruvec, unsigned long next_seq,
>> > +			 struct scan_control *sc, int swappiness)
>> > +{
>> > +	bool last;
>> > +	struct mm_struct *mm = NULL;
>> > +	int nid = lruvec_pgdat(lruvec)->node_id;
>> > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>> > +	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
>> > +
>> > +	VM_BUG_ON(next_seq > READ_ONCE(lruvec->evictable.max_seq));
>> > +
>> > +	/*
>> > +	 * For each walk of the mm list of a memcg, we decrement the priority
>> > +	 * of its lruvec. For each walk of memcgs in kswapd, we increment the
>> > +	 * priorities of all lruvecs.
>> > +	 *
>> > +	 * So if this lruvec has a higher priority (smaller value), it means
>> > +	 * other concurrent reclaimers (global or memcg reclaim) have walked
>> > +	 * its mm list. Skip it for this priority to balance the pressure on
>> > +	 * all memcgs.
>> > +	 */
>> > +#ifdef CONFIG_MEMCG
>> > +	if (!mem_cgroup_disabled() && !cgroup_reclaim(sc) &&
>> > +	    sc->priority > atomic_read(&lruvec->evictable.priority))
>> > +		return false;
>> > +#endif
>> > +
>> > +	do {
>> > +		last = get_next_mm(lruvec, next_seq, swappiness, &mm);
>> > +		if (mm)
>> > +			walk_mm(lruvec, mm, swappiness);
>> > +
>> > +		cond_resched();
>> > +	} while (mm);
>> 
>> It appears that we need to scan the whole address space of multiple
>> processes in this loop?
>> 
>> If so, I have some concerns about the duration of the function.  Do you
>> have some number of the distribution of the duration of the function?
>> And may be the number of mm_struct and the number of pages scanned.
>> 
>> In comparison, in the traditional LRU algorithm, for each round, only a
>> small subset of the whole physical memory is scanned.
>
> Reasonable concerns, and insightful too. We are sensitive to direct
> reclaim latency, and we tuned another path carefully so that direct
> reclaims virtually don't hit this path :)
>
> Some numbers from the cover letter first:
>   In addition, direct reclaim latency is reduced by 22% at 99th
>   percentile and the number of refaults is reduced 7%. These metrics are
>   important to phones and laptops as they are correlated to user
>   experience.
>
> And "another path" is the background aging in kswapd:
>   age_active_anon()
>     age_lru_gens()
>       try_walk_mm_list()
>         /* try to spread pages out across spread+1 generations */
>         if (old_and_young[0] >= old_and_young[1] * spread &&
>             min_nr_gens(max_seq, min_seq, swappiness) > max(spread, MIN_NR_GENS))
>                 return;
>
>         walk_mm_list(lruvec, max_seq, sc, swappiness);
>
> By default, spread = 2, which makes kswapd slight more aggressive
> than direct reclaim for our use cases. This can be entirely disabled
> by setting spread to 0, for worloads that don't care about direct
> reclaim latency, or larger values, they are more sensitive than
> ours.

OK, I see.  That can avoid the long latency in direct reclaim path.

> It's worth noting that walk_mm_list() is multithreaded -- reclaiming
> threads can work on different mm_structs on the same list
> concurrently. We do occasionally see this function in direct reclaims,
> on over-overcommitted systems, i.e., kswapd CPU usage is 100%. Under
> the same condition, we saw the current page reclaim live locked and
> triggered hardware watchdog timeouts (our hardware watchdog is set to
> 2 hours) many times.

Just to confirm, in the current page reclaim, kswapd will keep running
until watchdog?  This is avoided in your algorithm mainly via
multi-threading?  Or via direct vs. reversing page table scanning?

Best Regards,
Huang, Ying
