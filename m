Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A367041A724
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 07:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhI1Fe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 01:34:27 -0400
Received: from foss.arm.com ([217.140.110.172]:57832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhI1FeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:34:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FCC4D6E;
        Mon, 27 Sep 2021 22:32:45 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.74.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B37B3F70D;
        Mon, 27 Sep 2021 22:32:43 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/mm: Fix idmap on [16K|36VA|48PA]
Date:   Tue, 28 Sep 2021 11:03:45 +0530
Message-Id: <1632807225-20189-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating the idmap, the kernel may add one extra level to idmap memory
outside the VA range. But for [16K|36VA|48PA], we need two levels to reach
48 bits. If the bootloader places the kernel in memory above (1 << 46), the
kernel will fail to enable the MMU. Although we are not aware of a platform
where this happens, it is worth to accommodate such scenarios and prevent a
possible kernel crash.

Lets fix this problem by carefully analyzing existing VA_BITS with respect
to maximum possible mapping with the existing PGDIR level i.e (PGDIR_SHIFT
+ PAGE_SHIFT - 3) and then evaluating how many extra page table levels are
required to accommodate the reduced idmap_t0sz to map __idmap_text_end.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: 215399392fe4 ("arm64: 36 bit VA")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.15-rc3.

This is a different approach as compared to V1 which still applies on the
latest mainline. Besides this enables all upcoming FEAT_LPA2 combinations
as well. Please do suggest which approach would be preferred.

- Anshuman

 V1:  https://lore.kernel.org/all/1627879359-30303-1-git-send-email-anshuman.khandual@arm.com/
RFC: https://lore.kernel.org/lkml/1627019894-14819-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm64/include/asm/assembler.h |  9 ++++++++
 arch/arm64/kernel/head.S           | 46 +++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bfa5840..e5b5d3a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -25,6 +25,15 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
+	.macro shift_to_ptrs, ptrs, shift, tmp, tmp1
+	ldr_l   \tmp1, idmap_t0sz
+	add     \tmp1, \tmp1, \shift
+	mov     \tmp, #64
+	sub     \tmp, \tmp, \tmp1
+	mov     \ptrs, #1
+	lsr     \ptrs, \ptrs, \tmp
+	.endm
+
 	/*
 	 * Provide a wxN alias for each wN register so what we can paste a xN
 	 * reference after a 'w' to obtain the 32-bit version.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 1796245..b93d50d 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -328,30 +328,40 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	dmb	sy
 	dc	ivac, x6		// Invalidate potentially stale cache line
 
-#if (VA_BITS < 48)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
-#define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
-
-	/*
-	 * If VA_BITS < 48, we have to configure an additional table level.
-	 * First, we have to verify our assumption that the current value of
-	 * VA_BITS was chosen such that all translation levels are fully
-	 * utilised, and that lowering T0SZ will always result in an additional
-	 * translation level to be configured.
-	 */
-#if VA_BITS != EXTRA_SHIFT
+#define EXTRA_SHIFT_1	(EXTRA_SHIFT + PAGE_SHIFT - 3)
+#if (VA_BITS > EXTRA_SHIFT)
 #error "Mismatch between VA_BITS and page size/number of translation levels"
 #endif
 
-	mov	x4, EXTRA_PTRS
+#if (VA_BITS == EXTRA_SHIFT)
+	mov	x6, #TCR_T0SZ(VA_BITS_MIN)
+	sub	x6, x6, x5
+	cmp	x6, #(PAGE_SHIFT - 3)
+	b.gt	8f
+
+	shift_to_ptrs x4, EXTRA_SHIFT, x5, x6
 	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
-#else
-	/*
-	 * If VA_BITS == 48, we don't have to configure an additional
-	 * translation level, but the top-level table has more entries.
-	 */
-	mov	x4, #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT)
+	b	1f
+8:
+	shift_to_ptrs x4, EXTRA_SHIFT_1, x5, x6
+	create_table_entry x0, x3, EXTRA_SHIFT_1, x4, x5, x6
+
+	mov     x4, PTRS_PER_PTE
+	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
+#elif (VA_BITS < EXTRA_SHIFT)
+	mov	x6, #64
+	sub	x6, x6, x5
+	cmp	x6, EXTRA_SHIFT
+	b.eq	1f
+	b.gt	9f
+
+	shift_to_ptrs x4, PGDIR_SHIFT, x5, x6
 	str_l	x4, idmap_ptrs_per_pgd, x5
+	b	1f
+9:
+	shift_to_ptrs x4, EXTRA_SHIFT, x5, x6
+	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
 #endif
 1:
 	ldr_l	x4, idmap_ptrs_per_pgd
-- 
2.7.4

