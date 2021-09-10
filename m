Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0395E406A32
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhIJKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 06:36:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52104 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhIJKgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:36:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8CBD01FE65;
        Fri, 10 Sep 2021 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631270103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wYIN96dlfyxUk9rWZXzHgJP2ogNKRUq1YB5cFiiBzMc=;
        b=OWynuje8wmFcZ1fruEQTPqBXrYESWu/F76mVmZ50UVfSuDWjqXVsi0QQ8jlBU9VLBMs//x
        Sv0OfgakxXQAlnvVDhej4TcZ/DlmUZxujgGPDv6T3TbYp2aMIUFudvAldojoDsKsKAYWAN
        X3rAwEQUGCE4AOwKFcM0DPRjWV8rUm0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE67DA3B97;
        Fri, 10 Sep 2021 10:35:02 +0000 (UTC)
Date:   Fri, 10 Sep 2021 12:35:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <YTs01sPa5MojLGqO@dhcp22.suse.cz>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
 <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
 <20210908015014.GA28091@shbuild999.sh.intel.com>
 <YThg8Mp42b194k0/@dhcp22.suse.cz>
 <20210910074400.GA18707@shbuild999.sh.intel.com>
 <YTsYxbMhGIunUPZr@dhcp22.suse.cz>
 <20210910092132.GA54659@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910092132.GA54659@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would squash the two changes into a single patch.

On Fri 10-09-21 17:21:32, Feng Tang wrote:
[...]
> +/*
> + * Check if there has been insane configurations. E.g. there was usages
> + * which binds a docker OS to memory nodes with only movable zones, which
> + * causes system to behave abnormally, as the usage triggers many innocent
> + * processes get oom-killed.

I would go with more specifics here. What about

/*
 * This will get enabled whenever a cpuset configuration is considered
 * unsupportable in general. E.g. movable only node which cannot satisfy
 * any non movable allocations (see update_nodemask).
 * Page allocator needs to make additional checks for those
 * configurations and this check is meant to guard those checks without
 * any overhead for sane configurations.
 */
> + */
> +static inline bool cpusets_insane_config(void)
> +{
> +	return static_branch_unlikely(&cpusets_insane_config_key);
> +}
> +
>  extern int cpuset_init(void);
>  extern void cpuset_init_smp(void);
>  extern void cpuset_force_rebuild(void);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 6a1d79d..c3f5527 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1116,6 +1116,20 @@ extern struct zone *next_zone(struct zone *zone);
>  			; /* do nothing */		\
>  		else
>  
> +/* Whether the 'nodes' are all movable nodes */
> +static inline bool movable_only_nodes(nodemask_t *nodes)
> +{
> +	struct zone *zone;
> +
> +	for_each_populated_zone(zone) {
> +		if (zone_idx(zone) != ZONE_MOVABLE &&
> +			node_isset(zone_to_nid(zone), *nodes))
> +			return false;
> +	}
> +
> +	return true;

Sorry I didn't really get to read this previously. The implementation
works but I find it harder to read than really necessary. Why don't you
use first_zones_zonelist here as well?
	
> +}
> +
>  static inline struct zone *zonelist_zone(struct zoneref *zoneref)
>  {
>  	return zoneref->zone;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index df1ccf4..e0cb12e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -69,6 +69,13 @@
>  DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
>  DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
>  
> +/*
> + * There could be abnormal cpuset configurations for cpu or memory
> + * node binding, add this key to provide a quick low-cost judgement
> + * of the situation.
> + */
> +DEFINE_STATIC_KEY_FALSE(cpusets_insane_config_key);
> +
>  /* See "Frequency meter" comments, below. */
>  
>  struct fmeter {
> @@ -1868,6 +1875,12 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>  	if (retval < 0)
>  		goto done;
>  
> +	if (movable_only_nodes(&trialcs->mems_allowed)) {
> +		static_branch_enable(&cpusets_insane_config_key);
> +		pr_info("cpuset: See abornal binding to movable nodes only(nmask=%*pbl)\n",
> +			nodemask_pr_args(&trialcs->mems_allowed));

This doesn't sound very useful for admins IMHO. It is not clear what the
problem is and how to deal with it. What about
		pr_into("Unsupported (movable nodes only) cpuset configuration detected! Cpuset allocations might fail even with a lot of memory available.");

> +	}
> +
>  	spin_lock_irq(&callback_lock);
>  	cs->mems_allowed = trialcs->mems_allowed;
>  	spin_unlock_irq(&callback_lock);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4e455fa..a7e0854 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4919,7 +4919,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 * any suitable zone to satisfy the request - e.g. non-movable
>  	 * GFP_HIGHUSER allocations from MOVABLE nodes only.
>  	 */
> -	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
> +	if (cpusets_insane_config() && (gfp_mask & __GFP_HARDWALL)) {
>  		struct zoneref *z = first_zones_zonelist(ac->zonelist,
>  					ac->highest_zoneidx,
>  					&cpuset_current_mems_allowed);
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
