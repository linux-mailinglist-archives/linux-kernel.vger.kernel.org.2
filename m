Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B5A426619
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhJHIms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:42:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:39515 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235222AbhJHIme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:42:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213413444"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="213413444"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 01:40:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="439860376"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 01:40:02 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org
Subject: [PATCH -V9 3/6] memory tiering: skip to scan fast memory
Date:   Fri,  8 Oct 2021 16:39:35 +0800
Message-Id: <20211008083938.1702663-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008083938.1702663-1-ying.huang@intel.com>
References: <20211008083938.1702663-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the NUMA balancing isn't used to optimize the page placement among
sockets but only among memory types, the hot pages in the fast memory
node couldn't be migrated (promoted) to anywhere.  So it's unnecessary
to scan the pages in the fast memory node via changing their PTE/PMD
mapping to be PROT_NONE.  So that the page faults could be avoided
too.

In the test, if only the memory tiering NUMA balancing mode is enabled, the
number of the NUMA balancing hint faults for the DRAM node is reduced to
almost 0 with the patch.  While the benchmark score doesn't change
visibly.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/huge_memory.c | 30 +++++++++++++++++++++---------
 mm/mprotect.c    | 13 ++++++++++++-
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5e9ef0fc261e..8edcd64b5b1f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -34,6 +34,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/page_owner.h>
+#include <linux/sched/sysctl.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -1766,17 +1767,28 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 #endif
 
-	/*
-	 * Avoid trapping faults against the zero page. The read-only
-	 * data is likely to be read-cached on the local CPU and
-	 * local/remote hits to the zero page are not interesting.
-	 */
-	if (prot_numa && is_huge_zero_pmd(*pmd))
-		goto unlock;
+	if (prot_numa) {
+		struct page *page;
+		/*
+		 * Avoid trapping faults against the zero page. The read-only
+		 * data is likely to be read-cached on the local CPU and
+		 * local/remote hits to the zero page are not interesting.
+		 */
+		if (is_huge_zero_pmd(*pmd))
+			goto unlock;
 
-	if (prot_numa && pmd_protnone(*pmd))
-		goto unlock;
+		if (pmd_protnone(*pmd))
+			goto unlock;
 
+		page = pmd_page(*pmd);
+		/*
+		 * Skip scanning top tier node if normal numa
+		 * balancing is disabled
+		 */
+		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+		    node_is_toptier(page_to_nid(page)))
+			goto unlock;
+	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
 	 * to not clear pmd intermittently to avoid race with MADV_DONTNEED
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..0dd3f82ec6eb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -29,6 +29,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
+#include <linux/sched/sysctl.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -83,6 +84,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			 */
 			if (prot_numa) {
 				struct page *page;
+				int nid;
 
 				/* Avoid TLB flush if possible */
 				if (pte_protnone(oldpte))
@@ -109,7 +111,16 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				 * Don't mess with PTEs if page is already on the node
 				 * a single-threaded process is running on.
 				 */
-				if (target_node == page_to_nid(page))
+				nid = page_to_nid(page);
+				if (target_node == nid)
+					continue;
+
+				/*
+				 * Skip scanning top tier node if normal numa
+				 * balancing is disabled
+				 */
+				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+				    node_is_toptier(nid))
 					continue;
 			}
 
-- 
2.30.2

