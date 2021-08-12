Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17F3EADB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbhHLXjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238458AbhHLXi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 891E46103E;
        Thu, 12 Aug 2021 23:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811483;
        bh=c2E/fYN0v+g0xfHg2rVvxKo6rGmQOQAUbmipN+98JqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYTPuT8n3GgV0Xucjd68vJ6CHAUXHzjTflotEQmAyyX+8HP6E9WuMgnxjI66/5Fha
         KVimx/dzzrvWY/KTN5XYjHwpNE24BI/VhHe39jQGVDZx/VTp0tK3KLlYwV4gvEQYKw
         Qa5ueqtgIxHTqSThAVDoaBafxES4L/z9AkVW+Qzl4oeN/YfRBvnmcrITzl3Ifu6n5+
         DJGAyr2sQAbKJWQoRIJSvugwQxj63oGyXJlG/AEVXiD/qs6Ap9RBSvwwjtdHvOKOPR
         ZghQYx9ukRRXEYWL/O5LVk4b5cWXIsxOnzmdL9vRnTD9G0Jk0Zmxdkf5J6RBQG18xD
         shGwSKcC1I4Dw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 14/19] ARC: mm: disintegrate pgtable.h into levels and flags
Date:   Thu, 12 Aug 2021 16:37:48 -0700
Message-Id: <20210812233753.104217-15-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - pgtable-bits-arcv2.h (MMU specific page table flags)
 - pgtable-levels.h (paging levels)

No functional changes, but paves way for easy addition of new MMU code
with different bits and levels etc

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/pgtable-bits-arcv2.h | 149 ++++++++++++
 arch/arc/include/asm/pgtable-levels.h     |  91 +++++++
 arch/arc/include/asm/pgtable.h            | 277 +---------------------
 3 files changed, 244 insertions(+), 273 deletions(-)
 create mode 100644 arch/arc/include/asm/pgtable-bits-arcv2.h
 create mode 100644 arch/arc/include/asm/pgtable-levels.h

diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
new file mode 100644
index 000000000000..183d23bc1e00
--- /dev/null
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
+ */
+
+/*
+ * page table flags for software walked/managed MMUv3 (ARC700) and MMUv4 (HS)
+ * There correspond to the corresponding bits in the TLB
+ */
+
+#ifndef _ASM_ARC_PGTABLE_BITS_ARCV2_H
+#define _ASM_ARC_PGTABLE_BITS_ARCV2_H
+
+#ifdef CONFIG_ARC_CACHE_PAGES
+#define _PAGE_CACHEABLE		(1 << 0)  /* Cached (H) */
+#else
+#define _PAGE_CACHEABLE		0
+#endif
+
+#define _PAGE_EXECUTE		(1 << 1)  /* User Execute  (H) */
+#define _PAGE_WRITE		(1 << 2)  /* User Write    (H) */
+#define _PAGE_READ		(1 << 3)  /* User Read     (H) */
+#define _PAGE_ACCESSED		(1 << 4)  /* Accessed      (s) */
+#define _PAGE_DIRTY		(1 << 5)  /* Modified      (s) */
+#define _PAGE_SPECIAL		(1 << 6)
+#define _PAGE_GLOBAL		(1 << 8)  /* ASID agnostic (H) */
+#define _PAGE_PRESENT		(1 << 9)  /* PTE/TLB Valid (H) */
+
+#ifdef CONFIG_ARC_MMU_V4
+#define _PAGE_HW_SZ		(1 << 10)  /* Normal/super (H) */
+#else
+#define _PAGE_HW_SZ		0
+#endif
+
+/* Defaults for every user page */
+#define ___DEF		(_PAGE_PRESENT | _PAGE_CACHEABLE)
+
+/* Set of bits not changed in pte_modify */
+#define _PAGE_CHG_MASK	(PAGE_MASK_PHYS | _PAGE_ACCESSED | _PAGE_DIRTY | \
+							   _PAGE_SPECIAL)
+
+/* More Abbrevaited helpers */
+#define PAGE_U_NONE     __pgprot(___DEF)
+#define PAGE_U_R        __pgprot(___DEF | _PAGE_READ)
+#define PAGE_U_W_R      __pgprot(___DEF | _PAGE_READ | _PAGE_WRITE)
+#define PAGE_U_X_R      __pgprot(___DEF | _PAGE_READ | _PAGE_EXECUTE)
+#define PAGE_U_X_W_R    __pgprot(___DEF \
+				| _PAGE_READ | _PAGE_WRITE | _PAGE_EXECUTE)
+#define PAGE_KERNEL     __pgprot(___DEF | _PAGE_GLOBAL \
+				| _PAGE_READ | _PAGE_WRITE | _PAGE_EXECUTE)
+
+#define PAGE_SHARED	PAGE_U_W_R
+
+#define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) & ~_PAGE_CACHEABLE))
+
+/*
+ * Mapping of vm_flags (Generic VM) to PTE flags (arch specific)
+ *
+ * Certain cases have 1:1 mapping
+ *  e.g. __P101 means VM_READ, VM_EXEC and !VM_SHARED
+ *       which directly corresponds to  PAGE_U_X_R
+ *
+ * Other rules which cause the divergence from 1:1 mapping
+ *
+ *  1. Although ARC700 can do exclusive execute/write protection (meaning R
+ *     can be tracked independet of X/W unlike some other CPUs), still to
+ *     keep things consistent with other archs:
+ *      -Write implies Read:   W => R
+ *      -Execute implies Read: X => R
+ *
+ *  2. Pvt Writable doesn't have Write Enabled initially: Pvt-W => !W
+ *     This is to enable COW mechanism
+ */
+	/* xwr */
+#define __P000  PAGE_U_NONE
+#define __P001  PAGE_U_R
+#define __P010  PAGE_U_R	/* Pvt-W => !W */
+#define __P011  PAGE_U_R	/* Pvt-W => !W */
+#define __P100  PAGE_U_X_R	/* X => R */
+#define __P101  PAGE_U_X_R
+#define __P110  PAGE_U_X_R	/* Pvt-W => !W and X => R */
+#define __P111  PAGE_U_X_R	/* Pvt-W => !W */
+
+#define __S000  PAGE_U_NONE
+#define __S001  PAGE_U_R
+#define __S010  PAGE_U_W_R	/* W => R */
+#define __S011  PAGE_U_W_R
+#define __S100  PAGE_U_X_R	/* X => R */
+#define __S101  PAGE_U_X_R
+#define __S110  PAGE_U_X_W_R	/* X => R */
+#define __S111  PAGE_U_X_W_R
+
+#ifndef __ASSEMBLY__
+
+#define pte_write(pte)		(pte_val(pte) & _PAGE_WRITE)
+#define pte_dirty(pte)		(pte_val(pte) & _PAGE_DIRTY)
+#define pte_young(pte)		(pte_val(pte) & _PAGE_ACCESSED)
+#define pte_special(pte)	(pte_val(pte) & _PAGE_SPECIAL)
+
+#define PTE_BIT_FUNC(fn, op) \
+	static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
+
+PTE_BIT_FUNC(mknotpresent,     &= ~(_PAGE_PRESENT));
+PTE_BIT_FUNC(wrprotect,	&= ~(_PAGE_WRITE));
+PTE_BIT_FUNC(mkwrite,	|= (_PAGE_WRITE));
+PTE_BIT_FUNC(mkclean,	&= ~(_PAGE_DIRTY));
+PTE_BIT_FUNC(mkdirty,	|= (_PAGE_DIRTY));
+PTE_BIT_FUNC(mkold,	&= ~(_PAGE_ACCESSED));
+PTE_BIT_FUNC(mkyoung,	|= (_PAGE_ACCESSED));
+PTE_BIT_FUNC(mkspecial,	|= (_PAGE_SPECIAL));
+PTE_BIT_FUNC(mkhuge,	|= (_PAGE_HW_SZ));
+
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+}
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval)
+{
+	set_pte(ptep, pteval);
+}
+
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+		      pte_t *ptep);
+
+/* Encode swap {type,off} tuple into PTE
+ * We reserve 13 bits for 5-bit @type, keeping bits 12-5 zero, ensuring that
+ * PAGE_PRESENT is zero in a PTE holding swap "identifier"
+ */
+#define __swp_entry(type, off)		((swp_entry_t) \
+					{ ((type) & 0x1f) | ((off) << 13) })
+
+/* Decode a PTE containing swap "identifier "into constituents */
+#define __swp_type(pte_lookalike)	(((pte_lookalike).val) & 0x1f)
+#define __swp_offset(pte_lookalike)	((pte_lookalike).val >> 13)
+
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
+
+#define kern_addr_valid(addr)	(1)
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#include <asm/hugepage.h>
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
new file mode 100644
index 000000000000..8ece75335bb5
--- /dev/null
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Synopsys, Inc. (www.synopsys.com)
+ */
+
+/*
+ * Helpers for implemenintg paging levels
+ */
+
+#ifndef _ASM_ARC_PGTABLE_LEVELS_H
+#define _ASM_ARC_PGTABLE_LEVELS_H
+
+/*
+ * 2 level paging setup for software walked MMUv3 (ARC700) and MMUv4 (HS)
+ *
+ * [31]            32 bit virtual address              [0]
+ * -------------------------------------------------------
+ * |               | <---------- PGDIR_SHIFT ----------> |
+ * |               |                | <-- PAGE_SHIFT --> |
+ * -------------------------------------------------------
+ *       |                  |                |
+ *       |                  |                --> off in page frame
+ *       |                  ---> index into Page Table
+ *       ----> index into Page Directory
+ *
+ * Given software walk, the vaddr split is arbitrary set to 11:8:13
+ * However enabling of super page in a 2 level regime pegs PGDIR_SHIFT to
+ * super page size.
+ */
+
+#if defined(CONFIG_ARC_HUGEPAGE_16M)
+#define PGDIR_SHIFT		24
+#elif defined(CONFIG_ARC_HUGEPAGE_2M)
+#define PGDIR_SHIFT		21
+#else
+/* No Super page case: in theory this can be any number */
+#define PGDIR_SHIFT		21
+#endif
+
+#define PGDIR_SIZE		BIT(PGDIR_SHIFT)	/* vaddr span, not PDG sz */
+#define PGDIR_MASK		(~(PGDIR_SIZE - 1))
+
+#define PTRS_PER_PGD		BIT(32 - PGDIR_SHIFT)
+
+#define PTRS_PER_PTE		BIT(PGDIR_SHIFT - PAGE_SHIFT)
+
+#ifndef __ASSEMBLY__
+
+#include <asm-generic/pgtable-nopmd.h>
+
+/*
+ * 1st level paging: pgd
+ */
+#define pgd_index(addr)		((addr) >> PGDIR_SHIFT)
+#define pgd_offset(mm, addr)	(((mm)->pgd) + pgd_index(addr))
+#define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
+#define pgd_ERROR(e) \
+	pr_crit("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+
+/*
+ * Due to the strange way generic pgtable level folding works, in a 2 level
+ * setup, pmd_val() returns pgd, so these pmd_* macros actually work on pgd
+ */
+#define pmd_none(x)		(!pmd_val(x))
+#define pmd_bad(x)		((pmd_val(x) & ~PAGE_MASK))
+#define pmd_present(x)		(pmd_val(x))
+#define pmd_clear(xp)		do { pmd_val(*(xp)) = 0; } while (0)
+#define pmd_page_vaddr(pmd)	(pmd_val(pmd) & PAGE_MASK)
+#define pmd_page(pmd)		virt_to_page(pmd_page_vaddr(pmd))
+#define set_pmd(pmdp, pmd)	(*(pmdp) = pmd)
+#define pmd_pgtable(pmd)	((pgtable_t) pmd_page_vaddr(pmd))
+
+#define pte_ERROR(e) \
+	pr_crit("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
+
+#define pte_none(x)		(!pte_val(x))
+#define pte_present(x)		(pte_val(x) & _PAGE_PRESENT)
+#define pte_clear(mm,addr,ptep)	set_pte_at(mm, addr, ptep, __pte(0))
+#define pte_page(pte)		pfn_to_page(pte_pfn(pte))
+#define set_pte(ptep, pte)	((*(ptep)) = (pte))
+#define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
+#define pfn_pte(pfn, prot)	__pte(__pfn_to_phys(pfn) | pgprot_val(prot))
+#define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
+
+#ifdef CONFIG_ISA_ARCV2
+#define pmd_leaf(x)		(pmd_val(x) & _PAGE_HW_SZ)
+#endif
+
+#endif	/* !__ASSEMBLY__ */
+
+#endif
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index de4576e8d17a..9320b04c04bf 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -1,304 +1,35 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- *
- * vineetg: May 2011
- *  -Folded PAGE_PRESENT (used by VM) and PAGE_VALID (used by MMU) into 1.
- *     They are semantically the same although in different contexts
- *     VALID marks a TLB entry exists and it will only happen if PRESENT
- *  - Utilise some unused free bits to confine PTE flags to 12 bits
- *     This is a must for 4k pg-sz
- *
- * vineetg: Mar 2011 - changes to accommodate MMU TLB Page Descriptor mods
- *  -TLB Locking never really existed, except for initial specs
- *  -SILENT_xxx not needed for our port
- *  -Per my request, MMU V3 changes the layout of some of the bits
- *     to avoid a few shifts in TLB Miss handlers.
- *
- * vineetg: April 2010
- *  -PGD entry no longer contains any flags. If empty it is 0, otherwise has
- *   Pg-Tbl ptr. Thus pmd_present(), pmd_valid(), pmd_set( ) become simpler
- *
- * vineetg: April 2010
- *  -Switched form 8:11:13 split for page table lookup to 11:8:13
- *  -this speeds up page table allocation itself as we now have to memset 1K
- *    instead of 8k per page table.
- * -TODO: Right now page table alloc is 8K and rest 7K is unused
- *    need to optimise it
- *
- * Amit Bhor, Sameer Dhavale: Codito Technologies 2004
  */
 
 #ifndef _ASM_ARC_PGTABLE_H
 #define _ASM_ARC_PGTABLE_H
 
 #include <linux/bits.h>
-#include <asm-generic/pgtable-nopmd.h>
+
+#include <asm/pgtable-levels.h>
+#include <asm/pgtable-bits-arcv2.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
 
-/**************************************************************************
- * Page Table Flags
- *
- * ARC700 MMU only deals with softare managed TLB entries.
- * Page Tables are purely for Linux VM's consumption and the bits below are
- * suited to that (uniqueness). Hence some are not implemented in the TLB and
- * some have different value in TLB.
- * e.g. MMU v2: K_READ bit is 8 and so is GLOBAL (possible because they live in
- *      seperate PD0 and PD1, which combined forms a translation entry)
- *      while for PTE perspective, they are 8 and 9 respectively
- * with MMU v3: Most bits (except SHARED) represent the exact hardware pos
- *      (saves some bit shift ops in TLB Miss hdlrs)
- */
-
-#define _PAGE_CACHEABLE     (1<<0)	/* Page is cached (H) */
-#define _PAGE_EXECUTE       (1<<1)	/* Page has user execute perm (H) */
-#define _PAGE_WRITE         (1<<2)	/* Page has user write perm (H) */
-#define _PAGE_READ          (1<<3)	/* Page has user read perm (H) */
-#define _PAGE_ACCESSED      (1<<4)	/* Page is accessed (S) */
-#define _PAGE_DIRTY         (1<<5)	/* Page modified (dirty) (S) */
-#define _PAGE_SPECIAL       (1<<6)
-
-#define _PAGE_GLOBAL        (1<<8)	/* Page is global (H) */
-#define _PAGE_PRESENT       (1<<9)	/* TLB entry is valid (H) */
-
-#ifdef CONFIG_ARC_MMU_V4
-#define _PAGE_HW_SZ         (1<<10)	/* Page Size indicator (H): 0 normal, 1 super */
-#endif
-
-#define _PAGE_SHARED_CODE   (1<<11)	/* Shared Code page with cmn vaddr
-					   usable for shared TLB entries (H) */
-/* vmalloc permissions */
-#define _K_PAGE_PERMS  (_PAGE_EXECUTE | _PAGE_WRITE | _PAGE_READ | \
-			_PAGE_GLOBAL | _PAGE_PRESENT)
-
-#ifndef CONFIG_ARC_CACHE_PAGES
-#undef _PAGE_CACHEABLE
-#define _PAGE_CACHEABLE 0
-#endif
-
-#ifndef _PAGE_HW_SZ
-#define _PAGE_HW_SZ	0
-#endif
-
-/* Defaults for every user page */
-#define ___DEF (_PAGE_PRESENT | _PAGE_CACHEABLE)
-
-/* Set of bits not changed in pte_modify */
-#define _PAGE_CHG_MASK	(PAGE_MASK_PHYS | _PAGE_ACCESSED | _PAGE_DIRTY | \
-							   _PAGE_SPECIAL)
-/* More Abbrevaited helpers */
-#define PAGE_U_NONE     __pgprot(___DEF)
-#define PAGE_U_R        __pgprot(___DEF | _PAGE_READ)
-#define PAGE_U_W_R      __pgprot(___DEF | _PAGE_READ | _PAGE_WRITE)
-#define PAGE_U_X_R      __pgprot(___DEF | _PAGE_READ | _PAGE_EXECUTE)
-#define PAGE_U_X_W_R    __pgprot(___DEF | _PAGE_READ | _PAGE_WRITE | \
-						       _PAGE_EXECUTE)
-
-#define PAGE_SHARED	PAGE_U_W_R
-
-/* While kernel runs out of unstranslated space, vmalloc/modules use a chunk of
- * user vaddr space - visible in all addr spaces, but kernel mode only
- * Thus Global, all-kernel-access, no-user-access, cached
- */
-#define PAGE_KERNEL          __pgprot(_K_PAGE_PERMS | _PAGE_CACHEABLE)
-
-/**************************************************************************
- * Mapping of vm_flags (Generic VM) to PTE flags (arch specific)
- *
- * Certain cases have 1:1 mapping
- *  e.g. __P101 means VM_READ, VM_EXEC and !VM_SHARED
- *       which directly corresponds to  PAGE_U_X_R
- *
- * Other rules which cause the divergence from 1:1 mapping
- *
- *  1. Although ARC700 can do exclusive execute/write protection (meaning R
- *     can be tracked independet of X/W unlike some other CPUs), still to
- *     keep things consistent with other archs:
- *      -Write implies Read:   W => R
- *      -Execute implies Read: X => R
- *
- *  2. Pvt Writable doesn't have Write Enabled initially: Pvt-W => !W
- *     This is to enable COW mechanism
- */
-	/* xwr */
-#define __P000  PAGE_U_NONE
-#define __P001  PAGE_U_R
-#define __P010  PAGE_U_R	/* Pvt-W => !W */
-#define __P011  PAGE_U_R	/* Pvt-W => !W */
-#define __P100  PAGE_U_X_R	/* X => R */
-#define __P101  PAGE_U_X_R
-#define __P110  PAGE_U_X_R	/* Pvt-W => !W and X => R */
-#define __P111  PAGE_U_X_R	/* Pvt-W => !W */
-
-#define __S000  PAGE_U_NONE
-#define __S001  PAGE_U_R
-#define __S010  PAGE_U_W_R	/* W => R */
-#define __S011  PAGE_U_W_R
-#define __S100  PAGE_U_X_R	/* X => R */
-#define __S101  PAGE_U_X_R
-#define __S110  PAGE_U_X_W_R	/* X => R */
-#define __S111  PAGE_U_X_W_R
-
-/****************************************************************
- * 2 tier (PGD:PTE) software page walker
- *
- * [31]		    32 bit virtual address              [0]
- * -------------------------------------------------------
- * |               | <------------ PGDIR_SHIFT ----------> |
- * |		   |					 |
- * | BITS_FOR_PGD  |  BITS_FOR_PTE  | <-- PAGE_SHIFT --> |
- * -------------------------------------------------------
- *       |                  |                |
- *       |                  |                --> off in page frame
- *       |                  ---> index into Page Table
- *       ----> index into Page Directory
- *
- * In a single page size configuration, only PAGE_SHIFT is fixed
- * So both PGD and PTE sizing can be tweaked
- *  e.g. 8K page (PAGE_SHIFT 13) can have
- *  - PGDIR_SHIFT 21  -> 11:8:13 address split
- *  - PGDIR_SHIFT 24  -> 8:11:13 address split
- *
- * If Super Page is configured, PGDIR_SHIFT becomes fixed too,
- * so the sizing flexibility is gone.
- */
-
-#if defined(CONFIG_ARC_HUGEPAGE_16M)
-#define PGDIR_SHIFT	24
-#elif defined(CONFIG_ARC_HUGEPAGE_2M)
-#define PGDIR_SHIFT	21
-#else
-/*
- * Only Normal page support so "hackable" (see comment above)
- * Default value provides 11:8:13 (8K), 11:9:12 (4K)
- */
-#define PGDIR_SHIFT	21
-#endif
-
-#define BITS_FOR_PTE	(PGDIR_SHIFT - PAGE_SHIFT)
-#define BITS_FOR_PGD	(32 - PGDIR_SHIFT)
-
-#define PGDIR_SIZE	BIT(PGDIR_SHIFT)	/* vaddr span, not PDG sz */
-#define PGDIR_MASK	(~(PGDIR_SIZE-1))
-
-#define	PTRS_PER_PTE	BIT(BITS_FOR_PTE)
-#define	PTRS_PER_PGD	BIT(BITS_FOR_PGD)
-
 /*
  * Number of entries a user land program use.
  * TASK_SIZE is the maximum vaddr that can be used by a userland program.
  */
 #define	USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
 
