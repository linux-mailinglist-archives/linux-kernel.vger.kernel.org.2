Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366F637018D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhD3TyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:06 -0400
Received: from server.lespinasse.org ([63.205.204.226]:44335 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhD3Tx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:29 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=M/Ev9iks2mpuHbjoGtjSBN2w1TDQW6+EFN9w5Lcsf9s=;
 b=qorJ25mBWnaXh0kvHjZNSgrUysLUviTXD8V7S8+PwBGxSEadwdDSK9yKOVct7cU71wJ+c
 lJxszXP8H/LLEEjBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=M/Ev9iks2mpuHbjoGtjSBN2w1TDQW6+EFN9w5Lcsf9s=;
 b=MN4K5XVli33rheSlcHq6WD+tJr0i33+3ECUXM250WDhfV/hi/b9nxA2FOVZ2OJ4c29FMR
 PyUziXaigVfVLZ1msDdWuOEdkbN3if8wd+k7eOw4ytg1Hxosv0a4tz95lFMYMjH2RiIZHgX
 /A+eAocU1836zWv3dQ21RQfQGT5kn7sVQa9NF8CJ+0ZfoRMvHeEO0fZjcI4/tALfGyNfpiK
 LLM0GR1pOO3Bk/qWTd68h7gbggzMpcm0odD7zAxxEftdcjUxSyIh1TK5iMS0d2YrvWzYXfA
 FeEzFo+fcTRfEqx93bgoQS6GbIIwnE2+6cPHHMwNSOpAI7T5V02hJNd1PxDw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 85DF616032B;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 765F619F521; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 18/29] mm: enable speculative fault handling through do_anonymous_page()
Date:   Fri, 30 Apr 2021 12:52:19 -0700
Message-Id: <20210430195232.30491-19-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in x86 fault handler, only attempt spf if the vma is anonymous.

In do_handle_mm_fault(), let speculative page faults proceed as long
as they fall into anonymous vmas. This enables the speculative
handling code in __handle_mm_fault() and do_anonymous_page().

In handle_pte_fault(), if vmf->pte is set (the original pte was not
pte_none), catch speculative faults and return VM_FAULT_RETRY as
those cases are not implemented yet. Also assert that do_fault()
is not reached in the speculative case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c |  2 +-
 mm/memory.c         | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 0e8abe43d032..463061186827 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1327,7 +1327,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto spf_abort;
 	rcu_read_lock();
 	vma = find_vma(mm, address);
-	if (!vma || vma->vm_start > address) {
+	if (!vma || vma->vm_start > address || !vma_is_anonymous(vma)) {
 		rcu_read_unlock();
 		goto spf_abort;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index d95826c48f1d..eceb1b6e904c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4120,6 +4120,8 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	struct mm_struct *vm_mm = vma->vm_mm;
 	vm_fault_t ret;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
+
 	/*
 	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
 	 */
@@ -4357,6 +4359,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		pte_unmap(vmf->pte);
+		return VM_FAULT_RETRY;
+	}
+
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
@@ -4685,8 +4692,7 @@ vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
 {
 	vm_fault_t ret;
 
-	if (flags & FAULT_FLAG_SPECULATIVE)
-		return VM_FAULT_RETRY;
+	VM_BUG_ON((flags & FAULT_FLAG_SPECULATIVE) && !vma_is_anonymous(vma));
 
 	__set_current_state(TASK_RUNNING);
 
@@ -4708,10 +4714,12 @@ vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
 	if (flags & FAULT_FLAG_USER)
 		mem_cgroup_enter_user_fault();
 
-	if (unlikely(is_vm_hugetlb_page(vma)))
+	if (unlikely(is_vm_hugetlb_page(vma))) {
+		VM_BUG_ON(flags & FAULT_FLAG_SPECULATIVE);
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
-	else
+	} else {
 		ret = __handle_mm_fault(vma, address, flags, seq);
+	}
 
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
-- 
2.20.1

