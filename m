Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8836D5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbhD1KVp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Apr 2021 06:21:45 -0400
Received: from mx1.emlix.com ([136.243.223.33]:33612 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239308AbhD1KVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:21:39 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 0A5305FB56;
        Wed, 28 Apr 2021 12:20:53 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove argument from mem_init_print_info()
Date:   Wed, 28 Apr 2021 12:20:51 +0200
Message-ID: <1846777.ZUqDs8pn68@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers passed NULL there, and I have not found anything in git history that
shows this has been any different in the last 15 years.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 arch/alpha/mm/init.c             |  2 +-
 arch/arc/mm/init.c               |  2 +-
 arch/arm/mm/init.c               |  2 +-
 arch/arm64/mm/init.c             |  2 +-
 arch/csky/mm/init.c              |  2 +-
 arch/h8300/mm/init.c             |  2 +-
 arch/hexagon/mm/init.c           |  2 +-
 arch/ia64/mm/init.c              |  2 +-
 arch/m68k/mm/init.c              |  2 +-
 arch/microblaze/mm/init.c        |  2 +-
 arch/mips/loongson64/numa.c      |  2 +-
 arch/mips/mm/init.c              |  2 +-
 arch/mips/sgi-ip27/ip27-memory.c |  2 +-
 arch/nds32/mm/init.c             |  2 +-
 arch/nios2/mm/init.c             |  2 +-
 arch/openrisc/mm/init.c          |  2 +-
 arch/parisc/mm/init.c            |  2 +-
 arch/powerpc/mm/mem.c            |  2 +-
 arch/riscv/mm/init.c             |  2 +-
 arch/s390/mm/init.c              |  2 +-
 arch/sh/mm/init.c                |  2 +-
 arch/sparc/mm/init_32.c          |  2 +-
 arch/sparc/mm/init_64.c          |  2 +-
 arch/um/kernel/mem.c             |  2 +-
 arch/x86/mm/init_32.c            |  2 +-
 arch/x86/mm/init_64.c            |  2 +-
 arch/xtensa/mm/init.c            |  2 +-
 include/linux/mm.h               |  2 +-
 mm/page_alloc.c                  | 10 +++++-----
 29 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 3c42b3147fd6..1eacd9527a36 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -282,5 +282,5 @@ mem_init(void)
 	set_max_mapnr(max_low_pfn);
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 	memblock_free_all();
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index ce07e697916c..3bd7dff98da7 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -194,7 +194,7 @@ void __init mem_init(void)
 {
 	memblock_free_all();
 	highmem_init();
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
 
 #ifdef CONFIG_HIGHMEM
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 828a2561b229..f2bf4b0de362 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -316,7 +316,7 @@ void __init mem_init(void)
 
 	free_highpages();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3685e12aba9b..d7e05ee08b2e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -491,7 +491,7 @@ void __init mem_init(void)
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index 894050a8ce09..a9399e07b65f 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -107,7 +107,7 @@ void __init mem_init(void)
 			free_highmem_page(page);
 	}
 #endif
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
 
 void free_initmem(void)
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 1f3b345d68b9..4d3645d42c56 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -99,5 +99,5 @@ void __init mem_init(void)
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index f2e6c868e477..ce5a15671649 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -55,7 +55,7 @@ void __init mem_init(void)
 {
 	/*  No idea where this is actually declared.  Seems to evade LXR.  */
 	memblock_free_all();
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 	/*
 	 *  To-Do:  someone somewhere should wipe out the bootmem map
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 16d0d7d22657..1568c331cd8a 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -659,7 +659,7 @@ mem_init (void)
 	set_max_mapnr(max_low_pfn);
 	high_memory = __va(max_low_pfn * PAGE_SIZE);
 	memblock_free_all();
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 	/*
 	 * For fsyscall entrpoints with no light-weight handler, use the ordinary
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 14c1e541451c..9254df8bd83e 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -153,5 +153,5 @@ void __init mem_init(void)
 	/* this will put all memory onto the freelists */
 	memblock_free_all();
 	init_pointer_tables();
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 181e48782e6c..02510f567a4f 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -131,7 +131,7 @@ void __init mem_init(void)
 	highmem_setup();
 #endif
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 	mem_init_done = 1;
 }
 
diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index a8f57bf01285..6d84b2581526 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -167,7 +167,7 @@ void __init mem_init(void)
 	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
 	memblock_free_all();
 	setup_zero_pages();	/* This comes from node 0 */
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
 
 /* All PCI device belongs to logical Node-0 */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 5cb73bf74a8b..9f79fe628b6f 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -467,7 +467,7 @@ void __init mem_init(void)
 	memblock_free_all();
 	setup_zero_pages();	/* Setup zeroed pages.  */
 	mem_init_free_highmem();
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 #ifdef CONFIG_64BIT
 	if ((unsigned long) &_text > (unsigned long) CKSEG0)
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 87bb6945ec25..c1eefc01ee6e 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -420,5 +420,5 @@ void __init mem_init(void)
 	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
 	memblock_free_all();
 	setup_zero_pages();	/* This comes from node 0 */
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index fa86f7b2f416..310f7d320fa5 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -191,7 +191,7 @@ void __init mem_init(void)
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 	pr_info("virtual kernel memory layout:\n"
 		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 61862dbb0e32..e5109560fc9a 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -71,7 +71,7 @@ void __init mem_init(void)
 
 	/* this will put all memory onto the freelists */
 	memblock_free_all();
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
 
 void __init mmu_init(void)
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index bf9b2310fc93..f31a86d39fb8 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -211,7 +211,7 @@ void __init mem_init(void)
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 	printk("mem_init_done ...........................................\n");
 	mem_init_done = 1;
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 9ca4e4ff6895..3fb2c28729e9 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -573,7 +573,7 @@ void __init mem_init(void)
 #endif
 		parisc_vmalloc_start = SET_MAP_OFFSET(MAP_START);
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 #if 0
 	/*
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 4e8ce6d85232..f121158a23fc 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -312,7 +312,7 @@ void __init mem_init(void)
 		(mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) - 1;
 #endif
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 #ifdef CONFIG_PPC32
 	pr_info("Kernel virtual memory layout:\n");
 #ifdef CONFIG_KASAN
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 067583ab1bd7..a0488829efd6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -102,7 +102,7 @@ void __init mem_init(void)
 	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
 	memblock_free_all();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 	print_vm_layout();
 }
 
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 0e76b2127dc6..4c85d4bae2f7 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -210,7 +210,7 @@ void __init mem_init(void)
 
 	cmma_init_nodat();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
 
 void free_initmem(void)
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 0db6919af8d3..e3a12ef6e281 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -359,7 +359,7 @@ void __init mem_init(void)
 
 	vsyscall_init();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 	pr_info("virtual kernel memory layout:\n"
 		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
 		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 6139c5700ccc..290bd8f3180b 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -293,7 +293,7 @@ void __init mem_init(void)
 		map_high_region(start_pfn, end_pfn);
 	}
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
 
 void sparc_flush_page_to_ram(struct page *page)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 182bb7bdaa0a..57a2e4801d24 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2520,7 +2520,7 @@ void __init mem_init(void)
 	}
 	mark_page_reserved(mem_map_zero);
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 	if (tlb_type == cheetah || tlb_type == cheetah_plus)
 		cheetah_ecache_flush_init();
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 9242dc91d751..ab8fcd1c4c52 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -54,7 +54,7 @@ void __init mem_init(void)
 	memblock_free_all();
 	max_low_pfn = totalram_pages();
 	max_pfn = max_low_pfn;
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 	kmalloc_ok = 1;
 }
 
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index da31c2635ee4..892ed7b1f446 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -755,7 +755,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 55247451ba85..aff5e8588896 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1307,7 +1307,7 @@ void __init mem_init(void)
 
 	preallocate_vmalloc_pages();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 2daeba9e454e..0c9d31b759a9 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -119,7 +119,7 @@ void __init mem_init(void)
 
 	memblock_free_all();
 
-	mem_init_print_info(NULL);
+	mem_init_print_info();
 	pr_info("virtual kernel memory layout:\n"
 #ifdef CONFIG_KASAN
 		"    kasan   : 0x%08lx - 0x%08lx  (%5lu MB)\n"
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 06094627f1c1..b42964e5cb1a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2357,7 +2357,7 @@ extern unsigned long free_reserved_area(void *start, void *end,
 					int poison, const char *s);
 
 extern void adjust_managed_page_count(struct page *page, long count);
-extern void mem_init_print_info(const char *str);
+extern void mem_init_print_info(void);
 
 extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e2f19bf948db..2c2f4c6e399b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7689,7 +7689,7 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 	return pages;
 }
 
-void __init mem_init_print_info(const char *str)
+void __init mem_init_print_info(void)
 {
 	unsigned long physpages, codesize, datasize, rosize, bss_size;
 	unsigned long init_code_size, init_data_size;
@@ -7728,17 +7728,17 @@ void __init mem_init_print_info(const char *str)
 #ifdef	CONFIG_HIGHMEM
 		", %luK highmem"
 #endif
-		"%s%s)\n",
+		")\n",
 		nr_free_pages() << (PAGE_SHIFT - 10),
 		physpages << (PAGE_SHIFT - 10),
 		codesize >> 10, datasize >> 10, rosize >> 10,
 		(init_data_size + init_code_size) >> 10, bss_size >> 10,
 		(physpages - totalram_pages() - totalcma_pages) << (PAGE_SHIFT - 10),
-		totalcma_pages << (PAGE_SHIFT - 10),
+		totalcma_pages << (PAGE_SHIFT - 10)
 #ifdef	CONFIG_HIGHMEM
-		totalhigh_pages() << (PAGE_SHIFT - 10),
+		, totalhigh_pages() << (PAGE_SHIFT - 10)
 #endif
-		str ? ", " : "", str ? str : "");
+		);
 }
 
 /**
-- 
2.31.1


-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


