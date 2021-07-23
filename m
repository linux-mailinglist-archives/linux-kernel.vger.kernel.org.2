Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FD33D3AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhGWMWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:22:05 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:55557 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhGWMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:22:04 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D7D33100005;
        Fri, 23 Jul 2021 13:02:34 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 1/5] riscv: Introduce va_kernel_pa_offset for 32-bit kernel
Date:   Fri, 23 Jul 2021 15:01:24 +0200
Message-Id: <20210723130128.47664-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723130128.47664-1-alex@ghiti.fr>
References: <20210723130128.47664-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

va_kernel_pa_offset was only used for 64-bit as the kernel mapping lies
in the linear mapping for 32-bit kernel and then only the offset between
the PAGE_OFFSET and the kernel load address is needed.

But this distinction complexifies the code with #ifdefs and especially
with a separate definition of the address conversions macros.

Simplify the code by defining this variable for both 32-bit and 64-bit.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/include/asm/page.h | 15 ++-------------
 arch/riscv/mm/init.c          |  3 ---
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 10dc063868f6..adf5b4671684 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -91,10 +91,8 @@ struct kernel_mapping {
 	uintptr_t size;
 	/* Offset between linear mapping virtual address and kernel load address */
 	unsigned long va_pa_offset;
-#ifdef CONFIG_64BIT
 	/* Offset between kernel mapping virtual address and kernel load address */
 	unsigned long va_kernel_pa_offset;
-#endif
 	unsigned long va_kernel_xip_pa_offset;
 #ifdef CONFIG_XIP_KERNEL
 	uintptr_t xiprom;
@@ -105,11 +103,11 @@ struct kernel_mapping {
 extern struct kernel_mapping kernel_map;
 extern phys_addr_t phys_ram_base;
 
-#ifdef CONFIG_64BIT
 #define is_kernel_mapping(x)	\
 	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
+
 #define is_linear_mapping(x)	\
-	((x) >= PAGE_OFFSET && (x) < kernel_map.virt_addr)
+	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < kernel_map.virt_addr))
 
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
 #define kernel_mapping_pa_to_va(y)	({						\
@@ -133,15 +131,6 @@ extern phys_addr_t phys_ram_base;
 	is_linear_mapping(_x) ?							\
 		linear_mapping_va_to_pa(_x) : kernel_mapping_va_to_pa(_x);	\
 	})
-#else
-#define is_kernel_mapping(x)	\
-	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
-#define is_linear_mapping(x)	\
-	((x) >= PAGE_OFFSET)
-
-#define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + kernel_map.va_pa_offset))
-#define __va_to_pa_nodebug(x)  ((unsigned long)(x) - kernel_map.va_pa_offset)
-#endif /* CONFIG_64BIT */
 
 #ifdef CONFIG_DEBUG_VIRTUAL
 extern phys_addr_t __virt_to_phys(unsigned long x);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4ebe7e19c2b8..9668867e2702 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -559,11 +559,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.phys_addr = (uintptr_t)(&_start);
 	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
 #endif
-
 	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
-#ifdef CONFIG_64BIT
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
-#endif
 
 	pfn_base = PFN_DOWN(kernel_map.phys_addr);
 
-- 
2.30.2

