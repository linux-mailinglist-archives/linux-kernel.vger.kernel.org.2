Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01767398174
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFBGzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:55:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2843 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhFBGzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:55:40 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw04Q0PWszWncN;
        Wed,  2 Jun 2021 14:49:10 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
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
Subject: [PATCH v2 2/7] ARM: mm: Kill task_struct argument for __do_page_fault()
Date:   Wed, 2 Jun 2021 15:02:41 +0800
Message-ID: <20210602070246.83990-3-wangkefeng.wang@huawei.com>
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

The __do_page_fault() won't use task_struct argument, kill it
and also use current->mm directly in do_page_fault().

No functional change.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/fault.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 662ac3ca3c8a..249db395bdf0 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -202,8 +202,7 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 
 static vm_fault_t __kprobes
 __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
-		unsigned int flags, struct task_struct *tsk,
-		struct pt_regs *regs)
+		unsigned int flags, struct pt_regs *regs)
 {
 	struct vm_area_struct *vma = find_vma(mm, addr);
 	if (unlikely(!vma))
@@ -231,8 +230,7 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 static int __kprobes
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
-	struct task_struct *tsk;
-	struct mm_struct *mm;
+	struct mm_struct *mm = current->mm;
 	int sig, code;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
@@ -240,8 +238,6 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
 
-	tsk = current;
-	mm  = tsk->mm;
 
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))
@@ -285,7 +281,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, fsr, flags, tsk, regs);
+	fault = __do_page_fault(mm, addr, fsr, flags, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_lock because
-- 
2.26.2

