Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7936F585
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhD3F60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:58:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:43981 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230132AbhD3F6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:58:25 -0400
IronPort-SDR: YAG3RnpVJWT7PnkiqzOy10Zq7OCfHa1hkOoyPYTLtwlUi6cpkmqAyRS1elmWCF7kf1ecR7iUfU
 iaZkcc6uTgEA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177360691"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="177360691"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 22:57:37 -0700
IronPort-SDR: Ms9VpfrS3xmrKno3zWfSzjxhiXz+qSw3puU/Hz4XTpfTPsureRpGt50ZaH/Z4OiZhjqgegPA2k
 NudTez2S861Q==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="424704370"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.46]) ([10.238.4.46])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 22:57:35 -0700
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
To:     Yu Zhao <yuzhao@google.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        tim.c.chen@linux.intel.com, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
 <YIGuvh70JbE1Cx4U@google.com>
 <7a0fecab-f9e1-ad39-d55e-01e574a35484@linux.intel.com>
 <YIMsykToLKUVMWbZ@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <d7f670db-e77e-ca16-07c0-c0ebcce2c544@linux.intel.com>
Date:   Fri, 30 Apr 2021 13:57:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIMsykToLKUVMWbZ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On 4/24/2021 4:23 AM, Yu Zhao wrote:
> On Fri, Apr 23, 2021 at 02:57:07PM +0800, Xing Zhengjun wrote:
>> On 4/23/2021 1:13 AM, Yu Zhao wrote:
>>> On Thu, Apr 22, 2021 at 04:36:19PM +0800, Xing Zhengjun wrote:
>>>> Hi,
>>>>
>>>>      In the system with very few file pages (nr_active_file + nr_inactive_file
>>>> < 100), it is easy to reproduce "nr_isolated_file > nr_inactive_file",  then
>>>> too_many_isolated return true, shrink_inactive_list enter "msleep(100)", the
>>>> long latency will happen.
>>>>
>>>> The test case to reproduce it is very simple: allocate many huge pages(near
>>>> the DRAM size), then do free, repeat the same operation many times.
>>>> In the test case, the system with very few file pages (nr_active_file +
>>>> nr_inactive_file < 100), I have dumpped the numbers of
>>>> active/inactive/isolated file pages during the whole test(see in the
>>>> attachments) , in shrink_inactive_list "too_many_isolated" is very easy to
>>>> return true, then enter "msleep(100)",in "too_many_isolated" sc->gfp_mask is
>>>> 0x342cca ("_GFP_IO" and "__GFP_FS" is masked) , it is also very easy to
>>>> enter “inactive >>=3”, then “isolated > inactive” will be true.
>>>>
>>>> So I  have a proposal to set a threshold number for the total file pages to
>>>> ignore the system with very few file pages, and then bypass the 100ms sleep.
>>>> It is hard to set a perfect number for the threshold, so I just give an
>>>> example of "256" for it.
>>>>
>>>> I appreciate it if you can give me your suggestion/comments. Thanks.
>>>
>>> Hi Zhengjun,
>>>
>>> It seems to me using the number of isolated pages to keep a lid on
>>> direct reclaimers is not a good solution. We shouldn't keep going
>>> that direction if we really want to fix the problem because migration
>>> can isolate many pages too, which in turn blocks page reclaim.
>>>
>>> Here is something works a lot better. Please give it a try. Thanks.
>>
>> Thanks, I will try it with my test cases.
> 
> Thanks. I took care my sloppiness from yesterday and tested the
> following. It should apply cleanly and work well. Please let me know.
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 47946cec7584..48bb2b77389e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -832,6 +832,7 @@ typedef struct pglist_data {
>   #endif
>   
>   	/* Fields commonly accessed by the page reclaim scanner */
> +	atomic_t		nr_reclaimers;
>   
>   	/*
>   	 * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 562e87cbd7a1..3fcdfbee89c7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1775,43 +1775,6 @@ int isolate_lru_page(struct page *page)
>   	return ret;
>   }
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
>   /*
>    * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
>    * On return, @list is reused as a list of pages to be freed by the caller.
> @@ -1911,20 +1874,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>   	bool file = is_file_lru(lru);
>   	enum vm_event_item item;
>   	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> -	bool stalled = false;
> -
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
>   
>   	lru_add_drain();
>   
> @@ -2903,6 +2852,8 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>   	unsigned long nr_soft_scanned;
>   	gfp_t orig_mask;
>   	pg_data_t *last_pgdat = NULL;
> +	bool should_retry = false;
> +	int nr_cpus = num_online_cpus();
>   
>   	/*
>   	 * If the number of buffer_heads in the machine exceeds the maximum
> @@ -2914,9 +2865,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>   		sc->gfp_mask |= __GFP_HIGHMEM;
>   		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
>   	}
> -
> +retry:
>   	for_each_zone_zonelist_nodemask(zone, z, zonelist,
>   					sc->reclaim_idx, sc->nodemask) {
> +		/*
> +		 * Shrink each node in the zonelist once. If the zonelist is
> +		 * ordered by zone (not the default) then a node may be shrunk
> +		 * multiple times but in that case the user prefers lower zones
> +		 * being preserved.
> +		 */
> +		if (zone->zone_pgdat == last_pgdat)
> +			continue;
> +
>   		/*
>   		 * Take care memory controller reclaiming has small influence
>   		 * to global LRU.
> @@ -2941,16 +2901,28 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>   				sc->compaction_ready = true;
>   				continue;
>   			}
> +		}
>   
> -			/*
> -			 * Shrink each node in the zonelist once. If the
> -			 * zonelist is ordered by zone (not the default) then a
> -			 * node may be shrunk multiple times but in that case
> -			 * the user prefers lower zones being preserved.
> -			 */
> -			if (zone->zone_pgdat == last_pgdat)
> -				continue;
> +		/*
> +		 * A direct reclaimer may isolate SWAP_CLUSTER_MAX pages from
> +		 * the LRU list and then get rescheduled. When there are massive
> +		 * number of tasks doing page allocation, such sleeping direct
> +		 * reclaimers may keep piling up on each CPU, the LRU list will
> +		 * go small and be scanned faster than necessary, leading to
> +		 * unnecessary swapping, thrashing and OOM.
> +		 */
> +		VM_BUG_ON(current_is_kswapd());
>   
> +		if (!atomic_add_unless(&zone->zone_pgdat->nr_reclaimers, 1, nr_cpus)) {
> +			should_retry = true;
> +			continue;
> +		}
> +
> +		if (last_pgdat)
> +			atomic_dec(&last_pgdat->nr_reclaimers);
> +		last_pgdat = zone->zone_pgdat;
> +
> +		if (!cgroup_reclaim(sc)) {
>   			/*
>   			 * This steals pages from memory cgroups over softlimit
>   			 * and returns the number of reclaimed pages and
> @@ -2966,13 +2938,20 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>   			/* need some check for avoid more shrink_zone() */
>   		}
>   
> -		/* See comment about same check for global reclaim above */
> -		if (zone->zone_pgdat == last_pgdat)
> -			continue;
> -		last_pgdat = zone->zone_pgdat;
>   		shrink_node(zone->zone_pgdat, sc);
>   	}
>   
> +	if (last_pgdat)
> +		atomic_dec(&last_pgdat->nr_reclaimers);
> +	else if (should_retry) {
> +		/* wait a bit for the reclaimer. */
> +		if (!schedule_timeout_killable(HZ / 10))
> +			goto retry;
> +
> +		/* We are about to die and free our memory. Return now. */
> +		sc->nr_reclaimed += SWAP_CLUSTER_MAX;
> +	}
> +
>   	/*
>   	 * Restore to original mask to avoid the impact on the caller if we
>   	 * promoted it to __GFP_HIGHMEM.
> @@ -4189,6 +4168,15 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>   	set_task_reclaim_state(p, &sc.reclaim_state);
>   
>   	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages) {
> +		int nr_cpus = num_online_cpus();
> +
> +		VM_BUG_ON(current_is_kswapd());
> +
> +		if (!atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {
> +			schedule_timeout_killable(HZ / 10);
> +			goto out;
> +		}
> +
>   		/*
>   		 * Free memory by calling shrink node with increasing
>   		 * priorities until we have enough memory freed.
> @@ -4196,8 +4184,10 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>   		do {
>   			shrink_node(pgdat, &sc);
>   		} while (sc.nr_reclaimed < nr_pages && --sc.priority >= 0);
> -	}
>   
> +		atomic_dec(&pgdat->nr_reclaimers);
> +	}
> +out:
>   	set_task_reclaim_state(p, NULL);
>   	current->flags &= ~PF_SWAPWRITE;
>   	memalloc_noreclaim_restore(noreclaim_flag);
> 

I use my compaction test case to test it, test more than 30 times can 
not reproduce the 100ms sleep. I find that applies the patch, direct 
reclaim path latency reduces much, but the direct compact path latency 
double compares with it before.

  24)               |  __alloc_pages_direct_compact() {
  24)               |    try_to_compact_pages() {
  24)   0.131 us    |      __next_zones_zonelist();
  24) @ 184008.2 us |      compact_zone_order();
  24)   0.189 us    |      __next_zones_zonelist();
  24)   0.547 us    |      compact_zone_order();
  24)   0.225 us    |      __next_zones_zonelist();
  24)   0.592 us    |      compact_zone_order();
  24)   0.146 us    |      __next_zones_zonelist();
  24) @ 184012.3 us |    }
  24)               |    get_page_from_freelist() {
  24)   0.160 us    |      __zone_watermark_ok();
  24)   0.140 us    |      __next_zones_zonelist();
  24)   0.141 us    |      __zone_watermark_ok();
  24)   0.134 us    |      __next_zones_zonelist();
  24)   0.121 us    |      __zone_watermark_ok();
  24)   0.123 us    |      __next_zones_zonelist();
  24)   1.688 us    |    }
  24)   0.130 us    |    ___might_sleep();
  24)               |    __cond_resched() {
  24)   0.123 us    |      rcu_all_qs();
  24)   0.370 us    |    }
  24) @ 184015.2 us |  }
  24)               |  /* mm_page_alloc: page=0000000000000000 pfn=0 
order=9 migratetype=1 
gfp_flags=GFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE */
  24)               |  /* memlatency: lat=184716 order=9 
gfp_flags=342cca 
(GFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE|0x812a3c6000000000^@)migratetype=1 
*/
/*The memlatency measures the latency of "__alloc_pages_nodemask" */


-- 
Zhengjun Xing
