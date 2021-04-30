Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D6B36F6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhD3H5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:57:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16934 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhD3H5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:57:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FWl4T70yPznTVV;
        Fri, 30 Apr 2021 15:54:01 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 30 Apr 2021
 15:56:23 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH -next 4/4] riscv: mm: add THP support on 64-bit
Date:   Fri, 30 Apr 2021 16:28:50 +0800
Message-ID: <20210430082850.462609-5-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430082850.462609-1-sunnanyong@huawei.com>
References: <20210430082850.462609-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring Transparent HugePage support to riscv. A
transparent huge page is always represented as a pmd.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/Kconfig               |   1 +
 arch/riscv/include/asm/pgtable.h | 156 +++++++++++++++++++++++++++++++
 arch/riscv/mm/tlbflush.c         |   7 ++
 3 files changed, 164 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4e124b2eb..3628f9f12 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -101,6 +101,7 @@ config RISCV
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select UACCESS_MEMCPY if !MMU
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index f7fc47c58..ceb4b9c82 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -148,10 +148,23 @@ extern pgd_t swapper_pg_dir[];
 #define __S110	PAGE_SHARED_EXEC
 #define __S111	PAGE_SHARED_EXEC
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int pmd_present(pmd_t pmd)
+{
+	/*
+	 * Checking for _PAGE_LEAF is needed too because:
+	 * When splitting a THP, split_huge_page() will temporarily clear
+	 * the present bit, in this situation, pmd_present() and
+	 * pmd_trans_huge() still needs to return true.
+	 */
+	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE | _PAGE_LEAF));
+}
+#else
 static inline int pmd_present(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
 }
+#endif
 
 static inline int pmd_none(pmd_t pmd)
 {
@@ -345,6 +358,14 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	local_flush_tlb_page(address);
 }
 
+static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp)
+{
+	pte_t *ptep = (pte_t *)pmdp;
+
+	update_mmu_cache(vma, address, ptep);
+}
+
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
@@ -438,6 +459,141 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
 
+/*
+ * THP functions
+ */
+static inline pmd_t pte_pmd(pte_t pte)
+{
+	return __pmd(pte_val(pte));
+}
+
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	return pmd;
+}
+
+static inline pmd_t pmd_mkinvalid(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) & ~(_PAGE_PRESENT|_PAGE_PROT_NONE));
+}
+
+#define __pmd_to_phys(pmd)  (pmd_val(pmd) >> _PAGE_PFN_SHIFT << PAGE_SHIFT)
+
+static inline unsigned long pmd_pfn(pmd_t pmd)
+{
+	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
+}
+
+static inline pmd_t mk_pmd(struct page *page, pgprot_t prot)
+{
+	return pfn_pmd(page_to_pfn(page), prot);
+}
+
+static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
+}
+
+#define pmd_write pmd_write
+static inline int pmd_write(pmd_t pmd)
+{
+	return pte_write(pmd_pte(pmd));
+}
+
+static inline int pmd_dirty(pmd_t pmd)
+{
+	return pte_dirty(pmd_pte(pmd));
+}
+
+static inline int pmd_young(pmd_t pmd)
+{
+	return pte_young(pmd_pte(pmd));
+}
+
+static inline pmd_t pmd_mkold(pmd_t pmd)
+{
+	return pte_pmd(pte_mkold(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_mkyoung(pmd_t pmd)
+{
+	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_mkwrite(pmd_t pmd)
+{
+	return pte_pmd(pte_mkwrite(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_wrprotect(pmd_t pmd)
+{
+	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_mkclean(pmd_t pmd)
+{
+	return pte_pmd(pte_mkclean(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_mkdirty(pmd_t pmd)
+{
+	return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
+}
+
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+				pmd_t *pmdp, pmd_t pmd)
+{
+	return set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	return pmd_leaf(pmd);
+}
+
+#define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
+static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
+					unsigned long address, pmd_t *pmdp,
+					pmd_t entry, int dirty)
+{
+	return ptep_set_access_flags(vma, address, (pte_t *)pmdp, pmd_pte(entry), dirty);
+}
+
+#define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
+static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
+					unsigned long address, pmd_t *pmdp)
+{
+	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
+}
+
+#define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
+static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
+					unsigned long address, pmd_t *pmdp)
+{
+	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
+}
+
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT
+static inline void pmdp_set_wrprotect(struct mm_struct *mm,
+					unsigned long address, pmd_t *pmdp)
+{
+	ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
+}
+
+#define pmdp_establish pmdp_establish
+static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
+				unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
+}
+
+#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
+void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end);
+
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * Encode and decode a swap entry
  *
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 382781abf..fea45af91 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -54,3 +54,10 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 {
 	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start, PAGE_SIZE);
 }
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end)
+{
+	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start, PMD_SIZE);
+}
+#endif
-- 
2.25.1

