Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4F3D345D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 07:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhGWFRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 01:17:08 -0400
Received: from foss.arm.com ([217.140.110.172]:40920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233740AbhGWFRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 01:17:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5493D106F;
        Thu, 22 Jul 2021 22:57:41 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9D5B3F66F;
        Thu, 22 Jul 2021 22:57:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: [RFC] arm64/mm: Fix idmap on [16K|36VA|48PA]
Date:   Fri, 23 Jul 2021 11:28:14 +0530
Message-Id: <1627019894-14819-1-git-send-email-anshuman.khandual@arm.com>
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

Lets fix the problem on the above configuration by creating two additional
idmap page table levels when 'idmap_text_end' is outside the VA range. This
reduces 'idmap_t0sz' to cover the entire PA range which would prevent table
misconfiguration (fault) when a given 'idmap_t0sz' value requires a single
additional page table level where as two have been built.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: 215399392fe4 ("arm64: 36 bit VA")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.14-rc2

 arch/arm64/kernel/head.S | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c5c994a..da33bbc 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -329,7 +329,9 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 
 #if (VA_BITS < 48)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
+#define EXTRA_SHIFT_1	(EXTRA_SHIFT + PAGE_SHIFT - 3)
 #define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
+#define EXTRA_PTRS_1	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT_1))
 
 	/*
 	 * If VA_BITS < 48, we have to configure an additional table level.
@@ -342,8 +344,30 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 #error "Mismatch between VA_BITS and page size/number of translation levels"
 #endif
 
+/*
+ * In this particular CONFIG_ARM64_16K_PAGES config, there might be a
+ * scenario where 'idmap_text_end' ends up high enough in the PA range
+ * requiring two additional idmap page table levels. Reduce idmap_t0sz
+ * to cover the entire PA range. This prevents table misconfiguration
+ * when a given idmap_t0sz value just requires single additional level
+ * where as two levels have been built.
+ */
+#if defined(CONFIG_ARM64_VA_BITS_36) && defined(CONFIG_ARM64_PA_BITS_48)
+	mov	x4, EXTRA_PTRS_1
+	create_table_entry x0, x3, EXTRA_SHIFT_1, x4, x5, x6
+
+	mov	x4, PTRS_PER_PTE
+	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
+
+	mov	x5, #64 - PHYS_MASK_SHIFT
+	adr_l	x6, idmap_t0sz
+	str	x5, [x6]
+	dmb	sy
+	dc	ivac, x6
+#else
 	mov	x4, EXTRA_PTRS
 	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
+#endif
 #else
 	/*
 	 * If VA_BITS == 48, we don't have to configure an additional
-- 
2.7.4

