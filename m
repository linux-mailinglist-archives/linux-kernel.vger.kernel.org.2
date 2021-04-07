Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FBC356105
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347993AbhDGBwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:49 -0400
Received: from server.lespinasse.org ([63.205.204.226]:34719 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347830AbhDGBvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:51 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=TsUjPBR98OR+HycMa67lX3AwybmOXiXbr14JHEP/HPI=;
 b=NoQsbiuzomfmwqnnFDorqLDd23clwVI/I9qt180/mo9M7RjoPMhjRhfpsYGAlpOxxDY55
 QM3jB6ilptjwQwUAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=TsUjPBR98OR+HycMa67lX3AwybmOXiXbr14JHEP/HPI=;
 b=LCojAYHaLAo69slIhG0Zb2BOh6dMlEDVhhPB5aAHC2mq/JDWdr89S0Iru7tPJUmymI0ag
 h+RSJdTiN2E0VTSuQl97AgZdurjW6CCUju1Ei52zI+Qp/QLBkOKNJ/46scl+D5SDytGyBYl
 JSFUmit6FYMMvWBl7amZIS9ZFJLo3Yq6r2QBg4gEkurs3Zx3mpA4ZAUe4xXkuW62SkQRTUt
 doMkKI3WAAlOQIOnCf9qKEBTEKjfmXa+3kBm2EBnVccrdNYvQXdOo4pOvN6tK3dTTLNzxN7
 N+LgdPNmKnA7zdFsNgB0keq59CzhVyg0nm5VtBtSJsPguhY1mrda+pumYopg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 449EB160564;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 34C4C19F31F; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 30/37] mm: enable speculative fault handling for supported file types.
Date:   Tue,  6 Apr 2021 18:44:55 -0700
Message-Id: <20210407014502.24091-31-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce vma_can_speculate(), which allows speculative handling for
VMAs mapping supported file types.

From do_handle_mm_fault(), speculative handling will follow through
__handle_mm_fault(), handle_pte_fault() and do_fault().

At this point, we expect speculative faults to continue through one of:
- do_read_fault(), fully implemented;
- do_cow_fault(), which might abort if missing anon vmas,
- do_shared_fault(), not implemented yet
  (would require ->page_mkwrite() changes).

vma_can_speculate() provides an early abort for the do_shared_fault() case,
limiting the time spent on trying that unimplemented case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c |  3 ++-
 include/linux/mm.h  | 14 ++++++++++++++
 mm/memory.c         | 17 ++++++++++++-----
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fbf265f56a06..48b86911a6df 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1324,7 +1324,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto spf_abort;
 	rcu_read_lock();
 	vma = find_vma(mm, address);
-	if (!vma || vma->vm_start > address || !vma_is_anonymous(vma)) {
+	if (!vma || vma->vm_start > address ||
+	    !vma_can_speculate(vma, flags)) {
 		rcu_read_unlock();
 		goto spf_abort;
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b4c0c10e434e..edb809e9036b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -700,6 +700,20 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool vma_can_speculate(struct vm_area_struct *vma,
+		unsigned int flags)
+{
+	if (vma_is_anonymous(vma))
+		return true;
+	if (!vma->vm_ops->speculative)
+		return false;
+	if (!(flags & FAULT_FLAG_WRITE))
+		return true;
+	if (!(vma->vm_flags & VM_SHARED))
+		return true;
+	return false;
+}
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/mm/memory.c b/mm/memory.c
index a20e13d84145..074945faf1ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4090,8 +4090,12 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret;
 
-	if (unlikely(anon_vma_prepare(vma)))
-		return VM_FAULT_OOM;
+	if (unlikely(!vma->anon_vma)) {
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+			return VM_FAULT_RETRY;
+		if (__anon_vma_prepare(vma))
+			return VM_FAULT_OOM;
+	}
 
 	vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vmf->address);
 	if (!vmf->cow_page)
@@ -4128,6 +4132,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret, tmp;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
+
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		return ret;
@@ -4172,12 +4178,12 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	struct mm_struct *vm_mm = vma->vm_mm;
 	vm_fault_t ret;
 
-	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
-
 	/*
 	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
 	 */
 	if (!vma->vm_ops->fault) {
+		VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
+
 		/*
 		 * If we find a migration pmd entry or a none pmd entry, which
 		 * should never happen, return SIGBUS
@@ -4739,7 +4745,8 @@ vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
 {
 	vm_fault_t ret;
 
-	VM_BUG_ON((flags & FAULT_FLAG_SPECULATIVE) && !vma_is_anonymous(vma));
+	VM_BUG_ON((flags & FAULT_FLAG_SPECULATIVE) &&
+		  !vma_can_speculate(vma, flags));
 
 	__set_current_state(TASK_RUNNING);
 
-- 
2.20.1

