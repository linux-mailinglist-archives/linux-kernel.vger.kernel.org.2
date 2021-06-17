Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1808A3AB539
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhFQNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:55:19 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41405 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhFQNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:55:19 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D3DC46000C;
        Thu, 17 Jun 2021 13:53:08 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] riscv: Introduce structure that group all variables regarding kernel mapping
Date:   Thu, 17 Jun 2021 15:53:07 +0200
Message-Id: <20210617135307.1972069-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a lot of variables that are used to hold kernel mapping addresses,
offsets between physical and virtual mappings and some others used for XIP
kernels: they are all defined at different places in mm/init.c, so group
them into a single structure with, for some of them, more explicit and concise
names.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/include/asm/page.h      | 60 ++++++++++--------
 arch/riscv/kernel/asm-offsets.c    |  2 +
 arch/riscv/kernel/head.S           |  4 +-
 arch/riscv/kernel/kexec_relocate.S |  4 +-
 arch/riscv/kernel/machine_kexec.c  |  2 +-
 arch/riscv/mm/init.c               | 98 +++++++++++-------------------
 arch/riscv/mm/physaddr.c           |  2 +-
 arch/riscv/mm/ptdump.c             |  2 +-
 8 files changed, 78 insertions(+), 96 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 1c2010c292b3..d093154ac72a 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -79,55 +79,61 @@ typedef struct page *pgtable_t;
 #endif
 
 #ifdef CONFIG_MMU
-extern unsigned long va_pa_offset;
-#ifdef CONFIG_64BIT
-extern unsigned long va_kernel_pa_offset;
-#endif
-#ifdef CONFIG_XIP_KERNEL
-extern unsigned long va_kernel_xip_pa_offset;
-#endif
 extern unsigned long pfn_base;
-extern uintptr_t load_sz;
 #define ARCH_PFN_OFFSET		(pfn_base)
 #else
-#define va_pa_offset		0
-#ifdef CONFIG_64BIT
-#define va_kernel_pa_offset	0
-#endif
 #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
 #endif /* CONFIG_MMU */
 
-extern unsigned long kernel_virt_addr;
+struct kernel_mapping {
+	unsigned long virt_addr;
+	uintptr_t phys_addr;
+	uintptr_t size;
+	/* Offset between linear mapping virtual address and kernel load address */
+	unsigned long va_pa_offset;
+#ifdef CONFIG_64BIT
+	/* Offset between kernel mapping virtual address and kernel load address */
+	unsigned long va_kernel_pa_offset;
+#endif
+#ifdef CONFIG_XIP_KERNEL
+	unsigned long va_kernel_xip_pa_offset;
+	uintptr_t xiprom;
+	uintptr_t xiprom_sz;
+#endif
+};
+
+extern struct kernel_mapping kernel_map;
 
 #ifdef CONFIG_64BIT
 #define is_kernel_mapping(x)	\
-	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
+	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
 #define is_linear_mapping(x)	\
-	((x) >= PAGE_OFFSET && (x) < kernel_virt_addr)
+	((x) >= PAGE_OFFSET && (x) < kernel_map.virt_addr)
 
-#define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
+#define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
 #ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_pa_to_va(y)	({						\
 	unsigned long _y = y;								\
 	(_y >= CONFIG_PHYS_RAM_BASE) ?							\
-		(void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_OFFSET) :	\
-		(void *)((unsigned long)(_y) + va_kernel_xip_pa_offset);		\
+		(void *)((unsigned long)(_y) + kernel_map.va_kernel_pa_offset + XIP_OFFSET) :	\
+		(void *)((unsigned long)(_y) + kernel_map.va_kernel_xip_pa_offset);		\
 	})
 #else
-#define kernel_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_kernel_pa_offset))
+#define kernel_mapping_pa_to_va(x)	\
+	((void *)((unsigned long)(x) + kernel_map.va_kernel_pa_offset))
 #endif
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
-#define linear_mapping_va_to_pa(x)	((unsigned long)(x) - va_pa_offset)
+#define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
 #ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = y;							\
