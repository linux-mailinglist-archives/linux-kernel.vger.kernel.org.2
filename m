Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D637018F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhD3TyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:15 -0400
Received: from server.lespinasse.org ([63.205.204.226]:45039 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhD3Tx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:27 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=rYXn/93pk6t1tplCIUNdeG9K949Nx8Nhz+Jc2wP0R1Q=;
 b=newF3cfvGTS9NZHu8Z9WaTA6N891W7+LcXoBNpRst00ZibYoGbtRvwmRC4rI9PeS1dVL4
 ywG6C8+DYN7OLn5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=rYXn/93pk6t1tplCIUNdeG9K949Nx8Nhz+Jc2wP0R1Q=;
 b=lq1GjaSqce8boFrQcjPEUKQ/j7fShwyrCrWm0+mf8OdhWocXr/ZEjuG1q+Eb/JSPdxf0v
 MF4X4ZL/cUAg/T8w08i5+YfyObI/RWtNRFEj6Hoj1RofQGK6HXxcyyBVGnkZB73xigLFRg1
 /nt84j2+hYZpwF5R1SDZ0ddaIBMppSckoH+lpr18YgkWxSxK4bf1XpcRgR0/BBVWGlyytcT
 YdZLpB5op6orZRAsS9mb+EZFHVjyicfFkAcIKsWPbiEVzx63ALx8bNrVSu5Zp+VhIE/spFt
 OAIq04qEeqX2U1tCOto3PsN2VdkhoMmXwhclJ77F1/sDDkeYRTf+DCc/5etQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 70663160327;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 60D9C19F521; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 15/29] mm: implement speculative handling in __handle_mm_fault().
Date:   Fri, 30 Apr 2021 12:52:16 -0700
Message-Id: <20210430195232.30491-16-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The speculative path calls speculative_page_walk_begin() before walking
the page table tree to prevent page table reclamation. The logic is
otherwise similar to the non-speculative path, but with additional
restrictions: in the speculative path, we do not handle huge pages or
wiring new pages tables.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm.h |  4 +++
 mm/memory.c        | 77 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d5988e78e6ab..dee8a4833779 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -525,6 +525,10 @@ struct vm_fault {
 	};
 	unsigned int flags;		/* FAULT_FLAG_xxx flags
 					 * XXX: should really be 'const' */
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	unsigned long seq;
+	pmd_t orig_pmd;
+#endif
 	pmd_t *pmd;			/* Pointer to pmd entry matching
 					 * the 'address' */
 	pud_t *pud;			/* Pointer to pud entry matching
diff --git a/mm/memory.c b/mm/memory.c
index 45696166b10f..3f5c3d6c0197 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4329,7 +4329,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
  * return value.  See filemap_fault() and __lock_page_or_retry().
  */
 static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
-		unsigned long address, unsigned int flags)
+		unsigned long address, unsigned int flags, unsigned long seq)
 {
 	struct vm_fault vmf = {
 		.vma = vma,
@@ -4344,6 +4344,79 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	p4d_t *p4d;
 	vm_fault_t ret;
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	if (flags & FAULT_FLAG_SPECULATIVE) {
+		pgd_t pgdval;
+		p4d_t p4dval;
+		pud_t pudval;
+
+		vmf.seq = seq;
+
+		speculative_page_walk_begin();
+		pgd = pgd_offset(mm, address);
+		pgdval = READ_ONCE(*pgd);
+		if (pgd_none(pgdval) || unlikely(pgd_bad(pgdval)))
+			goto spf_fail;
+
+		p4d = p4d_offset(pgd, address);
+		p4dval = READ_ONCE(*p4d);
+		if (p4d_none(p4dval) || unlikely(p4d_bad(p4dval)))
+			goto spf_fail;
+
+		vmf.pud = pud_offset(p4d, address);
+		pudval = READ_ONCE(*vmf.pud);
+		if (pud_none(pudval) || unlikely(pud_bad(pudval)) ||
+		    unlikely(pud_trans_huge(pudval)) ||
+		    unlikely(pud_devmap(pudval)))
+			goto spf_fail;
+
+		vmf.pmd = pmd_offset(vmf.pud, address);
+		vmf.orig_pmd = READ_ONCE(*vmf.pmd);
+
+		/*
+		 * pmd_none could mean that a hugepage collapse is in
+		 * progress in our back as collapse_huge_page() mark
+		 * it before invalidating the pte (which is done once
+		 * the IPI is catched by all CPU and we have interrupt
+		 * disabled).  For this reason we cannot handle THP in
+		 * a speculative way since we can't safely identify an
+		 * in progress collapse operation done in our back on
+		 * that PMD.
+		 */
+		if (unlikely(pmd_none(vmf.orig_pmd) ||
+			     is_swap_pmd(vmf.orig_pmd) ||
+			     pmd_trans_huge(vmf.orig_pmd) ||
+			     pmd_devmap(vmf.orig_pmd)))
+			goto spf_fail;
+
+		/*
+		 * The above does not allocate/instantiate page-tables because
+		 * doing so would lead to the possibility of instantiating
+		 * page-tables after free_pgtables() -- and consequently
+		 * leaking them.
+		 *
+		 * The result is that we take at least one non-speculative
+		 * fault per PMD in order to instantiate it.
+		 */
+
+		vmf.pte = pte_offset_map(vmf.pmd, address);
+		vmf.orig_pte = READ_ONCE(*vmf.pte);
+		barrier();
+		if (pte_none(vmf.orig_pte)) {
+			pte_unmap(vmf.pte);
+			vmf.pte = NULL;
+		}
+
+		speculative_page_walk_end();
+
+		return handle_pte_fault(&vmf);
+
+	spf_fail:
+		speculative_page_walk_end();
+		return VM_FAULT_RETRY;
+	}
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 	pgd = pgd_offset(mm, address);
 	p4d = p4d_alloc(mm, pgd, address);
 	if (!p4d)
@@ -4563,7 +4636,7 @@ vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
 	else
-		ret = __handle_mm_fault(vma, address, flags);
+		ret = __handle_mm_fault(vma, address, flags, seq);
 
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
-- 
2.20.1

