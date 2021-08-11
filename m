Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645E43E8758
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhHKAnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235980AbhHKAnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D498960EFF;
        Wed, 11 Aug 2021 00:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642598;
        bh=o68pQKOkoMjqGvslTv9+5NhBcfzvevarzmfnV2WjK38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9E0moRAtyOyw9Sx7Ur777jymu/dOGX06mLGlJiV9J7UjMcNqnZWnrasSe3jnphZJ
         m+oAeup8cQVGK1bf56LRFIkx8Afv89ZYjAcP+0kpXROVmnN3s7OvB6IHo18pefNK/r
         xqrqgkMNIo/2uXAZMXCbo4FTNMGFWtrVIwuY3cLhAzJFHNFFX4bqFzm6uNgosWyKrL
         v8phW7+OpxKLP1YbUgtaCcUGwQDdZc7EJhMrrDN0UpaM8kwi3aZ9n9iEj68R/2sVMI
         +3zBgBaR0tjm1iv+IVAFceG3SkGbmKRRzSnLN8WcfL6xIs+dWiE0ZyoSB+RmCE4a4o
         d9YpYBgglc12A==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 04/18] ARC: mm: remove pgd_offset_fast
Date:   Tue, 10 Aug 2021 17:42:44 -0700
Message-Id: <20210811004258.138075-5-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/pgtable.h | 23 -----------------------
 arch/arc/mm/fault.c            |  2 +-
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 0c3e220bd2b4..80b57c14b430 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -284,29 +284,6 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	set_pte(ptep, pteval);
 }
 
-/*
- * Macro to quickly access the PGD entry, utlising the fact that some
- * arch may cache the pointer to Page Directory of "current" task
- * in a MMU register
- *
- * Thus task->mm->pgd (3 pointer dereferences, cache misses etc simply
- * becomes read a register
- *
- * ********CAUTION*******:
- * Kernel code might be dealing with some mm_struct of NON "current"
- * Thus use this macro only when you are certain that "current" is current
- * e.g. when dealing with signal frame setup code etc
- */
-#ifdef ARC_USE_SCRATCH_REG
-#define pgd_offset_fast(mm, addr)	\
-({					\
-	pgd_t *pgd_base = (pgd_t *) read_aux_reg(ARC_REG_SCRATCH_DATA0);  \
-	pgd_base + pgd_index(addr);	\
-})
-#else
-#define pgd_offset_fast(mm, addr)	pgd_offset(mm, addr)
-#endif
-
 extern pgd_t swapper_pg_dir[] __aligned(PAGE_SIZE);
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep);
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index f5657cb68e4f..41f154320964 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -33,7 +33,7 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	pud_t *pud, *pud_k;
 	pmd_t *pmd, *pmd_k;
 
-	pgd = pgd_offset_fast(current->active_mm, address);
+	pgd = pgd_offset(current->active_mm, address);
 	pgd_k = pgd_offset_k(address);
 
 	if (!pgd_present(*pgd_k))
-- 
2.25.1

