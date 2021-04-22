Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D913687C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbhDVUSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:18:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:24924 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236915AbhDVUST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:18:19 -0400
IronPort-SDR: bKEUz33tqiFtJA1jg8uicjjAu5asfatWLiSYvNnnVoMSvu+veNwi1S5WJy/3iM047puPqV0kRl
 zijJOgTVh2Ng==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192778300"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="192778300"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 13:17:43 -0700
IronPort-SDR: cGN1FiVr7rRdcgpr4pABfyQNa2TqI8SwHnvF0YAmf33j9kE5ZlJ1fIFzUW0D4ngpaW3CUaR7lt
 idK8Dg5iHbyA==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="428105376"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.72.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 13:17:42 -0700
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
To:     Yu Zhao <yuzhao@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
 <YIGuvh70JbE1Cx4U@google.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <a085478d-5118-cdff-c611-1649fce7a650@linux.intel.com>
Date:   Thu, 22 Apr 2021 13:17:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YIGuvh70JbE1Cx4U@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/21 10:13 AM, Yu Zhao wrote:

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

100 msec seems like a long time to wait.  The original code in shrink_inactive_list
choose 100 msec sleep because the sleep happens only once in the while loop and 100 msec was
used to check for stalling.  In this case the loop can go on for a while and the 
#reclaimers can go down below the sooner than 100 msec. Seems like it should be checked
more often.

Tim

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
> 