-	(_y < kernel_virt_addr + XIP_OFFSET) ?					\
-		((unsigned long)(_y) - va_kernel_xip_pa_offset) :		\
-		((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);	\
+	(_y < kernel_map.virt_addr + XIP_OFFSET) ?					\
+		((unsigned long)(_y) - kernel_map.va_kernel_xip_pa_offset) :		\
+		((unsigned long)(_y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET);	\
 	})
 #else
-#define kernel_mapping_va_to_pa(x)	((unsigned long)(x) - va_kernel_pa_offset)
+#define kernel_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_kernel_pa_offset)
 #endif
 #define __va_to_pa_nodebug(x)	({						\
 	unsigned long _x = x;							\
@@ -136,12 +142,12 @@ extern unsigned long kernel_virt_addr;
 	})
 #else
 #define is_kernel_mapping(x)	\
-	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
+	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
 #define is_linear_mapping(x)	\
 	((x) >= PAGE_OFFSET)
 
-#define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
-#define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
+#define __pa_to_va_nodebug(x)  ((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
+#define __va_to_pa_nodebug(x)  ((unsigned long)(x) - kernel_map.va_pa_offset)
 #endif
 
 #ifdef CONFIG_DEBUG_VIRTUAL
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 9ef33346853c..90f8ce64fa6f 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -311,4 +311,6 @@ void asm_offsets(void)
 	 * ensures the alignment is sane.
 	 */
 	DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));
+
+	OFFSET(KERNEL_MAP_VIRT_ADDR, kernel_mapping, virt_addr);
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 89cc58ab52b4..fce5184b22c3 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -81,9 +81,9 @@ pe_head_start:
 #ifdef CONFIG_MMU
 relocate:
 	/* Relocate return address */
-	la a1, kernel_virt_addr
+	la a1, kernel_map
 	XIP_FIXUP_OFFSET a1
-	REG_L a1, 0(a1)
+	REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)
 	la a2, _start
 	sub a1, a1, a2
 	add ra, ra, a1
diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index 88c3beabe9b4..a80b52a74f58 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -20,7 +20,7 @@ SYM_CODE_START(riscv_kexec_relocate)
 	 * s4: Pointer to the destination address for the relocation
 	 * s5: (const) Number of words per page
 	 * s6: (const) 1, used for subtraction
-	 * s7: (const) va_pa_offset, used when switching MMU off
+	 * s7: (const) kernel_map.va_pa_offset, used when switching MMU off
 	 * s8: (const) Physical address of the main loop
 	 * s9: (debug) indirection page counter
 	 * s10: (debug) entry counter
@@ -159,7 +159,7 @@ SYM_CODE_START(riscv_kexec_norelocate)
 	 * s0: (const) Phys address to jump to
 	 * s1: (const) Phys address of the FDT image
 	 * s2: (const) The hartid of the current hart
-	 * s3: (const) va_pa_offset, used when switching MMU off
+	 * s3: (const) kernel_map.va_pa_offset, used when switching MMU off
 	 */
 	mv	s0, a1
 	mv	s1, a2
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index cc048143fba5..3e39fd95e02b 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -188,6 +188,6 @@ machine_kexec(struct kimage *image)
 	/* Jump to the relocation code */
 	pr_notice("Bye...\n");
 	kexec_method(first_ind_entry, jump_addr, fdt_addr,
-		     this_hart_id, va_pa_offset);
+		     this_hart_id, kernel_map.va_pa_offset);
 	unreachable();
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3d77b04bec54..ed817016df2c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -30,10 +30,13 @@
 
 #include "../kernel/head.h"
 
-unsigned long kernel_virt_addr = KERNEL_LINK_ADDR;
-EXPORT_SYMBOL(kernel_virt_addr);
+struct kernel_mapping kernel_map __ro_after_init;
+EXPORT_SYMBOL(kernel_map);
+#ifdef CONFIG_XIP_KERNEL
+#define kernel_map	(*(struct kernel_mapping *)XIP_FIXUP(&kernel_map))
+#endif
+
 #ifdef CONFIG_XIP_KERNEL
