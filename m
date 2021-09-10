Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA18D4067ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhIJHpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:45:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:38095 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbhIJHpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:45:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="306585336"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="306585336"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 00:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="466974570"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2021 00:44:00 -0700
Date:   Fri, 10 Sep 2021 15:44:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <20210910074400.GA18707@shbuild999.sh.intel.com>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
 <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
 <20210908015014.GA28091@shbuild999.sh.intel.com>
 <YThg8Mp42b194k0/@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YThg8Mp42b194k0/@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 09:06:24AM +0200, Michal Hocko wrote:
> On Wed 08-09-21 09:50:14, Feng Tang wrote:
> > On Tue, Sep 07, 2021 at 10:44:32AM +0200, Michal Hocko wrote:
> [...]
> > > While this is a good fix from the functionality POV I believe you can go
> > > a step further. Please add a detection to the cpuset code and complain
> > > to the kernel log if somebody tries to configure movable only cpuset.
> > > Once you have that in place you can easily create a static branch for
> > > cpuset_insane_setup() and have zero overhead for all reasonable
> > > configuration. There shouldn't be any reason to pay a single cpu cycle
> > > to check for something that almost nobody does.
> > > 
> > > What do you think?
> > 
> > I thought about the implementation, IIUC, the static_branch_enable() is
> > easy, it could be done when cpuset.mems is set with movable only nodes,
> > but disable() is much complexer,
> 
> Do we care about disable at all? The point is to not have 99,999999%
> users pay overhead of the check which is irrelevant to them. Once
> somebody wants to use this "creative" setup then paying an extra check
> sounds perfectly sensible to me. If somebody cares enough then the
> disable logic could be implemented. But for now I believe we should be
> OK with only enable case.

Here is tested draft patch to add the check in cpuset code (the looping
zone code could be improved by adding a for_each_populated_zone_nodemask
macro.

Thanks,
Feng

---
 include/linux/cpuset.h |  7 +++++++
 include/linux/mmzone.h | 14 ++++++++++++++
 kernel/cgroup/cpuset.c | 10 ++++++++++
 mm/page_alloc.c        |  4 +++-
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d2b9c41..a434985 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -34,6 +34,8 @@
  */
 extern struct static_key_false cpusets_pre_enable_key;
 extern struct static_key_false cpusets_enabled_key;
+extern struct static_key_false cpusets_abnormal_setup_key;
+
 static inline bool cpusets_enabled(void)
 {
 	return static_branch_unlikely(&cpusets_enabled_key);
@@ -51,6 +53,11 @@ static inline void cpuset_dec(void)
 	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
 }
 
+static inline bool cpusets_abnormal_check_needed(void)
+{
+	return static_branch_unlikely(&cpusets_abnormal_setup_key);
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
index df1ccf4..e8a9053 100644
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
+DEFINE_STATIC_KEY_FALSE(cpusets_abnormal_setup_key);
+
 /* See "Frequency meter" comments, below. */
 
 struct fmeter {
@@ -1868,6 +1875,9 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		goto done;
 
+	if (movable_only_nodes(&trialcs->mems_allowed))
+		static_branch_enable(&cpusets_abnormal_setup_key);
+
 	spin_lock_irq(&callback_lock);
 	cs->mems_allowed = trialcs->mems_allowed;
 	spin_unlock_irq(&callback_lock);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4e455fa..5728675 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4919,7 +4919,9 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * any suitable zone to satisfy the request - e.g. non-movable
 	 * GFP_HIGHUSER allocations from MOVABLE nodes only.
 	 */
-	if (cpusets_enabled() && (gfp_mask & __GFP_HARDWALL)) {
+	if (cpusets_enabled() &&
+		cpusets_abnormal_check_needed() &&
+		(gfp_mask & __GFP_HARDWALL)) {
 		struct zoneref *z = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx,
 					&cpuset_current_mems_allowed);
-- 
2.7.4


