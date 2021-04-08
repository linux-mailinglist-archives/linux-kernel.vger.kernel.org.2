Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6F35848C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhDHNXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:23:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:15485 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhDHNXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:23:35 -0400
IronPort-SDR: e2c/91KE98qJrqlll4JuuW4HqUygmy3TRoEoD5bLRmtnOZjQU0nF3eeQtwZr16skcF2SnAhNuY
 ZzYfe4/ew+9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="254875972"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="254875972"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 06:23:23 -0700
IronPort-SDR: ycLUebdPG0tiR8hTtuNiYvuvb3wGKNHGSs+mKVHlfxBqiFVsMy30KBZiMmVaEG4I0nahdPYDLk
 mCN4UxWyhI9g==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="397083972"
Received: from yhuang6-desk1.sh.intel.com ([10.239.13.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 06:23:19 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH -V3] NUMA balancing: reduce TLB flush via delaying mapping on hint page fault
Date:   Thu,  8 Apr 2021 21:22:36 +0800
Message-Id: <20210408132236.1175607-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With NUMA balancing, in hint page fault handler, the faulting page
will be migrated to the accessing node if necessary.  During the
migration, TLB will be shot down on all CPUs that the process has run
on recently.  Because in the hint page fault handler, the PTE will be
made accessible before the migration is tried.  The overhead of TLB
shooting down can be high, so it's better to be avoided if possible.
In fact, if we delay mapping the page until migration, that can be
avoided.  This is what this patch doing.

For the multiple threads applications, it's possible that a page is
accessed by multiple threads almost at the same time.  In the original
implementation, because the first thread will install the accessible
PTE before migrating the page, the other threads may access the page
directly before the page is made inaccessible again during migration.
While with the patch, the second thread will go through the page fault
handler too. And because of the PageLRU() checking in the following
code path,

  migrate_misplaced_page()
    numamigrate_isolate_page()
      isolate_lru_page()

the migrate_misplaced_page() will return 0, and the PTE will be made
accessible in the second thread.

This will introduce a little more overhead.  But we think the
possibility for a page to be accessed by the multiple threads at the
same time is low, and the overhead difference isn't too large.  If
this becomes a problem in some workloads, we need to consider how to
reduce the overhead.

To test the patch, we run a test case as follows on a 2-socket Intel
server (1 NUMA node per socket) with 128GB DRAM (64GB per socket).

1. Run a memory eater on NUMA node 1 to use 40GB memory before running
   pmbench.

2. Run pmbench (normal accessing pattern) with 8 processes, and 8
   threads per process, so there are 64 threads in total.  The
   working-set size of each process is 8960MB, so the total working-set
   size is 8 * 8960MB = 70GB.  The CPU of all pmbench processes is bound
   to node 1.  The pmbench processes will access some DRAM on node 0.

3. After the pmbench processes run for 10 seconds, kill the memory
   eater.  Now, some pages will be migrated from node 0 to node 1 via
   NUMA balancing.

Test results show that, with the patch, the pmbench throughput (page
accesses/s) increases 5.5%.  The number of the TLB shootdowns
interrupts reduces 98% (from ~4.7e7 to ~9.7e5) with about 9.2e6
pages (35.8GB) migrated.  From the perf profile, it can be found that
the CPU cycles spent by try_to_unmap() and its callees reduces from
6.02% to 0.47%.  That is, the CPU cycles spent by TLB shooting down
decreases greatly.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: "Matthew Wilcox" <willy@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Michel Lespinasse <walken@google.com>
Cc: Arjun Roy <arjunroy@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
---
 mm/memory.c | 54 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index cc71a445c76c..7e9d4e55089c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4159,29 +4159,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		goto out;
 	}
 
-	/*
-	 * Make it present again, depending on how arch implements
-	 * non-accessible ptes, some can allow access by kernel mode.
-	 */
-	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
+	/* Get the normal PTE  */
+	old_pte = ptep_get(vmf->pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
-	pte = pte_mkyoung(pte);
-	if (was_writable)
-		pte = pte_mkwrite(pte);
-	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
-	update_mmu_cache(vma, vmf->address, vmf->pte);
 
 	page = vm_normal_page(vma, vmf->address, pte);
-	if (!page) {
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
-	}
+	if (!page)
+		goto out_map;
 
 	/* TODO: handle PTE-mapped THP */
-	if (PageCompound(page)) {
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
-	}
+	if (PageCompound(page))
+		goto out_map;
 
 	/*
 	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
@@ -4191,7 +4179,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * pte_dirty has unpredictable behaviour between PTE scan updates,
 	 * background writeback, dirty balancing and application behaviour.
 	 */
-	if (!pte_write(pte))
+	if (!was_writable)
 		flags |= TNF_NO_GROUP;
 
 	/*
@@ -4205,23 +4193,45 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	page_nid = page_to_nid(page);
 	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
 			&flags);
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	if (target_nid == NUMA_NO_NODE) {
 		put_page(page);
-		goto out;
+		goto out_map;
 	}
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
 
 	/* Migrate to the requested node */
 	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
-	} else
+	} else {
 		flags |= TNF_MIGRATE_FAIL;
+		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		spin_lock(vmf->ptl);
+		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
+			pte_unmap_unlock(vmf->pte, vmf->ptl);
+			goto out;
+		}
+		goto out_map;
+	}
 
 out:
 	if (page_nid != NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, page_nid, 1, flags);
 	return 0;
+out_map:
+	/*
+	 * Make it present again, depending on how arch implements
+	 * non-accessible ptes, some can allow access by kernel mode.
+	 */
+	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
+	pte = pte_modify(old_pte, vma->vm_page_prot);
+	pte = pte_mkyoung(pte);
+	if (was_writable)
+		pte = pte_mkwrite(pte);
+	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
+	update_mmu_cache(vma, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	goto out;
 }
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
-- 
2.30.2

