Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F34416446
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbhIWRWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235318AbhIWRWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:22:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0032E60F24;
        Thu, 23 Sep 2021 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632417681;
        bh=vwBCqfgCsBB5KZ+0lI75rBZvXTarSLXhZUpLWCMpgws=;
        h=From:To:Cc:Subject:Date:From;
        b=J9TKCZmreVLrrW7I2NgNl57fOFrdwoOl4myYkgdIgVhQZf/TRHam2VmQnRR62WHbZ
         cMtgYeQV5cyr0BgFnhfCSecvvsWucQ8T+qcRiDwFp3DAmyEIsd/ryzPcAkssK5U+KU
         Vw8qIXmDet8n9keOw13jrmQ3MSzSGJFhQ8iu4HnZjyNf1e8PhNN85Ih0dPtcsLp7yB
         +dapbjpaU7dmr6erYz8F53f4FvqIIK8QCyH+uxLlK30OXJbD36sM7HGYX4DaAKzArl
         6lmujQhIXh2MCTPsnVArgc4PtjePYDxOGhcy557tYy3jrXrwFzwb3YetRmBy8G+bNR
         vMkrZs8wHnfvQ==
From:   guoren@kernel.org
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Subject: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
Date:   Fri, 24 Sep 2021 01:21:06 +0800
Message-Id: <20210923172107.1117604-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch follows the standard pure RISC-V Svpbmt extension in
privilege spec to solve the non-coherent SOC dma synchronization
issues.

Here is the svpbmt PTE format:
| 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
  N     MT     RSW    D   A   G   U   X   W   R   V
        ^

Of the Reserved bits [63:54] in a leaf PTE, the high bit is already
allocated (as the N bit), so bits [62:61] are used as the MT (aka
MemType) field. This field specifies one of three memory types that
are close equivalents (or equivalent in effect) to the three main x86
and ARMv8 memory types - as shown in the following table.

RISC-V
Encoding &
MemType     RISC-V Description
----------  ------------------------------------------------
00 - PMA    Normal Cacheable, No change to implied PMA memory type
01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
11 - Rsvd   Reserved for future standard use

The standard protection_map[] needn't be modified because the "PMA"
type keeps the highest bits zero. And the whole modification is
limited in the arch/riscv/* and using a global variable
(__riscv_svpbmt) as _PAGE_DMA_MASK/IO/NC for pgprot_noncached
(&writecombine) in pgtable.h. We also add _PAGE_CHG_MASK to filter
PFN than before.

Enable it in devicetree - (Reuse "mmu-type" of cpu_section)
 - riscv,sv39,svpbmt
 - riscv,sv48,svpbmt

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Liu Shaohua <liush@allwinnertech.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Co-developed-by: Wei Fu <wefu@redhat.com>
Signed-off-by: Wei Fu <wefu@redhat.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Greg Favor <gfavor@ventanamicro.com>
Cc: Andrea Mondelli <andrea.mondelli@huawei.com>
Cc: Jonathan Behrens <behrensj@mit.edu>
Cc: Xinhaoqu (Freddie) <xinhaoqu@huawei.com>
Cc: Bill Huffman <huffman@cadence.com>
Cc: Nick Kossifidis <mick@ics.forth.gr>
Cc: Allen Baum <allen.baum@esperantotech.com>
Cc: Josh Scheid <jscheid@ventanamicro.com>
Cc: Richard Trauben <rtrauben@gmail.com>

---

Changes since V2:
 - Seperate DT modification into another patch
 - Move riscv_svpbmt() into riscv_fill_hwcap()
 - Fixup print_mmu()
 - Make __riscv_svpbmt updated only when all CPU nodes have "svpmbt"
   in the "mmu-type" DT property
 - Define _PAGE_MT_MASK as (_PAGE_MT_PMA | _PAGE_MT_NC | _PAGE_MT_IO)
 - Change u64 to unsigned long in _PAGE_MT_XXX
 - Change __riscv_svpbmt.mt[] to __riscv_svpbmt.mt_xxx
 - Optimize some misleading names
---
 arch/riscv/include/asm/fixmap.h       |  2 +-
 arch/riscv/include/asm/pgtable-64.h   |  8 ++++--
 arch/riscv/include/asm/pgtable-bits.h | 41 +++++++++++++++++++++++++--
 arch/riscv/include/asm/pgtable.h      | 39 +++++++++++++++++++------
 arch/riscv/kernel/cpu.c               |  4 ++-
 arch/riscv/kernel/cpufeature.c        | 24 ++++++++++++++++
 arch/riscv/mm/init.c                  |  5 ++++
 7 files changed, 107 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 54cbf07fb4e9..5acd99d08e74 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -43,7 +43,7 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };
 
-#define FIXMAP_PAGE_IO		PAGE_KERNEL
+#define FIXMAP_PAGE_IO		PAGE_IOREMAP
 
 #define __early_set_fixmap	__set_fixmap
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 228261aa9628..0b53ea67e91a 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -61,12 +61,14 @@ static inline void pud_clear(pud_t *pudp)
 
 static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
+	return (pmd_t *)pfn_to_virt((pud_val(pud) & _PAGE_CHG_MASK)
+						>> _PAGE_PFN_SHIFT);
 }
 
 static inline struct page *pud_page(pud_t pud)
 {
-	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
+	return pfn_to_page((pud_val(pud) & _PAGE_CHG_MASK)
+						>> _PAGE_PFN_SHIFT);
 }
 
 static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
@@ -76,7 +78,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
 
 static inline unsigned long _pmd_pfn(pmd_t pmd)
 {
-	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
+	return (pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT;
 }
 
 #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index 2ee413912926..3b38fe14f169 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -7,7 +7,7 @@
 #define _ASM_RISCV_PGTABLE_BITS_H
 
 /*
- * PTE format:
+ * rv32 PTE format:
  * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
  *       PFN      reserved for SW   D   A   G   U   X   W   R   V
  */
