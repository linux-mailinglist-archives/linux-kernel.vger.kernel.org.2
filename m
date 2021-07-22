Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D543D1C54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 05:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhGVCik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:38:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:47174 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhGVCi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:38:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="191139214"
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="191139214"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 20:19:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="501577001"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 20:19:00 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org
Subject: [PATCH -V7 4/6] memory tiering: hot page selection with hint page fault latency
Date:   Thu, 22 Jul 2021 11:18:17 +0800
Message-Id: <20210722031819.3446711-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722031819.3446711-1-ying.huang@intel.com>
References: <20210722031819.3446711-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To optimize page placement in a memory tiering system with NUMA
balancing, the hot pages in the slow memory node need to be
identified.  Essentially, the original NUMA balancing implementation
selects the mostly recently accessed (MRU) pages as the hot pages.
But this isn't a very good algorithm to identify the hot pages.

So, in this patch we implemented a better hot page selection
algorithm.  Which is based on NUMA balancing page table scanning and
hint page fault as follows,

- When the page tables of the processes are scanned to change PTE/PMD
  to be PROT_NONE, the current time is recorded in struct page as scan
  time.

- When the page is accessed, hint page fault will occur.  The scan
  time is gotten from the struct page.  And The hint page fault
  latency is defined as

    hint page fault time - scan time

The shorter the hint page fault latency of a page is, the higher the
probability of their access frequency to be higher.  So the hint page
fault latency is a good estimation of the page hot/cold.

But it's hard to find some extra space in struct page to hold the scan
time.  Fortunately, we can reuse some bits used by the original NUMA
balancing.

NUMA balancing uses some bits in struct page to store the page
accessing CPU and PID (referring to page_cpupid_xchg_last()).  Which
is used by the multi-stage node selection algorithm to avoid to
migrate pages shared accessed by the NUMA nodes back and forth.  But
for pages in the slow memory node, even if they are shared accessed by
multiple NUMA nodes, as long as the pages are hot, they need to be
promoted to the fast memory node.  So the accessing CPU and PID
information are unnecessary for the slow memory pages.  We can reuse
these bits in struct page to record the scan time for them.  For the
fast memory pages, these bits are used as before.

The remaining problem is how to determine the hot threshold.  It's not
easy to be done automatically.  So we provide a sysctl knob:
kernel.numa_balancing_hot_threshold_ms.  All pages with hint page
fault latency < the threshold will be considered hot.  The system
administrator can determine the hot threshold via various information,
such as PMEM bandwidth limit, the average number of the pages pass the
hot threshold, etc.  The default hot threshold is 1 second, which
works well in our performance test.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
16.8% with 41.1% less pages promoted (that is, less overhead) on a 2
socket Intel server with Optance DC Persistent Memory.

The downside of the patch is that the response time to the workload
hot spot changing may be much longer.  For example,

- A previous cold memory area becomes hot

- The hint page fault will be triggered.  But the hint page fault
  latency isn't shorter than the hot threshold.  So the pages will
  not be promoted.

- When the memory area is scanned again, maybe after a scan period,
  the hint page fault latency measured will be shorter than the hot
  threshold and the pages will be promoted.

To mitigate this,

- If there are enough free space in the fast memory node, the hot
  threshold will not be used, all pages will be promoted upon the hint
  page fault for fast response.

- If fast response is more important for system performance, the
  administrator can set a higher hot threshold.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mm.h           | 29 ++++++++++++++++
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/fair.c          | 67 ++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c              |  7 ++++
 mm/huge_memory.c             | 13 +++++--
 mm/memory.c                  | 11 +++++-
 mm/migrate.c                 | 12 +++++++
 mm/mmzone.c                  | 17 +++++++++
 mm/mprotect.c                |  8 ++++-
 9 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..c0c097adffa4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1379,6 +1379,18 @@ static inline int page_to_nid(const struct page *page)
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
+/* page access time bits needs to hold at least 4 seconds */
+#define PAGE_ACCESS_TIME_MIN_BITS	12
+#if LAST_CPUPID_SHIFT < PAGE_ACCESS_TIME_MIN_BITS
+#define PAGE_ACCESS_TIME_BUCKETS				\
+	(PAGE_ACCESS_TIME_MIN_BITS - LAST_CPUPID_SHIFT)
+#else
+#define PAGE_ACCESS_TIME_BUCKETS	0
+#endif
+
+#define PAGE_ACCESS_TIME_MASK				\
+	(LAST_CPUPID_MASK << PAGE_ACCESS_TIME_BUCKETS)
+
 static inline int cpu_pid_to_cpupid(int cpu, int pid)
 {
 	return ((cpu & LAST__CPU_MASK) << LAST__PID_SHIFT) | (pid & LAST__PID_MASK);
@@ -1421,6 +1433,16 @@ static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 	return xchg(&page->_last_cpupid, cpupid & LAST_CPUPID_MASK);
 }
 