-#define kernel_virt_addr       (*((unsigned long *)XIP_FIXUP(&kernel_virt_addr)))
 extern char _xiprom[], _exiprom[];
 #endif
 
@@ -211,25 +214,6 @@ static struct pt_alloc_ops _pt_ops __initdata;
 #define pt_ops _pt_ops
 #endif
 
-/* Offset between linear mapping virtual address and kernel load address */
-unsigned long va_pa_offset __ro_after_init;
-EXPORT_SYMBOL(va_pa_offset);
-#ifdef CONFIG_XIP_KERNEL
-#define va_pa_offset   (*((unsigned long *)XIP_FIXUP(&va_pa_offset)))
-#endif
-/* Offset between kernel mapping virtual address and kernel load address */
-#ifdef CONFIG_64BIT
-unsigned long va_kernel_pa_offset __ro_after_init;
-EXPORT_SYMBOL(va_kernel_pa_offset);
-#endif
-#ifdef CONFIG_XIP_KERNEL
-#define va_kernel_pa_offset    (*((unsigned long *)XIP_FIXUP(&va_kernel_pa_offset)))
-#endif
-unsigned long va_kernel_xip_pa_offset __ro_after_init;
-EXPORT_SYMBOL(va_kernel_xip_pa_offset);
-#ifdef CONFIG_XIP_KERNEL
-#define va_kernel_xip_pa_offset        (*((unsigned long *)XIP_FIXUP(&va_kernel_xip_pa_offset)))
-#endif
 unsigned long pfn_base __ro_after_init;
 EXPORT_SYMBOL(pfn_base);
 
@@ -345,7 +329,7 @@ static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
 
 static phys_addr_t __init alloc_pmd_early(uintptr_t va)
 {
-	BUG_ON((va - kernel_virt_addr) >> PGDIR_SHIFT);
+	BUG_ON((va - kernel_map.virt_addr) >> PGDIR_SHIFT);
 
 	return (uintptr_t)early_pmd;
 }
@@ -509,36 +493,24 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 #error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
 #endif
 
-static uintptr_t load_pa __initdata;
-uintptr_t load_sz;
-#ifdef CONFIG_XIP_KERNEL
-#define load_pa        (*((uintptr_t *)XIP_FIXUP(&load_pa)))
-#define load_sz        (*((uintptr_t *)XIP_FIXUP(&load_sz)))
-#endif
-
 #ifdef CONFIG_XIP_KERNEL
-static uintptr_t xiprom __initdata;
-static uintptr_t xiprom_sz __initdata;
-#define xiprom_sz      (*((uintptr_t *)XIP_FIXUP(&xiprom_sz)))
-#define xiprom         (*((uintptr_t *)XIP_FIXUP(&xiprom)))
-
 static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
 					    __always_unused bool early)
 {
 	uintptr_t va, end_va;
 
 	/* Map the flash resident part */
-	end_va = kernel_virt_addr + xiprom_sz;
-	for (va = kernel_virt_addr; va < end_va; va += map_size)
+	end_va = kernel_map.virt_addr + kernel_map.xiprom_sz;
+	for (va = kernel_map.virt_addr; va < end_va; va += map_size)
 		create_pgd_mapping(pgdir, va,
-				   xiprom + (va - kernel_virt_addr),
+				   kernel_map.xiprom + (va - kernel_map.virt_addr),
 				   map_size, PAGE_KERNEL_EXEC);
 
 	/* Map the data in RAM */
-	end_va = kernel_virt_addr + XIP_OFFSET + load_sz;
-	for (va = kernel_virt_addr + XIP_OFFSET; va < end_va; va += map_size)
+	end_va = kernel_map.virt_addr + XIP_OFFSET + kernel_map.size;
+	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += map_size)
 		create_pgd_mapping(pgdir, va,
-				   load_pa + (va - (kernel_virt_addr + XIP_OFFSET)),
+				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
 				   map_size, PAGE_KERNEL);
 }
 #else
