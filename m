Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222DA3EADB6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhHLXix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238455AbhHLXi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:38:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FB61610FD;
        Thu, 12 Aug 2021 23:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628811483;
        bh=2Fl+UaQd2LbBkvpg/DazzYYTlhrohlhzA+PnuOctBVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPK0kff4ECHeCAQ5/7/T8RrOf3uCFlgE4teUXWOt0D32NUoOkPIkN5V9THIfZtjas
         kw1gv/ujim8O654BSs6OKq+uDfgJOQQSGzf1c8ii07AWLy+c9WLQqUcB9SM+sVZuxe
         0Y+XfnZRNZ0B7gbFefwxETwkm8QKVbl2AzPaAt72it1DgB3p27p26vPlUwDwG8SmCv
         VjdtYqTwVtYvTUtF0H+tseJNpFtqJp1QhNN9cSsJ1qB4aDdfqQs2RkggLFobtEatMn
         j83jsD5tMIau/9zOlhfvTOWHkD3DvRFtItE3nQvaZbw6bC9SpDHIDMUQ1xEpc0Vmac
         kNVgGqnboAfkw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 13/19] ARC: mm: disintegrate mmu.h (arcv2 bits out)
Date:   Thu, 12 Aug 2021 16:37:47 -0700
Message-Id: <20210812233753.104217-14-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812233753.104217-1-vgupta@kernel.org>
References: <20210812233753.104217-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

non functional change

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/mmu-arcv2.h | 103 +++++++++++++++++++++++++++++++
 arch/arc/include/asm/mmu.h       |  80 +-----------------------
 arch/arc/include/asm/pgtable.h   |   6 --
 3 files changed, 105 insertions(+), 84 deletions(-)
 create mode 100644 arch/arc/include/asm/mmu-arcv2.h

diff --git a/arch/arc/include/asm/mmu-arcv2.h b/arch/arc/include/asm/mmu-arcv2.h
new file mode 100644
index 000000000000..4c47dd3864d1
--- /dev/null
+++ b/arch/arc/include/asm/mmu-arcv2.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2004, 2007-2010, 2011-2012, 2019-20 Synopsys, Inc. (www.synopsys.com)
+ *
+ * MMUv3 (arc700) / MMUv4 (archs) are software page walked and software managed.
+ * This file contains the TLB access registers and commands
+ */
+
+#ifndef _ASM_ARC_MMU_ARCV2_H
+#define _ASM_ARC_MMU_ARCV2_H
+
+/*
+ * TLB Management regs
+ */
+#define ARC_REG_MMU_BCR		0x06f
+
+#ifdef CONFIG_ARC_MMU_V3
+#define ARC_REG_TLBPD0		0x405
+#define ARC_REG_TLBPD1		0x406
+#define ARC_REG_TLBPD1HI	0	/* Dummy: allows common code */
+#define ARC_REG_TLBINDEX	0x407
+#define ARC_REG_TLBCOMMAND	0x408
+#define ARC_REG_PID		0x409
+#define ARC_REG_SCRATCH_DATA0	0x418
+#else
+#define ARC_REG_TLBPD0		0x460
+#define ARC_REG_TLBPD1		0x461
+#define ARC_REG_TLBPD1HI	0x463
+#define ARC_REG_TLBINDEX	0x464
+#define ARC_REG_TLBCOMMAND	0x465
+#define ARC_REG_PID		0x468
+#define ARC_REG_SCRATCH_DATA0	0x46c
+#endif
+
+/* Bits in MMU PID reg */
+#define __TLB_ENABLE		(1 << 31)
+#define __PROG_ENABLE		(1 << 30)
+#define MMU_ENABLE		(__TLB_ENABLE | __PROG_ENABLE)
+
+/* Bits in TLB Index reg */
+#define TLB_LKUP_ERR		0x80000000
+
+#ifdef CONFIG_ARC_MMU_V3
+#define TLB_DUP_ERR		(TLB_LKUP_ERR | 0x00000001)
+#else
+#define TLB_DUP_ERR		(TLB_LKUP_ERR | 0x40000000)
+#endif
+
+/*
+ * TLB Commands
+ */
+#define TLBWrite    		0x1
+#define TLBRead     		0x2
+#define TLBGetIndex 		0x3
+#define TLBProbe    		0x4
+#define TLBWriteNI		0x5  /* write JTLB without inv uTLBs */
+#define TLBIVUTLB		0x6  /* explicitly inv uTLBs */
+
+#ifdef CONFIG_ARC_MMU_V4
+#define TLBInsertEntry		0x7
+#define TLBDeleteEntry		0x8
+#endif
+
+/* Masks for actual TLB "PD"s */
+#define PTE_BITS_IN_PD0		(_PAGE_GLOBAL | _PAGE_PRESENT | _PAGE_HW_SZ)
+#define PTE_BITS_RWX		(_PAGE_EXECUTE | _PAGE_WRITE | _PAGE_READ)
+
+#define PTE_BITS_NON_RWX_IN_PD1	(PAGE_MASK_PHYS | _PAGE_CACHEABLE)
+
+#ifndef __ASSEMBLY__
+
+struct mm_struct;
+extern int pae40_exist_but_not_enab(void);
+
+static inline int is_pae40_enabled(void)
+{
+	return IS_ENABLED(CONFIG_ARC_HAS_PAE40);
+}
+
+static void inline mmu_setup_asid(struct mm_struct *mm, unsigned long asid)
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
+#else
+
+.macro ARC_MMU_REENABLE reg
+	lr \reg, [ARC_REG_PID]
+	or \reg, \reg, MMU_ENABLE
+	sr \reg, [ARC_REG_PID]
+.endm
+
+#endif /* !__ASSEMBLY__ */
+
+#endif
diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index 414a27e806b6..ca427c30f70e 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -7,91 +7,15 @@
 #define _ASM_ARC_MMU_H
 
 #ifndef __ASSEMBLY__
