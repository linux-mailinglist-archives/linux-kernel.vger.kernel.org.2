Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9603E3CF4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbhGTGQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:16:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:38914 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235313AbhGTGPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:15:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190773558"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="190773558"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 23:56:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="500534441"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 23:55:59 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mel Gorman <mgorman@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm,do_huge_pmd_numa_page: remove unnecessary TLB flushing code
Date:   Tue, 20 Jul 2021 14:55:29 +0800
Message-Id: <20210720065529.716031-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the commit c5b5a3dd2c1f ("mm: thp: refactor NUMA fault
handling"), the TLB flushing is done in do_huge_pmd_numa_page() itself
via flush_tlb_range().

But after commit c5b5a3dd2c1f ("mm: thp: refactor NUMA fault
handling"), the TLB flushing is done in migrate_pages() as in the
following code path anyway.

do_huge_pmd_numa_page
  migrate_misplaced_page
    migrate_pages

So now, the TLB flushing code in do_huge_pmd_numa_page() becomes
unnecessary.  So the code is deleted in this patch to simplify the
code.  This is only code cleanup, there's no visible performance
difference.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index afff3ac87067..9f21e44c9030 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1440,32 +1440,6 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 		goto out;
 	}
 
-	/*
-	 * Since we took the NUMA fault, we must have observed the !accessible
-	 * bit. Make sure all other CPUs agree with that, to avoid them
-	 * modifying the page we're about to migrate.
-	 *
-	 * Must be done under PTL such that we'll observe the relevant
-	 * inc_tlb_flush_pending().
-	 *
-	 * We are not sure a pending tlb flush here is for a huge page
-	 * mapping or not. Hence use the tlb range variant
-	 */
-	if (mm_tlb_flush_pending(vma->vm_mm)) {
-		flush_tlb_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
-		/*
-		 * change_huge_pmd() released the pmd lock before
-		 * invalidating the secondary MMUs sharing the primary
-		 * MMU pagetables (with ->invalidate_range()). The
-		 * mmu_notifier_invalidate_range_end() (which
-		 * internally calls ->invalidate_range()) in
-		 * change_pmd_range() will run after us, so we can't
-		 * rely on it here and we need an explicit invalidate.
-		 */
-		mmu_notifier_invalidate_range(vma->vm_mm, haddr,
-					      haddr + HPAGE_PMD_SIZE);
-	}
-
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
 	page = vm_normal_page_pmd(vma, haddr, pmd);
 	if (!page)
-- 
2.30.2

