Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA03C34C3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 08:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhC2G1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 02:27:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:5006 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhC2G1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 02:27:08 -0400
IronPort-SDR: vpCikbkuZBwXaGjvxRZ9Tb0NVgx0ey/+rIFDGks3t5BfF1q7BxOqXOMe2kE7nRIOowzSqBQuS4
 ceqrFoGqsFcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="179030156"
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="179030156"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 23:27:07 -0700
IronPort-SDR: C55Yv/wcT4TNJESa9QMS+A9xypbRgFYWcf7BBW0vRprWTUw3EW9+BJ9KnzMJzAMgqaBE2LAYkA
 UqOaE6lC5DrA==
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="609616892"
Received: from yhuang6-desk1.sh.intel.com ([10.239.13.1])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 23:27:04 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC] NUMA balancing: reduce TLB flush via delaying mapping on hint page fault
Date:   Mon, 29 Mar 2021 14:26:51 +0800
Message-Id: <20210329062651.2487905-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For NUMA balancing, in hint page fault handler, the faulting page will
be migrated to the accessing node if necessary.  During the migration,
TLB will be shot down on all CPUs that the process has run on
recently.  Because in the hint page fault handler, the PTE will be
made accessible before the migration is tried.  The overhead of TLB
shooting down is high, so it's better to be avoided if possible.  In
fact, if we delay mapping the page in PTE until migration, that can be
avoided.  This is what this patch doing.

We have tested the patch with the pmbench memory accessing benchmark
on a 2-socket Intel server, and found that the number of the TLB
shooting down IPI reduces up to 99% (from ~6.0e6 to ~2.3e4) if NUMA
balancing is triggered (~8.8e6 pages migrated).  The benchmark score
has no visible changes.

Known issues:

For the multiple threads applications, it's possible that the page is
accessed by 2 threads almost at the same time.  In the original
implementation, the second thread may go accessing the page directly
because the first thread has installed the accessible PTE.  While with
this patch, there will be a window that the second thread will find
the PTE is still inaccessible.  But the difference between the
accessible window is small.  Because the page will be made
inaccessible soon for migrating.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
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
index d3273bd69dbb..a9a8ed1ac06c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4148,29 +4148,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		goto out;
 	}
 
-	/*
-	 * Make it present again, Depending on how arch implementes non
-	 * accessible ptes, some can allow access by kernel mode.
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
@@ -4180,7 +4168,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * pte_dirty has unpredictable behaviour between PTE scan updates,
 	 * background writeback, dirty balancing and application behaviour.
 	 */
-	if (!pte_write(pte))
+	if (was_writable)
 		flags |= TNF_NO_GROUP;
 
 	/*
@@ -4194,23 +4182,45 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
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
+	 * Make it present again, Depending on how arch implementes non
+	 * accessible ptes, some can allow access by kernel mode.
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

