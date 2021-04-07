Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE30435611C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348023AbhDGBxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:45 -0400
Received: from server.lespinasse.org ([63.205.204.226]:40059 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347844AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=mO5MU45MyVZcFHxHRLPz46S2R58Y3f1o/RvXopsTgug=;
 b=x8Ntsiwc/FMdqgxnWlPWGRMTMXKGXUd7FH7ae8ZNK07QdvjB9kdBhnKqEpDWUGep8WKgH
 agBG8aS8vepwuR9DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=mO5MU45MyVZcFHxHRLPz46S2R58Y3f1o/RvXopsTgug=;
 b=psR8q2EllG8INTzPGm5GoRHikfJCeKeFiVpoGicOrWGGGHq0JVzKS7chnTxPadxN82J4S
 jgkUavAqZfvS7qtYoZ30w4IeLh1awXgYDxl7BwEvUJ4oQE6+AhCFkcE0Qzh08C4HXiovxGS
 hLlPXxtWwLKFOgCkA3eP9WXrmsitGCWenDzpIgjLC7olWkErJSelAlrPp2mvIB7lLX50swf
 YYOHYT/YnPjrziUErSUmlNX1HI0Z670r9mkloDUGgn4ugJbzNQcZloAxwZcMhUFKxiONRWf
 tBhnOM8mm/8aax6ivgVkb1HvaqDBIQwG/lC6CHAPXCUknPqfVjHYSjx3gBhg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id B8D011602D1;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id A8AAC19F31F; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 12/37] mm: refactor __handle_mm_fault() / handle_pte_fault()
Date:   Tue,  6 Apr 2021 18:44:37 -0700
Message-Id: <20210407014502.24091-13-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code that initializes vmf->pte and vmf->orig_pte from
handle_pte_fault() to its single call site in __handle_mm_fault().

This ensures vmf->pte is now initialized together with the higher levels
of the page table hierarchy. This also prepares for speculative page fault
handling, where the entire page table walk (higher levels down to ptes)
needs special care in the speculative case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 98 ++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3691be1f1319..66e7a4554c54 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3516,7 +3516,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (pte_alloc(vma->vm_mm, vmf->pmd))
 		return VM_FAULT_OOM;
 
-	/* See comment in handle_pte_fault() */
+	/* See comment in __handle_mm_fault() */
 	if (unlikely(pmd_trans_unstable(vmf->pmd)))
 		return 0;
 
@@ -3797,7 +3797,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
-	/* See comment in handle_pte_fault() */
+	/* See comment in __handle_mm_fault() */
 	if (pmd_devmap_trans_unstable(vmf->pmd))
 		return 0;
 
@@ -4253,53 +4253,6 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
 
-	if (unlikely(pmd_none(*vmf->pmd))) {
-		/*
-		 * Leave __pte_alloc() until later: because vm_ops->fault may
-		 * want to allocate huge page, and if we expose page table
-		 * for an instant, it will be difficult to retract from
-		 * concurrent faults and from rmap lookups.
-		 */
-		vmf->pte = NULL;
-	} else {
-		/*
-		 * If a huge pmd materialized under us just retry later.  Use
-		 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead
-		 * of pmd_trans_huge() to ensure the pmd didn't become
-		 * pmd_trans_huge under us and then back to pmd_none, as a
-		 * result of MADV_DONTNEED running immediately after a huge pmd
-		 * fault in a different thread of this mm, in turn leading to a
-		 * misleading pmd_trans_huge() retval. All we have to ensure is
-		 * that it is a regular pmd that we can walk with
-		 * pte_offset_map() and we can do that through an atomic read
-		 * in C, which is what pmd_trans_unstable() provides.
-		 */
-		if (pmd_devmap_trans_unstable(vmf->pmd))
-			return 0;
-		/*
-		 * A regular pmd is established and it can't morph into a huge
-		 * pmd from under us anymore at this point because we hold the
-		 * mmap_lock read mode and khugepaged takes it in write mode.
-		 * So now it's safe to run pte_offset_map().
-		 */
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
-		vmf->orig_pte = *vmf->pte;
-
-		/*
-		 * some architectures can have larger ptes than wordsize,
-		 * e.g.ppc44x-defconfig has CONFIG_PTE_64BIT=y and
-		 * CONFIG_32BIT=y, so READ_ONCE cannot guarantee atomic
-		 * accesses.  The code below just needs a consistent view
-		 * for the ifs and we later double check anyway with the
-		 * ptl lock held. So here a barrier will do.
-		 */
-		barrier();
-		if (pte_none(vmf->orig_pte)) {
-			pte_unmap(vmf->pte);
-			vmf->pte = NULL;
-		}
-	}
-
 	if (!vmf->pte) {
 		if (vma_is_anonymous(vmf->vma))
 			return do_anonymous_page(vmf);
@@ -4439,6 +4392,53 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		}
 	}
 
+	if (unlikely(pmd_none(*vmf.pmd))) {
+		/*
+		 * Leave __pte_alloc() until later: because vm_ops->fault may
+		 * want to allocate huge page, and if we expose page table
+		 * for an instant, it will be difficult to retract from
+		 * concurrent faults and from rmap lookups.
+		 */
+		vmf.pte = NULL;
+	} else {
+		/*
+		 * If a huge pmd materialized under us just retry later.  Use
+		 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead
+		 * of pmd_trans_huge() to ensure the pmd didn't become
+		 * pmd_trans_huge under us and then back to pmd_none, as a
+		 * result of MADV_DONTNEED running immediately after a huge pmd
+		 * fault in a different thread of this mm, in turn leading to a
+		 * misleading pmd_trans_huge() retval. All we have to ensure is
+		 * that it is a regular pmd that we can walk with
+		 * pte_offset_map() and we can do that through an atomic read
+		 * in C, which is what pmd_trans_unstable() provides.
+		 */
+		if (pmd_devmap_trans_unstable(vmf.pmd))
+			return 0;
+		/*
+		 * A regular pmd is established and it can't morph into a huge
+		 * pmd from under us anymore at this point because we hold the
+		 * mmap_lock read mode and khugepaged takes it in write mode.
+		 * So now it's safe to run pte_offset_map().
+		 */
+		vmf.pte = pte_offset_map(vmf.pmd, vmf.address);
+		vmf.orig_pte = *vmf.pte;
+
+		/*
+		 * some architectures can have larger ptes than wordsize,
+		 * e.g.ppc44x-defconfig has CONFIG_PTE_64BIT=y and
+		 * CONFIG_32BIT=y, so READ_ONCE cannot guarantee atomic
+		 * accesses.  The code below just needs a consistent view
+		 * for the ifs and we later double check anyway with the
+		 * ptl lock held. So here a barrier will do.
+		 */
+		barrier();
+		if (pte_none(vmf.orig_pte)) {
+			pte_unmap(vmf.pte);
+			vmf.pte = NULL;
+		}
+	}
+
 	return handle_pte_fault(&vmf);
 }
 
-- 
2.20.1

