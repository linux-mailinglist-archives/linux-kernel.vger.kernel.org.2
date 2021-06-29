Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551F13B6FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhF2JSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:18:35 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37565 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhF2JSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:18:32 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 76C7E200012;
        Tue, 29 Jun 2021 09:16:02 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 3/3] riscv: Make sure the kernel mapping does not overlap with IS_ERR_VALUE
Date:   Tue, 29 Jun 2021 11:13:48 +0200
Message-Id: <20210629091349.3802690-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629091349.3802690-1-alex@ghiti.fr>
References: <20210629091349.3802690-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check that is done in setup_bootmem currently only works for 32-bit
kernel since the kernel mapping has been moved outside of the linear
mapping for 64-bit kernel. So make sure that for 64-bit kernel, the kernel
mapping does not overlap with the last 4K of the addressable memory.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a1a0c4afa80f..a90c41bc9485 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -156,7 +156,7 @@ static void __init setup_bootmem(void)
 {
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
-	phys_addr_t max_mapped_addr = __pa(~(ulong)0);
+	phys_addr_t __maybe_unused max_mapped_addr;
 	phys_addr_t dram_end;
 
 #ifdef CONFIG_XIP_KERNEL
@@ -179,14 +179,20 @@ static void __init setup_bootmem(void)
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
 	dram_end = memblock_end_of_DRAM();
+#ifndef CONFIG_64BIT
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
 	 * the addressable memory can not be mapped because of IS_ERR_VALUE
 	 * macro. Make sure that last 4k bytes are not usable by memblock
-	 * if end of dram is equal to maximum addressable memory.
+	 * if end of dram is equal to maximum addressable memory. For 64-bit
+	 * kernel, this problem can't happen here as the end of the virtual
+	 * address space is occupied by the kernel mapping then this check must
+	 * be done in create_kernel_page_table.
 	 */
+	max_mapped_addr = __pa(~(ulong)0);
 	if (max_mapped_addr == (dram_end - 1))
 		memblock_set_current_limit(max_mapped_addr - 4096);
+#endif
 
 	min_low_pfn = PFN_UP(memblock_start_of_DRAM());
 	max_low_pfn = max_pfn = PFN_DOWN(dram_end);
@@ -556,6 +562,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
 	uintptr_t va, end_va;
 
 	end_va = kernel_virt_addr + load_sz;
+
 	for (va = kernel_virt_addr; va < end_va; va += map_size)
 		create_pgd_mapping(pgdir, va,
 				   load_pa + (va - kernel_virt_addr),
@@ -602,6 +609,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
 	BUG_ON((load_pa % map_size) != 0);
+#ifdef CONFIG_64BIT
+	/*
+	 * The last 4K bytes of the addressable memory can not be mapped because
+	 * of IS_ERR_VALUE macro.
+	 */
+	BUG_ON((kernel_virt_addr + load_sz) > ADDRESS_SPACE_END - SZ_4K);
+#endif
 
 	pt_ops.alloc_pte = alloc_pte_early;
 	pt_ops.get_pte_virt = get_pte_virt_early;
-- 
2.30.2

