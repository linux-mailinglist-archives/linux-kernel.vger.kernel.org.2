Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC1C3EADA8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbhHLXiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233854AbhHLXiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 784C160EE2;
        Thu, 12 Aug 2021 23:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811477;
        bh=iGK8PU/tmDB3AhUhP6XkaxS4+cLDTMouE860/hGTGtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmHBNkN4z+GRV91Y98Q1O5gj2BS2hSbsyBU1Rx42aTRA4/P9lVbJnrvjY5Eb8eMnv
         0pqmEK6WYQTWwCKA5BnsmlHJ2HO7Vp7NLGBqchILI58wf97BmDY4YcH8upSiFpcwB9
         MFvVipwSqrmvgtXplIi9CggjYMAbUEIeoOePlmwCC7EOLUYS87fEoGbvCBaDAfdTuC
         mDstBKy/+HjdigeqxLcTwOd6iP0OizA7OhuBZ6JW4YQxAIFxMSeoFPgheg066VCrGI
         +wwmROgzgSqQvsTRy6KYUPX1JPktQyDyUHbcmqLvoyW7bQBvvJK6O1Vnb0qUTFJeN7
         wPm/0VpPpF59Q==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 01/19] ARC: mm: use SCRATCH_DATA0 register for caching pgdir in ARCv2 only
Date:   Thu, 12 Aug 2021 16:37:35 -0700
Message-Id: <20210812233753.104217-2-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU SCRATCH_DATA0 register is intended to cache task pgd. However in
ARC700 SMP port, it has to be repurposed for reentrant interrupt
handling, while UP port doesn't. We  currently ahandle boe usecases
using a fabricated which has usual issues of dependency nesting and
ugliness.

So clean this up: for ARC700 don't use to cache pgd (even in UP) and do
the opposite for ARCv2.

And while here, switch to canonical pgd_offset().

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/entry-compact.h |  8 --------
 arch/arc/include/asm/mmu.h           |  4 ----
 arch/arc/include/asm/mmu_context.h   |  2 +-
 arch/arc/include/asm/pgtable.h       | 23 -----------------------
 arch/arc/mm/fault.c                  |  2 +-
 arch/arc/mm/tlb.c                    |  4 ++--
 arch/arc/mm/tlbex.S                  |  2 +-
 7 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 6dbf5cecc8cc..5aab4f93ab8a 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -126,19 +126,11 @@
  * to be saved again on kernel mode stack, as part of pt_regs.
  *-------------------------------------------------------------*/
 .macro PROLOG_FREEUP_REG	reg, mem
-#ifndef ARC_USE_SCRATCH_REG
-	sr  \reg, [ARC_REG_SCRATCH_DATA0]
-#else
 	st  \reg, [\mem]
-#endif
 .endm
 
 .macro PROLOG_RESTORE_REG	reg, mem
-#ifndef ARC_USE_SCRATCH_REG
-	lr  \reg, [ARC_REG_SCRATCH_DATA0]
-#else
 	ld  \reg, [\mem]
-#endif
 .endm
 
 /*--------------------------------------------------------------
diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index a81d1975866a..4065335a7922 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -31,10 +31,6 @@
 #define ARC_REG_SCRATCH_DATA0	0x46c
 #endif
 
-#if defined(CONFIG_ISA_ARCV2) || !defined(CONFIG_SMP)
-#define	ARC_USE_SCRATCH_REG
-#endif
-
 /* Bits in MMU PID register */
 #define __TLB_ENABLE		(1 << 31)
 #define __PROG_ENABLE		(1 << 30)
diff --git a/arch/arc/include/asm/mmu_context.h b/arch/arc/include/asm/mmu_context.h
index df164066e172..49318a126879 100644
--- a/arch/arc/include/asm/mmu_context.h
+++ b/arch/arc/include/asm/mmu_context.h
@@ -146,7 +146,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 */
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
-#ifdef ARC_USE_SCRATCH_REG
+#ifdef CONFIG_ISA_ARCV2
 	/* PGD cached in MMU reg to avoid 3 mem lookups: task->mm->pgd */
 	write_aux_reg(ARC_REG_SCRATCH_DATA0, next->pgd);
 #endif
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
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 8696829d37c0..349fb7a75d1d 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -719,8 +719,8 @@ void arc_mmu_init(void)
 	/* Enable the MMU */
 	write_aux_reg(ARC_REG_PID, MMU_ENABLE);
 
-	/* In smp we use this reg for interrupt 1 scratch */
-#ifdef ARC_USE_SCRATCH_REG
+	/* In arc700/smp needed for re-entrant interrupt handling */
+#ifdef CONFIG_ISA_ARCV2
 	/* swapper_pg_dir is the pgd for the kernel, used by vmalloc */
 	write_aux_reg(ARC_REG_SCRATCH_DATA0, swapper_pg_dir);
 #endif
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index 96c3a5de9dd4..bcd2909c691f 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -202,7 +202,7 @@ ex_saved_reg1:
 
 	lr  r2, [efa]
 
-#ifdef ARC_USE_SCRATCH_REG
+#ifdef CONFIG_ISA_ARCV2
 	lr  r1, [ARC_REG_SCRATCH_DATA0] ; current pgd
 #else
 	GET_CURR_TASK_ON_CPU  r1
-- 
2.25.1

