Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F38368D72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbhDWG5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:57:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:38738 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWG5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:57:50 -0400
IronPort-SDR: iEMrTWdFuT/jVoHQ9WGUyUUtuBDzaEiL4F+UYcbV+f8La0kRUXl8kY1uhIIvj+CSG8PBiRbK8m
 FPJiNieHke/w==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="196137833"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="196137833"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 23:57:11 -0700
IronPort-SDR: N6+TW/dOJtLAhBX+tNeAT9fVbNmp7IC7l5gjOqnZZJphVTO0OAe/QolffJi1IBE7QV/AOxqspH
 CpTOQxqv//LA==
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="428273228"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.46]) ([10.238.4.46])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 23:57:09 -0700
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
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <7a0fecab-f9e1-ad39-d55e-01e574a35484@linux.intel.com>
Date:   Fri, 23 Apr 2021 14:57:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIGuvh70JbE1Cx4U@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/2021 1:13 AM, Yu Zhao wrote:
> On Thu, Apr 22, 2021 at 04:36:19PM +0800, Xing Zhengjun wrote:
>> Hi,
>>
>>     In the system with very few file pages (nr_active_file + nr_inactive_file
>> < 100), it is easy to reproduce "nr_isolated_file > nr_inactive_file",  then
>> too_many_isolated return true, shrink_inactive_list enter "msleep(100)", the
>> long latency will happen.
>>
>> The test case to reproduce it is very simple: allocate many huge pages(near
>> the DRAM size), then do free, repeat the same operation many times.
>> In the test case, the system with very few file pages (nr_active_file +
>> nr_inactive_file < 100), I have dumpped the numbers of
>> active/inactive/isolated file pages during the whole test(see in the
>> attachments) , in shrink_inactive_list "too_many_isolated" is very easy to
>> return true, then enter "msleep(100)",in "too_many_isolated" sc->gfp_mask is
>> 0x342cca ("_GFP_IO" and "__GFP_FS" is masked) , it is also very easy to
>> enter “inactive >>=3”, then “isolated > inactive” will be true.
>>
>> So I  have a proposal to set a threshold number for the total file pages to
>> ignore the system with very few file pages, and then bypass the 100ms sleep.
>> It is hard to set a perfect number for the threshold, so I just give an
>> example of "256" for it.
>>
>> I appreciate it if you can give me your suggestion/comments. Thanks.
> 
> Hi Zhengjun,
> 
> It seems to me using the number of isolated pages to keep a lid on
> direct reclaimers is not a good solution. We shouldn't keep going
> that direction if we really want to fix the problem because migration
> can isolate many pages too, which in turn blocks page reclaim.
> 
> Here is something works a lot better. Please give it a try. Thanks.

Thanks, I will try it with my test cases.

> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 507d216610bf2..9a09f7e76f6b8 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -951,6 +951,8 @@ typedef struct pglist_data {
>   
>   	/* Fields commonly accessed by the page reclaim scanner */
>   
> +	atomic_t nr_reclaimers;
> +
>   	/*
>   	 * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
>   	 *
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1c080fafec396..f7278642290a6 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1786,43 +1786,6 @@ int isolate_lru_page(struct page *page)
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
> @@ -1924,19 +1887,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>   	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>   	bool stalled = false;
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
>   	lru_add_drain();
>   
>   	spin_lock_irq(&lruvec->lru_lock);
> @@ -3302,6 +3252,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
>   unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>   				gfp_t gfp_mask, nodemask_t *nodemask)
>   {
> +	int nr_cpus;
>   	unsigned long nr_reclaimed;
>   	struct scan_control sc = {
>   		.nr_to_reclaim = SWAP_CLUSTER_MAX,
> @@ -3334,8 +3285,17 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>   	set_task_reclaim_state(current, &sc.reclaim_state);
>   	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
>   
> +	nr_cpus = current_is_kswapd() ? 0 : num_online_cpus();
> +	while (nr_cpus && !atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {
> +		if (schedule_timeout_killable(HZ / 10))
> +			return SWAP_CLUSTER_MAX;
> +	}
> +
>   	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>   
> +	if (nr_cpus)
> +		atomic_dec(&pgdat->nr_reclaimers);
> +
>   	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
>   	set_task_reclaim_state(current, NULL);
> 

-- 
Zhengjun Xing
