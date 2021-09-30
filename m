Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB9F41D7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350091AbhI3Kgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:36:43 -0400
Received: from foss.arm.com ([217.140.110.172]:52126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350067AbhI3Kgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:36:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4638511D4;
        Thu, 30 Sep 2021 03:34:57 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2CD93F793;
        Thu, 30 Sep 2021 03:34:53 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V3 11/13] arm64/mm: Add FEAT_LPA2 specific fallback (48 bits PA) when not implemented
Date:   Thu, 30 Sep 2021 16:05:14 +0530
Message-Id: <1632998116-11552-12-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
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
index c1543067..e4f67ab 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -629,9 +629,17 @@ alternative_endif
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
@@ -643,9 +651,17 @@ alternative_endif
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
index 9038d05..5365661 100644
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

