Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69DD41D7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350045AbhI3Kge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:36:34 -0400
Received: from foss.arm.com ([217.140.110.172]:52096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350080AbhI3Kg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:36:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B664B106F;
        Thu, 30 Sep 2021 03:34:45 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 889CE3F793;
        Thu, 30 Sep 2021 03:34:42 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V3 08/13] arm64/mm: Detect and enable FEAT_LPA2
Date:   Thu, 30 Sep 2021 16:05:11 +0530
Message-Id: <1632998116-11552-9-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect FEAT_LPA2 implementation early enough during boot when requested via
CONFIG_ARM64_PA_BITS_52_LPA2 and remember in a variable arm64_lpa2_enabled.
This variable could then be used to turn on TCR_EL1.TCR_DS effecting the 52
bits PA range or fall back to default 48 bits PA range if FEAT_LPA2 feature
was requested but found not to be implemented.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/memory.h |  1 +
 arch/arm64/kernel/head.S        | 15 +++++++++++++++
 arch/arm64/mm/mmu.c             |  3 +++
 arch/arm64/mm/proc.S            |  9 +++++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f1745a8..41bf258 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -178,6 +178,7 @@
 #include <asm/bug.h>
 
 extern u64			vabits_actual;
+extern u64			arm64_lpa2_enabled;
 
 extern s64			memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index a8b6716..ab21aac 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -94,6 +94,21 @@ SYM_CODE_START(primary_entry)
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
+
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA2
+	mrs     x10, ID_AA64MMFR0_EL1
+	ubfx    x10, x10, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+	cmp     x10, #ID_AA64MMFR0_TGRAN_LPA2
+	b.lt	1f
+
+	mov	x10, #1
+	adr_l	x11, arm64_lpa2_enabled
+	str	x10, [x11]
+	dmb	sy
+	dc	ivac, x11
+1:
+#endif /* CONFIG_ARM64_PA_BITS_52_LPA2 */
+
 	bl	__create_page_tables
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cfd9deb..b2a4d98 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -48,6 +48,9 @@ u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 u64 __section(".mmuoff.data.write") vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
+u64 __section(".mmuoff.data.write") arm64_lpa2_enabled;
+EXPORT_SYMBOL(arm64_lpa2_enabled);
+
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 50bbed9..a1578e7 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -423,6 +423,15 @@ SYM_FUNC_START(__cpu_setup)
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
 
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA2
+	ldr_l   x10, arm64_lpa2_enabled
+	cmp	x10, #1
+	b.ne	1f
+	mov_q	x10, TCR_DS
+	orr	tcr, tcr, x10
+1:
+#endif /* CONFIG_ARM64_PA_BITS_52_LPA2 */
+
 #ifdef CONFIG_ARM64_MTE
 	/*
 	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
-- 
2.7.4

