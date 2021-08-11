Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC333E8752
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhHKAnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235830AbhHKAnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:43:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79F7D60EB7;
        Wed, 11 Aug 2021 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628642596;
        bh=uXKpbJ3Z+SCcgPMWkmhiiIS5hjgeCpPYAif1Yg1470w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOckdQAWP8L66RAfndqODARBsukOFxCZBMKgNgH91dKQaKdxiM3TLCU+uZl6uXL1x
         yQjfObCGS7o5G47ZbSvb0ihA7HNydt9nUxmRT9y/RoS4Q0U5XFpSO9R1FG2y7qhyrZ
         XhO7t2hthYh1+APgpkz+WPBM2GuyWlVe7Kv6SH29eZ281EP1RanLcfEmMP61hxTypL
         vribWhUobrP0VJMHuwWdT90s2mA+nOSE9Mw41050ahdwVx8kIYuMammiEd1ftiAblA
         BZexw66vM+Fvd36A1I4tFgUubRGJm64YH3nFJS+RghPw8wHs0WxqA8ip6Na9NTK9Yw
         bApR84zlo8YgA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 01/18] ARC: mm: simplify mmu scratch register assingment to mmu needs
Date:   Tue, 10 Aug 2021 17:42:41 -0700
Message-Id: <20210811004258.138075-2-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811004258.138075-1-vgupta@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC700 SMP uses MMU scratch reg for re-entrant interrupt handling (as
opposed to the canonical usage for task pgd pointer caching for ARCv2
and ARC700 UP builds). However this requires fabricating a #define in a
header which has usual issues of dependency nesting and ugliness.

So clean this up and just use it as intended for ARCv2 only.
For ARC700 just don't use it for mmu needs (even for UP which it
potentially can (degrades it slightly) but that config it not a
big deal in this day and age.

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/entry-compact.h | 8 --------
 arch/arc/include/asm/mmu.h           | 4 ----
 arch/arc/include/asm/mmu_context.h   | 2 +-
 arch/arc/mm/tlb.c                    | 4 ++--
 arch/arc/mm/tlbex.S                  | 2 +-
 5 files changed, 4 insertions(+), 16 deletions(-)

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

