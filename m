Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B762D336DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhCKITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:19:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:25901 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhCKITU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:19:20 -0500
IronPort-SDR: CdpmXq1XMiZRU5n4YO6jlvSsS49pZu07Zp08JyCipmwtP1EC7mlb9LYJoy7jXevrK8QNS/HTFn
 JT1ZFSPa9pQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="252649036"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="252649036"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 00:19:20 -0800
IronPort-SDR: NcrmL9N8xijyQI3uKoXffcfvRrXVefIf0gyL+cs9W1dikY7ff8yV7YS/CeY/BKaQnxGsiPKPO2
 RytCMHHl1PTA==
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="410527543"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 00:19:16 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V6 3/6] memory tiering: skip to scan fast memory
Date:   Thu, 11 Mar 2021 16:18:18 +0800
Message-Id: <20210311081821.138467-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210311081821.138467-1-ying.huang@intel.com>
References: <20210311081821.138467-1-ying.huang@intel.com>
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
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/huge_memory.c | 30 +++++++++++++++++++++---------
 mm/mprotect.c    | 13 ++++++++++++-
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 91ca9b103ee5..1e5f023873ec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -33,6 +33,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/page_owner.h>
+#include <linux/sched/sysctl.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -1836,17 +1837,28 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
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
index ab709023e9aa..0a68fa54d63d 100644
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
2.30.1

