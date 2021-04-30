Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8275037018E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhD3TyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:08 -0400
Received: from server.lespinasse.org ([63.205.204.226]:39479 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhD3Tx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:29 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=JLbOD6CQvK5+Vbi6lHoPmCez/F/O/tswSP9m74uqZKA=;
 b=ZHIRuBYI42TPV0EKvuDcckJ/sm5j5f0A5ghiyVmRets6zFEr5EvGBrfObyqWSuNH0ixzZ
 miFe3Szsn+X1IdJCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=JLbOD6CQvK5+Vbi6lHoPmCez/F/O/tswSP9m74uqZKA=;
 b=IEDqf76yGYIduS5KKKlHNO9UJwI6AkwAdi+FRipbomT86Si8cIyNoBlVo6LnSP2V9dZiB
 PsYJDHd97hdwOEUEvnaCnBUwcGglz4ElbbVSrNX4ZTBSEu2cT9bGtWbTs23fFB5ZzTIM/GN
 /TtD6alSyHZ/E45XIpaHdYoDLFV3Qs3cNEljS4ZmsalC/c3+2OVgKtAVV+yreeuIfq7JdqA
 5xDkj/SM8+Hmegt72zXCejv9qyp9f7w9dy2gBe23gaGmz32wlP6BQDp0O8y/83K0xdZWlUW
 bzoH4Ih6nFnIPoUHZ+DVDwakUnpXPjUDXm8IoLfrbS+H6ZH4XbNe08xo1YHw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 773F4160328;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 682A219F523; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 16/29] mm: add pte_map_lock() and pte_spinlock()
Date:   Fri, 30 Apr 2021 12:52:17 -0700
Message-Id: <20210430195232.30491-17-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
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
 include/linux/mm.h | 36 +++++++++++++++++++++++++
 mm/memory.c        | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dee8a4833779..8124cd53ce15 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3183,5 +3183,41 @@ extern int sysctl_nr_trim_pages;
 
 void mem_dump_obj(void *object);
 
+#ifdef CONFIG_MMU
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
+#endif	/* CONFIG_MMU */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory.c b/mm/memory.c
index 3f5c3d6c0197..e2f9e4c096dd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2586,6 +2586,72 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
 #define speculative_page_walk_end()   local_irq_enable()
 #endif
 
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
+	speculative_page_walk_begin();
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+		goto fail;
+	/*
+	 * The mmap sequence count check guarantees that the page
+	 * tables are still valid at that point, and
+	 * speculative_page_walk_begin() ensures that they stay around.
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
+	 * We are still under the speculative_page_walk_begin() section,
+	 * and zap_pte_range() could thus deadlock with us if we tried
+	 * using spin_lock() here.
+	 *
+	 * We also don't want to retry until spin_trylock() succeeds,
+	 * because of the starvation potential against a stream of lockers.
+	 */
+	if (unlikely(!spin_trylock(ptl)))
+		goto fail;
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+		goto unlock_fail;
+	speculative_page_walk_end();
+	vmf->pte = pte;
+	vmf->ptl = ptl;
+	return true;
+
+unlock_fail:
+	spin_unlock(ptl);
+fail:
+	if (pte)
+		pte_unmap(pte);
+	speculative_page_walk_end();
+	return false;
+}
+
 #endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
 
 /*
-- 
2.20.1