@@ -546,10 +518,10 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size, bo
 {
 	uintptr_t va, end_va;
 
-	end_va = kernel_virt_addr + load_sz;
-	for (va = kernel_virt_addr; va < end_va; va += map_size)
+	end_va = kernel_map.virt_addr + kernel_map.size;
+	for (va = kernel_map.virt_addr; va < end_va; va += map_size)
 		create_pgd_mapping(pgdir, va,
-				   load_pa + (va - kernel_virt_addr),
+				   kernel_map.phys_addr + (va - kernel_map.virt_addr),
 				   map_size, early ? PAGE_KERNEL_EXEC : pgprot_from_va(va));
 }
 #endif
@@ -562,25 +534,27 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pmd_t fix_bmap_spmd, fix_bmap_epmd;
 #endif
 
+	kernel_map.virt_addr = KERNEL_LINK_ADDR;
+
 #ifdef CONFIG_XIP_KERNEL
-	xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
-	xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
+	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
+	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
-	load_pa = (uintptr_t)CONFIG_PHYS_RAM_BASE;
-	load_sz = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
+	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
+	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
 
-	va_kernel_xip_pa_offset = kernel_virt_addr - xiprom;
+	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
 #else
-	load_pa = (uintptr_t)(&_start);
-	load_sz = (uintptr_t)(&_end) - load_pa;
+	kernel_map.phys_addr = (uintptr_t)(&_start);
+	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
 #endif
 
-	va_pa_offset = PAGE_OFFSET - load_pa;
+	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
 #ifdef CONFIG_64BIT
-	va_kernel_pa_offset = kernel_virt_addr - load_pa;
+	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 #endif
 
-	pfn_base = PFN_DOWN(load_pa);
+	pfn_base = PFN_DOWN(kernel_map.phys_addr);
 
 	/*
 	 * Enforce boot alignment requirements of RV32 and
@@ -590,7 +564,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
-	BUG_ON((load_pa % map_size) != 0);
+	BUG_ON((kernel_map.phys_addr % map_size) != 0);
 
 	pt_ops.alloc_pte = alloc_pte_early;
 	pt_ops.get_pte_virt = get_pte_virt_early;
@@ -607,19 +581,19 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
 			   (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
 	/* Setup trampoline PGD and PMD */
-	create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
+	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
 			   (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
 #ifdef CONFIG_XIP_KERNEL
-	create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
-			   xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
+	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
+			   kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
 #else
-	create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
-			   load_pa, PMD_SIZE, PAGE_KERNEL_EXEC);
+	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
+			   kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
 #endif
 #else
 	/* Setup trampoline PGD */
-	create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
-			   load_pa, PGDIR_SIZE, PAGE_KERNEL_EXEC);
+	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
+			   kernel_map.phys_addr, PGDIR_SIZE, PAGE_KERNEL_EXEC);
 #endif
 
 	/*
diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index 35703d5ef5fd..e7fd0c253c7b 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -23,7 +23,7 @@ EXPORT_SYMBOL(__virt_to_phys);
 
 phys_addr_t __phys_addr_symbol(unsigned long x)
 {
-	unsigned long kernel_start = (unsigned long)kernel_virt_addr;
+	unsigned long kernel_start = kernel_map.virt_addr;
 	unsigned long kernel_end = (unsigned long)_end;
 
 	/*
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 0536ac84b730..ee4e5c1c39c5 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -379,7 +379,7 @@ static int __init ptdump_init(void)
 	address_markers[PAGE_OFFSET_NR].start_address = PAGE_OFFSET;
 #ifdef CONFIG_64BIT
 	address_markers[MODULES_MAPPING_NR].start_address = MODULES_VADDR;
-	address_markers[KERNEL_MAPPING_NR].start_address = kernel_virt_addr;
+	address_markers[KERNEL_MAPPING_NR].start_address = kernel_map.virt_addr;
 #endif
 
 	kernel_ptd_info.base_addr = KERN_VIRT_START;
-- 
2.30.2

