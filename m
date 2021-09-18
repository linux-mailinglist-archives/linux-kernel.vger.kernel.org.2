Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786DA410509
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbhIRIL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:11:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9894 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbhIRILy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:11:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HBNgF07rGz8yQD;
        Sat, 18 Sep 2021 16:06:01 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 18 Sep 2021 16:10:30 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 18 Sep
 2021 16:10:29 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] arm64: remove page granularity limitation from KFENCE
Date:   Sat, 18 Sep 2021 16:38:49 +0800
Message-ID: <20210918083849.2696287-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if KFENCE is enabled in arm64, the entire linear map will be
mapped at page granularity which seems overkilled. Actually only the
kfence pool requires to be mapped at page granularity. We can remove the
restriction from KFENCE and force the linear mapping of the kfence pool
at page granularity later in arch_kfence_init_pool().

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 arch/arm64/include/asm/kfence.h | 69 ++++++++++++++++++++++++++++++++-
 arch/arm64/mm/mmu.c             |  4 +-
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index aa855c6a0ae6..bee101eced0b 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -8,9 +8,76 @@
 #ifndef __ASM_KFENCE_H
 #define __ASM_KFENCE_H
 
+#include <linux/kfence.h>
 #include <asm/set_memory.h>
+#include <asm/pgalloc.h>
 
-static inline bool arch_kfence_init_pool(void) { return true; }
+static inline int split_pud_page(pud_t *pud, unsigned long addr)
+{
+	int i;
+	pmd_t *pmd = pmd_alloc_one(&init_mm, addr);
+	unsigned long pfn = PFN_DOWN(__pa(addr));
+
+	if (!pmd)
+		return -ENOMEM;
+
+	for (i = 0; i < PTRS_PER_PMD; i++)
+		set_pmd(pmd + i, pmd_mkhuge(pfn_pmd(pfn + i * PTRS_PER_PTE, PAGE_KERNEL)));
+
+	smp_wmb(); /* See comment in __pte_alloc */
+	pud_populate(&init_mm, pud, pmd);
+	flush_tlb_kernel_range(addr, addr + PUD_SIZE);
+	return 0;
+}
+
+static inline int split_pmd_page(pmd_t *pmd, unsigned long addr)
+{
+	int i;
+	pte_t *pte = pte_alloc_one_kernel(&init_mm);
+	unsigned long pfn = PFN_DOWN(__pa(addr));
+
+	if (!pte)
+		return -ENOMEM;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		set_pte(pte + i, pfn_pte(pfn + i, PAGE_KERNEL));
+
+	smp_wmb(); /* See comment in __pte_alloc */
+	pmd_populate_kernel(&init_mm, pmd, pte);
+
+	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+	return 0;
+}
+
+static inline bool arch_kfence_init_pool(void)
+{
+	unsigned long addr;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
+	     addr += PAGE_SIZE) {
+		pgd = pgd_offset(&init_mm, addr);
+		if (pgd_leaf(*pgd))
+			return false;
+		p4d = p4d_offset(pgd, addr);
+		if (p4d_leaf(*p4d))
+			return false;
+		pud = pud_offset(p4d, addr);
+		if (pud_leaf(*pud)) {
+			if (split_pud_page(pud, addr & PUD_MASK))
+				return false;
+		}
+		pmd = pmd_offset(pud, addr);
+		if (pmd_leaf(*pmd)) {
+			if (split_pmd_page(pmd, addr & PMD_MASK))
+				return false;
+		}
+	}
+	return true;
+}
 
 static inline bool kfence_protect_page(unsigned long addr, bool protect)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cfd9deb347c3..b2c79ccfb1c5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -516,7 +516,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
 
-	if (can_set_direct_map() || crash_mem_map || IS_ENABLED(CONFIG_KFENCE))
+	if (can_set_direct_map() || crash_mem_map)
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
@@ -1485,7 +1485,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	 * KFENCE requires linear map to be mapped at page granularity, so that
 	 * it is possible to protect/unprotect single pages in the KFENCE pool.
 	 */
-	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
+	if (can_set_direct_map())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-- 
2.18.0.huawei.25

