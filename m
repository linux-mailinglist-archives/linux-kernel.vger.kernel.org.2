Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E02641015A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbhIQWgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:36:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:63257 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344816AbhIQWgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:36:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="222543381"
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="222543381"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 15:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="546658640"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.28.105])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2021 15:35:08 -0700
Subject: [PATCH 2/2] mm/migrate: add CPU hotplug to demotion #ifdef
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, ying.huang@intel.com,
        mhocko@suse.com, weixugc@google.com, osalvador@suse.de,
        rientjes@google.com, dan.j.williams@intel.com, david@redhat.com,
        gthelen@google.com, yang.shi@linux.alibaba.com,
        akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 17 Sep 2021 15:35:07 -0700
References: <20210917223504.C140445A@davehans-spike.ostc.intel.com>
In-Reply-To: <20210917223504.C140445A@davehans-spike.ostc.intel.com>
Message-Id: <20210917223507.913387AB@davehans-spike.ostc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Once upon a time, the node demotion updates were driven solely by
memory hotplug events.  But now, there are  handlers for both CPU
and memory hotplug.

However, the #ifdef around the code checks only memory hotplug.
A system that has HOTPLUG_CPU=y but MEMORY_HOTPLUG=n would miss
CPU hotplug events.

Update the #ifdef around the common code.  Add memory and
CPU-specific #ifdefs for their handlers.  These memory/CPU
#ifdefs avoid unused function warnings when their Kconfig option
is off.

Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

 b/mm/migrate.c |   46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff -puN mm/migrate.c~add-cpu-hotplug-config mm/migrate.c
--- a/mm/migrate.c~add-cpu-hotplug-config	2021-09-16 16:14:01.770140593 -0700
+++ b/mm/migrate.c	2021-09-17 11:30:19.197027668 -0700
@@ -3066,7 +3066,7 @@ void migrate_vma_finalize(struct migrate
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
-#if defined(CONFIG_MEMORY_HOTPLUG)
+#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_HOTPLUG_CPU)
 /* Disable reclaim-based migration. */
 static void __disable_all_migrate_targets(void)
 {
@@ -3248,25 +3248,7 @@ static void set_migration_target_nodes(v
 	put_online_mems();
 }
 
-/*
- * React to hotplug events that might affect the migration targets
- * like events that online or offline NUMA nodes.
- *
- * The ordering is also currently dependent on which nodes have
- * CPUs.  That means we need CPU on/offline notification too.
- */
-static int migration_online_cpu(unsigned int cpu)
-{
-	set_migration_target_nodes();
-	return 0;
-}
-
-static int migration_offline_cpu(unsigned int cpu)
-{
-	set_migration_target_nodes();
-	return 0;
-}
-
+#if defined(CONFIG_MEMORY_HOTPLUG)
 /*
  * This leaves migrate-on-reclaim transiently disabled between
  * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
@@ -3313,6 +3295,27 @@ static int __meminit migrate_on_reclaim_
 
 	return notifier_from_errno(0);
 }
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * React to hotplug events that might affect the migration targets
+ * like events that online or offline NUMA nodes.
+ *
+ * The ordering is also currently dependent on which nodes have
+ * CPUs.  That means we need CPU on/offline notification too.
+ */
+static int migration_online_cpu(unsigned int cpu)
+{
+	set_migration_target_nodes();
+	return 0;
+}
+
+static int migration_offline_cpu(unsigned int cpu)
+{
+	set_migration_target_nodes();
+	return 0;
+}
 
 static int __init migrate_on_reclaim_init(void)
 {
@@ -3333,4 +3336,5 @@ static int __init migrate_on_reclaim_ini
 	return 0;
 }
 late_initcall(migrate_on_reclaim_init);
-#endif /* CONFIG_MEMORY_HOTPLUG */
+#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_HOTPLUG_CPU */
_
