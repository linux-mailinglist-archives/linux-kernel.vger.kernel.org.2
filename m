Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB313AFF30
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhFVI0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:26:02 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40893 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFVI0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:26:00 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A2544FF813;
        Tue, 22 Jun 2021 08:23:41 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v7 2/2] riscv: Map the kernel with correct permissions the first time
Date:   Tue, 22 Jun 2021 10:21:34 +0200
Message-Id: <20210622082134.2404162-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210622082134.2404162-1-alex@ghiti.fr>
References: <20210622082134.2404162-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 64-bit kernels, we map all the kernel with write and execute
permissions and afterwards remove writability from text and executability
from data.

For 32-bit kernels, the kernel mapping resides in the linear mapping, so we
map all the linear mapping as writable and executable and afterwards we
remove those properties for unused memory and kernel mapping as
described above.

Change this behavior to directly map the kernel with correct permissions
and avoid going through the whole mapping to fix the permissions.

At the same time, this fixes an issue introduced by commit 2bfc6cd81bd1
("riscv: Move kernel mapping outside of linear mapping") as reported
here https://github.com/starfive-tech/linux/issues/17.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/page.h       |  13 +++-
 arch/riscv/include/asm/sections.h   |  17 +++++
 arch/riscv/include/asm/set_memory.h |   8 --
 arch/riscv/kernel/setup.c           |  12 +--
 arch/riscv/mm/init.c                | 112 ++++++++++++----------------
 5 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index a1b888f77d57..1c2010c292b3 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -87,6 +87,7 @@ extern unsigned long va_kernel_pa_offset;
 extern unsigned long va_kernel_xip_pa_offset;
 #endif
 extern unsigned long pfn_base;
+extern uintptr_t load_sz;
 #define ARCH_PFN_OFFSET		(pfn_base)
 #else
 #define va_pa_offset		0
@@ -99,6 +100,11 @@ extern unsigned long pfn_base;
 extern unsigned long kernel_virt_addr;
 
 #ifdef CONFIG_64BIT
+#define is_kernel_mapping(x)	\
+	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
+#define is_linear_mapping(x)	\
+	((x) >= PAGE_OFFSET && (x) < kernel_virt_addr)
+
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
 #ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_pa_to_va(y)	({						\
@@ -125,10 +131,15 @@ extern unsigned long kernel_virt_addr;
 #endif
 #define __va_to_pa_nodebug(x)	({						\
 	unsigned long _x = x;							\
-	(_x < kernel_virt_addr) ?						\
+	is_linear_mapping(_x) ?							\
 		linear_mapping_va_to_pa(_x) : kernel_mapping_va_to_pa(_x);	\
 	})
 #else
+#define is_kernel_mapping(x)	\
+	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
+#define is_linear_mapping(x)	\
+	((x) >= PAGE_OFFSET)
+
 #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
 #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
 #endif
diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
index 8a303fb1ee3b..32336e8a17cb 100644
--- a/arch/riscv/include/asm/sections.h
+++ b/arch/riscv/include/asm/sections.h
@@ -6,6 +6,7 @@
 #define __ASM_SECTIONS_H
 
 #include <asm-generic/sections.h>
+#include <linux/mm.h>
 
 extern char _start[];
 extern char _start_kernel[];
@@ -13,4 +14,20 @@ extern char __init_data_begin[], __init_data_end[];
 extern char __init_text_begin[], __init_text_end[];
 extern char __alt_start[], __alt_end[];
 
+static inline bool is_va_kernel_text(uintptr_t va)
+{
+	uintptr_t start = (uintptr_t)_start;
+	uintptr_t end = (uintptr_t)__init_data_begin;
+
+	return va >= start && va < end;
+}
+
+static inline bool is_va_kernel_lm_alias_text(uintptr_t va)
+{
+	uintptr_t start = (uintptr_t)lm_alias(_start);
+	uintptr_t end = (uintptr_t)lm_alias(__init_data_begin);
+
+	return va >= start && va < end;
+}
+
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 4f9fc54d1806..01da17e3044f 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -18,13 +18,11 @@ int set_memory_nx(unsigned long addr, int numpages);
 int set_memory_rw_nx(unsigned long addr, int numpages);
 int set_kernel_memory(char *start, char *end,
 		      int (*set_memory)(unsigned long start, int num_pages));
