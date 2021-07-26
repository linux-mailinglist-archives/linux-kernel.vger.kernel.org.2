Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3311E3D5346
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhGZF4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:56:51 -0400
Received: from foss.arm.com ([217.140.110.172]:45642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbhGZF4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:56:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E805139F;
        Sun, 25 Jul 2021 23:37:16 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 033E43F66F;
        Sun, 25 Jul 2021 23:37:11 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V2 06/10] arm64/mm: Add FEAT_LPA2 specific encoding
Date:   Mon, 26 Jul 2021 12:07:21 +0530
Message-Id: <1627281445-12445-7-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FEAT_LPA2 requires different PTE representation formats for both 4K and 16K
page size config. This adds FEAT_LPA2 specific new PTE encodings as per ARM
ARM (0487G.A) which updates [pte|phys]_to_[phys|pte](). The updated helpers
would be used when FEAT_LPA2 gets enabled via CONFIG_ARM64_PA_BITS_52 on 4K
and 16K page size. Although TTBR encoding and phys_to_ttbr() helper remains
the same as FEAT_LPA for FEAT_LPA2 as well. It updates 'phys_to_pte' helper
to accept a temporary variable and changes impacted call sites.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/assembler.h     | 14 +++++++++++---
 arch/arm64/include/asm/pgtable-hwdef.h |  4 ++++
 arch/arm64/include/asm/pgtable.h       |  4 ++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index fedc202..d7ce4cf 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -614,6 +614,10 @@ alternative_endif
 	 */
 	orr	\pte, \phys, \phys, lsr #36
 	and	\pte, \pte, #PTE_ADDR_MASK
+#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+	orr	\pte, \phys, \phys, lsr #42
+	and	\pte, \pte, #PTE_ADDR_MASK | GENMASK(PAGE_SHIFT - 1, 10)
+	and	\pte, \pte, #~GENMASK(PAGE_SHIFT - 1, 10)
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 	mov	\pte, \phys
 #endif /* CONFIG_ARM64_PA_BITS_52_LPA */
@@ -621,9 +625,13 @@ alternative_endif
 
 	.macro	pte_to_phys, phys, pte
 #ifdef CONFIG_ARM64_PA_BITS_52_LPA
-	ubfiz	\phys, \pte, #(48 - 16 - 12), #16
-	bfxil	\phys, \pte, #16, #32
-	lsl	\phys, \phys, #16
+	ubfiz	\phys, \pte, #(48 - PAGE_SHIFT - 12), #16
+	bfxil	\phys, \pte, #PAGE_SHIFT, #(48 - PAGE_SHIFT)
+	lsl	\phys, \phys, #PAGE_SHIFT
+#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+	ubfiz	\phys, \pte, #(52 - PAGE_SHIFT - 10), #10
+	bfxil	\phys, \pte, #PAGE_SHIFT, #(50 - PAGE_SHIFT)
+	lsl	\phys, \phys, #PAGE_SHIFT
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 	and	\phys, \pte, #PTE_ADDR_MASK
 #endif /* CONFIG_ARM64_PA_BITS_52_LPA */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index f375bcf..c815a85 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -159,6 +159,10 @@
 #define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 #define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
 #define PTE_ADDR_MASK		(PTE_ADDR_LOW | PTE_ADDR_HIGH)
+#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+#define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (50 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
+#define PTE_ADDR_HIGH		(_AT(pteval_t, 0x3) << 8)
+#define PTE_ADDR_MASK		(PTE_ADDR_LOW | PTE_ADDR_HIGH)
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 #define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 #define PTE_ADDR_MASK		PTE_ADDR_LOW
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3c57fb2..5e7e402 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -70,6 +70,10 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define __pte_to_phys(pte)	\
 	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 36))
 #define __phys_to_pte_val(phys)	(((phys) | ((phys) >> 36)) & PTE_ADDR_MASK)
+#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+#define __pte_to_phys(pte)	\
+	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 42))
+#define __phys_to_pte_val(phys)	(((phys) | ((phys) >> 42)) & PTE_ADDR_MASK)
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 #define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_MASK)
 #define __phys_to_pte_val(phys)	(phys)
-- 
2.7.4

