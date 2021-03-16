Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3D33CB46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhCPCJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:09:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:46687 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231958AbhCPCJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:09:01 -0400
IronPort-SDR: tli/eWljL3lO8OJr+oEE67kDE/koI/N3nyAS5H7ELBp8KKYyJN0sPOHIAWoCFm/El1FsDpG+s5
 hEu77hWk4FtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="186807385"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="186807385"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 19:09:00 -0700
IronPort-SDR: SPTHSj6HkgQoZ3Q7lopQ61Jk45aLfkIvYBbRHSiDmI95R2J68a3jyJ6r2bZ2ulF4puTHOcPVWu
 eYViBXSN/z4Q==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="388305768"
Received: from unknown (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 19:08:55 -0700
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
Date:   Tue, 16 Mar 2021 10:08:51 +0800
Message-ID: <87im5rsvd8.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:
[snip]

> +/* Main function used by foreground, background and user-triggered aging. */
> +static bool walk_mm_list(struct lruvec *lruvec, unsigned long next_seq,
> +			 struct scan_control *sc, int swappiness)
> +{
> +	bool last;
> +	struct mm_struct *mm = NULL;
> +	int nid = lruvec_pgdat(lruvec)->node_id;
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
> +
> +	VM_BUG_ON(next_seq > READ_ONCE(lruvec->evictable.max_seq));
> +
> +	/*
> +	 * For each walk of the mm list of a memcg, we decrement the priority
> +	 * of its lruvec. For each walk of memcgs in kswapd, we increment the
> +	 * priorities of all lruvecs.
> +	 *
> +	 * So if this lruvec has a higher priority (smaller value), it means
> +	 * other concurrent reclaimers (global or memcg reclaim) have walked
> +	 * its mm list. Skip it for this priority to balance the pressure on
> +	 * all memcgs.
> +	 */
> +#ifdef CONFIG_MEMCG
> +	if (!mem_cgroup_disabled() && !cgroup_reclaim(sc) &&
> +	    sc->priority > atomic_read(&lruvec->evictable.priority))
> +		return false;
> +#endif
> +
> +	do {
> +		last = get_next_mm(lruvec, next_seq, swappiness, &mm);
> +		if (mm)
> +			walk_mm(lruvec, mm, swappiness);
> +
> +		cond_resched();
> +	} while (mm);

It appears that we need to scan the whole address space of multiple
processes in this loop?

If so, I have some concerns about the duration of the function.  Do you
have some number of the distribution of the duration of the function?
And may be the number of mm_struct and the number of pages scanned.

In comparison, in the traditional LRU algorithm, for each round, only a
small subset of the whole physical memory is scanned.

Best Regards,
Huang, Ying

> +
> +	if (!last) {
> +		/* foreground aging prefers not to wait unless "necessary" */
> +		if (!current_is_kswapd() && sc->priority < DEF_PRIORITY - 2)
> +			wait_event_killable(mm_list->nodes[nid].wait,
> +				next_seq < READ_ONCE(lruvec->evictable.max_seq));
> +
> +		return next_seq < READ_ONCE(lruvec->evictable.max_seq);
> +	}
> +
> +	VM_BUG_ON(next_seq != READ_ONCE(lruvec->evictable.max_seq));
> +
> +	inc_max_seq(lruvec);
> +
> +#ifdef CONFIG_MEMCG
> +	if (!mem_cgroup_disabled())
> +		atomic_add_unless(&lruvec->evictable.priority, -1, 0);
> +#endif
> +
> +	/* order against inc_max_seq() */
> +	smp_mb();
> +	/* either we see any waiters or they will see updated max_seq */
> +	if (waitqueue_active(&mm_list->nodes[nid].wait))
> +		wake_up_all(&mm_list->nodes[nid].wait);
> +
> +	wakeup_flusher_threads(WB_REASON_VMSCAN);
> +
> +	return true;
> +}
> +

[snip]

Best Regards,
Huang, Ying
