Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91EC41D7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350046AbhI3KgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:36:07 -0400
Received: from foss.arm.com ([217.140.110.172]:52034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350037AbhI3KgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:36:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62FF7106F;
        Thu, 30 Sep 2021 03:34:23 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34C193F793;
        Thu, 30 Sep 2021 03:34:19 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V3 02/13] arm64/mm: Consolidate TCR_EL1 fields
Date:   Thu, 30 Sep 2021 16:05:05 +0530
Message-Id: <1632998116-11552-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames and moves SYS_TCR_EL1_TCMA1 and SYS_TCR_EL1_TCMA0 definitions
into pgtable-hwdef.h thus consolidating all TCR fields in a single header.
This does not cause any functional change.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 2 ++
 arch/arm64/include/asm/sysreg.h        | 4 ----
 arch/arm64/mm/proc.S                   | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 40085e5..66671ff 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -273,6 +273,8 @@
 #define TCR_NFD1		(UL(1) << 54)
 #define TCR_E0PD0		(UL(1) << 55)
 #define TCR_E0PD1		(UL(1) << 56)
+#define TCR_TCMA0		(UL(1) << 57)
+#define TCR_TCMA1		(UL(1) << 58)
 
 /*
  * TTBR.
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b268082..4630eac 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1076,10 +1076,6 @@
 #define CPACR_EL1_ZEN_EL0EN	(BIT(17)) /* enable EL0 access, if EL1EN set */
 #define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
 
-/* TCR EL1 Bit Definitions */
-#define SYS_TCR_EL1_TCMA1	(BIT(58))
-#define SYS_TCR_EL1_TCMA0	(BIT(57))
-
 /* GCR_EL1 Definitions */
 #define SYS_GCR_EL1_RRND	(BIT(16))
 #define SYS_GCR_EL1_EXCL_MASK	0xffffUL
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index d35c90d..50bbed9 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -46,7 +46,7 @@
 #endif
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define TCR_MTE_FLAGS SYS_TCR_EL1_TCMA1 | TCR_TBI1 | TCR_TBID1
+#define TCR_MTE_FLAGS TCR_TCMA1 | TCR_TBI1 | TCR_TBID1
 #else
 /*
  * The mte_zero_clear_page_tags() implementation uses DC GZVA, which relies on
-- 
2.7.4

