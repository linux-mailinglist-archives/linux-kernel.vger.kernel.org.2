Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0637018C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhD3TyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:03 -0400
Received: from server.lespinasse.org ([63.205.204.226]:47923 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhD3Tx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:26 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=mkNeF95yymhY25nTphKSx+4hdLGj+j0544x2VC2sxV8=;
 b=Vzuvm5PMGxgNrmbQBB0aCENsJ84r2DFUqmlU9p6r1v+c+rf0FUVVAq3Ad/RKxVHckmML+
 OgEgx80PSi7aAVFBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=mkNeF95yymhY25nTphKSx+4hdLGj+j0544x2VC2sxV8=;
 b=StQ30JKSY5VmWjfOF5DeEw34dLbaZjHYA1mDovwHFgabfvjbIbUeyEtBCodyalX1aE3dv
 WZV4Iy3RwL1bLk6Ku5564VxRlUAH4UkbhxPCt8Hel32RFwrHiRojFQqXWjNCE5Tr4qix53W
 ugwiblrYAzCpSFCYR1+/6qDGLXceGJZR/RmH2TpIds26S1XZFUHXjecDbt5WecbdD6mHtgs
 D+fkUERUM7dItifrCwSxK1QMaHvo+lpSoRMP1t3UE9tKkNJXFaEG2hZipSA/jY9XOvYt7Oj
 p6XkBOfn+YpGHDBwnthF7z4BbqfQBc3xT9WIps8gX7fyItZt7BLmw9ffQiiA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 5AEB3160321;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 4B8E819F521; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 12/29] x86/mm: attempt speculative mm faults first
Date:   Fri, 30 Apr 2021 12:52:13 -0700
Message-Id: <20210430195232.30491-13-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt speculative mm fault handling first, and fall back to the
existing (non-speculative) code if that fails.

The speculative handling closely mirrors the non-speculative logic.
This includes some x86 specific bits such as the access_error() call.
This is why we chose to implement the speculative handling in arch/x86
rather than in common code.

The vma is first looked up and copied, under protection of the rcu
read lock. The mmap lock sequence count is used to verify the
integrity of the copied vma, and passed to do_handle_mm_fault() to
allow checking against races with mmap writers when finalizing the fault.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c           | 42 +++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h      |  5 +++++
 include/linux/vm_event_item.h |  4 ++++
 mm/vmstat.c                   |  4 ++++
 4 files changed, 55 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a73347e2cdfc..0e8abe43d032 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1219,6 +1219,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	struct vm_area_struct pvma;
+	unsigned long seq;
+#endif
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1316,6 +1320,41 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 #endif
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	count_vm_event(SPF_ATTEMPT);
+	seq = mmap_seq_read_start(mm);
+	if (seq & 1)
+		goto spf_abort;
+	rcu_read_lock();
+	vma = find_vma(mm, address);
+	if (!vma || vma->vm_start > address) {
+		rcu_read_unlock();
+		goto spf_abort;
+	}
+	pvma = *vma;
+	rcu_read_unlock();
+	if (!mmap_seq_read_check(mm, seq))
+		goto spf_abort;
+	vma = &pvma;
+	if (unlikely(access_error(error_code, vma)))
+		goto spf_abort;
+	fault = do_handle_mm_fault(vma, address,
+				   flags | FAULT_FLAG_SPECULATIVE, seq, regs);
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGBUS, BUS_ADRERR);
+		return;
+	}
+	if (!(fault & VM_FAULT_RETRY))
+		goto done;
+
+spf_abort:
+	count_vm_event(SPF_ABORT);
+#endif
+
 	/*
 	 * Kernel-mode access to the user address space should only occur
 	 * on well-defined single instructions listed in the exception
@@ -1412,6 +1451,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	mmap_read_unlock(mm);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+done:
+#endif
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 024970635921..d2bfffcbe364 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -300,6 +300,11 @@ struct vm_userfaultfd_ctx {};
  * per VM-area/task. A VM area is any part of the process virtual memory
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
+ *
+ * Note that speculative page faults make an on-stack copy of the VMA,
+ * so the structure size matters.
+ * (TODO - it would be preferable to copy only the required vma attributes
+ *  rather than the entire vma).
  */
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 18e75974d4e3..cc4f8d14e43f 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -120,6 +120,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
+#endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+		SPF_ATTEMPT,
+		SPF_ABORT,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 74b2c374b86c..9ae1c27a549e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1365,6 +1365,10 @@ const char * const vmstat_text[] = {
 	"swap_ra",
 	"swap_ra_hit",
 #endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	"spf_attempt",
+	"spf_abort",
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.20.1