-
-/****************************************************************
- * Bucket load of VM Helpers
- */
-
 #ifndef __ASSEMBLY__
 
-#define pte_ERROR(e) \
-	pr_crit("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-#define pgd_ERROR(e) \
-	pr_crit("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
-
-/* the zero page used for uninitialized and anonymous pages */
 extern char empty_zero_page[PAGE_SIZE];
 #define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
 
-#define set_pte(pteptr, pteval)	((*(pteptr)) = (pteval))
-#define set_pmd(pmdptr, pmdval)	(*(pmdptr) = pmdval)
-
-/* find the page descriptor of the Page Tbl ref by PMD entry */
-#define pmd_page(pmd)		virt_to_page(pmd_val(pmd) & PAGE_MASK)
-
-/* find the logical addr (phy for ARC) of the Page Tbl ref by PMD entry */
-#define pmd_page_vaddr(pmd)	(pmd_val(pmd) & PAGE_MASK)
-
-#define pte_none(x)			(!pte_val(x))
-#define pte_present(x)			(pte_val(x) & _PAGE_PRESENT)
-#define pte_clear(mm, addr, ptep)	set_pte_at(mm, addr, ptep, __pte(0))
-
-#define pmd_none(x)			(!pmd_val(x))
-#define	pmd_bad(x)			((pmd_val(x) & ~PAGE_MASK))
-#define pmd_present(x)			(pmd_val(x))
-#define pmd_leaf(x)			(pmd_val(x) & _PAGE_HW_SZ)
-#define pmd_clear(xp)			do { pmd_val(*(xp)) = 0; } while (0)
-
-#define pte_page(pte)		pfn_to_page(pte_pfn(pte))
-#define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
-#define pfn_pte(pfn, prot)	__pte(__pfn_to_phys(pfn) | pgprot_val(prot))
-
-/* Don't use virt_to_pfn for macros below: could cause truncations for PAE40*/
-#define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
-
-/* Zoo of pte_xxx function */
-#define pte_read(pte)		(pte_val(pte) & _PAGE_READ)
-#define pte_write(pte)		(pte_val(pte) & _PAGE_WRITE)
-#define pte_dirty(pte)		(pte_val(pte) & _PAGE_DIRTY)
-#define pte_young(pte)		(pte_val(pte) & _PAGE_ACCESSED)
-#define pte_special(pte)	(pte_val(pte) & _PAGE_SPECIAL)
-
-#define PTE_BIT_FUNC(fn, op) \
-	static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
-
-PTE_BIT_FUNC(mknotpresent,	&= ~(_PAGE_PRESENT));
-PTE_BIT_FUNC(wrprotect,	&= ~(_PAGE_WRITE));
-PTE_BIT_FUNC(mkwrite,	|= (_PAGE_WRITE));
-PTE_BIT_FUNC(mkclean,	&= ~(_PAGE_DIRTY));
-PTE_BIT_FUNC(mkdirty,	|= (_PAGE_DIRTY));
-PTE_BIT_FUNC(mkold,	&= ~(_PAGE_ACCESSED));
-PTE_BIT_FUNC(mkyoung,	|= (_PAGE_ACCESSED));
-PTE_BIT_FUNC(exprotect,	&= ~(_PAGE_EXECUTE));
-PTE_BIT_FUNC(mkexec,	|= (_PAGE_EXECUTE));
-PTE_BIT_FUNC(mkspecial,	|= (_PAGE_SPECIAL));
-PTE_BIT_FUNC(mkhuge,	|= (_PAGE_HW_SZ));
-
-static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-{
-	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
-}
+extern pgd_t swapper_pg_dir[] __aligned(PAGE_SIZE);
 
 /* Macro to mark a page protection as uncacheable */
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) & ~_PAGE_CACHEABLE))
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pteval)
-{
-	set_pte(ptep, pteval);
-}
-
 extern pgd_t swapper_pg_dir[] __aligned(PAGE_SIZE);
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *ptep);
-
-/* Encode swap {type,off} tuple into PTE
- * We reserve 13 bits for 5-bit @type, keeping bits 12-5 zero, ensuring that
- * PAGE_PRESENT is zero in a PTE holding swap "identifier"
- */
-#define __swp_entry(type, off)	((swp_entry_t) { \
-					((type) & 0x1f) | ((off) << 13) })
-
-/* Decode a PTE containing swap "identifier "into constituents */
-#define __swp_type(pte_lookalike)	(((pte_lookalike).val) & 0x1f)
-#define __swp_offset(pte_lookalike)	((pte_lookalike).val >> 13)
-
-/* NOPs, to keep generic kernel happy */
-#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
-
-#define kern_addr_valid(addr)	(1)
-
-#define pmd_pgtable(pmd)       ((pgtable_t) pmd_page_vaddr(pmd))
-
-/*
- * remap a physical page `pfn' of size `size' with page protection `prot'
- * into virtual address `from'
- */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#include <asm/hugepage.h>
-#endif
 
 /* to cope with aliasing VIPT cache */
 #define HAVE_ARCH_UNMAPPED_AREA
-- 
2.25.1

