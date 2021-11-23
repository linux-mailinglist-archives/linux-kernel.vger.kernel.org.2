Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8DB4599E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhKWCAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232342AbhKWCAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:00:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34D1A61038;
        Tue, 23 Nov 2021 01:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637632656;
        bh=qDjQ99afxjGsn+nYQ6tdrOeVRsGDzyUxlcwsA2r2rN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyBW8KwkC3P/Pkr0s1K5J7ovchRYTSlB+Sae9dTyRAGL020LecZfFCv3rhIBuRe+i
         foALqnM2ZIGHhagFBIebC+GjYnl2ZmWONCPpHKA9HgsUUZ6xjzO9uGwW/UIJjyJeYW
         njwxqCkfDHYY9Y4QSr+gQUABkYRJ7SpZQxWnkmypUyzj9PNG7/M6vY8l2aA/DE2Hmu
         n8mpEcXVvgdNg8QOVohzAz1es8zXA86udcqrvLDaczl5zMDvV7aBfPnqowInWo6+kR
         2+az07Q5c+k7ZJkK3Uw43L9SA62T4y1cCJUpxIqHPSWVB17s7pI5BHYHVhpTScFXeR
         +MuG/9LjN2gsA==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, palmer@dabbelt.com,
        atishp@rivosinc.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH 1/3] riscv: Remove 2MB offset in the mm layout
Date:   Tue, 23 Nov 2021 09:57:15 +0800
Message-Id: <20211123015717.542631-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123015717.542631-1-guoren@kernel.org>
References: <20211123015717.542631-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The current RISC-V's mm layout is based on a 2MB offset and wasting
memory. Remove 2MB offset and map PAGE_OFFSET at start_of_DRAM.
Then we could reduce the memory reserved for opensbi in the next
patch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/page.h   |  8 ++++++++
 arch/riscv/kernel/head.S        | 10 +++-------
 arch/riscv/kernel/vmlinux.lds.S |  5 ++---
 arch/riscv/mm/init.c            | 11 ++++++++---
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index b3e5ff0125fe..299147c78b4a 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -16,6 +16,14 @@
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE - 1))
 
+#if __riscv_xlen == 64
+/* Image load offset(2MB) from start of RAM */
+#define LOAD_OFFSET	0x200000
+#else
+/* Image load offset(4MB) from start of RAM */
+#define LOAD_OFFSET	0x400000
+#endif
+
 #ifdef CONFIG_64BIT
 #define HUGE_MAX_HSTATE		2
 #else
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f52f01ecbeea..a6ac892d2ccf 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -61,13 +61,7 @@ ENTRY(_start)
 	/* Image load offset (0MB) from start of RAM for M-mode */
 	.dword 0
 #else
-#if __riscv_xlen == 64
-	/* Image load offset(2MB) from start of RAM */
-	.dword 0x200000
-#else
-	/* Image load offset(4MB) from start of RAM */
-	.dword 0x400000
-#endif
+	.dword LOAD_OFFSET
 #endif
 	/* Effective size of kernel image */
 	.dword _end - _start
@@ -94,6 +88,8 @@ relocate:
 	la a1, kernel_map
 	XIP_FIXUP_OFFSET a1
 	REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)
+	li a2, LOAD_OFFSET
+	add a1, a1, a2
 	la a2, _start
 	sub a1, a1, a2
 	add ra, ra, a1
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 5104f3a871e3..75b7c72cd4bd 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -11,10 +11,9 @@
 #else
 
 #include <asm/pgtable.h>
-#define LOAD_OFFSET KERNEL_LINK_ADDR
 
-#include <asm/vmlinux.lds.h>
 #include <asm/page.h>
+#include <asm/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/set_memory.h>
@@ -32,7 +31,7 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 SECTIONS
 {
 	/* Beginning of code and text segment */
-	. = LOAD_OFFSET;
+	. = LOAD_OFFSET + KERNEL_LINK_ADDR;
 	_start = .;
 	HEAD_TEXT_SECTION
 	. = ALIGN(PAGE_SIZE);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 24b2b8044602..920e78f8c3e4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -221,6 +221,11 @@ static void __init setup_bootmem(void)
 	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
 		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
 
+	/*
+	 * Reserve OpenSBI region and depends on PMP to deny accesses.
+	 */
+	memblock_reserve(__pa(PAGE_OFFSET), LOAD_OFFSET);
+
 	early_init_fdt_scan_reserved_mem();
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
@@ -604,7 +609,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
 #else
-	kernel_map.phys_addr = (uintptr_t)(&_start);
+	kernel_map.phys_addr = (uintptr_t)(&_start) - LOAD_OFFSET;
 	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
 #endif
 	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
@@ -645,8 +650,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
 			   kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
 #else
-	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
-			   kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
+	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr + LOAD_OFFSET,
+			   kernel_map.phys_addr + LOAD_OFFSET, PMD_SIZE, PAGE_KERNEL_EXEC);
 #endif
 #else
 	/* Setup trampoline PGD */
-- 
2.25.1

