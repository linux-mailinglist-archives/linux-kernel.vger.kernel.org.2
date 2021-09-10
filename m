Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0C406AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhIJLbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:31:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:21021 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhIJLbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:31:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="217889679"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="217889679"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 04:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="540562981"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2021 04:29:54 -0700
Date:   Fri, 10 Sep 2021 19:29:53 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <20210910112953.GB54659@shbuild999.sh.intel.com>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
 <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
 <20210908015014.GA28091@shbuild999.sh.intel.com>
 <YThg8Mp42b194k0/@dhcp22.suse.cz>
 <20210910074400.GA18707@shbuild999.sh.intel.com>
 <YTsYxbMhGIunUPZr@dhcp22.suse.cz>
 <20210910092132.GA54659@shbuild999.sh.intel.com>
 <YTs01sPa5MojLGqO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTs01sPa5MojLGqO@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 12:35:02PM +0200, Michal Hocko wrote:
> I would squash the two changes into a single patch.
> 
> On Fri 10-09-21 17:21:32, Feng Tang wrote:
> [...]
> > +/*
> > + * Check if there has been insane configurations. E.g. there was usages
> > + * which binds a docker OS to memory nodes with only movable zones, which
> > + * causes system to behave abnormally, as the usage triggers many innocent
> > + * processes get oom-killed.
> 
> I would go with more specifics here. What about
> 
> /*
>  * This will get enabled whenever a cpuset configuration is considered
>  * unsupportable in general. E.g. movable only node which cannot satisfy
>  * any non movable allocations (see update_nodemask).
>  * Page allocator needs to make additional checks for those
>  * configurations and this check is meant to guard those checks without
>  * any overhead for sane configurations.
>  */

will use this, thanks

> > + */
> > +static inline bool cpusets_insane_config(void)
> > +{
> > +	return static_branch_unlikely(&cpusets_insane_config_key);
> > +}
> > +
> >  extern int cpuset_init(void);
> >  extern void cpuset_init_smp(void);
> >  extern void cpuset_force_rebuild(void);
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 6a1d79d..c3f5527 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1116,6 +1116,20 @@ extern struct zone *next_zone(struct zone *zone);
> >  			; /* do nothing */		\
> >  		else
> >  
> > +/* Whether the 'nodes' are all movable nodes */
> > +static inline bool movable_only_nodes(nodemask_t *nodes)
> > +{
> > +	struct zone *zone;
> > +
> > +	for_each_populated_zone(zone) {
> > +		if (zone_idx(zone) != ZONE_MOVABLE &&
> > +			node_isset(zone_to_nid(zone), *nodes))
> > +			return false;
> > +	}
> > +
> > +	return true;
> 
> Sorry I didn't really get to read this previously. The implementation
> works but I find it harder to read than really necessary. Why don't you
> use first_zones_zonelist here as well?

The concern I had was which zonelist to use, local node or the first node
of nodemask's node_zonelists[ZONELIST_FALLBACK], and the node_zonelists[]
is initialized in node init time, I'm not sure if all nodes's zone will
be showed in it (though it is 'yes' for current code).

Also, I tried another logic (a new 'for_each_populated_zone_nodes' macro)
	for_each_populated_zone_nodes(zone, node, *nodes) {
		if (zone_idx(zone) != ZONE_MOVABLE)
 			return false;
 	}

> > +}
> > +
> >  static inline struct zone *zonelist_zone(struct zoneref *zoneref)
> >  {
> >  	return zoneref->zone;
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index df1ccf4..e0cb12e 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -69,6 +69,13 @@
> >  DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
> >  DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
> >  
> > +/*
> > + * There could be abnormal cpuset configurations for cpu or memory
> > + * node binding, add this key to provide a quick low-cost judgement
> > + * of the situation.
> > + */
> > +DEFINE_STATIC_KEY_FALSE(cpusets_insane_config_key);
> > +
> >  /* See "Frequency meter" comments, below. */
> >  
> >  struct fmeter {
> > @@ -1868,6 +1875,12 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
> >  	if (retval < 0)
> >  		goto done;
> >  
> > +	if (movable_only_nodes(&trialcs->mems_allowed)) {
> > +		static_branch_enable(&cpusets_insane_config_key);
> > +		pr_info("cpuset: See abornal binding to movable nodes only(nmask=%*pbl)\n",
> > +			nodemask_pr_args(&trialcs->mems_allowed));
> 
> This doesn't sound very useful for admins IMHO. It is not clear what the
> problem is and how to deal with it. What about
> 		pr_into("Unsupported (movable nodes only) cpuset configuration detected! Cpuset allocations might fail even with a lot of memory available.");

Yep, this is better!

Thanks,
Feng
