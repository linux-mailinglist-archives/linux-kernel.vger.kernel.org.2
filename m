Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE2406903
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhIJJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 05:23:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:1791 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231964AbhIJJXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 05:23:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="220709742"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="220709742"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 02:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="504993651"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2021 02:21:33 -0700
Date:   Fri, 10 Sep 2021 17:21:32 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <20210910092132.GA54659@shbuild999.sh.intel.com>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
 <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
 <20210908015014.GA28091@shbuild999.sh.intel.com>
 <YThg8Mp42b194k0/@dhcp22.suse.cz>
 <20210910074400.GA18707@shbuild999.sh.intel.com>
 <YTsYxbMhGIunUPZr@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTsYxbMhGIunUPZr@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:35:17AM +0200, Michal Hocko wrote:
[...]
> >  
> > +static inline bool cpusets_abnormal_check_needed(void)
> 
> I would go with cpusets_insane_config with a comment explaining what
> that means. I would also do a pr_info() when the static branch is
> enabled.
> 
> [...]
> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 4e455fa..5728675 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4919,7 +4919,9 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >  	 * any suitable zone to satisfy the request - e.g. non-movable
> >  	 * GFP_HIGHUSER allocations from MOVABLE nodes only.
> >  	 */
> > -	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
> > +	if (cpusets_enabled() &&
> > +		cpusets_abnormal_check_needed() &&
> 
> You do not need cpusets_enabled check here. Remember the primary point
> is to not introduce any branch unless a dubious configuration is in
> place.

Thanks for the review, patch updated below. Also should we combine
this one with the original detection patch?

Thanks,
Feng

---
 include/linux/cpuset.h | 13 +++++++++++++
 include/linux/mmzone.h | 14 ++++++++++++++
 kernel/cgroup/cpuset.c | 13 +++++++++++++
 mm/page_alloc.c        |  2 +-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d2b9c41..95bacec 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -34,6 +34,8 @@
  */
 extern struct static_key_false cpusets_pre_enable_key;
 extern struct static_key_false cpusets_enabled_key;
+extern struct static_key_false cpusets_insane_config_key;
+
 static inline bool cpusets_enabled(void)
 {
 	return static_branch_unlikely(&cpusets_enabled_key);
@@ -51,6 +53,17 @@ static inline void cpuset_dec(void)
 	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
 }
 
+/*
+ * Check if there has been insane configurations. E.g. there was usages
+ * which binds a docker OS to memory nodes with only movable zones, which
+ * causes system to behave abnormally, as the usage triggers many innocent
+ * processes get oom-killed.
+ */
+static inline bool cpusets_insane_config(void)
+{
+	return static_branch_unlikely(&cpusets_insane_config_key);
+}
+
 extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6a1d79d..c3f5527 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1116,6 +1116,20 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
+/* Whether the 'nodes' are all movable nodes */
+static inline bool movable_only_nodes(nodemask_t *nodes)
+{
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		if (zone_idx(zone) != ZONE_MOVABLE &&
+			node_isset(zone_to_nid(zone), *nodes))
+			return false;
+	}
+
+	return true;
+}
+
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
 	return zoneref->zone;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index df1ccf4..e0cb12e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -69,6 +69,13 @@
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
 
+/*
+ * There could be abnormal cpuset configurations for cpu or memory
+ * node binding, add this key to provide a quick low-cost judgement
+ * of the situation.
+ */
+DEFINE_STATIC_KEY_FALSE(cpusets_insane_config_key);
+
 /* See "Frequency meter" comments, below. */
 
 struct fmeter {
@@ -1868,6 +1875,12 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		goto done;
 
+	if (movable_only_nodes(&trialcs->mems_allowed)) {
+		static_branch_enable(&cpusets_insane_config_key);
+		pr_info("cpuset: See abornal binding to movable nodes only(nmask=%*pbl)\n",
+			nodemask_pr_args(&trialcs->mems_allowed));
+	}
+
 	spin_lock_irq(&callback_lock);
 	cs->mems_allowed = trialcs->mems_allowed;
 	spin_unlock_irq(&callback_lock);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4e455fa..a7e0854 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4919,7 +4919,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * any suitable zone to satisfy the request - e.g. non-movable
 	 * GFP_HIGHUSER allocations from MOVABLE nodes only.
 	 */
-	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
+	if (cpusets_insane_config() && (gfp_mask & __GFP_HARDWALL)) {
 		struct zoneref *z = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx,
 					&cpuset_current_mems_allowed);
-- 
2.7.4

