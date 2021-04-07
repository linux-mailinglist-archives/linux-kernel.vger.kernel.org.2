Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171193560F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbhDGBv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347786AbhDGBvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:49 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36325C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=6Xk9Sm2CAPu5UeFzJfU4JDeDX0RiT2wns7kOozzzECg=;
 b=7grdFgIOFoL+sFz8eTYiEWlsZlFNu3QaQ7BjZW/uEilCXudw/Peh55wHDyXVBajW+uJn7
 vbXGmZj0pr/8Rg2Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=6Xk9Sm2CAPu5UeFzJfU4JDeDX0RiT2wns7kOozzzECg=;
 b=NZYHSkYE1Fgtl4w74m11l7+TLPmFTlO0VLSwgHrpfs1dB9loZbm9gBfrfN2dVOk+8QSWu
 7Yk9CsMDybHvAqobUgqKdZ1kfMA1Srp57g90H2PyY0iA9rLLEndU14xKiYnRLFE2Q2qZkpk
 Lx8pDdT7mA1ZFwW6dIOR2B9czle+y2AytZoCaryNtROKJQk+V3/Y7NENQYEkyllygAlMYLi
 aCzPxKEzK7QNNU4Ekddh3dMo7ok73SsSo7H6FfTAeIraY9bzDETnW6bMQN1yqKw6HTrxDUL
 bEeN0e1eqM1fwFsH4x05mEuArrTM2yPRH9xpvykz1hyHe++qFBlSgIQOjhVg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id C9B431602D3;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id B755B19F31D; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 14/37] mm: add pte_map_lock() and pte_spinlock()
Date:   Tue,  6 Apr 2021 18:44:39 -0700
Message-Id: <20210407014502.24091-15-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_map_lock() and pte_spinlock() are used by fault handlers to ensure
the pte is mapped and locked before they commit the faulted page to the
mm's address space at the end of the fault.

The functions differ in their preconditions; pte_map_lock() expects
the pte to be unmapped prior to the call, while pte_spinlock() expects
it to be already mapped.

In the speculative fault case, the functions verify, after locking the pte,
that the mmap sequence count has not changed since the start of the fault,
and thus that no mmap lock writers have been running concurrently with
the fault. After that point the page table lock serializes any further
races with concurrent mmap lock writers.

If the mmap sequence count check fails, both functions will return false
with the pte being left unmapped and unlocked.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm.h | 34 ++++++++++++++++++++++
 mm/memory.c        | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dee8a4833779..f26490aff514 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3183,5 +3183,39 @@ extern int sysctl_nr_trim_pages;
 
 void mem_dump_obj(void *object);
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+
+bool __pte_map_lock(struct vm_fault *vmf);
+
+static inline bool pte_map_lock(struct vm_fault *vmf)
+{
+	VM_BUG_ON(vmf->pte);
+	return __pte_map_lock(vmf);
+}
+
+static inline bool pte_spinlock(struct vm_fault *vmf)
+{
+	VM_BUG_ON(!vmf->pte);
+	return __pte_map_lock(vmf);
+}
+
+#else	/* !CONFIG_SPECULATIVE_PAGE_FAULT */
+
+static inline bool pte_map_lock(struct vm_fault *vmf)
+{
+	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
+				       &vmf->ptl);
+	return true;
+}
+
+static inline bool pte_spinlock(struct vm_fault *vmf)
+{
+	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+	spin_lock(vmf->ptl);
+	return true;
+}
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory.c b/mm/memory.c
index a17704aac019..3e192d5f89a6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2566,6 +2566,77 @@ int apply_to_existing_page_range(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+
+bool __pte_map_lock(struct vm_fault *vmf)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	pmd_t pmdval;
+#endif
+	pte_t *pte = vmf->pte;
+	spinlock_t *ptl;
+
+	if (!(vmf->flags & FAULT_FLAG_SPECULATIVE)) {
+		vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+		if (!pte)
+			vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		spin_lock(vmf->ptl);
+		return true;
+	}
+
+	local_irq_disable();
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+		goto fail;
+	/*
+	 * The mmap sequence count check guarantees that the page
+	 * tables are still valid at that point, and having IRQs
+	 * disabled ensures that they stay around (see Fast GUP
+	 * comment in mm/gup.c).
+	 */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/*
+	 * We check if the pmd value is still the same to ensure that there
+	 * is not a huge collapse operation in progress in our back.
+	 */
+	pmdval = READ_ONCE(*vmf->pmd);
+	if (!pmd_same(pmdval, vmf->orig_pmd))
+		goto fail;
+#endif
+	ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+	if (!pte)
+		pte = pte_offset_map(vmf->pmd, vmf->address);
+	/*
+	 * Try locking the page table.
+	 *
+	 * Note that we might race against zap_pte_range() which
+	 * invalidates TLBs while holding the page table lock.
+	 * We still have local IRQs disabled here to prevent the
+	 * page table from being reclaimed, and zap_pte_range() could
+	 * thus deadlock with us if we tried using spin_lock() here.
+	 *
+	 * We also don't want to retry until spin_trylock() succeeds,
+	 * because of the starvation potential against a stream of lockers.
+	 */
+	if (unlikely(!spin_trylock(ptl)))
+		goto fail;
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+		goto unlock_fail;
+	local_irq_enable();
+	vmf->pte = pte;
+	vmf->ptl = ptl;
+	return true;
+
+unlock_fail:
+	spin_unlock(ptl);
+fail:
+	if (pte)
+		pte_unmap(pte);
+	local_irq_enable();
+	return false;
+}
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was
  * read non-atomically.  Before making any commitment, on those architectures
-- 
2.20.1

