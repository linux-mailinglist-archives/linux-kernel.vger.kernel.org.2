Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A4D42A54C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhJLNUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:20:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236695AbhJLNUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:20:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A6F21396;
        Tue, 12 Oct 2021 06:18:12 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA3173F70D;
        Tue, 12 Oct 2021 06:18:10 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 03/15] arm64: errata: Add workaround for TSB flush failures
Date:   Tue, 12 Oct 2021 14:17:31 +0100
Message-Id: <20211012131743.2040596-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211012131743.2040596-1-suzuki.poulose@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
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
Changes since v3:
 - Merge the Kconfig changes back.
---
 Documentation/arm64/silicon-errata.rst |  4 ++++
 arch/arm64/Kconfig                     | 33 ++++++++++++++++++++++++++
 arch/arm64/include/asm/barrier.h       | 16 ++++++++++++-
 arch/arm64/kernel/cpu_errata.c         | 19 +++++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 5 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 2f99229d993c..569a92411dcd 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -94,6 +94,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -102,6 +104,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 404f56e87e93..b9b181470f0f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -707,6 +707,39 @@ config ARM64_ERRATUM_2139208
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+	bool
+
+config ARM64_ERRATUM_2054223
+	bool "Cortex-A710: 2054223: workaround TSB instruction failing to flush trace"
+	default y
+	select ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+	help
+	  Enable workaround for ARM Cortex-A710 erratum 2054223
+
+	  Affected cores may fail to flush the trace data on a TSB instruction, when
+	  the PE is in trace prohibited state. This will cause losing a few bytes
+	  of the trace cached.
+
+	  Workaround is to issue two TSB consecutively on affected cores.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_2067961
+	bool "Neoverse-N2: 2067961: workaround TSB instruction failing to flush trace"
+	default y
+	select ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+	help
+	  Enable workaround for ARM Neoverse-N2 erratum 2067961
+
+	  Affected cores may fail to flush the trace data on a TSB instruction, when
+	  the PE is in trace prohibited state. This will cause losing a few bytes
+	  of the trace cached.
+
+	  Workaround is to issue two TSB consecutively on affected cores.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
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