-void protect_kernel_text_data(void);
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
-static inline void protect_kernel_text_data(void) {}
 static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
 static inline int set_kernel_memory(char *start, char *end,
 				    int (*set_memory)(unsigned long start,
@@ -34,12 +32,6 @@ static inline int set_kernel_memory(char *start, char *end,
 }
 #endif
 
-#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
-void __init protect_kernel_linear_mapping_text_rodata(void);
-#else
-static inline void protect_kernel_linear_mapping_text_rodata(void) {}
-#endif
-
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 bool kernel_page_present(struct page *page);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 5c6d2a1fdbc7..b0c6f372a9ec 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -289,11 +289,6 @@ void __init setup_arch(char **cmdline_p)
 	init_resources();
 	sbi_init();
 
-	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
-		protect_kernel_text_data();
-		protect_kernel_linear_mapping_text_rodata();
-	}
-
 #ifdef CONFIG_KASAN
 	kasan_init();
 #endif
@@ -328,11 +323,10 @@ subsys_initcall(topology_init);
 
 void free_initmem(void)
 {
-	unsigned long init_begin = (unsigned long)__init_begin;
-	unsigned long init_end = (unsigned long)__init_end;
-
 	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
-		set_memory_rw_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
+		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
+				  IS_ENABLED(CONFIG_64BIT) ?
+					set_memory_rw : set_memory_rw_nx);
 
 	free_initmem_default(POISON_FREE_INITMEM);
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b3fd235ddbb6..12f956b3a674 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -455,6 +455,43 @@ asmlinkage void __init __copy_data(void)
 }
 #endif
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+static __init pgprot_t pgprot_from_va(uintptr_t va)
+{
+	if (is_va_kernel_text(va))
+		return PAGE_KERNEL_READ_EXEC;
+
+	/*
+	 * In 64-bit kernel, the kernel mapping is outside the linear mapping so
+	 * we must protect its linear mapping alias from being executed and
+	 * written.
+	 * And rodata section is marked readonly in mark_rodata_ro.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT) && is_va_kernel_lm_alias_text(va))
+		return PAGE_KERNEL_READ;
+
+	return PAGE_KERNEL;
+}
+
+void mark_rodata_ro(void)
+{
+	set_kernel_memory(__start_rodata, _data, set_memory_ro);
+	if (IS_ENABLED(CONFIG_64BIT))
+		set_kernel_memory(lm_alias(__start_rodata), lm_alias(_data),
+				  set_memory_ro);
+
+	debug_checkwx();
+}
+#else
+static __init pgprot_t pgprot_from_va(uintptr_t va)
+{
+	if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
+		return PAGE_KERNEL;
+
+	return PAGE_KERNEL_EXEC;
+}
+#endif /* CONFIG_STRICT_KERNEL_RWX */
+
 /*
  * setup_vm() is called from head.S with MMU-off.
  *
@@ -474,7 +511,7 @@ asmlinkage void __init __copy_data(void)
 #endif
 
 static uintptr_t load_pa __initdata;
-static uintptr_t load_sz __initdata;
+uintptr_t load_sz;
 #ifdef CONFIG_XIP_KERNEL
 #define load_pa        (*((uintptr_t *)XIP_FIXUP(&load_pa)))
 #define load_sz        (*((uintptr_t *)XIP_FIXUP(&load_sz)))
@@ -486,7 +523,8 @@ static uintptr_t xiprom_sz __initdata;
 #define xiprom_sz      (*((uintptr_t *)XIP_FIXUP(&xiprom_sz)))
 #define xiprom         (*((uintptr_t *)XIP_FIXUP(&xiprom)))
 
-static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
+static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
+					    __always_unused bool early)
 {
 	uintptr_t va, end_va;
 
@@ -505,7 +543,8 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
 				   map_size, PAGE_KERNEL);
 }
 #else
-static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
+static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
+					    bool early)
 {
 	uintptr_t va, end_va;
 
@@ -513,7 +552,9 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
 	for (va = kernel_virt_addr; va < end_va; va += map_size)
 		create_pgd_mapping(pgdir, va,
 				   load_pa + (va - kernel_virt_addr),
-				   map_size, PAGE_KERNEL_EXEC);
+				   map_size,
+				   early ?
+					PAGE_KERNEL_EXEC : pgprot_from_va(va));
 }
 #endif
 
@@ -590,7 +631,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 * us to reach paging_init(). We map all memory banks later
 	 * in setup_vm_final() below.
 	 */
-	create_kernel_page_table(early_pg_dir, map_size);
+	create_kernel_page_table(early_pg_dir, map_size, true);
 
 #ifndef __PAGETABLE_PMD_FOLDED
 	/* Setup early PMD for DTB */
@@ -666,22 +707,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 }
 
