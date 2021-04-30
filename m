Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB1370193
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhD3Tyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:41 -0400
Received: from server.lespinasse.org ([63.205.204.226]:45461 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhD3Txh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:37 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=FTmd8q5bXeYtX6zqFZAxa8+xy7tYwTDwfSzy7iAnfZo=;
 b=ZulnIIq8a4SfDWkrfX/OUtIvvvF7dZx7gaKOvE4F0it1bDwwukBrcIykrRJ86Xw5/d0Ri
 g3rZSQUQjZOfd6JBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=FTmd8q5bXeYtX6zqFZAxa8+xy7tYwTDwfSzy7iAnfZo=;
 b=PmpwOhrUj9PXxXes471bRWBh2GoLrbZ85V8g5GC4KXE0WEvlpmV0L03hppw1kXO7SmZ6a
 g0LcSRCyYWeWKva4E7tFkRYs/PQGhfa3Pseay7k6iGYcQitfgZVH2HddXgr5oQLiqnvtm5W
 blzgBE54N/Y1xL4UstFKJRsEKXrxr1oMCJvBVPVpoQa1VlnrpucugfXBZnAqLrnHs7ZUO42
 B8DnYDMypFIvB0IskZIHlD1AXOGeJnEmbDUIekM0mtMERqMY4tdE6Vu6kOQef2NkmV3a5IN
 /12olEZIe2g2Cu36KvTlwMYeEjMQ4tC7WO4m/beAYKqcUWqCFrAKQDDEb+bQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id CE7B3160368;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id BE0D219F521; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 29/29] arm64/mm: attempt speculative mm faults first
Date:   Fri, 30 Apr 2021 12:52:30 -0700
Message-Id: <20210430195232.30491-30-michel@lespinasse.org>
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

This follows the lines of the x86 speculative fault handling code,
but with some minor arch differences such as the way that the
VM_FAULT_BADACCESS case is handled.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/arm64/mm/fault.c | 63 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f37d4e3830b7..f2d09f8e4bc2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -25,6 +25,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/vm_event_item.h>
 
 #include <asm/acpi.h>
 #include <asm/bug.h>
@@ -530,6 +531,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 	unsigned long vm_flags = VM_ACCESS_FLAGS;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	struct vm_area_struct *vma;
+	struct vm_area_struct pvma;
+	unsigned long seq;
+#endif
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -564,6 +570,60 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+
+	/*
+	 * No need to try speculative faults for kernel or
+	 * single threaded user space.
+	 */
+	if (!(mm_flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto no_spf;
+
+	count_vm_event(SPF_ATTEMPT);
+	seq = mmap_seq_read_start(mm);
+	if (seq & 1) {
+		count_vm_spf_event(SPF_ABORT_ODD);
+		goto spf_abort;
+	}
+	rcu_read_lock();
+	vma = find_vma(mm, addr);
+	if (!vma || vma->vm_start > addr) {
+		rcu_read_unlock();
+		count_vm_spf_event(SPF_ABORT_UNMAPPED);
+		goto spf_abort;
+	}
+	if (!vma_is_anonymous(vma)) {
+		rcu_read_unlock();
+		count_vm_spf_event(SPF_ABORT_NO_SPECULATE);
+		goto spf_abort;
+	}
+	pvma = *vma;
+	rcu_read_unlock();
+	if (!mmap_seq_read_check(mm, seq, SPF_ABORT_VMA_COPY))
+		goto spf_abort;
+	vma = &pvma;
+	if (!(vma->vm_flags & vm_flags)) {
+		count_vm_spf_event(SPF_ABORT_ACCESS_ERROR);
+		goto spf_abort;
+	}
+	fault = do_handle_mm_fault(vma, addr & PAGE_MASK,
+			mm_flags | FAULT_FLAG_SPECULATIVE, seq, regs);
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return 0;
+	}
+	if (!(fault & VM_FAULT_RETRY))
+		goto done;
+
+spf_abort:
+	count_vm_event(SPF_ABORT);
+no_spf:
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -604,6 +664,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 		}
 	}
 	mmap_read_unlock(mm);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+done:
+#endif
 
 	/*
 	 * Handle the "normal" (no error) case first.
-- 
2.20.1

