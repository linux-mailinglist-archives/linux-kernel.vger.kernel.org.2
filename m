Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604933EADB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbhHLXis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238446AbhHLXi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 204C86109F;
        Thu, 12 Aug 2021 23:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811482;
        bh=Jvemhc6NK+B85RnvnFOWoDrTakqtEWuGs1UKrKyANmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ido4Na3TV+bU6rUPv7EqSinKJX4s2BCubbt0YOja5AkqcyvCgaKyZxoURN5dq0sQ5
         4Szcj2DRWNI4n+VdNRzdjf/WTcnDR/sFlcn/dlIW/PA8O+15aWQeQtM6stnG17wJ5S
         7DWHwEvEA+0fc6t9KLaG0Ls1Y08rrvZ1893noPHT5P/3l4AAjFbK6Mgc22ZssdVyWJ
         hTjKUqHLsAI0vF2BTCX3MMBuQI6X115LHn7/k4ZAziRE0GqIk85CJemkNJNm/oI+EB
         gXMhsLQOWPjtNTsJBlJbExC7Om5SwEky8LySkkptpImSNm25rzCSGhHwKrsWvuYpas
         LfWF4py32WNEg==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 11/19] ARC: mm: move MMU specific bits out of ASID allocator
Date:   Thu, 12 Aug 2021 16:37:45 -0700
Message-Id: <20210812233753.104217-12-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And while at it, rewrite commentary on ASID allocator

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/mmu.h         | 13 +++++++++++++
 arch/arc/include/asm/mmu_context.h | 28 +++++++++++++---------------
 arch/arc/mm/tlb.c                  | 11 ++++-------
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index 762cfe66e16b..0b117ea07048 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -64,6 +64,19 @@ typedef struct {
 	unsigned long asid[NR_CPUS];	/* 8 bit MMU PID + Generation cycle */
 } mm_context_t;
 
+static void inline mmu_setup_asid(struct mm_struct *mm, unsigned int asid)
+{
+	write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
+}
+
+static void inline mmu_setup_pgd(struct mm_struct *mm, void *pgd)
+{
+	/* PGD cached in MMU reg to avoid 3 mem lookups: task->mm->pgd */
+#ifdef CONFIG_ISA_ARCV2
+	write_aux_reg(ARC_REG_SCRATCH_DATA0, (unsigned int)pgd);
+#endif
+}
+
 static inline int is_pae40_enabled(void)
 {
 	return IS_ENABLED(CONFIG_ARC_HAS_PAE40);
diff --git a/arch/arc/include/asm/mmu_context.h b/arch/arc/include/asm/mmu_context.h
index 49318a126879..dda471f5f05b 100644
--- a/arch/arc/include/asm/mmu_context.h
+++ b/arch/arc/include/asm/mmu_context.h
@@ -15,22 +15,23 @@
 #ifndef _ASM_ARC_MMU_CONTEXT_H
 #define _ASM_ARC_MMU_CONTEXT_H
 
-#include <asm/arcregs.h>
-#include <asm/tlb.h>
 #include <linux/sched/mm.h>
 
+#include <asm/tlb.h>
 #include <asm-generic/mm_hooks.h>
 
-/*		ARC700 ASID Management
+/*		ARC ASID Management
+ *
+ * MMU tags TLBs with an 8-bit ASID, avoiding need to flush the TLB on
+ * context-switch.
  *
- * ARC MMU provides 8-bit ASID (0..255) to TAG TLB entries, allowing entries
- * with same vaddr (different tasks) to co-exit. This provides for
- * "Fast Context Switch" i.e. no TLB flush on ctxt-switch
+ * ASID is managed per cpu, so task threads across CPUs can have different
+ * ASID. Global ASID management is needed if hardware supports TLB shootdown
+ * and/or shared TLB across cores, which ARC doesn't.
  *
- * Linux assigns each task a unique ASID. A simple round-robin allocation
- * of H/w ASID is done using software tracker @asid_cpu.
- * When it reaches max 255, the allocation cycle starts afresh by flushing
- * the entire TLB and wrapping ASID back to zero.
+ * Each task is assigned unique ASID, with a simple round-robin allocator
+ * tracked in @asid_cpu. When 8-bit value rolls over,a new cycle is started
+ * over from 0, and TLB is flushed
  *
  * A new allocation cycle, post rollover, could potentially reassign an ASID
  * to a different task. Thus the rule is to refresh the ASID in a new cycle.
@@ -93,7 +94,7 @@ static inline void get_new_mmu_context(struct mm_struct *mm)
 	asid_mm(mm, cpu) = asid_cpu(cpu);
 
 set_hw:
-	write_aux_reg(ARC_REG_PID, hw_pid(mm, cpu) | MMU_ENABLE);
+	mmu_setup_asid(mm, hw_pid(mm, cpu));
 
 	local_irq_restore(flags);
 }
@@ -146,10 +147,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 */
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
-#ifdef CONFIG_ISA_ARCV2
-	/* PGD cached in MMU reg to avoid 3 mem lookups: task->mm->pgd */
-	write_aux_reg(ARC_REG_SCRATCH_DATA0, next->pgd);
-#endif
+	mmu_setup_pgd(next, next->pgd);
 
 	get_new_mmu_context(next);
 }
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 15cbc285b0de..b68d5798327b 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -716,14 +716,11 @@ void arc_mmu_init(void)
 	if (IS_ENABLED(CONFIG_ARC_HAS_PAE40) && !mmu->pae)
 		panic("Hardware doesn't support PAE40\n");
 
-	/* Enable the MMU */
-	write_aux_reg(ARC_REG_PID, MMU_ENABLE);
+	/* Enable the MMU with ASID 0 */
+	mmu_setup_asid(NULL, 0);
 
-	/* In arc700/smp needed for re-entrant interrupt handling */
-#ifdef CONFIG_ISA_ARCV2
-	/* swapper_pg_dir is the pgd for the kernel, used by vmalloc */
-	write_aux_reg(ARC_REG_SCRATCH_DATA0, swapper_pg_dir);
-#endif
+	/* cache the pgd pointer in MMU SCRATCH reg (ARCv2 only) */
+	mmu_setup_pgd(NULL, swapper_pg_dir);
 
 	if (pae40_exist_but_not_enab())
 		write_aux_reg(ARC_REG_TLBPD1HI, 0);
-- 
2.25.1

