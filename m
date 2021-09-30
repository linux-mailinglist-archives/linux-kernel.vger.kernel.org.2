Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4760F41D7DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350117AbhI3Kgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:36:38 -0400
Received: from foss.arm.com ([217.140.110.172]:52108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350094AbhI3Kgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:36:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BD3E106F;
        Thu, 30 Sep 2021 03:34:49 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4139D3F793;
        Thu, 30 Sep 2021 03:34:46 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V3 09/13] arm64/mm: Add __cpu_secondary_check52bitpa()
Date:   Thu, 30 Sep 2021 16:05:12 +0530
Message-Id: <1632998116-11552-10-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FEAT_LPA2 enabled systems needs to test ID_AA64MMFR0.TGRAN value to ensure
that 52 bit PA range is supported across all secondary CPUs both for 4K and
16K configs. This adds a new __cpu_secondary_check52bitva check along with
a corresponding reason code CPU_STUCK_REASON_52_BIT_PA. This will identify
the exact reason in case the system gets stuck after detecting a secondary
CPU that does not support 52 bit PA.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/smp.h |  1 +
 arch/arm64/kernel/head.S     | 21 +++++++++++++++++++++
 arch/arm64/kernel/smp.c      |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index fc55f5a..e5ff305 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -22,6 +22,7 @@
 
 #define CPU_STUCK_REASON_52_BIT_VA	(UL(1) << CPU_STUCK_REASON_SHIFT)
 #define CPU_STUCK_REASON_NO_GRAN	(UL(2) << CPU_STUCK_REASON_SHIFT)
+#define CPU_STUCK_REASON_52_BIT_PA	(UL(3) << CPU_STUCK_REASON_SHIFT)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ab21aac..0b48e4c 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -667,6 +667,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	 */
 	bl	switch_to_vhe
 	bl	__cpu_secondary_check52bitva
+	bl	__cpu_secondary_check52bitpa
 	bl	__cpu_setup			// initialise processor
 	adrp	x1, swapper_pg_dir
 	bl	__enable_mmu
@@ -770,6 +771,26 @@ SYM_FUNC_START(__cpu_secondary_check52bitva)
 2:	ret
 SYM_FUNC_END(__cpu_secondary_check52bitva)
 
+SYM_FUNC_START(__cpu_secondary_check52bitpa)
+#ifdef CONFIG_ARM64_PA_BITS_52_LPA2
+	ldr_l	x0, arm64_lpa2_enabled
+	cmp     x2, #1
+	b.ne	2f
+
+	mrs     x0, ID_AA64MMFR0_EL1
+	ubfx    x0, x0, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+	cmp     x0, #ID_AA64MMFR0_TGRAN_LPA2
+	b.ge	2f
+
+	update_early_cpu_boot_status \
+		CPU_STUCK_IN_KERNEL | CPU_STUCK_REASON_52_BIT_PA, x0, x1
+1:	wfe
+	wfi
+	b	1b
+#endif
+2:	ret
+SYM_FUNC_END(__cpu_secondary_check52bitpa)
+
 SYM_FUNC_START_LOCAL(__no_granule_support)
 	/* Indicate that this CPU can't boot and is stuck in the kernel */
 	update_early_cpu_boot_status \
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6f6ff072..a8d08d1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -164,6 +164,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		if (status & CPU_STUCK_REASON_NO_GRAN) {
 			pr_crit("CPU%u: does not support %luK granule\n",
 				cpu, PAGE_SIZE / SZ_1K);
+		if (status & CPU_STUCK_REASON_52_BIT_PA)
+			pr_crit("CPU%u: does not support 52-bit PAs\n", cpu);
 		}
 		cpus_stuck_in_kernel++;
 		break;
-- 
2.7.4

