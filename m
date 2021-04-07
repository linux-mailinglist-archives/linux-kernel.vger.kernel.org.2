Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56C35611D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbhDGBxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347851AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4976C0613D9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=wmzTNOpmvJgU2+ktObZqYl7ztD+8ceDz1BXrR5WVsHA=;
 b=WqfE2X+chCev1QmePRjeuCrLGUj6TXALSmqGZlONI43Pl3PjzGxGJqBzjzNYC5wCMyWzX
 7kAAXcM9WXxDLhPDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=wmzTNOpmvJgU2+ktObZqYl7ztD+8ceDz1BXrR5WVsHA=;
 b=j2O1Dn7hwEqXxPaFt1j92dvD5LnaAj1gNu182V8uNbDW77KXiHD/IvchklgWFg+3HdPiu
 0Wc9n3eoMVW6ufA4LGoVG1h8aMAZnDdsDM87uQC2QGKU45z5x8VGSn2NolG0WP5mUmLyC5w
 wANilgJ5mW8LgdMoel/qRH9I9DLbNlbun1WZwh52o/0QvbkjyX47f9yNvp5K8r6/VRFO8X+
 oTiFyJ4wp1U6mYbAjJaydTepcGkgyyY80luQ3L+1EJIBqxNkK8dts6OyilOpk2JiMaoB/j5
 pIlBWfU3k+iopAQl7hfoymM6wZ6vImnYBVfbuLM7xeJbWFHLEyBN0wo7t5cw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id AF0A61602CB;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id A162919F31D; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 11/37] x86/mm: attempt speculative mm faults first
Date:   Tue,  6 Apr 2021 18:44:36 -0700
Message-Id: <20210407014502.24091-12-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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
 arch/x86/mm/fault.c           | 36 +++++++++++++++++++++++++++++++++++
 include/linux/vm_event_item.h |  4 ++++
 mm/vmstat.c                   |  4 ++++
 3 files changed, 44 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a73347e2cdfc..f8c8e325af77 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1219,6 +1219,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	struct vm_area_struct pvma;
+	unsigned long seq;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1316,6 +1318,39 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 #endif
 
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
+
 	/*
 	 * Kernel-mode access to the user address space should only occur
 	 * on well-defined single instructions listed in the exception
@@ -1412,6 +1447,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	mmap_read_unlock(mm);
+done:
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
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

