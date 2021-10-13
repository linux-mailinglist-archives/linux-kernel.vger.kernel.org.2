Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1535D42C399
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhJMOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhJMOmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63489610E5;
        Wed, 13 Oct 2021 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634136035;
        bh=NSsOZtszn2RKnRJ99lqqhr3bfOpANz3roH2E0vUWbUc=;
        h=From:To:Cc:Subject:Date:From;
        b=KQgClq1PEFXYIQSRwFbtZlrX5QH93JOoLXeTJtkqqAtEK0uGTeieeVevismUES+zn
         EuOBaJNs1vlvFiQxHOpCuCNvHiOHluoiapQpaERgrronGRa2z7Bz6+WLvLmf506IUd
         h9tSr4g1GUNGK3qx0tR5ypuKaxNehXbECsBp+n+yTA3TgeRePU7pQiezUJK9jMUUwW
         ZWbR0f5TMid/F4ojIjpf5l4L+k/SJf7JNeG6yCpTLFfd2P/ZMz36XHcG8amEaM+MN0
         kxcWJOsXgbdqwJdJFBiq0S5IaF10bO2Jy0vJbtsJxvo5/h8fB8+Ljn0tQabuik6XzD
         5EkWZ/zC7hQBw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/migrate: rework hotplug_memory_notifier() stub
Date:   Wed, 13 Oct 2021 16:39:38 +0200
Message-Id: <20211013144029.2154629-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The previous change added a compile time warning for the
CONFIG_MEMORY_HOTPLUG=n case:

mm/migrate.c:3216:22: error: 'migrate_on_reclaim_callback' defined but not used [-Werror=unused-function]
 3216 | static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/migrate.c:3197:13: error: 'set_migration_target_nodes' defined but not used [-Werror=unused-function]
 3197 | static void set_migration_target_nodes(void)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~

Rework the hotplug_memory_notifier() stub implementation into
an inline function so it always references its argument but
ignores it, leading the compiler to silently drop the hotplug
memory notifier function and further code referenced from it.

To do this, the #ifdef around those functions need to be removed
as well, but this tends to help with readability and build coverage.

Fixes: dd3e24b84bc1 ("mm/migrate: add CPU hotplug to demotion #ifdef")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/memory.h | 5 ++++-
 mm/migrate.c           | 6 +-----
 mm/page_ext.c          | 4 +---
 mm/slab.c              | 4 ++--
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index a216829df280..95af54f585a1 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -125,7 +125,10 @@ static inline int memory_notify(unsigned long val, void *v)
 {
 	return 0;
 }
-#define hotplug_memory_notifier(fn, pri)	({ 0; })
+static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
+{
+	return 0;
+}
 /* These aren't inline functions due to a GCC bug. */
 #define register_hotmemory_notifier(nb)    ({ (void)(nb); 0; })
 #define unregister_hotmemory_notifier(nb)  ({ (void)(nb); })
diff --git a/mm/migrate.c b/mm/migrate.c
index 7769abac8aad..32303d517e10 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3059,7 +3059,7 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
-#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_HOTPLUG_CPU)
+#if defined(CONFIG_HOTPLUG_CPU)
 /* Disable reclaim-based migration. */
 static void __disable_all_migrate_targets(void)
 {
@@ -3201,7 +3201,6 @@ static void set_migration_target_nodes(void)
 	put_online_mems();
 }
 
-#if defined(CONFIG_MEMORY_HOTPLUG)
 /*
  * This leaves migrate-on-reclaim transiently disabled between
  * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
@@ -3258,9 +3257,7 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
 
 	return notifier_from_errno(0);
 }
-#endif /* CONFIG_MEMORY_HOTPLUG */
 
-#ifdef CONFIG_HOTPLUG_CPU
 /*
  * React to hotplug events that might affect the migration targets
  * like events that online or offline NUMA nodes.
@@ -3302,4 +3299,3 @@ static int __init migrate_on_reclaim_init(void)
 }
 late_initcall(migrate_on_reclaim_init);
 #endif /* CONFIG_HOTPLUG_CPU */
-#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_HOTPLUG_CPU */
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 106079e67c2e..6242afb24d84 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -269,7 +269,7 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
 	total_usage += table_size;
 	return 0;
 }
-#ifdef CONFIG_MEMORY_HOTPLUG
+
 static void free_page_ext(void *addr)
 {
 	if (is_vmalloc_addr(addr)) {
@@ -374,8 +374,6 @@ static int __meminit page_ext_callback(struct notifier_block *self,
 	return notifier_from_errno(ret);
 }
 
-#endif
-
 void __init page_ext_init(void)
 {
 	unsigned long pfn;
diff --git a/mm/slab.c b/mm/slab.c
index 01775fe0e002..da132a9ae6f8 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1095,7 +1095,7 @@ static int slab_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
+#if defined(CONFIG_NUMA)
 /*
  * Drains freelist for a node on each slab cache, used for memory hot-remove.
  * Returns -EBUSY if all objects cannot be drained so that the node is not
@@ -1157,7 +1157,7 @@ static int __meminit slab_memory_callback(struct notifier_block *self,
 out:
 	return notifier_from_errno(ret);
 }
-#endif /* CONFIG_NUMA && CONFIG_MEMORY_HOTPLUG */
+#endif /* CONFIG_NUMA */
 
 /*
  * swap the static kmem_cache_node with kmalloced memory
-- 
2.29.2

