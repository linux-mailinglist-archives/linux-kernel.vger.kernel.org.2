Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596DD40688C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 10:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhIJIgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 04:36:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57474 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhIJIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 04:36:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 918E420203;
        Fri, 10 Sep 2021 08:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631262919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byJxGIGEdXY0dNiR3JR/k4UiilB5WnFIjCG84yHjPvA=;
        b=oMY1GPzbSb4+Nhh3TT6muALj3czRc6RYjO8XFhoTGB2SwjjsTicuFJdPQobspIh+rISUHL
        eLMWo1ZyXCJA99BQCG2PIGOwS2I4vxmS5p+ttronuYx0OmdLvjSpNOFIp7k0x5sI8qfwPP
        4n1ySiHDzUjYigcgBvIWrfsXPmOGYlk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EF7FEA3B99;
        Fri, 10 Sep 2021 08:35:17 +0000 (UTC)
Date:   Fri, 10 Sep 2021 10:35:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <YTsYxbMhGIunUPZr@dhcp22.suse.cz>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
 <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
 <20210908015014.GA28091@shbuild999.sh.intel.com>
 <YThg8Mp42b194k0/@dhcp22.suse.cz>
 <20210910074400.GA18707@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910074400.GA18707@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-09-21 15:44:00, Feng Tang wrote:
> On Wed, Sep 08, 2021 at 09:06:24AM +0200, Michal Hocko wrote:
> > On Wed 08-09-21 09:50:14, Feng Tang wrote:
> > > On Tue, Sep 07, 2021 at 10:44:32AM +0200, Michal Hocko wrote:
> > [...]
> > > > While this is a good fix from the functionality POV I believe you can go
> > > > a step further. Please add a detection to the cpuset code and complain
> > > > to the kernel log if somebody tries to configure movable only cpuset.
> > > > Once you have that in place you can easily create a static branch for
> > > > cpuset_insane_setup() and have zero overhead for all reasonable
> > > > configuration. There shouldn't be any reason to pay a single cpu cycle
> > > > to check for something that almost nobody does.
> > > > 
> > > > What do you think?
> > > 
> > > I thought about the implementation, IIUC, the static_branch_enable() is
> > > easy, it could be done when cpuset.mems is set with movable only nodes,
> > > but disable() is much complexer,
> > 
> > Do we care about disable at all? The point is to not have 99,999999%
> > users pay overhead of the check which is irrelevant to them. Once
> > somebody wants to use this "creative" setup then paying an extra check
> > sounds perfectly sensible to me. If somebody cares enough then the
> > disable logic could be implemented. But for now I believe we should be
> > OK with only enable case.
> 
> Here is tested draft patch to add the check in cpuset code (the looping
> zone code could be improved by adding a for_each_populated_zone_nodemask
> macro.
> 
> Thanks,
> Feng
> 
> ---
>  include/linux/cpuset.h |  7 +++++++
>  include/linux/mmzone.h | 14 ++++++++++++++
>  kernel/cgroup/cpuset.c | 10 ++++++++++
>  mm/page_alloc.c        |  4 +++-
>  4 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d2b9c41..a434985 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -34,6 +34,8 @@
>   */
>  extern struct static_key_false cpusets_pre_enable_key;
>  extern struct static_key_false cpusets_enabled_key;
> +extern struct static_key_false cpusets_abnormal_setup_key;
> +
>  static inline bool cpusets_enabled(void)
>  {
>  	return static_branch_unlikely(&cpusets_enabled_key);
> @@ -51,6 +53,11 @@ static inline void cpuset_dec(void)
>  	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
>  }
>  
> +static inline bool cpusets_abnormal_check_needed(void)

I would go with cpusets_insane_config with a comment explaining what
that means. I would also do a pr_info() when the static branch is
enabled.

[...]

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4e455fa..5728675 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4919,7 +4919,9 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 * any suitable zone to satisfy the request - e.g. non-movable
>  	 * GFP_HIGHUSER allocations from MOVABLE nodes only.
>  	 */
> -	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
> +	if (cpusets_enabled() &&
> +		cpusets_abnormal_check_needed() &&

You do not need cpusets_enabled check here. Remember the primary point
is to not introduce any branch unless a dubious configuration is in
place.

> +		(gfp_mask & __GFP_HARDWALL)) {
>  		struct zoneref *z = first_zones_zonelist(ac->zonelist,
>  					ac->highest_zoneidx,
>  					&cpuset_current_mems_allowed);
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
