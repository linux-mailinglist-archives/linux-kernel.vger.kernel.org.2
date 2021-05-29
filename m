Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C54394A22
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 05:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhE2DeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 23:34:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2520 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2Dd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 23:33:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsRr34m7gzYr8Q;
        Sat, 29 May 2021 11:29:39 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 11:32:20 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 11:32:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] ARM: mm: Refactor __do_page_fault()
Date:   Sat, 29 May 2021 11:41:37 +0800
Message-ID: <20210529034138.83384-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
References: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. cleanup access_error(), make vma flags set and check into
   __do_page_fault() and do_page_fault() directly.

2. drop fsr and task argument, instead, using vm_flags in
   __do_page_fault().

3. cleans up the multiple goto statements in __do_page_fault().

4. use current->mm directly in do_page_fault().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/fault.c | 73 ++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index efa402025031..81cf3e6e2a3d 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -183,74 +183,45 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #define VM_FAULT_BADMAP		0x010000
 #define VM_FAULT_BADACCESS	0x020000
 
-/*
- * Check that the permissions on the VMA allow for the fault which occurred.
- * If we encountered a write fault, we must have write permission, otherwise
- * we allow any permission.
- */
-static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
-{
-	unsigned int mask = VM_ACCESS_FLAGS;
-
-	if ((fsr & FSR_WRITE) && !(fsr & FSR_CM))
-		mask = VM_WRITE;
-	if (fsr & FSR_LNX_PF)
-		mask = VM_EXEC;
-
-	return vma->vm_flags & mask ? false : true;
-}
-
 static vm_fault_t __kprobes
-__do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
-		unsigned int flags, struct task_struct *tsk,
-		struct pt_regs *regs)
+__do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int flags,
+		unsigned long vma_flags, struct pt_regs *regs)
 {
-	struct vm_area_struct *vma;
-	vm_fault_t fault;
-
-	vma = find_vma(mm, addr);
-	fault = VM_FAULT_BADMAP;
+	struct vm_area_struct *vma = find_vma(mm, addr);
 	if (unlikely(!vma))
-		goto out;
-	if (unlikely(vma->vm_start > addr))
-		goto check_stack;
+		return VM_FAULT_BADMAP;
+
+	if (unlikely(vma->vm_start > addr)) {
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			return VM_FAULT_BADMAP;
+		if (addr < FIRST_USER_ADDRESS)
+			return VM_FAULT_BADMAP;
+		if (expand_stack(vma, addr))
+			return VM_FAULT_BADMAP;
+	}
 
 	/*
 	 * Ok, we have a good vm_area for this
 	 * memory access, so we can handle it.
 	 */
-good_area:
-	if (access_error(fsr, vma)) {
-		fault = VM_FAULT_BADACCESS;
-		goto out;
-	}
+	if (!(vma->vm_flags & vma_flags))
+		return VM_FAULT_BADACCESS;
 
 	return handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
-
-check_stack:
-	/* Don't allow expansion below FIRST_USER_ADDRESS */
-	if (vma->vm_flags & VM_GROWSDOWN &&
-	    addr >= FIRST_USER_ADDRESS && !expand_stack(vma, addr))
-		goto good_area;
-out:
-	return fault;
 }
 
 static int __kprobes
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
-	struct task_struct *tsk;
-	struct mm_struct *mm;
+	struct mm_struct *mm = current->mm;
 	int sig, code;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	unsigned long vm_flags = VM_ACCESS_FLAGS;
 
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
 
-	tsk = current;
-	mm  = tsk->mm;
-
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))
 		local_irq_enable();
@@ -264,8 +235,14 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
-	if ((fsr & FSR_WRITE) && !(fsr & FSR_CM))
+
+	if ((fsr & FSR_WRITE) && !(fsr & FSR_CM)) {
 		flags |= FAULT_FLAG_WRITE;
+		vm_flags = VM_WRITE;
+	}
+
+	if (fsr & FSR_LNX_PF)
+		vm_flags = VM_EXEC;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
@@ -293,7 +270,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, fsr, flags, tsk, regs);
+	fault = __do_page_fault(mm, addr, flags, vm_flags, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_lock because
-- 
2.26.2

