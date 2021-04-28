Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B7636D6D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhD1L4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:56:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:44544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhD1L4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:56:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619610922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVaAE5j4PRgNVtKYb1xi0JNMS/yIGUD1+Zz/inuGnBA=;
        b=ZRf3ph+TnessjTvvtr/DsOTmTdjfYuifQx85GKSChPclLGlKVU+Tca39Ojkq6mbumeZ8+f
        SeIRObEy8skWFL6/2edyJO7a/ZAN4uDpVLyQjbnrZ2gNIkGY8QiG+hDPcU3xnhUoKyyTws
        JjS4uZnkl+VychQrxBVVx35+pAxq010=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23ABBB155;
        Wed, 28 Apr 2021 11:55:22 +0000 (UTC)
Date:   Wed, 28 Apr 2021 13:55:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        tim.c.chen@linux.intel.com, Shakeel Butt <shakeelb@google.com>,
        wfg@mail.ustc.edu.cn, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
Message-ID: <YIlNKds8klSiOalo@dhcp22.suse.cz>
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
 <YIGuvh70JbE1Cx4U@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIGuvh70JbE1Cx4U@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Rik and Andrea]

On Thu 22-04-21 11:13:34, Yu Zhao wrote:
> On Thu, Apr 22, 2021 at 04:36:19PM +0800, Xing Zhengjun wrote:
> > Hi,
> > 
> >    In the system with very few file pages (nr_active_file + nr_inactive_file
> > < 100), it is easy to reproduce "nr_isolated_file > nr_inactive_file",  then
> > too_many_isolated return true, shrink_inactive_list enter "msleep(100)", the
> > long latency will happen.
> > 
> > The test case to reproduce it is very simple: allocate many huge pages(near
> > the DRAM size), then do free, repeat the same operation many times.
> > In the test case, the system with very few file pages (nr_active_file +
> > nr_inactive_file < 100), I have dumpped the numbers of
> > active/inactive/isolated file pages during the whole test(see in the
> > attachments) , in shrink_inactive_list "too_many_isolated" is very easy to
> > return true, then enter "msleep(100)",in "too_many_isolated" sc->gfp_mask is
> > 0x342cca ("_GFP_IO" and "__GFP_FS" is masked) , it is also very easy to
> > enter “inactive >>=3”, then “isolated > inactive” will be true.
> > 
> > So I  have a proposal to set a threshold number for the total file pages to
> > ignore the system with very few file pages, and then bypass the 100ms sleep.
> > It is hard to set a perfect number for the threshold, so I just give an
> > example of "256" for it.
> > 
> > I appreciate it if you can give me your suggestion/comments. Thanks.
> 
> Hi Zhengjun,
> 
> It seems to me using the number of isolated pages to keep a lid on
> direct reclaimers is not a good solution. We shouldn't keep going
> that direction if we really want to fix the problem because migration
> can isolate many pages too, which in turn blocks page reclaim.
> 
> Here is something works a lot better. Please give it a try. Thanks.

O do have a very vague recollection that number of reclaimers used to be
a criterion in very old days and it has proven to be quite bad in the
end. I am sorry but I do not have an reference at hands and do not have
time to crawl git history. Maybe Rik/Andrea will remember details.

The existing throttling mechanism is quite far from optimal but it aims
at handling close to OOM situations where effectivelly a large part of
the existing LRUs can be already isolated. We already have a retry
logic which is LRU aware in the page allocator
(should_reclaim_retry). The logic would have to be extended but that
sounds like a better fit for the back off to me.

> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 507d216610bf2..9a09f7e76f6b8 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -951,6 +951,8 @@ typedef struct pglist_data {
>  
>  	/* Fields commonly accessed by the page reclaim scanner */
>  
> +	atomic_t nr_reclaimers;
> +
>  	/*
>  	 * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
>  	 *
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1c080fafec396..f7278642290a6 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1786,43 +1786,6 @@ int isolate_lru_page(struct page *page)
>  	return ret;
>  }
>  
> -/*
> - * A direct reclaimer may isolate SWAP_CLUSTER_MAX pages from the LRU list and
> - * then get rescheduled. When there are massive number of tasks doing page
> - * allocation, such sleeping direct reclaimers may keep piling up on each CPU,
> - * the LRU list will go small and be scanned faster than necessary, leading to
> - * unnecessary swapping, thrashing and OOM.
> - */
> -static int too_many_isolated(struct pglist_data *pgdat, int file,
> -		struct scan_control *sc)
> -{
> -	unsigned long inactive, isolated;
> -
> -	if (current_is_kswapd())
> -		return 0;
> -
> -	if (!writeback_throttling_sane(sc))
> -		return 0;
> -
> -	if (file) {
> -		inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
> -		isolated = node_page_state(pgdat, NR_ISOLATED_FILE);
> -	} else {
> -		inactive = node_page_state(pgdat, NR_INACTIVE_ANON);
> -		isolated = node_page_state(pgdat, NR_ISOLATED_ANON);
> -	}
> -
> -	/*
> -	 * GFP_NOIO/GFP_NOFS callers are allowed to isolate more pages, so they
> -	 * won't get blocked by normal direct-reclaimers, forming a circular
> -	 * deadlock.
> -	 */
> -	if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
> -		inactive >>= 3;
> -
> -	return isolated > inactive;
> -}
> -
>  /*
>   * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
>   * On return, @list is reused as a list of pages to be freed by the caller.
> @@ -1924,19 +1887,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  	bool stalled = false;
>  
> -	while (unlikely(too_many_isolated(pgdat, file, sc))) {
> -		if (stalled)
> -			return 0;
> -
> -		/* wait a bit for the reclaimer. */
> -		msleep(100);
> -		stalled = true;
> -
> -		/* We are about to die and free our memory. Return now. */
> -		if (fatal_signal_pending(current))
> -			return SWAP_CLUSTER_MAX;
> -	}
> -
>  	lru_add_drain();
>  
>  	spin_lock_irq(&lruvec->lru_lock);
> @@ -3302,6 +3252,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
>  unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  				gfp_t gfp_mask, nodemask_t *nodemask)
>  {
> +	int nr_cpus;
>  	unsigned long nr_reclaimed;
>  	struct scan_control sc = {
>  		.nr_to_reclaim = SWAP_CLUSTER_MAX,
> @@ -3334,8 +3285,17 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  	set_task_reclaim_state(current, &sc.reclaim_state);
>  	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
>  
> +	nr_cpus = current_is_kswapd() ? 0 : num_online_cpus();
> +	while (nr_cpus && !atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {
> +		if (schedule_timeout_killable(HZ / 10))
> +			return SWAP_CLUSTER_MAX;
> +	}
> +
>  	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>  
> +	if (nr_cpus)
> +		atomic_dec(&pgdat->nr_reclaimers);
> +
>  	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
>  	set_task_reclaim_state(current, NULL);

This will surely break any memcg direct reclaim.

-- 
Michal Hocko
SUSE Labs
