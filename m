Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED39398171
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFBGzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:55:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2945 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFBGzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:55:31 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw06K1rtjz658T;
        Wed,  2 Jun 2021 14:50:49 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:47 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:46 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/7] ARM: mm: Rafactor the __do_page_fault()
Date:   Wed, 2 Jun 2021 15:02:40 +0800
Message-ID: <20210602070246.83990-2-wangkefeng.wang@huawei.com>
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

Clean up the multiple goto statements and drops local variable
vm_fault_t fault, which will make the __do_page_fault() much
more readability.

No functional change.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/fault.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index efa402025031..662ac3ca3c8a 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -205,35 +205,27 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		unsigned int flags, struct task_struct *tsk,
 		struct pt_regs *regs)
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
+	if (access_error(fsr, vma))
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
-- 
2.26.2

