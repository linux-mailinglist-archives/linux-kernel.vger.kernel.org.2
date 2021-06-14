Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A913A5E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhFNIT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:19:57 -0400
Received: from foss.arm.com ([217.140.110.172]:57448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhFNIT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:19:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9203C1FB;
        Mon, 14 Jun 2021 01:17:53 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.85.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DD633F694;
        Mon, 14 Jun 2021 01:17:51 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop SECTION_[SHIFT|SIZE|MASK]
Date:   Mon, 14 Jun 2021 13:48:26 +0530
Message-Id: <1623658706-7182-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SECTION_[SHIFT|SIZE|MASK] are essentially PMD_[SHIFT|SIZE|MASK]. But these
create confusion being similar to generic sparsemem memory sections, which
are derived from SECTION_SIZE_BITS. Section references have always implied
PMD level block mapping. Instead just use all PMD level macros which would
make it explicit and also remove confusion with sparsmem memory sections.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.13-rc6.

 arch/arm64/include/asm/kernel-pgtable.h | 4 ++--
 arch/arm64/include/asm/pgtable-hwdef.h  | 7 -------
 arch/arm64/mm/mmu.c                     | 2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index d44df9d62fc9..88b8d681ad91 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -91,8 +91,8 @@
 
 /* Initial memory map size */
 #if ARM64_SWAPPER_USES_SECTION_MAPS
-#define SWAPPER_BLOCK_SHIFT	SECTION_SHIFT
-#define SWAPPER_BLOCK_SIZE	SECTION_SIZE
+#define SWAPPER_BLOCK_SHIFT	PMD_SHIFT
+#define SWAPPER_BLOCK_SIZE	PMD_SIZE
 #define SWAPPER_TABLE_SHIFT	PUD_SHIFT
 #else
 #define SWAPPER_BLOCK_SHIFT	PAGE_SHIFT
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index b82575a33f8b..40085e53f573 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -71,13 +71,6 @@
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
 
-/*
- * Section address mask and size definitions.
- */
-#define SECTION_SHIFT		PMD_SHIFT
-#define SECTION_SIZE		(_AC(1, UL) << SECTION_SHIFT)
-#define SECTION_MASK		(~(SECTION_SIZE-1))
-
 /*
  * Contiguous page definitions.
  */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 89b66ef43a0f..380771610dd2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -228,7 +228,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 		next = pmd_addr_end(addr, end);
 
 		/* try section mapping first */
-		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
+		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
 			pmd_set_huge(pmdp, phys, prot);
 
-- 
2.20.1

