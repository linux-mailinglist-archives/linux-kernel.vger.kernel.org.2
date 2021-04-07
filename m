Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86B8356106
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbhDGBwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347834AbhDGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:51 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA313C061763
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=JSd8USyA44o7aisWRjJJmP/cvdrCX+QQ/xlTQKWni9A=;
 b=Mcq+tvl8z5tdgleIqie0lPGvo52Y/rVkX9Q70gSnW7/1nyO4h6x8+Y2tLz3+q6ZOfws7j
 20Cpmhpc2n1VjYPDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=JSd8USyA44o7aisWRjJJmP/cvdrCX+QQ/xlTQKWni9A=;
 b=ZSb7AHc/7/Pz09SX05JdQA0njLz+syzdV2IXZAgfAHmhRiolcNlHFH/3CNdEGBhnxENFM
 B4iV1cVjTFVKtRgcF4s2AFnptqp+XUyF7ZraP83Sk13Iq+aIpCYR4kv2jqtjwSs7I42jsH/
 l/ipYRoZmqWwLoG3sounZvnGVXm4LAHBE+W00nAPf4xNvab25u0YkZT2c/RNx1xuPlofCU3
 +i0wp85qLr/QEz1QOtdIas/1QNehEw9qRfnBzJBkX2sN6eRc9crG95VDt8WMl9ODNYEWAbK
 T9yhTEI5D4yBMKN8q4v7gViGKwCe8eL6g0oyVdtx6idZFEqT8ARf7Cd0ZItg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 9B7ED160253;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 8C3BA19F31D; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 08/37] mm: add do_handle_mm_fault()
Date:   Tue,  6 Apr 2021 18:44:33 -0700
Message-Id: <20210407014502.24091-9-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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
index 477c98bfdd9d..3691be1f1319 100644
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