+static inline unsigned int xchg_page_access_time(struct page *page,
+						 unsigned int time)
+{
+	unsigned int last_time;
+
+	last_time = xchg(&page->_last_cpupid,
+			 (time >> PAGE_ACCESS_TIME_BUCKETS) & LAST_CPUPID_MASK);
+	return last_time << PAGE_ACCESS_TIME_BUCKETS;
+}
+
 static inline int page_cpupid_last(struct page *page)
 {
 	return page->_last_cpupid;
@@ -1436,6 +1458,7 @@ static inline int page_cpupid_last(struct page *page)
 }
 
 extern int page_cpupid_xchg_last(struct page *page, int cpupid);
+extern unsigned int xchg_page_access_time(struct page *page, unsigned int time);
 
 static inline void page_cpupid_reset_last(struct page *page)
 {
@@ -1448,6 +1471,12 @@ static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 	return page_to_nid(page); /* XXX */
 }
 
+static inline unsigned int xchg_page_access_time(struct page *page,
+						 unsigned int time)
+{
+	return 0;
+}
+
 static inline int page_cpupid_last(struct page *page)
 {
 	return page_to_nid(page); /* XXX */
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index bc54c1d75d6d..0ea43b146aee 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -41,6 +41,7 @@ enum sched_tunable_scaling {
 
 #ifdef CONFIG_NUMA_BALANCING
 extern int sysctl_numa_balancing_mode;
+extern unsigned int sysctl_numa_balancing_hot_threshold;
 #else
 #define sysctl_numa_balancing_mode	0
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44e44c235f1f..98e3f1600ca6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1037,6 +1037,9 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
+/* The page with hint page fault latency < threshold in ms is considered hot */
+unsigned int sysctl_numa_balancing_hot_threshold = 1000;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1377,6 +1380,37 @@ static inline unsigned long group_weight(struct task_struct *p, int nid,
 	return 1000 * faults / total_faults;
 }
 
+static bool pgdat_free_space_enough(struct pglist_data *pgdat)
+{
+	int z;
+	unsigned long enough_mark;
+
+	enough_mark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
+			  pgdat->node_present_pages >> 4);
+	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+		struct zone *zone = pgdat->node_zones + z;
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone_watermark_ok(zone, 0,
+				      high_wmark_pages(zone) + enough_mark,
+				      ZONE_MOVABLE, 0))
+			return true;
+	}
+	return false;
+}
+
+static int numa_hint_fault_latency(struct page *page)
+{
+	unsigned int last_time, time;
+
+	time = jiffies_to_msecs(jiffies);
+	last_time = xchg_page_access_time(page, time);
+
+	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1384,6 +1418,27 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	/*
+	 * The pages in slow memory node should be migrated according
+	 * to hot/cold instead of accessing CPU node.
+	 */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+	    !node_is_toptier(src_nid)) {
+		struct pglist_data *pgdat;
+		unsigned long latency, th;
+
+		pgdat = NODE_DATA(dst_nid);
+		if (pgdat_free_space_enough(pgdat))
+			return true;
+
+		th = sysctl_numa_balancing_hot_threshold;
+		latency = numa_hint_fault_latency(page);
+		if (latency > th)
+			return false;
+
+		return true;
+	}
+
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
 
@@ -2604,6 +2659,11 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	if (!p->mm)
 		return;
 
