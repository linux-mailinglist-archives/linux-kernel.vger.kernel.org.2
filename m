Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A17356103
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347970AbhDGBwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:40 -0400
Received: from server.lespinasse.org ([63.205.204.226]:35241 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347825AbhDGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:51 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=KSwVFXcXC1LvgNAhlUzawOb6cyImWm4fVIR5ZQJd5xc=;
 b=gRHSZhDTNNGCbnIvlycMkhUVlPwyxniNsdMuORhL95atZDObl7ItbtuphSDdUjX23gpa2
 5g/6FTl+SQbi/A/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=KSwVFXcXC1LvgNAhlUzawOb6cyImWm4fVIR5ZQJd5xc=;
 b=MKIjsemPluEEIll0eWbtQ+LZ5lhWdvrPCIPD45WpylLuLds09nW2fmnBC0BmLlFlKs2TE
 z+Lj8BxURaoMDZEGU6ShDzgdUM73C8UPBdI2ut40XJBRoFJdPKDR5fIZoALC1Wc7q2vJmq/
 rkoreBCPgtSezyWIDekGZoGnWX/wmypzyEXeFSNVR5xeRO5qyroG1rwM8043lZjBRC1FaWB
 tlBOQw9nwVBE4W9R8+hOsrIf6MwXYLl1ZGQNV8/QsjZ1T4uTfgweNCuxKJlNtxHTrRzAKK4
 aF/5rzRtLwNtEAKGDik+k8MEqgZ7ImHLBgSe8amwi/4oPZclODAzWRvqHH+w==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 18CB516036D;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 09A2819F31F; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 24/37] mm: implement speculative handling in __do_fault()
Date:   Tue,  6 Apr 2021 18:44:49 -0700
Message-Id: <20210407014502.24091-25-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the speculative case, call the vm_ops->fault() method from within
an rcu read locked section, and verify the mmap sequence lock at the
start of the section. A match guarantees that the original vma is still
valid at that time, and that the associated vma->vm_file stays valid
while the vm_ops->fault() method is running.

Note that this implies that speculative faults can not sleep within
the vm_ops->fault method. We will only attempt to fetch existing pages
from the page cache during speculative faults; any miss (or prefetch)
will be handled by falling back to non-speculative fault handling.

The speculative handling case also does not preallocate page tables,
as it is always called with a pre-existing page table.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 63 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6eddd7b4e89c..7139004c624d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3709,29 +3709,50 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret;
 
-	/*
-	 * Preallocate pte before we take page_lock because this might lead to
-	 * deadlocks for memcg reclaim which waits for pages under writeback:
-	 *				lock_page(A)
-	 *				SetPageWriteback(A)
-	 *				unlock_page(A)
-	 * lock_page(B)
-	 *				lock_page(B)
-	 * pte_alloc_one
-	 *   shrink_page_list
-	 *     wait_on_page_writeback(A)
-	 *				SetPageWriteback(B)
-	 *				unlock_page(B)
-	 *				# flush A, B to clear the writeback
-	 */
-	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
-		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
-		if (!vmf->prealloc_pte)
-			return VM_FAULT_OOM;
-		smp_wmb(); /* See comment in __pte_alloc() */
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		rcu_read_lock();
+		if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq)) {
+			ret = VM_FAULT_RETRY;
+		} else {
+			/*
+			 * The mmap sequence count check guarantees that the
+			 * vma we fetched at the start of the fault was still
+			 * current at that point in time. The rcu read lock
+			 * ensures vmf->vma->vm_file stays valid.
+			 */
+			ret = vma->vm_ops->fault(vmf);
+		}
+		rcu_read_unlock();
+	} else
+#endif
+	{
+		/*
+		 * Preallocate pte before we take page_lock because
+		 * this might lead to deadlocks for memcg reclaim
+		 * which waits for pages under writeback:
+		 *				lock_page(A)
+		 *				SetPageWriteback(A)
+		 *				unlock_page(A)
+		 * lock_page(B)
+		 *				lock_page(B)
+		 * pte_alloc_one
+		 *   shrink_page_list
+		 *     wait_on_page_writeback(A)
+		 *				SetPageWriteback(B)
+		 *				unlock_page(B)
+		 *				# flush A, B to clear writeback
+		 */
+		if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
+			vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
+			if (!vmf->prealloc_pte)
+				return VM_FAULT_OOM;
+			smp_wmb(); /* See comment in __pte_alloc() */
+		}
+
+		ret = vma->vm_ops->fault(vmf);
 	}
 
-	ret = vma->vm_ops->fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
 			    VM_FAULT_DONE_COW)))
 		return ret;
-- 
2.20.1

