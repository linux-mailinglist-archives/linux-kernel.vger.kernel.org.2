Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A339B649
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFDJ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:59:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4554 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFDJ70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:59:26 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FxJ8y5zHqzBCh9;
        Fri,  4 Jun 2021 11:57:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cjOOqixGj5JY; Fri,  4 Jun 2021 11:57:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FxJ8y55mYz9ryy;
        Fri,  4 Jun 2021 11:57:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A914B8B876;
        Fri,  4 Jun 2021 11:57:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3dMIB7lb-7uV; Fri,  4 Jun 2021 11:57:37 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 266718B86A;
        Fri,  4 Jun 2021 11:57:37 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DEDE264BDD; Fri,  4 Jun 2021 09:57:36 +0000 (UTC)
Message-Id: <9fa9ba6807c17f93f35a582c199c646c4a8bfd9c.1622800638.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Remove klimit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        wangkefeng.wang@huawei.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  4 Jun 2021 09:57:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

klimit is a global variable initialised at build time with the
value of _end.

This variable is never modified, so _end symbol can be used directly.

Remove klimit.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/include/asm/setup.h             | 1 -
 arch/powerpc/kernel/head_book3s_32.S         | 6 ++----
 arch/powerpc/kernel/prom.c                   | 2 +-
 arch/powerpc/kernel/setup-common.c           | 4 +---
 arch/powerpc/platforms/powermac/bootx_init.c | 2 +-
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index e89bfebd4e00..6c1a7d217d1a 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -10,7 +10,6 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
 extern unsigned int rtas_data;
 extern unsigned long long memory_limit;
 extern bool init_mem_is_free;
-extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 struct device_node;
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 326262030279..b724e88bcdaf 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -766,9 +766,6 @@ PerformanceMonitor:
  * the kernel image to physical address PHYSICAL_START.
  */
 relocate_kernel:
-	addis	r9,r26,klimit@ha	/* fetch klimit */
-	lwz	r25,klimit@l(r9)
-	addis	r25,r25,-KERNELBASE@h
 	lis	r3,PHYSICAL_START@h	/* Destination base address */
 	li	r6,0			/* Destination offset */
 	li	r5,0x4000		/* # bytes of memory to copy */
@@ -776,7 +773,8 @@ relocate_kernel:
 	addi	r0,r3,4f@l		/* jump to the address of 4f */
 	mtctr	r0			/* in copy and do the rest. */
 	bctr				/* jump to the copy */
-4:	mr	r5,r25
+4:	lis	r5,_end-KERNELBASE@h
+	ori	r5,r5,_end-KERNELBASE@l
 	bl	copy_and_flush		/* copy the rest */
 	b	turn_on_mmu
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fbe9deebc8e1..f620e04dc9bf 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -758,7 +758,7 @@ void __init early_init_devtree(void *params)
 		first_memblock_size = min_t(u64, first_memblock_size, memory_limit);
 	setup_initial_memory_limit(memstart_addr, first_memblock_size);
 	/* Reserve MEMBLOCK regions used by kernel, initrd, dt, etc... */
-	memblock_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
+	memblock_reserve(PHYSICAL_START, __pa(_end) - PHYSICAL_START);
 	/* If relocatable, reserve first 32k for interrupt vectors etc. */
 	if (PHYSICAL_START > MEMORY_START)
 		memblock_reserve(MEMORY_START, 0x8000);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 74a98fff2c2f..138bb7f49ef9 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -91,8 +91,6 @@ EXPORT_SYMBOL_GPL(boot_cpuid);
 int dcache_bsize;
 int icache_bsize;
 
-unsigned long klimit = (unsigned long) _end;
-
 /*
  * This still seems to be needed... -- paulus
  */ 
@@ -930,7 +928,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
-	init_mm.brk = klimit;
+	init_mm.brk = (unsigned long)_end;
 
 	mm_iommu_init(&init_mm);
 	irqstack_early_init();
diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index 9d4ecd292255..d20ef35e6d9d 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -433,7 +433,7 @@ static void __init btext_welcome(boot_infos_t *bi)
 	bootx_printf("\nframe buffer at  : 0x%x", bi->dispDeviceBase);
 	bootx_printf(" (phys), 0x%x", bi->logicalDisplayBase);
 	bootx_printf(" (log)");
-	bootx_printf("\nklimit           : 0x%x",(unsigned long)klimit);
+	bootx_printf("\nklimit           : 0x%x",(unsigned long)_end);
 	bootx_printf("\nboot_info at     : 0x%x", bi);
 	__asm__ __volatile__ ("mfmsr %0" : "=r" (flags));
 	bootx_printf("\nMSR              : 0x%x", flags);
-- 
2.25.0

