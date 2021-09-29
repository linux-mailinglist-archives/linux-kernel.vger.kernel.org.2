Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6142F41BEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 08:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbhI2GFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 02:05:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:5360 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243377AbhI2GFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 02:05:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224523666"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="224523666"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 23:04:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="562981471"
Received: from xuefeich-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.118])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 23:04:06 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH -V3] mm/migrate: fix CPUHP state to update node demotion order
Date:   Wed, 29 Sep 2021 14:03:51 +0800
Message-Id: <20210929060351.7293-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node demotion order needs to be updated during CPU hotplug.
Because whether a NUMA node has CPU may influence the demotion order.
The update function should be called during CPU online/offline after
the node_states[N_CPU] has been updated.  That is done in
CPUHP_AP_ONLINE_DYN during CPU online and in CPUHP_MM_VMSTAT_DEAD
during CPU offline.  But in commit 884a6e5d1f93 ("mm/migrate: update
node demotion order on hotplug events"), the function to update node
demotion order is called in CPUHP_AP_ONLINE_DYN during CPU
online/offline.  This doesn't satisfy the order requirement.

For example, there are 4 CPUs (P0, P1, P2, P3) in 2 sockets (P0, P1 in
S0 and P2, P3 in S1), the demotion order is

- S0 -> NUMA_NO_NODE
- S1 -> NUMA_NO_NODE

After P2 and P3 is offlined, because S1 has no CPU now, the demotion
order should have been changed to

- S0 -> S1
- S1 -> NO_NODE

but it isn't changed, because the order updating callback for CPU
hotplug doesn't see the new nodemask.  After that, if P1 is offlined,
the demotion order is changed to the expected order as above.

So in this patch, we added CPUHP_AP_MM_DEMOTION_ONLINE and
CPUHP_MM_DEMOTION_DEAD to be called after CPUHP_AP_ONLINE_DYN and
CPUHP_MM_VMSTAT_DEAD during CPU online and offline, and register the
update function on them.

Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Keith Busch <kbusch@kernel.org>

Changes:

v3:

- Revise patch description per Andrew's comments.

v2:

- Revise state name to follow the naming convention per Thomas' comments.

- Use cpuhp_setup_state() to initialize the initial order per Mika's comments.
---
 include/linux/cpuhotplug.h | 4 ++++
 mm/migrate.c               | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 832d8a74fa59..991911048857 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -72,6 +72,8 @@ enum cpuhp_state {
 	CPUHP_SLUB_DEAD,
 	CPUHP_DEBUG_OBJ_DEAD,
 	CPUHP_MM_WRITEBACK_DEAD,
+	/* Must be after CPUHP_MM_VMSTAT_DEAD */
+	CPUHP_MM_DEMOTION_DEAD,
 	CPUHP_MM_VMSTAT_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
 	CPUHP_NET_MVNETA_DEAD,
@@ -240,6 +242,8 @@ enum cpuhp_state {
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
+	/* Must be after CPUHP_AP_ONLINE_DYN for node_states[N_CPU] update */
+	CPUHP_AP_MM_DEMOTION_ONLINE,
 	CPUHP_AP_X86_HPET_ONLINE,
 	CPUHP_AP_X86_KVM_CLK_ONLINE,
 	CPUHP_AP_DTPM_CPU_ONLINE,
diff --git a/mm/migrate.c b/mm/migrate.c
index c14a55004fee..7769abac8aad 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3284,9 +3284,8 @@ static int __init migrate_on_reclaim_init(void)
 {
 	int ret;
 
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "migrate on reclaim",
-				migration_online_cpu,
-				migration_offline_cpu);
+	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
+					NULL, migration_offline_cpu);
 	/*
 	 * In the unlikely case that this fails, the automatic
 	 * migration targets may become suboptimal for nodes
@@ -3294,6 +3293,9 @@ static int __init migrate_on_reclaim_init(void)
 	 * rare case, do not bother trying to do anything special.
 	 */
 	WARN_ON(ret < 0);
+	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
+				migration_online_cpu, NULL);
+	WARN_ON(ret < 0);
 
 	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
 	return 0;
-- 
2.30.2