@@ -24,6 +24,42 @@
 #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
 #define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_64BIT
+/*
+ * rv64 PTE format:
+ * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
+ *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
+ * [62:61] Memory Type definitions:
+ *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
+ *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
+ *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
+ *  11 - Rsvd   Reserved for future standard use
+ */
+#define _SVPBMT_PMA		((unsigned long)0x0 << 61)
+#define _SVPBMT_NC		((unsigned long)0x1 << 61)
+#define _SVPBMT_IO		((unsigned long)0x2 << 61)
+#define _SVPBMT_MASK		(_SVPBMT_PMA | _SVPBMT_NC | _SVPBMT_IO)
+
+extern struct __riscv_svpbmt_struct {
+	unsigned long mask;
+	unsigned long mt_pma;
+	unsigned long mt_nc;
+	unsigned long mt_io;
+} __riscv_svpbmt;
+
+#define _PAGE_MT_MASK		__riscv_svpbmt.mask
+#define _PAGE_MT_PMA		__riscv_svpbmt.mt_pma
+#define _PAGE_MT_NC		__riscv_svpbmt.mt_nc
+#define _PAGE_MT_IO		__riscv_svpbmt.mt_io
+#else
+#define _PAGE_MT_MASK		0
+#define _PAGE_MT_PMA		0
+#define _PAGE_MT_NC		0
+#define _PAGE_MT_IO		0
+#endif /* CONFIG_64BIT */
+#endif /* __ASSEMBLY__ */
+
 #define _PAGE_SPECIAL   _PAGE_SOFT
 #define _PAGE_TABLE     _PAGE_PRESENT
 
@@ -38,7 +74,8 @@
 /* Set of bits to preserve across pte_modify() */
 #define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
 					  _PAGE_WRITE | _PAGE_EXEC |	\
