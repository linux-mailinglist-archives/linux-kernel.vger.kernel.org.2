Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704083C7BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhGNCYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:24:31 -0400
Received: from foss.arm.com ([217.140.110.172]:55838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237471AbhGNCYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:24:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BED231042;
        Tue, 13 Jul 2021 19:21:39 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B8253F7D8;
        Tue, 13 Jul 2021 19:21:36 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 09/10] arm64/mm: Add FEAT_LPA2 specific fallback (48 bits PA) when not implemented
Date:   Wed, 14 Jul 2021 07:51:30 +0530
Message-Id: <1626229291-6569-10-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
References: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ARM64_PA_BITS_52 build kernels need to fallback for 48 bits PA range
encodings when FEAT_LPA2 is not implemented i.e TCR_EL1.DS could not be set
.  Hence modify applicable PTE and TTBR encoding helpers to accommodate the
scenario via 'arm64_lpa2_enabled'.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/assembler.h     | 13 +++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  2 ++
 arch/arm64/include/asm/pgtable.h       | 12 ++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0492543..844e9a0 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -615,6 +615,10 @@ alternative_endif
 	orr	\pte, \phys, \phys, lsr #36
 	and	\pte, \pte, #PTE_ADDR_MASK
 #elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
+	ldr_l   \tmp, arm64_lpa2_enabled
+	cmp     \tmp, #1
+	b.ne    .Lskip_lpa2\@
+
 	orr	\pte, \phys, \phys, lsr #42
 
 	/*
@@ -625,6 +629,9 @@ alternative_endif
 	mov	\tmp, #PTE_ADDR_LOW
 	orr	\tmp, \tmp, #PTE_ADDR_HIGH
 	and	\pte, \pte, \tmp
+
+.Lskip_lpa2\@:
+	mov	\pte, \phys
 #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
 	mov	\pte, \phys
 #endif /* CONFIG_ARM64_PA_BITS_52_LPA */
@@ -636,9 +643,15 @@ alternative_endif
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
+.Lskip_lpa2\@:
+	and	\phys, \pte, #PTE_ADDR_MASK_48
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

