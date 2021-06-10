Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5566D3A2B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhFJMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:30:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9067 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhFJM3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:29:17 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G137Z0QDZzYWFY;
        Thu, 10 Jun 2021 20:24:26 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 20:27:16 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 20:27:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Will Deacon <will@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 6/6] ARM: mm: Fix PXN process with LPAE feature
Date:   Thu, 10 Jun 2021 20:35:56 +0800
Message-ID: <20210610123556.171328-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
References: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user code execution with privilege mode, it will lead to
infinite loop in the page fault handler if ARM_LPAE enabled,

The issue could be reproduced with
  "echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT"

As Permission fault shows in ARM spec,
  IFSR format when using the Short-descriptor translation table format
    Permission fault:       01101 First level      01111 Second level
  IFSR format when using the Long-descriptor translation table format
    Permission fault:       0011LL LL bits indicate levelb.

Add is_permission_fault() function to check permission fault and die
if permission fault occurred under instruction fault in do_page_fault().

Fixes: 1d4d37159d01 ("ARM: 8235/1: Support for the PXN CPU feature on ARMv7")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/fault.c | 20 +++++++++++++++++++-
 arch/arm/mm/fault.h |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 82bcfe57de20..bc8779d54a64 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -194,6 +194,19 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 #define VM_FAULT_BADMAP		0x010000
 #define VM_FAULT_BADACCESS	0x020000
 
+static inline bool is_permission_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+#ifdef CONFIG_ARM_LPAE
+	if ((fs & FS_PERM_NOLL_MASK) == FS_PERM_NOLL)
+		return true;
+#else
+	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
+		return true;
+#endif
+	return false;
+}
+
 static vm_fault_t __kprobes
 __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int flags,
 		unsigned long vma_flags, struct pt_regs *regs)
@@ -253,9 +266,14 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		vm_flags = VM_WRITE;
 	}
 
-	if (fsr & FSR_LNX_PF)
+	if (fsr & FSR_LNX_PF) {
 		vm_flags = VM_EXEC;
 
+		if (is_permission_fault(fsr) && !user_mode(regs))
+			die_kernel_fault("execution of memory",
+					 mm, addr, fsr, regs);
+	}
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
 	/*
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index 9ecc2097a87a..83b5ab32d7a4 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_ARM_LPAE
 #define FSR_FS_AEA		17
+#define FS_PERM_NOLL		0xC
+#define FS_PERM_NOLL_MASK	0x3C
 
 static inline int fsr_fs(unsigned int fsr)
 {
@@ -21,6 +23,8 @@ static inline int fsr_fs(unsigned int fsr)
 }
 #else
 #define FSR_FS_AEA		22
+#define FS_L1_PERM             0xD
+#define FS_L2_PERM             0xF
 
 static inline int fsr_fs(unsigned int fsr)
 {
-- 
2.26.2

