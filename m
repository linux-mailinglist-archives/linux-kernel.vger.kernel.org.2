Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712373560FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347931AbhDGBwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:11 -0400
Received: from server.lespinasse.org ([63.205.204.226]:44459 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347808AbhDGBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:50 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=Mm4sRKZ9oPWWjYrlQVTDWSlP7K2SJOXE1Iezs0Haf/4=;
 b=hJKxBzc+YjcRxjNqDuMMXauTqpgX6EMXmblbyYlLywC9uaLxI4Z+Bio3AkTWuAVx/1JC4
 4hIOBBUYzycNFX2Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=Mm4sRKZ9oPWWjYrlQVTDWSlP7K2SJOXE1Iezs0Haf/4=;
 b=oNyM6JjSd6DoO5pFFb7RFw2adq0RuCvDIcOprNuCa7GNE9NteCWGBTYF1RjLLOYs5q6NG
 hyyyt+UrHy8Svrf6p35yGy6pUQg6E26BAYUi1wuMWsq24vIL4XqSvQhJ449QW2yaNFTEHDX
 eX4Bs6oSx9b4ZiV2n/gVaK7o28yIR31cY2TMUdmFE2EBUx1WOe0xWBqcPcCZYRdp0ZSJLhb
 Tv1wO7MMA3GpFI6tr4H67khd0Kdb5EKmCcjdB4GXl5KjEwBkoI/dNUMuMVffJsBZYLvPWfy
 vrB3LR7z41KD9Pn3d3tMfA76/tU1tf90D+gAKXg8hwdc3LA9T7VTmlGsZh+A==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id D62311602F1;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id C57F019F31E; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 16/37] mm: enable speculative fault handling through do_anonymous_page()
Date:   Tue,  6 Apr 2021 18:44:41 -0700
Message-Id: <20210407014502.24091-17-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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
index f8c8e325af77..fbf265f56a06 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1324,7 +1324,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto spf_abort;
 	rcu_read_lock();
 	vma = find_vma(mm, address);
-	if (!vma || vma->vm_start > address) {
+	if (!vma || vma->vm_start > address || !vma_is_anonymous(vma)) {
 		rcu_read_unlock();
 		goto spf_abort;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index fd84576f9c01..a2c5bf29f989 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4103,6 +4103,8 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	struct mm_struct *vm_mm = vma->vm_mm;
 	vm_fault_t ret;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
+
 	/*
 	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
 	 */
@@ -4340,6 +4342,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		pte_unmap(vmf->pte);
+		return VM_FAULT_RETRY;
+	}
+
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
@@ -4668,8 +4675,7 @@ vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
 {
 	vm_fault_t ret;
 
-	if (flags & FAULT_FLAG_SPECULATIVE)
-		return VM_FAULT_RETRY;
+	VM_BUG_ON((flags & FAULT_FLAG_SPECULATIVE) && !vma_is_anonymous(vma));
 
 	__set_current_state(TASK_RUNNING);
 
@@ -4691,10 +4697,12 @@ vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
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

