Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8C370188
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhD3Tx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:56 -0400
Received: from server.lespinasse.org ([63.205.204.226]:47601 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhD3TxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:24 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=BLfb3AqVSS1iZWKnBAI32as/v1HrLIIvwM3hMYePNUI=;
 b=8cMpbIOWRRdLq4qrH07ZoApzOUUqxKhtXC5TX3uGlt6u+RUpiVpcE9PrmNQePGgU2/K/e
 a5JOxs2y8H+oTEoCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=BLfb3AqVSS1iZWKnBAI32as/v1HrLIIvwM3hMYePNUI=;
 b=DpIS0cFIofpJRFqMCJ61gjVijTff1dHnb1HPNRT1ZgY0tp/JXtLD9wd4oL+SrkGgcVvBO
 KMzFQepiwY1MBrqX3MbFVG0nrARR9h8xY42hFlnylvzNSekRPkJlpHirQ5xtxFdzcAU3cB9
 1gj9/pjpbfCUZguQONX4fogFhe0N7MEDP1Nk9+74LwpTp5KxOfkBaDq09oPjlQqpEMdGeWr
 LANhkPfVDjI7lUJ+HQNB5DgVXhPDmlON4GsxCTQDgKHIJg2HVSe2lchFlRpo3M5eUnVe6yG
 qK6biGFrXSuBT8XVyl8swV17MF/DsmFVvc5054DirfuOL+J7p3G4+H+kBQUw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 437BF16031E;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 3666A19F521; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 09/29] mm: add do_handle_mm_fault()
Date:   Fri, 30 Apr 2021 12:52:10 -0700
Message-Id: <20210430195232.30491-10-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new do_handle_mm_fault function, which extends the existing
handle_mm_fault() API by adding an mmap sequence count, to be used
in the FAULT_FLAG_SPECULATIVE case.

In the initial implementation, FAULT_FLAG_SPECULATIVE always fails
(by returning VM_FAULT_RETRY).

The existing handle_mm_fault() API is kept as a wrapper around
do_handle_mm_fault() so that we do not have to immediately update
every handle_mm_fault() call site.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm.h | 12 +++++++++---
 mm/memory.c        | 10 +++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 021fdab5b721..d5988e78e6ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1724,9 +1724,15 @@ int generic_error_remove_page(struct address_space *mapping, struct page *page);
 int invalidate_inode_page(struct page *page);
 
 #ifdef CONFIG_MMU
-extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
-				  unsigned long address, unsigned int flags,
-				  struct pt_regs *regs);
+extern vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
+		unsigned long address, unsigned int flags,
+		unsigned long seq, struct pt_regs *regs);
+static inline vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
+		unsigned long address, unsigned int flags,
+		struct pt_regs *regs)
+{
+	return do_handle_mm_fault(vma, address, flags, 0, regs);
+}
 extern int fixup_user_fault(struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
diff --git a/mm/memory.c b/mm/memory.c
index 217c31c616f4..8258ff93a055 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4509,11 +4509,15 @@ static inline void mm_account_fault(struct pt_regs *regs,
  * The mmap_lock may have been released depending on flags and our
  * return value.  See filemap_fault() and __lock_page_or_retry().
  */
-vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
-			   unsigned int flags, struct pt_regs *regs)
+vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
+		unsigned long address, unsigned int flags,
+		unsigned long seq, struct pt_regs *regs)
 {
 	vm_fault_t ret;
 
+	if (flags & FAULT_FLAG_SPECULATIVE)
+		return VM_FAULT_RETRY;
+
 	__set_current_state(TASK_RUNNING);
 
 	count_vm_event(PGFAULT);
@@ -4555,7 +4559,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(handle_mm_fault);
+EXPORT_SYMBOL_GPL(do_handle_mm_fault);
 
 #ifndef __PAGETABLE_P4D_FOLDED
 /*
-- 
2.20.1