+	/* Numa faults statistics are unnecessary for the slow memory node */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+	    !node_is_toptier(mem_node))
+		return;
+
 	/* Allocate buffer to track faults on a per-node basis */
 	if (unlikely(!p->numa_faults)) {
 		int size = sizeof(*p->numa_faults) *
@@ -2623,6 +2683,13 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	 */
 	if (unlikely(last_cpupid == (-1 & LAST_CPUPID_MASK))) {
 		priv = 1;
+	} else if (unlikely(!cpu_online(cpupid_to_cpu(last_cpupid)))) {
+		/*
+		 * In memory tiering mode, cpupid of slow memory page is
+		 * used to record page access time, so its value may be
+		 * invalid during numa balancing mode transition.
+		 */
+		return;
 	} else {
 		priv = cpupid_match_pid(p, last_cpupid);
 		if (!priv && !(flags & TNF_NO_GROUP))
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d08ebb1d8d80..27b6daeb1004 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1770,6 +1770,13 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &three,
 	},
+	{
+		.procname	= "numa_balancing_hot_threshold_ms",
+		.data		= &sysctl_numa_balancing_hot_threshold,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #endif /* CONFIG_NUMA_BALANCING */
 	{
 		.procname	= "sched_rt_period_us",
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 16280f695638..604d81b5525b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1430,7 +1430,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	int page_nid = NUMA_NO_NODE;
-	int target_nid, last_cpupid = -1;
+	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
 	bool migrated = false;
 	bool was_writable = pmd_savedwrite(oldpmd);
 	int flags = 0;
@@ -1477,7 +1477,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 		flags |= TNF_NO_GROUP;
 
 	page_nid = page_to_nid(page);
-	last_cpupid = page_cpupid_last(page);
+	if (node_is_toptier(page_nid))
+		last_cpupid = page_cpupid_last(page);
 	target_nid = numa_migrate_prep(page, vma, haddr, page_nid,
 				       &flags);
 
@@ -1795,6 +1796,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 
 	if (prot_numa) {
 		struct page *page;
+		bool toptier;
 		/*
 		 * Avoid trapping faults against the zero page. The read-only
 		 * data is likely to be read-cached on the local CPU and
@@ -1807,13 +1809,18 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			goto unlock;
 
 		page = pmd_page(*pmd);
+		toptier = node_is_toptier(page_to_nid(page));
 		/*
 		 * Skip scanning top tier node if normal numa
 		 * balancing is disabled
 		 */
 		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-		    node_is_toptier(page_to_nid(page)))
+		    toptier)
 			goto unlock;
+
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    !toptier)
+			xchg_page_access_time(page, jiffies_to_msecs(jiffies));
 	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
diff --git a/mm/memory.c b/mm/memory.c
index db86558791f1..48c8bf5a83af 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -73,6 +73,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/sched/sysctl.h>
 
 #include <trace/events/kmem.h>
 
@@ -4369,8 +4370,16 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (page_mapcount(page) > 1 && (vma->vm_flags & VM_SHARED))
 		flags |= TNF_SHARED;
 
-	last_cpupid = page_cpupid_last(page);
 	page_nid = page_to_nid(page);
+	/*
+	 * In memory tiering mode, cpupid of slow memory page is used
+	 * to record page access time.  So use default value.
+	 */
+	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	    !node_is_toptier(page_nid))
+		last_cpupid = (-1 & LAST_CPUPID_MASK);
+	else
+		last_cpupid = page_cpupid_last(page);
 	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
 			&flags);
 	if (target_nid == NUMA_NO_NODE) {
diff --git a/mm/migrate.c b/mm/migrate.c
index b99d0db73cb3..8523ff80cdd9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -577,6 +577,18 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	 * future migrations of this same page.
 	 */
 	cpupid = page_cpupid_xchg_last(page, -1);
+	/*
+	 * If migrate between slow and fast memory node, reset cpupid,
+	 * because that is used to record page access time in slow
+	 * memory node
+	 */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) {
+		bool f_toptier = node_is_toptier(page_to_nid(page));
+		bool t_toptier = node_is_toptier(page_to_nid(newpage));
+
+		if (f_toptier != t_toptier)
+			cpupid = -1;
+	}
 	page_cpupid_xchg_last(newpage, cpupid);
 
 	ksm_migrate_page(newpage, page);
diff --git a/mm/mmzone.c b/mm/mmzone.c
index eb89d6e018e2..27f9075632ee 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -99,4 +99,21 @@ int page_cpupid_xchg_last(struct page *page, int cpupid)
 
 	return last_cpupid;
 }
+
+unsigned int xchg_page_access_time(struct page *page, unsigned int time)
+{
+	unsigned long old_flags, flags;
+	unsigned int last_time;
+
+	time >>= PAGE_ACCESS_TIME_BUCKETS;
+	do {
+		old_flags = flags = page->flags;
+		last_time = (flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
+
+		flags &= ~(LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT);
+		flags |= (time & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
+	} while (unlikely(cmpxchg(&page->flags, old_flags, flags) != old_flags));
+
+	return last_time << PAGE_ACCESS_TIME_BUCKETS;
+}
 #endif
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0dd3f82ec6eb..bbf2c65cc4ae 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -85,6 +85,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (prot_numa) {
 				struct page *page;
 				int nid;
+				bool toptier;
 
 				/* Avoid TLB flush if possible */
 				if (pte_protnone(oldpte))
@@ -114,14 +115,19 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				nid = page_to_nid(page);
 				if (target_node == nid)
 					continue;
+				toptier = node_is_toptier(nid);
 
 				/*
 				 * Skip scanning top tier node if normal numa
 				 * balancing is disabled
 				 */
 				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-				    node_is_toptier(nid))
+				    toptier)
 					continue;
+				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+				    !toptier)
+					xchg_page_access_time(page,
+						jiffies_to_msecs(jiffies));
 			}
 
 			oldpte = ptep_modify_prot_start(vma, addr, pte);
-- 
2.30.2

