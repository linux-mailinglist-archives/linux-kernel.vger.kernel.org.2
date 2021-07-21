Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC77A3D0A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhGUHVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:21:09 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60763 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbhGUHUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:20:17 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 02675E0005;
        Wed, 21 Jul 2021 08:00:44 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH -fixes 1/3] riscv: Get rid of CONFIG_PHYS_RAM_BASE in kernel physical address conversion
Date:   Wed, 21 Jul 2021 09:59:35 +0200
Message-Id: <20210721075937.696811-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721075937.696811-1-alex@ghiti.fr>
References: <20210721075937.696811-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of CONFIG_PHYS_RAM_BASE for all kernel types was a mistake:
this value is implementation-specific and this breaks the genericity of
the RISC-V kernel.

Fix this by introducing a new variable phys_ram_base that holds this
value at runtime and use it in the kernel physical address conversion
macro. Since this value is used only for XIP kernels, evaluate it only if
CONFIG_XIP_KERNEL is set which in addition optimizes this macro for
standard kernels at compile-time.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/include/asm/page.h |  7 ++++---
 arch/riscv/mm/init.c          | 17 ++++++++++++-----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index cca8764aed83..b0ca5058e7ae 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -103,6 +103,7 @@ struct kernel_mapping {
 };
 
 extern struct kernel_mapping kernel_map;
+extern phys_addr_t phys_ram_base;
 
 #ifdef CONFIG_64BIT
 #define is_kernel_mapping(x)	\
@@ -113,9 +114,9 @@ extern struct kernel_mapping kernel_map;
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
 #define kernel_mapping_pa_to_va(y)	({						\
 	unsigned long _y = y;								\
-	(_y >= CONFIG_PHYS_RAM_BASE) ?							\
-		(void *)((unsigned long)(_y) + kernel_map.va_kernel_pa_offset + XIP_OFFSET) :	\
-		(void *)((unsigned long)(_y) + kernel_map.va_kernel_xip_pa_offset);		\
+	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?					\
+		(void *)((unsigned long)(_y) + kernel_map.va_kernel_xip_pa_offset) :		\
+		(void *)((unsigned long)(_y) + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
 	})
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 269fc648ef3d..4ebe7e19c2b8 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -36,6 +36,9 @@ EXPORT_SYMBOL(kernel_map);
 #define kernel_map	(*(struct kernel_mapping *)XIP_FIXUP(&kernel_map))
 #endif
 
+phys_addr_t phys_ram_base __ro_after_init;
+EXPORT_SYMBOL(phys_ram_base);
+
 #ifdef CONFIG_XIP_KERNEL
 extern char _xiprom[], _exiprom[];
 #endif
@@ -153,7 +156,7 @@ static void __init setup_bootmem(void)
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
 	phys_addr_t max_mapped_addr = __pa(~(ulong)0);
-	phys_addr_t dram_end;
+	phys_addr_t phys_ram_end;
 
 #ifdef CONFIG_XIP_KERNEL
 	vmlinux_start = __pa_symbol(&_sdata);
@@ -174,18 +177,21 @@ static void __init setup_bootmem(void)
 #endif
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
-	dram_end = memblock_end_of_DRAM();
+#ifndef CONFIG_XIP_KERNEL
+	phys_ram_base = memblock_start_of_DRAM();
+#endif
+	phys_ram_end = memblock_end_of_DRAM();
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
 	 * the addressable memory can not be mapped because of IS_ERR_VALUE
 	 * macro. Make sure that last 4k bytes are not usable by memblock
 	 * if end of dram is equal to maximum addressable memory.
 	 */
-	if (max_mapped_addr == (dram_end - 1))
+	if (max_mapped_addr == (phys_ram_end - 1))
 		memblock_set_current_limit(max_mapped_addr - 4096);
 
-	min_low_pfn = PFN_UP(memblock_start_of_DRAM());
-	max_low_pfn = max_pfn = PFN_DOWN(dram_end);
+	min_low_pfn = PFN_UP(phys_ram_base);
+	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
 
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
 	set_max_mapnr(max_low_pfn - ARCH_PFN_OFFSET);
@@ -544,6 +550,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
+	phys_ram_base = CONFIG_PHYS_RAM_BASE;
 	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
 	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
 
-- 
2.30.2

