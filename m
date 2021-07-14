Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B753C848B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhGNMkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239284AbhGNMkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:40:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C6E0613B2;
        Wed, 14 Jul 2021 12:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626266269;
        bh=eB/aRbWx8Vg1xHTIrqr77rlGb+2tSbVzgP7O9bEwkBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+ItVP07qAEbowMHt4gfGRJUCIn8EOeLWLjo6p4sfLljEhAitwNh+Elx3WQtpkzuF
         R5LEgraLcJpkXSkG/+iwTvOFDir7K2gNcvMH2sHYpERbl0AQDvEHgmAXLR+ZFSdLNr
         vuckqr1QmJrfGAEX9hcHmgBQja0fYry66MFN3wWDBhtcpUbqD0cXicGUOfygflCug8
         BBpJfGQq/ZR4EEBhz+jYw0x1xtNFI7x9+9tXzV5w54oEsmhibQpqrd50pFjAJTwWLR
         C/siixYK7AvMvBnBu1uLmu9zscM5Zt0nUwLx4AUcbHjMrLjF5QGu9lF5w6wwKS4gUQ
         tFu3Dv0Lo/g0g==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/4] microblaze: simplify pte_alloc_one_kernel()
Date:   Wed, 14 Jul 2021 15:37:37 +0300
Message-Id: <20210714123739.16493-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210714123739.16493-1-rppt@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The microblaze's implementation of pte_alloc_one_kernel() used
memblock_alloc_try_nid_raw() along with clear_page() to allocated a zeroed
page during early setup.

Replace calls of these functions with a call to memblock_alloc_try_nid()
that already returns zeroed page and respects the same allocation limits as
memblock_alloc_try_nid_raw().

While on it drop early_get_page() wrapper that was only used in
pte_alloc_one_kernel().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/microblaze/include/asm/pgtable.h |  2 --
 arch/microblaze/mm/init.c             | 12 ------------
 arch/microblaze/mm/pgtable.c          | 17 ++++++++---------
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 71cd547655d9..c136a01e467e 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -443,8 +443,6 @@ extern int mem_init_done;
 
 asmlinkage void __init mmu_init(void);
 
-void __init *early_get_page(void);
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index ab55c70380a5..952f35b335b2 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -265,18 +265,6 @@ asmlinkage void __init mmu_init(void)
 	dma_contiguous_reserve(memory_start + lowmem_size - 1);
 }
 
-/* This is only called until mem_init is done. */
-void __init *early_get_page(void)
-{
-	/*
-	 * Mem start + kernel_tlb -> here is limit
-	 * because of mem mapping from head.S
-	 */
-	return memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
-				MEMBLOCK_LOW_LIMIT, memory_start + kernel_tlb,
-				NUMA_NO_NODE);
-}
-
 void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
 {
 	void *p;
diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
index 38ccb909bc9d..c1833b159d3b 100644
--- a/arch/microblaze/mm/pgtable.c
+++ b/arch/microblaze/mm/pgtable.c
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
+#include <linux/memblock.h>
 
 #include <asm/pgalloc.h>
 #include <linux/io.h>
@@ -242,15 +243,13 @@ unsigned long iopa(unsigned long addr)
 
 __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	pte_t *pte;
-	if (mem_init_done) {
-		pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	} else {
-		pte = (pte_t *)early_get_page();
-		if (pte)
-			clear_page(pte);
-	}
-	return pte;
+	if (mem_init_done)
+		return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	else
+		return memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
+					      MEMBLOCK_LOW_LIMIT,
+					      memory_start + kernel_tlb,
+					      NUMA_NO_NODE);
 }
 
 void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
-- 
2.28.0