-#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
-void __init protect_kernel_linear_mapping_text_rodata(void)
-{
-	unsigned long text_start = (unsigned long)lm_alias(_start);
-	unsigned long init_text_start = (unsigned long)lm_alias(__init_text_begin);
-	unsigned long rodata_start = (unsigned long)lm_alias(__start_rodata);
-	unsigned long data_start = (unsigned long)lm_alias(_data);
-
-	set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
-	set_memory_nx(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
-
-	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
-	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
-}
-#endif
-
 static void __init setup_vm_final(void)
 {
 	uintptr_t va, map_size;
@@ -714,21 +739,15 @@ static void __init setup_vm_final(void)
 		map_size = best_map_size(start, end - start);
 		for (pa = start; pa < end; pa += map_size) {
 			va = (uintptr_t)__va(pa);
-			create_pgd_mapping(swapper_pg_dir, va, pa,
-					   map_size,
-#ifdef CONFIG_64BIT
-					   PAGE_KERNEL
-#else
-					   PAGE_KERNEL_EXEC
-#endif
-					);
 
+			create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
+					   pgprot_from_va(va));
 		}
 	}
 
 #ifdef CONFIG_64BIT
 	/* Map the kernel */
-	create_kernel_page_table(swapper_pg_dir, PMD_SIZE);
+	create_kernel_page_table(swapper_pg_dir, PMD_SIZE, false);
 #endif
 
 	/* Clear fixmap PTE and PMD mappings */
@@ -759,39 +778,6 @@ static inline void setup_vm_final(void)
 }
 #endif /* CONFIG_MMU */
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
-void __init protect_kernel_text_data(void)
-{
-	unsigned long text_start = (unsigned long)_start;
-	unsigned long init_text_start = (unsigned long)__init_text_begin;
-	unsigned long init_data_start = (unsigned long)__init_data_begin;
-	unsigned long rodata_start = (unsigned long)__start_rodata;
-	unsigned long data_start = (unsigned long)_data;
-#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
-	unsigned long end_va = kernel_virt_addr + load_sz;
-#else
-	unsigned long end_va = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
-#endif
-
-	set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
-	set_memory_ro(init_text_start, (init_data_start - init_text_start) >> PAGE_SHIFT);
-	set_memory_nx(init_data_start, (rodata_start - init_data_start) >> PAGE_SHIFT);
-	/* rodata section is marked readonly in mark_rodata_ro */
-	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
-	set_memory_nx(data_start, (end_va - data_start) >> PAGE_SHIFT);
-}
-
-void mark_rodata_ro(void)
-{
-	unsigned long rodata_start = (unsigned long)__start_rodata;
-	unsigned long data_start = (unsigned long)_data;
-
-	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
-
-	debug_checkwx();
-}
-#endif
-
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
-- 
2.30.2

