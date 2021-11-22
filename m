Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64496458AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbhKVIwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:52:08 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:35965 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232786AbhKVIvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:51:55 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HyLXc1R6Xz9sSq;
        Mon, 22 Nov 2021 09:48:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OtwPH2BQYl9C; Mon, 22 Nov 2021 09:48:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HyLXc0DPQz9sSL;
        Mon, 22 Nov 2021 09:48:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E9BDD8B77D;
        Mon, 22 Nov 2021 09:48:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MySMw8Ud7QXq; Mon, 22 Nov 2021 09:48:47 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E2878B774;
        Mon, 22 Nov 2021 09:48:47 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1AM8mcjh631712
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 09:48:38 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1AM8mcHY631711;
        Mon, 22 Nov 2021 09:48:38 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: [PATCH 1/8] powerpc/mm: Make slice specific to book3s/64
Date:   Mon, 22 Nov 2021 09:48:21 +0100
Message-Id: <14e2c0b0d4fff49c1cb30166f54ce8e445e17b16.1637570556.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637570556.git.christophe.leroy@csgroup.eu>
References: <cover.1637570556.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637570905; l=2880; s=20211009; h=from:subject:message-id; bh=vnOfRzb4I+xxbHSiQuNgjnjWCUkmW+ckcWxKQ+NXyJE=; b=9bwb10+DP33eXjlI7shzwyAcRqEcNyqVqbojPLodCahm+v+kchcvdS9qqvRDu+MsOPuvBqHQFEGJ Qx0MgS0SDS3vvlWvSIj00mYHk47oEwLcR7rSDLU8hD2ZjyPoUGw1
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 555904d07eef ("powerpc/8xx: MM_SLICE is not needed
anymore") only book3s/64 selects CONFIG_PPC_MM_SLICES.

Move slice.c into mm/book3s64/

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/Makefile               | 1 -
 arch/powerpc/mm/book3s64/Makefile      | 1 +
 arch/powerpc/mm/{ => book3s64}/slice.c | 0
 arch/powerpc/mm/nohash/mmu_context.c   | 2 --
 arch/powerpc/mm/nohash/tlb.c           | 4 ----
 5 files changed, 1 insertion(+), 7 deletions(-)
 rename arch/powerpc/mm/{ => book3s64}/slice.c (100%)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index df8172da2301..d4c20484dad9 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= nohash/
 obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s32/
 obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64/
 obj-$(CONFIG_NUMA) += numa.o
-obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
diff --git a/arch/powerpc/mm/book3s64/Makefile b/arch/powerpc/mm/book3s64/Makefile
index 1b56d3af47d4..30951668c684 100644
--- a/arch/powerpc/mm/book3s64/Makefile
+++ b/arch/powerpc/mm/book3s64/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += hash_hugepage.o
 obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage_prot.o
 obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= iommu_api.o
 obj-$(CONFIG_PPC_PKEY)	+= pkeys.o
+obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 
 # Instrumenting the SLB fault path can lead to duplicate SLB entries
 KCOV_INSTRUMENT_slb.o := n
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/book3s64/slice.c
similarity index 100%
rename from arch/powerpc/mm/slice.c
rename to arch/powerpc/mm/book3s64/slice.c
diff --git a/arch/powerpc/mm/nohash/mmu_context.c b/arch/powerpc/mm/nohash/mmu_context.c
index 44b2b5e7cabe..b8dfe66bdf18 100644
--- a/arch/powerpc/mm/nohash/mmu_context.c
+++ b/arch/powerpc/mm/nohash/mmu_context.c
@@ -320,8 +320,6 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 	 * have id == 0) and don't alter context slice inherited via fork (which
 	 * will have id != 0).
 	 */
-	if (mm->context.id == 0)
-		slice_init_new_context_exec(mm);
 	mm->context.id = MMU_NO_CONTEXT;
 	mm->context.active = 0;
 	pte_frag_set(&mm->context, NULL);
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 89353d4f5604..4822dfd6c246 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -782,9 +782,5 @@ void __init early_init_mmu(void)
 #ifdef CONFIG_PPC_47x
 	early_init_mmu_47x();
 #endif
-
-#ifdef CONFIG_PPC_MM_SLICES
-	mm_ctx_set_slb_addr_limit(&init_mm.context, SLB_ADDR_LIMIT_DEFAULT);
-#endif
 }
 #endif /* CONFIG_PPC64 */
-- 
2.33.1

