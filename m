Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D04270BB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbhJHSb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:31:26 -0400
Received: from foss.arm.com ([217.140.110.172]:41372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239913AbhJHSbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:31:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51A5C1396;
        Fri,  8 Oct 2021 11:29:26 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C6E13F766;
        Fri,  8 Oct 2021 11:29:24 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, coresight@lists.linaro.org,
        maz@kernel.org, james.morse@arm.com, mark.rutland@arm.com,
        lcherian@marvell.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 03/16] arm64: errata: Add workaround for TSB flush failures
Date:   Fri,  8 Oct 2021 19:28:53 +0100
Message-Id: <20211008182906.1688009-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211008182906.1688009-1-suzuki.poulose@arm.com>
References: <20211008182906.1688009-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Neoverse-N2 (#2067961) and Cortex-A710 (#2054223) suffers
from errata, where a TSB (trace synchronization barrier)
fails to flush the trace data completely, when executed from
a trace prohibited region. In Linux we always execute it
after we have moved the PE to trace prohibited region. So,
we can apply the workaround every time a TSB is executed.

The work around is to issue two TSB consecutively.

NOTE: This errata is defined as LOCAL_CPU_ERRATUM, implying
that a late CPU could be blocked from booting if it is the
first CPU that requires the workaround. This is because we
do not allow setting a cpu_hwcaps after the SMP boot. The
other alternative is to use "this_cpu_has_cap()" instead
of the faster system wide check, which may be a bit of an
overhead, given we may have to do this in nvhe KVM host
before a guest entry.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
 - Split the Kconfig/erratum list update to a later patch
   I have retained the tags, as there were no changes to
   the patches as such, except for split and move
---
 arch/arm64/include/asm/barrier.h | 16 +++++++++++++++-
 arch/arm64/kernel/cpu_errata.c   | 19 +++++++++++++++++++
 arch/arm64/tools/cpucaps         |  1 +
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 451e11e5fd23..1c5a00598458 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -23,7 +23,7 @@
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
 #define psb_csync()	asm volatile("hint #17" : : : "memory")
-#define tsb_csync()	asm volatile("hint #18" : : : "memory")
+#define __tsb_csync()	asm volatile("hint #18" : : : "memory")
 #define csdb()		asm volatile("hint #20" : : : "memory")
 
 #ifdef CONFIG_ARM64_PSEUDO_NMI
@@ -46,6 +46,20 @@
 #define dma_rmb()	dmb(oshld)
 #define dma_wmb()	dmb(oshst)
 
+
+#define tsb_csync()								\
+	do {									\
+		/*								\
+		 * CPUs affected by Arm Erratum 2054223 or 2067961 needs	\
+		 * another TSB to ensure the trace is flushed. The barriers	\
+		 * don't have to be strictly back to back, as long as the	\
+		 * CPU is in trace prohibited state.				\
+		 */								\
+		if (cpus_have_final_cap(ARM64_WORKAROUND_TSB_FLUSH_FAILURE))	\
+			__tsb_csync();						\
+		__tsb_csync();							\
+	} while (0)
+
 /*
  * Generate a mask for array_index__nospec() that is ~0UL when 0 <= idx < sz
  * and 0 otherwise.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index ccd757373f36..bdbeac75ead6 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -352,6 +352,18 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 };
 #endif	/* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
 
+#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+static const struct midr_range tsb_flush_fail_cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2067961
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2054223
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+#endif
+	{},
+};
+#endif	/* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -558,6 +570,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
 	},
+#endif
+#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILRE
+	{
+		.desc = "ARM erratum 2067961 or 2054223",
+		.capability = ARM64_WORKAROUND_TSB_FLUSH_FAILURE,
+		ERRATA_MIDR_RANGE_LIST(tsb_flush_fail_cpus),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 1ccb92165bd8..2102e15af43d 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -54,6 +54,7 @@ WORKAROUND_1463225
 WORKAROUND_1508412
 WORKAROUND_1542419
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115
-- 
2.25.4

