Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789CE3A7411
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFOChs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:37:48 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:6325 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOChr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:37:47 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G3skB1kYZz1BMSs;
        Tue, 15 Jun 2021 10:30:42 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 10:35:41 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 10:35:41 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v2] riscv: Enable KFENCE for riscv64
Date:   Tue, 15 Jun 2021 11:07:34 +0800
Message-ID: <20210615030734.2465923-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific implementation details for KFENCE and enable
KFENCE for the riscv64 architecture. In particular, this implements the
required interface in <asm/kfence.h>.

KFENCE requires that attributes for pages from its memory pool can
individually be set. Therefore, force the kfence pool to be mapped at
page granularity.

Testing this patch using the testcases in kfence_test.c and all passed.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Acked-by: Marco Elver <elver@google.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v1->v2: Add the acked-by and Reviewed-by.

 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/kfence.h | 63 +++++++++++++++++++++++++++++++++
 arch/riscv/mm/fault.c           | 11 +++++-
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/kfence.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c0bfb2569e9..1421da5ef1a2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -65,6 +65,7 @@ config RISCV
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if MMU && 64BIT
 	select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
+	select HAVE_ARCH_KFENCE if MMU && 64BIT
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_KGDB_QXFER_PKT
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
new file mode 100644
index 000000000000..d887a54042aa
--- /dev/null
+++ b/arch/riscv/include/asm/kfence.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_RISCV_KFENCE_H
+#define _ASM_RISCV_KFENCE_H
+
+#include <linux/kfence.h>
+#include <linux/pfn.h>
+#include <asm-generic/pgalloc.h>
+#include <asm/pgtable.h>
+
+static inline int split_pmd_page(unsigned long addr)
+{
+	int i;
+	unsigned long pfn = PFN_DOWN(__pa((addr & PMD_MASK)));
+	pmd_t *pmd = pmd_off_k(addr);
+	pte_t *pte = pte_alloc_one_kernel(&init_mm);
+
+	if (!pte)
+		return -ENOMEM;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		set_pte(pte + i, pfn_pte(pfn + i, PAGE_KERNEL));
+	set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(pte)), PAGE_TABLE));
+
+	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+	return 0;
+}
+
+static inline bool arch_kfence_init_pool(void)
+{
+	int ret;
+	unsigned long addr;
+	pmd_t *pmd;
+
+	for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
+	     addr += PAGE_SIZE) {
+		pmd = pmd_off_k(addr);
+
+		if (pmd_leaf(*pmd)) {
+			ret = split_pmd_page(addr);
+			if (ret)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static inline bool kfence_protect_page(unsigned long addr, bool protect)
+{
+	pte_t *pte = virt_to_kpte(addr);
+
+	if (protect)
+		set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
+	else
+		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
+
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+	return true;
+}
+
+#endif /* _ASM_RISCV_KFENCE_H */
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 096463cc6fff..aa08dd2f8fae 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -14,6 +14,7 @@
 #include <linux/signal.h>
 #include <linux/uaccess.h>
 #include <linux/kprobes.h>
+#include <linux/kfence.h>
 
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
@@ -45,7 +46,15 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 	 * Oops. The kernel tried to access some bad page. We'll have to
 	 * terminate things with extreme prejudice.
 	 */
-	msg = (addr < PAGE_SIZE) ? "NULL pointer dereference" : "paging request";
+	if (addr < PAGE_SIZE)
+		msg = "NULL pointer dereference";
+	else {
+		if (kfence_handle_page_fault(addr, regs->cause == EXC_STORE_PAGE_FAULT, regs))
+			return;
+
+		msg = "paging request";
+	}
+
 	die_kernel_fault(msg, addr, regs);
 }
 
-- 
2.18.0.huawei.25

