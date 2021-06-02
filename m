Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0748D398177
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFBGzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:55:53 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3336 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFBGzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:55:49 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw04b1S1Sz19S7R;
        Wed,  2 Jun 2021 14:49:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:47 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:47 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 3/7] ARM: mm: Cleanup access_error()
Date:   Wed, 2 Jun 2021 15:02:42 +0800
Message-ID: <20210602070246.83990-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
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

Now the write fault check in do_page_fault() and access_error() twice,
we can cleanup access_error(), and make the fault check and vma flags set
into do_page_fault() directly, then pass the vma flags to __do_page_fault.

No functional change.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/fault.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 249db395bdf0..9a6d74f6ea1d 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -183,26 +183,9 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
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
-		unsigned int flags, struct pt_regs *regs)
+__do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int flags,
+		unsigned long vma_flags, struct pt_regs *regs)
 {
 	struct vm_area_struct *vma = find_vma(mm, addr);
 	if (unlikely(!vma))
@@ -218,10 +201,10 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 	}
 
 	/*
-	 * Ok, we have a good vm_area for this
-	 * memory access, so we can handle it.
+	 * ok, we have a good vm_area for this memory access, check the
+	 * permissions on the VMA allow for the fault which occurred.
 	 */
-	if (access_error(fsr, vma))
+	if (!(vma->vm_flags & vma_flags))
 		return VM_FAULT_BADACCESS;
 
 	return handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
@@ -234,6 +217,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	int sig, code;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	unsigned long vm_flags = VM_ACCESS_FLAGS;
 
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
@@ -252,8 +236,14 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
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
 
@@ -281,7 +271,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, fsr, flags, regs);
+	fault = __do_page_fault(mm, addr, flags, vm_flags, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_lock because
-- 
2.26.2

