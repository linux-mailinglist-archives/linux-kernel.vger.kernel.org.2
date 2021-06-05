Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AC339C602
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 07:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFEFSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 01:18:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7109 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFEFSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 01:18:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fxnps6XFszYqL6;
        Sat,  5 Jun 2021 13:13:41 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 13:16:28 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 13:16:28 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH RFC] riscv: Enable pud vmap support for Sv48
Date:   Sat, 5 Jun 2021 13:48:38 +0800
Message-ID: <20210605054838.2017817-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210605054838.2017817-1-liushixin2@huawei.com>
References: <20210605054838.2017817-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pud vmap support and define the required page table functions
for Sv48.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
As riscv doesn't have Sv48 support currently, I test pud vmap based on Alex's
patch "riscv: Implement sv48 support".

 arch/riscv/include/asm/pgtable-64.h | 10 ++++++++
 arch/riscv/include/asm/vmalloc.h    |  8 +++++-
 arch/riscv/mm/pgtable.c             | 39 +++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index e3b7c5dd6a80..8920321770c7 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -69,6 +69,16 @@ static inline struct page *pud_page(pud_t pud)
 	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
 }
 
+static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
+{
+	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+}
+
+static inline unsigned long _pud_pfn(pud_t pud)
+{
+	return pud_val(pud) >> _PAGE_PFN_SHIFT;
+}
+
 static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
 {
 	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
diff --git a/arch/riscv/include/asm/vmalloc.h b/arch/riscv/include/asm/vmalloc.h
index 8f17f421f80c..83464895f902 100644
--- a/arch/riscv/include/asm/vmalloc.h
+++ b/arch/riscv/include/asm/vmalloc.h
@@ -3,7 +3,13 @@
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
-#define IOREMAP_MAX_ORDER (PMD_SHIFT)
+#define IOREMAP_MAX_ORDER (PUD_SHIFT)
+
+#define arch_vmap_pud_supported arch_vmap_pud_supported
+static inline bool __init arch_vmap_pud_supported(pgprot_t prot)
+{
+	return true;
+}
 
 #define arch_vmap_pmd_supported	arch_vmap_pmd_supported
 static inline bool __init arch_vmap_pmd_supported(pgprot_t prot)
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 738dc6f3530f..ed13b80424e6 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -7,6 +7,45 @@
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
+#ifndef __PAGETABLE_PUD_FOLDED
+int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
+{
+	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), prot);
+
+	set_pud(pud, new_pud);
+	return 1;
+}
+
+int pud_clear_huge(pud_t *pud)
+{
+	if (!pud_leaf(READ_ONCE(*pud)))
+		return 0;
+	pud_clear(pud);
+	return 1;
+}
+#endif
+
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
+{
+	pmd_t *pmd;
+	pte_t *pte;
+	int i;
+
+	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pud_clear(pud);
+
+	flush_tlb_kernel_range(addr, addr + PUD_SIZE);
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (!pmd_none(pmd[i])) {
+			pte = (pte_t *)pmd_page_vaddr(pmd[i]);
+			pte_free_kernel(NULL, pte);
+		}
+	}
+	pmd_free(NULL, pmd);
+	return 1;
+}
+
 #ifndef __PAGETABLE_PMD_FOLDED
 int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
 {
-- 
2.18.0.huawei.25

