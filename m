Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343D33D3ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhGWMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:25:17 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58503 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhGWMZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:25:15 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 60443C0007;
        Fri, 23 Jul 2021 13:05:45 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 4/5] riscv: Simplify BUILTIN_DTB device tree mapping handling
Date:   Fri, 23 Jul 2021 15:01:27 +0200
Message-Id: <20210723130128.47664-5-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723130128.47664-1-alex@ghiti.fr>
References: <20210723130128.47664-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__PAGETABLE_PMD_FOLDED defines a 2-level page table that is only used in
32-bit kernel, so there is no need to check for CONFIG_64BIT in #ifndef
__PAGETABLE_PMD_FOLDED and vice-versa.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 6b29c5791555..1b30ad7e3ebc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -614,18 +614,14 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 			   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
 	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
 #else /* CONFIG_BUILTIN_DTB */
-#ifdef CONFIG_64BIT
 	/*
 	 * __va can't be used since it would return a linear mapping address
 	 * whereas dtb_early_va will be used before setup_vm_final installs
 	 * the linear mapping.
 	 */
 	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
-#else
-	dtb_early_va = __va(dtb_pa);
-#endif /* CONFIG_64BIT */
 #endif /* CONFIG_BUILTIN_DTB */
-#else
+#else /* __PAGETABLE_PMD_FOLDED */
 #ifndef CONFIG_BUILTIN_DTB
 	/* Create two consecutive PGD mappings for FDT early scan */
 	pa = dtb_pa & ~(PGDIR_SIZE - 1);
@@ -635,13 +631,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
 	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
 #else /* CONFIG_BUILTIN_DTB */
-#ifdef CONFIG_64BIT
-	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
-#else
 	dtb_early_va = __va(dtb_pa);
-#endif /* CONFIG_64BIT */
 #endif /* CONFIG_BUILTIN_DTB */
-#endif
+#endif /* __PAGETABLE_PMD_FOLDED */
 	dtb_early_pa = dtb_pa;
 
 	/*
-- 
2.30.2

