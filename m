Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5261E3FEA18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbhIBHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:36:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:65023 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243454AbhIBHgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:36:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="241284266"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="241284266"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 00:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="520915216"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2021 00:34:34 -0700
Date:   Thu, 2 Sep 2021 15:34:33 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom: detect and kill task which has allocation
 forbidden by cpuset limit
Message-ID: <20210902073433.GA48711@shbuild999.sh.intel.com>
References: <1630399085-70431-1-git-send-email-feng.tang@intel.com>
 <YS5RTiVgydjszmjn@dhcp22.suse.cz>
 <52d80e9-cf27-9a59-94fd-d27a1e2dac6f@google.com>
 <20210901024402.GB46357@shbuild999.sh.intel.com>
 <20210901134200.GA50993@shbuild999.sh.intel.com>
 <YS+ItADNn08hCLPY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS+ItADNn08hCLPY@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 04:05:40PM +0200, Michal Hocko wrote:
[SNIP]
> 
> This looks better than the previous attempt. It would be still better to
> solve this at the page allocator layer. The slowpath is already doing
> this for the nodemask. E.g.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eeb3a9cb36bb..a3193134540d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4929,6 +4929,17 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	if (!ac->preferred_zoneref->zone)
>  		goto nopage;
>  
> +	/*
> +	 * Check for insane configurations where the cpuset doesn't contain any suitable
> +	 * zone to satisfy the request - e.g. kernel allocations from MOVABLE nodes only
> +	 */
> +	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
> +		struct zoneref *z = first_zones_zonelist(ac->zonelist, ac->highest_zoneidx,
> +				&cpuset_current_mems_allowed);
> +		if (!z->zone)
> +			goto nopage;
> +	}
> +
>  	if (alloc_flags & ALLOC_KSWAPD)
>  		wake_all_kswapds(order, gfp_mask, ac);

Thanks for the suggestion! It dose bail out early skipping the kswapd,
direct reclaim and compaction.

I also looked at prepare_alloc_pages() which does some cpuset check
and zone initialization, but I'd better leave it alone as it's in a
real hot path, while here is in slowpath anyway. 

Will run some page fault benchmark cases with this patch.

Thanks,
Feng

> if this is seen as an additional overhead for an insane configuration
> then we can add insane_cpusets_enabled() which would be a static branch
> enabled when somebody actually tries to configure movable only cpusets
> or potentially other dubious usage.
> -- 
> Michal Hocko
> SUSE Labs
