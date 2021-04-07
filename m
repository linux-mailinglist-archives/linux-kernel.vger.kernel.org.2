Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56245356101
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347969AbhDGBwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347828AbhDGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:51 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8CEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=1pcgL6msPKrfTRZ1fn8ZYvCmKEa5WSF8jkX3M1HqC8Q=;
 b=hQvw4qVAk9RjFRT0YurEoXBUfSyibVWfDTUoCsMeXQbkWLv85cnNBgYIduwwAJSYkk9nX
 dBueIiIj6nFh/usBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=1pcgL6msPKrfTRZ1fn8ZYvCmKEa5WSF8jkX3M1HqC8Q=;
 b=iNI/FbYx7Xyn86mRVSOET3lACzR7zhpyLEsLKAwjwO+52vhn4w0U0kT1L0VFRgTFDJbI2
 H+KlbaIoIomCY6TbjUUQPaYfgiJ6rZVCYGClP+LomXZzhbY1WTNzfv3hZEwwzs92mNG7C+v
 GP9g4TVH4xBdqqSwehvTgygusMqE2oUqC2cGKIhgfVDEQJW/t4ekzDi26VXIW9QP8njhll6
 W0l7WVqhhxQ27zpWV/j/6rOgMkyYz/GQG816a5JEhhLkMGlGgeM+ljwkBxELBaJJrztnNGD
 dspGKP7paDbt7nX+v18rbCFEypfvuS9gOBP0r6AEOcN+wfVRX8sB8ybKE+HA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 7880A1606A3;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 673BE19F320; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 37/37] arm64/mm: attempt speculative mm faults first
Date:   Tue,  6 Apr 2021 18:45:02 -0700
Message-Id: <20210407014502.24091-38-michel@lespinasse.org>
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

This follows the lines of the x86 speculative fault handling code,
but with some minor arch differences such as the way that the
VM_FAULT_BADACCESS case is handled.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/arm64/mm/fault.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f37d4e3830b7..3757bfbb457a 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -25,6 +25,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/vm_event_item.h>
 
 #include <asm/acpi.h>
 #include <asm/bug.h>
@@ -530,6 +531,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 	unsigned long vm_flags = VM_ACCESS_FLAGS;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
+	struct vm_area_struct *vma;
+	struct vm_area_struct pvma;
+	unsigned long seq;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -564,6 +568,53 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+	/* Only try spf for multithreaded user space faults. */
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
+	if (!vma_can_speculate(vma, mm_flags)) {
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
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -604,6 +655,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 		}
 	}
 	mmap_read_unlock(mm);
+done:
 
 	/*
 	 * Handle the "normal" (no error) case first.
-- 
2.20.1

