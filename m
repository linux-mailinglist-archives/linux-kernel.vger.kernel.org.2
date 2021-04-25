Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F2636A3C3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 02:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhDYAtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 20:49:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:44023 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhDYAtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 20:49:05 -0400
IronPort-SDR: GSq/ueOLhBaiPlGY7RVWixzgzeYaeRN6oaIhJIpt7j3MN1VtX5r+v0+9si6YlQgzWWwJlpRUoG
 w13Cx43tBFbg==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="196315554"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="196315554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 17:48:26 -0700
IronPort-SDR: EeMfR+hV1QrmnisxPdxkxo1LcIoKYFOjOAP13eXwTZTXMao2BRqg949nKNtJRVaNoSTvjOuMH+
 /lr9129zEQHg==
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="428890013"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 17:48:24 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
        <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
        <YIGuvh70JbE1Cx4U@google.com>
        <7a0fecab-f9e1-ad39-d55e-01e574a35484@linux.intel.com>
        <YIMsykToLKUVMWbZ@google.com>
Date:   Sun, 25 Apr 2021 08:48:22 +0800
In-Reply-To: <YIMsykToLKUVMWbZ@google.com> (Yu Zhao's message of "Fri, 23 Apr
        2021 14:23:38 -0600")
Message-ID: <87fszfxk89.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:
[snip]

> @@ -2966,13 +2938,20 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>  			/* need some check for avoid more shrink_zone() */
>  		}
>  
> -		/* See comment about same check for global reclaim above */
> -		if (zone->zone_pgdat == last_pgdat)
> -			continue;
> -		last_pgdat = zone->zone_pgdat;
>  		shrink_node(zone->zone_pgdat, sc);
>  	}
>  
> +	if (last_pgdat)
> +		atomic_dec(&last_pgdat->nr_reclaimers);
> +	else if (should_retry) {
> +		/* wait a bit for the reclaimer. */
> +		if (!schedule_timeout_killable(HZ / 10))

Once we reached here, even accidentally, the caller needs to sleep at
least 100ms.  How about use a semaphore for pgdat->nr_reclaimers?  Then
the sleeper can be waken up when the resource is considered enough.

Best Regards,
Huang, Ying

> +			goto retry;
> +
> +		/* We are about to die and free our memory. Return now. */
> +		sc->nr_reclaimed += SWAP_CLUSTER_MAX;
> +	}
> +
>  	/*
>  	 * Restore to original mask to avoid the impact on the caller if we
>  	 * promoted it to __GFP_HIGHMEM.

[snip]
