Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78F63D5348
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhGZF47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:56:59 -0400
Received: from foss.arm.com ([217.140.110.172]:45666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232170AbhGZF45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:56:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 721F3139F;
        Sun, 25 Jul 2021 23:37:26 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3F6C3F66F;
        Sun, 25 Jul 2021 23:37:21 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V2 08/10] arm64/mm: Add FEAT_LPA2 specific PTE_SHARED and PMD_SECT_S
Date:   Mon, 26 Jul 2021 12:07:23 +0530
Message-Id: <1627281445-12445-9-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTE[9:8] which holds the sharability attribute bits SH[1:0] could collide
with PA[51:50] when CONFIG_ARM64_PA_BITS_52 is enabled but then FEAT_LPA2
is not detected during boot. Dropping PTE_SHARED and PMD_SECT_S attributes
completely in this scenario will create non-shared page table entries which
would cause regression.

Instead just define PTE_SHARED and PMD_SECT_S after accounting for runtime
'arm64_lpa2_enable', thus maintaining required sharability attributes for
both kernel and user space page table entries. This updates ptdump handling
for page table entry shared attributes accommodating FEAT_LPA2 scenarios.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/kernel-pgtable.h |  4 ++--
 arch/arm64/include/asm/pgtable-hwdef.h  | 12 ++++++++++--
 arch/arm64/kernel/head.S                | 15 +++++++++++++++
 arch/arm64/mm/ptdump.c                  | 26 ++++++++++++++++++++++++--
 4 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 3512184..db682b5 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -103,8 +103,8 @@
 /*
  * Initial memory map attributes.
  */
-#define SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+#define SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF)
+#define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF)
 
 #if ARM64_KERNEL_USES_PMD_MAPS
 #define SWAPPER_MM_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index c815a85..8a3b75e 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -116,13 +116,21 @@
 #define PMD_TYPE_SECT		(_AT(pmdval_t, 1) << 0)
 #define PMD_TABLE_BIT		(_AT(pmdval_t, 1) << 1)
 
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA2
+#define PTE_SHARED		(arm64_lpa2_enabled ? 0 : PTE_SHARED_STATIC)
+#define PMD_SECT_S		(arm64_lpa2_enabled ? 0 : PMD_SECT_S_STATIC)
+#else  /* !CONFIG_ARM64_PA_BITS_52_LPA2 */
+#define PTE_SHARED		PTE_SHARED_STATIC
+#define PMD_SECT_S		PMD_SECT_S_STATIC
+#endif /* CONFIG_ARM64_PA_BITS_52_LPA2 */
+
 /*
  * Section
  */
 #define PMD_SECT_VALID		(_AT(pmdval_t, 1) << 0)
 #define PMD_SECT_USER		(_AT(pmdval_t, 1) << 6)		/* AP[1] */
 #define PMD_SECT_RDONLY		(_AT(pmdval_t, 1) << 7)		/* AP[2] */
-#define PMD_SECT_S		(_AT(pmdval_t, 3) << 8)
+#define PMD_SECT_S_STATIC	(_AT(pmdval_t, 3) << 8)
 #define PMD_SECT_AF		(_AT(pmdval_t, 1) << 10)
 #define PMD_SECT_NG		(_AT(pmdval_t, 1) << 11)
 #define PMD_SECT_CONT		(_AT(pmdval_t, 1) << 52)
@@ -146,7 +154,7 @@
 #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
 #define PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
 #define PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
-#define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
+#define PTE_SHARED_STATIC	(_AT(pteval_t, 3) << 8)         /* SH[1:0], inner shareable */
 #define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
 #define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
 #define PTE_GP			(_AT(pteval_t, 1) << 50)	/* BTI guarded */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index efc6e41..f8b2399 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -301,6 +301,21 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 
 	mov	x7, SWAPPER_MM_MMUFLAGS
 
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA2
+	ldr_l   x2, arm64_lpa2_enabled
+	cmp     x2, #1
+	b.eq    1f
+#endif /* CONFIG_ARM64_PA_BITS_52_LPA2 */
+
+	/*
+	 * FEAT_LPA2 has not been detected during boot.
+	 * Hence SWAPPER_MM_MMUFLAGS needs to have the
+	 * regular sharability attributes in PTE[9:8].
+	 * Same is also applicable when FEAT_LPA2 has
+	 * not been requested in the first place.
+	 */
+	orr     x7, x7, PTE_SHARED_STATIC
+1:
 	/*
 	 * Create the identity mapping.
 	 */
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 1c40353..be171cf 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -115,8 +115,8 @@ static const struct prot_bits pte_bits[] = {
 		.set	= "NX",
 		.clear	= "x ",
 	}, {
-		.mask	= PTE_SHARED,
-		.val	= PTE_SHARED,
+		.mask	= PTE_SHARED_STATIC,
+		.val	= PTE_SHARED_STATIC,
 		.set	= "SHD",
 		.clear	= "   ",
 	}, {
@@ -211,6 +211,28 @@ static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
 	for (i = 0; i < num; i++, bits++) {
 		const char *s;
 
+		if (IS_ENABLED(CONFIG_ARM64_PA_BITS_52_LPA2) &&
+		   (bits->mask == PTE_SHARED_STATIC)) {
+			/*
+			 * If FEAT_LPA2 has been detected and enabled
+			 * sharing attributes for page table entries
+			 * are inherited from TCR_EL1.SH1 as init_mm
+			 * based mappings are enabled from TTBR1_EL1.
+			 */
+			if (arm64_lpa2_enabled) {
+				if ((read_sysreg(tcr_el1) & TCR_SH1_INNER) == TCR_SH1_INNER)
+					pt_dump_seq_printf(st->seq, " SHD ");
+				else
+					pt_dump_seq_printf(st->seq, " ");
+				continue;
+			}
+			/*
+			 * In case FEAT_LPA2 has not been detected and
+			 * enabled sharing attributes should be found
+			 * in the regular PTE positions. It just falls
+			 * through regular PTE attribute handling.
+			 */
+		}
 		if ((st->current_prot & bits->mask) == bits->val)
 			s = bits->set;
 		else
-- 
2.7.4