-#include <linux/threads.h>	/* NR_CPUS */
-#endif
-
-/* MMU Management regs */
-#define ARC_REG_MMU_BCR		0x06f
-
-#ifdef CONFIG_ARC_MMU_V3
-#define ARC_REG_TLBPD0		0x405
-#define ARC_REG_TLBPD1		0x406
-#define ARC_REG_TLBPD1HI	0	/* Dummy: allows code sharing with ARC700 */
-#define ARC_REG_TLBINDEX	0x407
-#define ARC_REG_TLBCOMMAND	0x408
-#define ARC_REG_PID		0x409
-#define ARC_REG_SCRATCH_DATA0	0x418
-#else
-#define ARC_REG_TLBPD0		0x460
-#define ARC_REG_TLBPD1		0x461
-#define ARC_REG_TLBPD1HI	0x463
-#define ARC_REG_TLBINDEX	0x464
-#define ARC_REG_TLBCOMMAND	0x465
-#define ARC_REG_PID		0x468
-#define ARC_REG_SCRATCH_DATA0	0x46c
-#endif
-
-/* Bits in MMU PID register */
-#define __TLB_ENABLE		(1 << 31)
-#define __PROG_ENABLE		(1 << 30)
-#define MMU_ENABLE		(__TLB_ENABLE | __PROG_ENABLE)
-
-/* Error code if probe fails */
-#define TLB_LKUP_ERR		0x80000000
-
-#ifdef CONFIG_ARC_MMU_V3
-#define TLB_DUP_ERR	(TLB_LKUP_ERR | 0x00000001)
-#else
-#define TLB_DUP_ERR	(TLB_LKUP_ERR | 0x40000000)
-#endif
-
-/* TLB Commands */
-#define TLBWrite    0x1
-#define TLBRead     0x2
-#define TLBGetIndex 0x3
-#define TLBProbe    0x4
-#define TLBWriteNI  0x5		/* write JTLB without inv uTLBs */
-#define TLBIVUTLB   0x6		/* explicitly inv uTLBs */
 
-#ifdef CONFIG_ARC_MMU_V4
-#define TLBInsertEntry	0x7
-#define TLBDeleteEntry	0x8
-#endif
-
-#ifndef __ASSEMBLY__
+#include <linux/threads.h>	/* NR_CPUS */
 
 typedef struct {
 	unsigned long asid[NR_CPUS];	/* 8 bit MMU PID + Generation cycle */
 } mm_context_t;
 
-static void inline mmu_setup_asid(struct mm_struct *mm, unsigned int asid)
-{
-	write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
-}
-
-static void inline mmu_setup_pgd(struct mm_struct *mm, void *pgd)
-{
-	/* PGD cached in MMU reg to avoid 3 mem lookups: task->mm->pgd */
-#ifdef CONFIG_ISA_ARCV2
-	write_aux_reg(ARC_REG_SCRATCH_DATA0, (unsigned int)pgd);
 #endif
-}
-
-static inline int is_pae40_enabled(void)
-{
-	return IS_ENABLED(CONFIG_ARC_HAS_PAE40);
-}
-
-extern int pae40_exist_but_not_enab(void);
-
-#else
-
-.macro ARC_MMU_REENABLE reg
-	lr \reg, [ARC_REG_PID]
-	or \reg, \reg, MMU_ENABLE
-	sr \reg, [ARC_REG_PID]
-.endm
 
-#endif	/* !__ASSEMBLY__ */
+#include <asm/mmu-arcv2.h>
 
 #endif
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index f762bacb2358..de4576e8d17a 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -103,12 +103,6 @@
  */
 #define PAGE_KERNEL          __pgprot(_K_PAGE_PERMS | _PAGE_CACHEABLE)
 
-/* Masks for actual TLB "PD"s */
-#define PTE_BITS_IN_PD0		(_PAGE_GLOBAL | _PAGE_PRESENT | _PAGE_HW_SZ)
-#define PTE_BITS_RWX		(_PAGE_EXECUTE | _PAGE_WRITE | _PAGE_READ)
-
-#define PTE_BITS_NON_RWX_IN_PD1	(PAGE_MASK_PHYS | _PAGE_CACHEABLE)
-
 /**************************************************************************
  * Mapping of vm_flags (Generic VM) to PTE flags (arch specific)
  *
-- 
2.25.1

