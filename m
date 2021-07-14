Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3063C7BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhGNCYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:24:17 -0400
Received: from foss.arm.com ([217.140.110.172]:55776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237474AbhGNCYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:24:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30BD31FB;
        Tue, 13 Jul 2021 19:21:24 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C455F3F7D8;
        Tue, 13 Jul 2021 19:21:20 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 05/10] arm64/mm: Add CONFIG_ARM64_PA_BITS_52_[LPA|LPA2]
Date:   Wed, 14 Jul 2021 07:51:26 +0530
Message-Id: <1626229291-6569-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
References: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going forward, CONFIG_ARM64_PA_BITS_52 could be enabled on a system via two
different architecture features i.e FEAT_LPA for CONFIG_ARM64_64K_PAGES and
FEAT_LPA2 for CONFIG_ARM64_[4K|16K]_PAGES. But CONFIG_ARM64_PA_BITS_52 is
exclussively available on 64K page size config currently, which needs to be
freed up for other page size configs to use when FEAT_LPA2 gets enabled.

To achieve CONFIG_ARM64_PA_BITS_52 and CONFIG_ARM64_64K_PAGES decoupling,
and also to reduce #ifdefs while navigating various page size configs, this
adds two internal config options CONFIG_ARM64_PA_BITS_52_[LPA|LPA2]. While
here it also converts existing 64K page size based FEAT_LPA implementations
to use CONFIG_ARM64_PA_BITS_52_LPA. TTBR representation remains same for
both FEAT_LPA and FEAT_LPA2. No functional change for 64K page size config.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig                     |  7 +++++++
 arch/arm64/include/asm/assembler.h     | 12 ++++++------
 arch/arm64/include/asm/pgtable-hwdef.h |  7 ++++---
 arch/arm64/include/asm/pgtable.h       |  6 +++---
 arch/arm64/mm/pgd.c                    |  2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e07e7de..658a6fd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -934,6 +934,12 @@ config ARM64_VA_BITS
 	default 48 if ARM64_VA_BITS_48
 	default 52 if ARM64_VA_BITS_52
 
+config ARM64_PA_BITS_52_LPA
+	bool
+
+config ARM64_PA_BITS_52_LPA2
+	bool
+
 choice
 	prompt "Physical address space size"
 	default ARM64_PA_BITS_48
@@ -948,6 +954,7 @@ config ARM64_PA_BITS_52
 	bool "52-bit (ARMv8.2)"
 	depends on ARM64_64K_PAGES
 	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
+	select ARM64_PA_BITS_52_LPA if ARM64_64K_PAGES
 	help
 	  Enable support for a 52-bit physical address space, introduced as
 	  part of the ARMv8.2-LPA extension.
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 89faca0..fedc202 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -607,26 +607,26 @@ alternative_endif
 	.endm
 
 	.macro	phys_to_pte, pte, phys
-#ifdef CONFIG_ARM64_PA_BITS_52
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA
 	/*
 	 * We assume \phys is 64K aligned and this is guaranteed by only
 	 * supporting this configuration with 64K pages.
 	 */
 	orr	\pte, \phys, \phys, lsr #36
 	and	\pte, \pte, #PTE_ADDR_MASK
-#else
+#else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 	mov	\pte, \phys
-#endif
+#endif /* CONFIG_ARM64_PA_BITS_52_LPA */
 	.endm
 
 	.macro	pte_to_phys, phys, pte
-#ifdef CONFIG_ARM64_PA_BITS_52
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA
 	ubfiz	\phys, \pte, #(48 - 16 - 12), #16
 	bfxil	\phys, \pte, #16, #32
 	lsl	\phys, \phys, #16
-#else
+#else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 	and	\phys, \pte, #PTE_ADDR_MASK
-#endif
+#endif /* CONFIG_ARM64_PA_BITS_52_LPA */
 	.endm
 
 /*
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 1eb5574..f375bcf 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -155,13 +155,14 @@
 #define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
 #define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
 
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA
 #define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
-#ifdef CONFIG_ARM64_PA_BITS_52
 #define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
 #define PTE_ADDR_MASK		(PTE_ADDR_LOW | PTE_ADDR_HIGH)
-#else
+#else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
+#define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 #define PTE_ADDR_MASK		PTE_ADDR_LOW
-#endif
+#endif /* CONFIG_ARM64_PA_BITS_52_LPA */
 
 /*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f09bf5c..3c57fb2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -66,14 +66,14 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
  * Macros to convert between a physical address and its placement in a
  * page table entry, taking care of 52-bit addresses.
  */
-#ifdef CONFIG_ARM64_PA_BITS_52
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA
 #define __pte_to_phys(pte)	\
 	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 36))
 #define __phys_to_pte_val(phys)	(((phys) | ((phys) >> 36)) & PTE_ADDR_MASK)
-#else
+#else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 #define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_MASK)
 #define __phys_to_pte_val(phys)	(phys)
-#endif
+#endif /* CONFIG_ARM64_PA_BITS_52_LPA */
 
 #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
 #define pfn_pte(pfn,prot)	\
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 4a64089..090dfbe 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -40,7 +40,7 @@ void __init pgtable_cache_init(void)
 	if (PGD_SIZE == PAGE_SIZE)
 		return;
 
-#ifdef CONFIG_ARM64_PA_BITS_52
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA
 	/*
 	 * With 52-bit physical addresses, the architecture requires the
 	 * top-level table to be aligned to at least 64 bytes.
-- 
2.7.4

