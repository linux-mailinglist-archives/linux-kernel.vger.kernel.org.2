Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE413DFB8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhHDGqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 02:46:51 -0400
Received: from foss.arm.com ([217.140.110.172]:56844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhHDGqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 02:46:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6518011FB;
        Tue,  3 Aug 2021 23:46:38 -0700 (PDT)
Received: from [10.163.67.195] (unknown [10.163.67.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 062493F66F;
        Tue,  3 Aug 2021 23:46:35 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64/mm: Fix idmap on [16K|36VA|48PA]
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <1627879359-30303-1-git-send-email-anshuman.khandual@arm.com>
 <20210803103440.GA5786@arm.com>
 <7bad50a2-76f1-7946-3a15-35e46fb289c0@arm.com>
 <20210803131201.GB5786@arm.com>
 <4d6a4a0c-7f68-991d-5b0e-08c280543fe8@arm.com>
Message-ID: <cad9294f-8158-6aa4-5740-26f534530740@arm.com>
Date:   Wed, 4 Aug 2021 12:17:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4d6a4a0c-7f68-991d-5b0e-08c280543fe8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/21 9:16 AM, Anshuman Khandual wrote:
> I am working on a solution which re-works idmap extension logic based on the
> difference between __idmap_text_end and PGDIR_SHIFT coverage, then creating
> additional page table levels and reducing idmap_t0sz appropriately. All the
> existing code including this fix here, will be dropped completely. Because
> it might be difficult to extend this patch to get the entire thing in order,
> the idea was to just fix [16K|36VA|48PA] which could then be backported and
> then do the rework in mainline (which need not be backported)

FYI.

Here is the rework (draft standard, lightly tested and not documented) which
I have been working on. It tries to take care of three different situations,
when __idmap_text_end would not be covered with the existing idmap levels.

1. idmap requires single new level
2. idmap requires two new levels
3. idmap does not require more levels but idmap_ptrs_per_pgd needs adjustment

Applies after the fix here.

---
 arch/arm64/include/asm/assembler.h |  9 ++++++
 arch/arm64/kernel/head.S           | 62 +++++++++++++++-----------------------
 2 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 89faca0..d826641 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -25,6 +25,15 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
+	.macro shift_to_nr_ptrs, reg1, reg2, reg3, tmp
+	ldr_l   \reg3, idmap_t0sz
+	add     \reg3, \reg3, \tmp
+	mov     \reg2, #64
+	sub     \reg2, \reg2, \reg3
+	mov     \reg1, #1
+	lsr     \reg1, \reg1, \reg2
+	.endm
+
 	/*
 	 * Provide a wxN alias for each wN register so what we can paste a xN
 	 * reference after a 'w' to obtain the 32-bit version.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index da33bbc..b308787 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -327,54 +327,40 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	dmb	sy
 	dc	ivac, x6		// Invalidate potentially stale cache line
 
-#if (VA_BITS < 48)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
 #define EXTRA_SHIFT_1	(EXTRA_SHIFT + PAGE_SHIFT - 3)
-#define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
-#define EXTRA_PTRS_1	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT_1))
-
-	/*
-	 * If VA_BITS < 48, we have to configure an additional table level.
-	 * First, we have to verify our assumption that the current value of
-	 * VA_BITS was chosen such that all translation levels are fully
-	 * utilised, and that lowering T0SZ will always result in an additional
-	 * translation level to be configured.
-	 */
-#if VA_BITS != EXTRA_SHIFT
+#if (VA_BITS > EXTRA_SHIFT)
 #error "Mismatch between VA_BITS and page size/number of translation levels"
 #endif
 
-/*
- * In this particular CONFIG_ARM64_16K_PAGES config, there might be a
- * scenario where 'idmap_text_end' ends up high enough in the PA range
- * requiring two additional idmap page table levels. Reduce idmap_t0sz
- * to cover the entire PA range. This prevents table misconfiguration
- * when a given idmap_t0sz value just requires single additional level
- * where as two levels have been built.
- */
-#if defined(CONFIG_ARM64_VA_BITS_36) && defined(CONFIG_ARM64_PA_BITS_48)
-	mov	x4, EXTRA_PTRS_1
-	create_table_entry x0, x3, EXTRA_SHIFT_1, x4, x5, x6
+#if (VA_BITS == EXTRA_SHIFT)
+	mov	x6, #TCR_T0SZ(VA_BITS_MIN)
+	sub	x6, x6, x5
+	cmp	x6, #(PAGE_SHIFT - 3)
+	b.gt	8f
 
-	mov	x4, PTRS_PER_PTE
+	shift_to_nr_ptrs x4, x5, x6, #EXTRA_SHIFT
 	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
+	b	1f
+8:
+	shift_to_nr_ptrs x4, x5, x6, #EXTRA_SHIFT_1
+	create_table_entry x0, x3, EXTRA_SHIFT_1, x4, x5, x6
 
-	mov	x5, #64 - PHYS_MASK_SHIFT
-	adr_l	x6, idmap_t0sz
-	str	x5, [x6]
-	dmb	sy
-	dc	ivac, x6
-#else
-	mov	x4, EXTRA_PTRS
+	mov     x4, PTRS_PER_PTE
 	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
-#endif
-#else
-	/*
-	 * If VA_BITS == 48, we don't have to configure an additional
-	 * translation level, but the top-level table has more entries.
-	 */
-	mov	x4, #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT)
+#elif (VA_BITS < EXTRA_SHIFT)
+	mov	x6, #64
+	sub	x6, x6, x5
+	cmp	x6, EXTRA_SHIFT
+	b.eq	1f
+	b.gt	8f
+
+	shift_to_nr_ptrs x4, x5, x6, #PGDIR_SHIFT
 	str_l	x4, idmap_ptrs_per_pgd, x5
+	b	1f
+8:
+	shift_to_nr_ptrs x4, x5, x6, #EXTRA_SHIFT
+	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
 #endif
 1:
 	ldr_l	x4, idmap_ptrs_per_pgd
-- 
2.7.4

