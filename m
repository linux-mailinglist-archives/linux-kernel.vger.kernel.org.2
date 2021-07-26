Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD483D5349
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhGZF5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:57:06 -0400
Received: from foss.arm.com ([217.140.110.172]:45682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232207AbhGZF5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:57:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 456D3106F;
        Sun, 25 Jul 2021 23:37:31 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EF663F66F;
        Sun, 25 Jul 2021 23:37:26 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V2 09/10] arm64/mm: Add FEAT_LPA2 specific fallback (48 bits PA) when not implemented
Date:   Mon, 26 Jul 2021 12:07:24 +0530
Message-Id: <1627281445-12445-10-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ARM64_PA_BITS_52 build kernels need to fallback for 48 bits PA range
encodings when FEAT_LPA2 is not implemented i.e TCR_EL1.DS could not be set
.  Hence modify applicable PTE and TTBR encoding helpers to accommodate the
scenario via 'arm64_lpa2_enabled'.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/assembler.h     | 16 ++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  2 ++
 arch/arm64/include/asm/pgtable.h       | 12 ++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d7ce4cf..ae69825 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -615,9 +615,17 @@ alternative_endif
 	orr	\pte, \phys, \phys, lsr #36
 	and	\pte, \pte, #PTE_ADDR_MASK
 #elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+	ldr_l   \pte, arm64_lpa2_enabled
+	cmp     \pte, #1
+	b.ne    .Lskip_lpa2\@
+
 	orr	\pte, \phys, \phys, lsr #42
 	and	\pte, \pte, #PTE_ADDR_MASK | GENMASK(PAGE_SHIFT - 1, 10)
 	and	\pte, \pte, #~GENMASK(PAGE_SHIFT - 1, 10)
+	b	.Ldone_lpa2\@
+.Lskip_lpa2\@:
+	mov	\pte, \phys
+.Ldone_lpa2\@:
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 	mov	\pte, \phys
 #endif /* CONFIG_ARM64_PA_BITS_52_LPA */
@@ -629,9 +637,17 @@ alternative_endif
 	bfxil	\phys, \pte, #PAGE_SHIFT, #(48 - PAGE_SHIFT)
 	lsl	\phys, \phys, #PAGE_SHIFT
 #elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+	ldr_l   \phys, arm64_lpa2_enabled
+	cmp     \phys, #1
+	b.ne    .Lskip_lpa2\@
+
 	ubfiz	\phys, \pte, #(52 - PAGE_SHIFT - 10), #10
 	bfxil	\phys, \pte, #PAGE_SHIFT, #(50 - PAGE_SHIFT)
 	lsl	\phys, \phys, #PAGE_SHIFT
+	b	.Ldone_lpa2\@
+.Lskip_lpa2\@:
+	and	\phys, \pte, #PTE_ADDR_MASK_48
+.Ldone_lpa2\@:
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 	and	\phys, \pte, #PTE_ADDR_MASK
 #endif /* CONFIG_ARM64_PA_BITS_52_LPA */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 8a3b75e..b98b764 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -176,6 +176,8 @@
 #define PTE_ADDR_MASK		PTE_ADDR_LOW
 #endif /* CONFIG_ARM64_PA_BITS_52_LPA */
 
+#define PTE_ADDR_MASK_48	(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
+
 /*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
  */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5e7e402..97b3cd2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -71,9 +71,17 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 36))
 #define __phys_to_pte_val(phys)	(((phys) | ((phys) >> 36)) & PTE_ADDR_MASK)
 #elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
-#define __pte_to_phys(pte)	\
+#define __pte_to_phys_52(pte)	\
 	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 42))
-#define __phys_to_pte_val(phys)	(((phys) | ((phys) >> 42)) & PTE_ADDR_MASK)
+#define __phys_to_pte_val_52(phys)	(((phys) | ((phys) >> 42)) & PTE_ADDR_MASK)
+
+#define __pte_to_phys_48(pte)		(pte_val(pte) & PTE_ADDR_MASK_48)
+#define __phys_to_pte_val_48(phys)	(phys)
+
+#define __pte_to_phys(pte)	\
+	(arm64_lpa2_enabled ? __pte_to_phys_52(pte) : __pte_to_phys_48(pte))
+#define __phys_to_pte_val(phys)	\
+	(arm64_lpa2_enabled ? __phys_to_pte_val_52(phys) : __phys_to_pte_val_48(phys))
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 #define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_MASK)
 #define __phys_to_pte_val(phys)	(phys)
-- 
2.7.4