-					  _PAGE_USER | _PAGE_GLOBAL))
+					  _PAGE_USER | _PAGE_GLOBAL |	\
+					  _PAGE_MT_MASK))
 /*
  * when all of R/W/X are zero, the PTE is a pointer to the next level
  * of the page table; otherwise, it is a leaf PTE.
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 39b550310ec6..3fc70a63e395 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -136,7 +136,8 @@
 				| _PAGE_PRESENT \
 				| _PAGE_ACCESSED \
 				| _PAGE_DIRTY \
-				| _PAGE_GLOBAL)
+				| _PAGE_GLOBAL \
+				| _PAGE_MT_PMA)
 
 #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
 #define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
@@ -146,11 +147,9 @@
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
-/*
- * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
- * change the properties of memory regions.
- */
-#define _PAGE_IOREMAP _PAGE_KERNEL
+#define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MT_MASK) | _PAGE_MT_IO)
+
+#define PAGE_IOREMAP		__pgprot(_PAGE_IOREMAP)
 
 extern pgd_t swapper_pg_dir[];
 
@@ -230,12 +229,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
 
 static inline struct page *pmd_page(pmd_t pmd)
 {
-	return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
+	return pfn_to_page((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
 }
 
 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 {
-	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
+	return (unsigned long)pfn_to_virt((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
 }
 
 static inline pte_t pmd_pte(pmd_t pmd)
@@ -251,7 +250,7 @@ static inline pte_t pud_pte(pud_t pud)
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	return (pte_val(pte) >> _PAGE_PFN_SHIFT);
+	return ((pte_val(pte) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
 }
 
 #define pte_page(x)     pfn_to_page(pte_pfn(x))
@@ -490,6 +489,28 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
 
+#define pgprot_noncached pgprot_noncached
+static inline pgprot_t pgprot_noncached(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
+	prot &= ~_PAGE_MT_MASK;
+	prot |= _PAGE_MT_IO;
+
+	return __pgprot(prot);
+}
+
+#define pgprot_writecombine pgprot_writecombine
+static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
+	prot &= ~_PAGE_MT_MASK;
+	prot |= _PAGE_MT_NC;
+
+	return __pgprot(prot);
+}
+
 /*
  * THP functions
  */
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 6d59e6906fdd..fbce525961c0 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -77,7 +77,9 @@ static void print_mmu(struct seq_file *f, const char *mmu_type)
 		return;
 #elif defined(CONFIG_64BIT)
 	if (strcmp(mmu_type, "riscv,sv39") != 0 &&
-	    strcmp(mmu_type, "riscv,sv48") != 0)
+	    strcmp(mmu_type, "riscv,sv48") != 0 &&
+	    strcmp(mmu_type, "riscv,sv39,svpbmt") != 0 &&
+	    strcmp(mmu_type, "riscv,sv48,svpbmt") != 0)
 		return;
 #endif
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d959d207a40d..d1b046a8254b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/of.h>
+#include <linux/pgtable.h>
 #include <asm/processor.h>
 #include <asm/hwcap.h>
 #include <asm/smp.h>
@@ -59,6 +60,27 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
+static void __init riscv_svpbmt(void)
+{
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+	struct device_node *node;
+	const char *str;
+
+	for_each_of_cpu_node(node) {
+		if (of_property_read_string(node, "mmu-type", &str))
+			continue;
+
+		if (strncmp(str + 11, "svpbmt", 6))
+			return;
+	}
+
+	__riscv_svpbmt.mask	= _SVPBMT_MASK;
+	__riscv_svpbmt.mt_pma	= _SVPBMT_PMA;
+	__riscv_svpbmt.mt_nc	= _SVPBMT_NC;
+	__riscv_svpbmt.mt_io	= _SVPBMT_IO;
+#endif
+}
+
 void __init riscv_fill_hwcap(void)
 {
 	struct device_node *node;
@@ -67,6 +89,8 @@ void __init riscv_fill_hwcap(void)
 	size_t i, j, isa_len;
 	static unsigned long isa2hwcap[256] = {0};
 
+	riscv_svpbmt();
+
 	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
 	isa2hwcap['a'] = isa2hwcap['A'] = COMPAT_HWCAP_ISA_A;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7cb4f391d106..43b2e11fd3e0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -905,3 +905,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return vmemmap_populate_basepages(start, end, node, NULL);
 }
 #endif
+
+#ifdef CONFIG_64BIT
+struct __riscv_svpbmt_struct __riscv_svpbmt __ro_after_init;
+EXPORT_SYMBOL(__riscv_svpbmt);
+#endif
-- 
2.25.1

