Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10937019C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhD3TzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:55:07 -0400
Received: from server.lespinasse.org ([63.205.204.226]:47923 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhD3Txi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:38 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=eULoJwQoISRJDyWh6sQIkPbJRau/grHqDfGiWr2ndBc=;
 b=hNOAqV+Bi3m/G9I1+p/zbTgoypBTOIz9B9w7EuLXDESQcB7YB+wNpudjM89Jlv4pGyn1d
 eppGrtsnZHr/cNRBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=eULoJwQoISRJDyWh6sQIkPbJRau/grHqDfGiWr2ndBc=;
 b=LLcNJN4Q0cNreUi2QNRCmvi9zlH+OSkbXB/q3IC4eYa3yeOiFOzGf7On1WAFSRGdYS4Hy
 jDWbNZpT8l72PTG6DCd9W22CDTlebRhwdA69DEVWWQB8UZGfktRR0w/+VDx3geYu4Qt37My
 vBe5z2c36M/iQlLy1RWER9bUFrR63ZNDfJnizhjBtrQsR5QMmlaz2b/zziuf959oknLxTF6
 XHkWLqzy4v3htaBTYFcJVZqEnFtjBbFHdLnnsvn1gxQj7eIjoYN3F62t5hvwB9Ky2p/2+Gh
 S6Lvbcn9dW4G2XDxg5zPVBk62nFgrXWu/01L/iNX///ZO6Nc3ebsipAsTkeQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id DBD20160372;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id CCB6D19F523; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 31/31] powerpc/mm: attempt speculative mm faults first
Date:   Fri, 30 Apr 2021 12:52:32 -0700
Message-Id: <20210430195232.30491-32-michel@lespinasse.org>
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
access_pkey_error case is handled

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/powerpc/mm/fault.c | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index bb368257b55c..d7c820751a58 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -398,6 +398,10 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_write = page_fault_is_write(error_code);
 	vm_fault_t fault, major = 0;
 	bool kprobe_fault = kprobe_page_fault(regs, 11);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	struct vm_area_struct pvma;
+	unsigned long seq;
+#endif
 
 	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
 		return 0;
@@ -450,6 +454,64 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+
+	/*
+	 * No need to try speculative faults for kernel or
+	 * single threaded user space.
+	 */
+	if (!(flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto no_spf;
+
+	count_vm_event(SPF_ATTEMPT);
+	seq = mmap_seq_read_start(mm);
+	if (seq & 1) {
+		count_vm_spf_event(SPF_ABORT_ODD);
+		goto spf_abort;
+	}
+	rcu_read_lock();
+	vma = find_vma(mm, address);
+	if (!vma || vma->vm_start > address) {
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
+#ifdef CONFIG_PPC_MEM_KEYS
+	if (unlikely(access_pkey_error(is_write, is_exec,
+				       (error_code & DSISR_KEYFAULT), vma))) {
+		count_vm_spf_event(SPF_ABORT_ACCESS_ERROR);
+		goto spf_abort;
+	}
+#endif /* CONFIG_PPC_MEM_KEYS */
+	if (unlikely(access_error(is_write, is_exec, vma))) {
+		count_vm_spf_event(SPF_ABORT_ACCESS_ERROR);
+		goto spf_abort;
+	}
+	fault = do_handle_mm_fault(vma, address,
+				   flags | FAULT_FLAG_SPECULATIVE, seq, regs);
+	major |= fault & VM_FAULT_MAJOR;
+
+	if (fault_signal_pending(fault, regs))
+		return user_mode(regs) ? 0 : SIGBUS;
+	if (!(fault & VM_FAULT_RETRY))
+		goto done;
+
+spf_abort:
+	count_vm_event(SPF_ABORT);
+no_spf:
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -525,6 +587,9 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	mmap_read_unlock(current->mm);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+done:
+#endif
 
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
-- 
2.20.1

