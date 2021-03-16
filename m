Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31BC33CFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhCPIZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbhCPIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:24:51 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A4DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:24:51 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z13so36219620iox.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OpnffJILt17fHp8Xu2b6sG4C5uMifJxsEdEnBIARqKw=;
        b=kzOf57e7KIbrgrdXnmJ5x+hAo6YrY9spBvZqOy2y/2vsd9/8pks319xyVpjHNumix3
         smeueJ0A1okpj8yTFqALWGD460+zJEXqOx7bUElUBYAfo+XC0HcK0xFApc9yLdgQSZsZ
         rdQenK66GW8qvOQ7B2lye2JppFq1IcnRi/xbTioZf6Kgbelce2VHOdGOp62onCFhWi+w
         APlUHTaGHsVYINu6n6rNHqdr1oNZMTRJUtQWc7p+vItAm8iwbrt09avTbiErYrf1kPIl
         7I7hoSM+mulYVCv6rD7j+3JCDrukEQUGtrTzu0I7McT3MoVsKc7n22hxVypS5OYWlZ9/
         HjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OpnffJILt17fHp8Xu2b6sG4C5uMifJxsEdEnBIARqKw=;
        b=KIDSkMNLaXd4/+IbpMstQmTWY9BA+z6x3xO/7PeKwOGU1lD7ULHF4NhiZ5bXQPTr8t
         HCn0nyG4zuO/iTQvcnvgtOvJ2CR5ZIto5dNSbZx/fcojVePn6ZuYtU6sMjUyc5uJowNe
         qU/XZARmGbSVmxB/eBpsSa2vYTUIPESYycdudCheIV/X8RMCWwvfWmYxsUteC7chmEYP
         FWwFTmcSruV4krSAIKYJMtr0He3oxbIzIt+nm8ZGyjhSorRTPGK6gi3sblU7llUIT4tU
         Pr/kZrK96NUGyySFJAJOnZR6dvSNLjnEaeivdUP9QgaBPKJlKSzC8VbbMzG3XxebemSe
         dUqA==
X-Gm-Message-State: AOAM5326+DJWriMdHAyQdBQBujk9Zlc05zaGZLRyCaDcupkadi+CTjbH
        1gcsPf4RqzFUN10i3cGUt6t9AA==
X-Google-Smtp-Source: ABdhPJyaXfxKjPvuSm7JOWw7/6YMVUGqmXxhd2ibW+rA+N0FTq58hUfMM2K+okU1J3uplw7Zhrwv6Q==
X-Received: by 2002:a02:9382:: with SMTP id z2mr13269772jah.120.1615883090614;
        Tue, 16 Mar 2021 01:24:50 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:d825:37a2:4b55:995f])
        by smtp.gmail.com with ESMTPSA id l14sm9113336ilc.33.2021.03.16.01.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 01:24:49 -0700 (PDT)
Date:   Tue, 16 Mar 2021 02:24:45 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     "Huang, Ying" <ying.huang@intel.com>
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
Message-ID: <YFBrTXLZygkfJiQs@google.com>
References: <87im5rsvd8.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <YFA33n+zQb8oomjJ@google.com>
 <87wnu7y4hn.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnu7y4hn.fsf@yhuang6-desk1.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:52:52PM +0800, Huang, Ying wrote:
> Yu Zhao <yuzhao@google.com> writes:
> 
> > On Tue, Mar 16, 2021 at 10:08:51AM +0800, Huang, Ying wrote:
> >> Yu Zhao <yuzhao@google.com> writes:
> >> [snip]
> >> 
> >> > +/* Main function used by foreground, background and user-triggered aging. */
> >> > +static bool walk_mm_list(struct lruvec *lruvec, unsigned long next_seq,
> >> > +			 struct scan_control *sc, int swappiness)
> >> > +{
> >> > +	bool last;
> >> > +	struct mm_struct *mm = NULL;
> >> > +	int nid = lruvec_pgdat(lruvec)->node_id;
> >> > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> >> > +	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
> >> > +
> >> > +	VM_BUG_ON(next_seq > READ_ONCE(lruvec->evictable.max_seq));
> >> > +
> >> > +	/*
> >> > +	 * For each walk of the mm list of a memcg, we decrement the priority
> >> > +	 * of its lruvec. For each walk of memcgs in kswapd, we increment the
> >> > +	 * priorities of all lruvecs.
> >> > +	 *
> >> > +	 * So if this lruvec has a higher priority (smaller value), it means
> >> > +	 * other concurrent reclaimers (global or memcg reclaim) have walked
> >> > +	 * its mm list. Skip it for this priority to balance the pressure on
> >> > +	 * all memcgs.
> >> > +	 */
> >> > +#ifdef CONFIG_MEMCG
> >> > +	if (!mem_cgroup_disabled() && !cgroup_reclaim(sc) &&
> >> > +	    sc->priority > atomic_read(&lruvec->evictable.priority))
> >> > +		return false;
> >> > +#endif
> >> > +
> >> > +	do {
> >> > +		last = get_next_mm(lruvec, next_seq, swappiness, &mm);
> >> > +		if (mm)
> >> > +			walk_mm(lruvec, mm, swappiness);
> >> > +
> >> > +		cond_resched();
> >> > +	} while (mm);
> >> 
> >> It appears that we need to scan the whole address space of multiple
> >> processes in this loop?
> >> 
> >> If so, I have some concerns about the duration of the function.  Do you
> >> have some number of the distribution of the duration of the function?
> >> And may be the number of mm_struct and the number of pages scanned.
> >> 
> >> In comparison, in the traditional LRU algorithm, for each round, only a
> >> small subset of the whole physical memory is scanned.
> >
> > Reasonable concerns, and insightful too. We are sensitive to direct
> > reclaim latency, and we tuned another path carefully so that direct
> > reclaims virtually don't hit this path :)
> >
> > Some numbers from the cover letter first:
> >   In addition, direct reclaim latency is reduced by 22% at 99th
> >   percentile and the number of refaults is reduced 7%. These metrics are
> >   important to phones and laptops as they are correlated to user
> >   experience.
> >
> > And "another path" is the background aging in kswapd:
> >   age_active_anon()
> >     age_lru_gens()
> >       try_walk_mm_list()
> >         /* try to spread pages out across spread+1 generations */
> >         if (old_and_young[0] >= old_and_young[1] * spread &&
> >             min_nr_gens(max_seq, min_seq, swappiness) > max(spread, MIN_NR_GENS))
> >                 return;
> >
> >         walk_mm_list(lruvec, max_seq, sc, swappiness);
> >
> > By default, spread = 2, which makes kswapd slight more aggressive
> > than direct reclaim for our use cases. This can be entirely disabled
> > by setting spread to 0, for worloads that don't care about direct
> > reclaim latency, or larger values, they are more sensitive than
> > ours.
> 
> OK, I see.  That can avoid the long latency in direct reclaim path.
> 
> > It's worth noting that walk_mm_list() is multithreaded -- reclaiming
> > threads can work on different mm_structs on the same list
> > concurrently. We do occasionally see this function in direct reclaims,
> > on over-overcommitted systems, i.e., kswapd CPU usage is 100%. Under
> > the same condition, we saw the current page reclaim live locked and
> > triggered hardware watchdog timeouts (our hardware watchdog is set to
> > 2 hours) many times.
> 
> Just to confirm, in the current page reclaim, kswapd will keep running
> until watchdog?  This is avoided in your algorithm mainly via
> multi-threading?  Or via direct vs. reversing page table scanning?

Well, don't tell me you've seen the problem :) Let me explain one
subtle difference in how the aging works between the current page
reclaim and this series, and point you to the code.

In the current page reclaim, we can't scan a page via the rmap without
isolating the page first. So the aging basically isolates a batch of
pages from a lru list, walks the rmap for each of the pages, and puts
active ones back to the list.

In this series, aging walks page tables to update the generation
numbers of active pages without isolating them. The isolation is the
subtle difference: it's not a problem when there are few threads, but
it causes live locks when hundreds of threads running the aging and
hit the following in shrink_inactive_list():

	while (unlikely(too_many_isolated(pgdat, file, sc))) {
		if (stalled)
			return 0;

		/* wait a bit for the reclaimer. */
		msleep(100);
		stalled = true;

		/* We are about to die and free our memory. Return now. */
		if (fatal_signal_pending(current))
			return SWAP_CLUSTER_MAX;
	}

Thanks to Michal who has improved it considerably by commit
db73ee0d4637 ("mm, vmscan: do not loop on too_many_isolated for
ever"). But we still occasionally see live locks on over-overcommitted
machines. Reclaiming threads step on each other while interleaving
between the msleep() and the aging, on 100+ CPUs.
