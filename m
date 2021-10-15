Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56C342E42E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhJNWdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:33:51 -0400
Received: from foss.arm.com ([217.140.110.172]:60948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234227AbhJNWdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:33:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DC0B150C;
        Thu, 14 Oct 2021 15:31:39 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED0C63F694;
        Thu, 14 Oct 2021 15:31:37 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 02/15] arm64: errata: Add detection for TRBE overwrite in FILL mode
Date:   Thu, 14 Oct 2021 23:31:12 +0100
Message-Id: <20211014223125.2605031-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211014223125.2605031-1-suzuki.poulose@arm.com>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Neoverse-N2 and the Cortex-A710 cores are affected
by a CPU erratum where the TRBE will overwrite the trace buffer
in FILL mode. The TRBE doesn't stop (as expected in FILL mode)
when it reaches the limit and wraps to the base to continue
writing upto 3 cache lines. This will overwrite any trace that
was written previously.

Add the Neoverse-N2 erratumi(#2139208) and Cortex-A710 erratum
(#2119858) to the  detection logic.

This will be used by the TRBE driver in later patches to work
around the issue. The detection has been kept with the core
arm64 errata framework list to make sure :
  - We don't duplicate the framework in TRBE driver
  - The errata detection is advertised like the rest
    of the CPU errata.

Note that the Kconfig entries are not fully active until the
TRBE driver implements the work around.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
cc: Leo Yan <leo.yan@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/arm64/silicon-errata.rst |  4 +++
 arch/arm64/Kconfig                     | 41 ++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         | 25 ++++++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 4 files changed, 71 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index d410a47ffa57..2f99229d993c 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -92,12 +92,16 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 077f2ec4eeb2..b452181d3638 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -666,6 +666,47 @@ config ARM64_ERRATUM_1508412
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	bool
+
+config ARM64_ERRATUM_2119858
+	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
+	default y
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	help
+	  This option adds the workaround for ARM Cortex-A710 erratum 2119858.
+
+	  Affected Cortex-A710 cores could overwrite up to 3 cache lines of trace
+	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
+	  the event of a WRAP event.
+
+	  Work around the issue by always making sure we move the TRBPTR_EL1 by
+	  256 bytes before enabling the buffer and filling the first 256 bytes of
+	  the buffer with ETM ignore packets upon disabling.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_2139208
+	bool "Neoverse-N2: 2139208: workaround TRBE overwriting trace data in FILL mode"
+	default y
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	help
+	  This option adds the workaround for ARM Neoverse-N2 erratum 2139208.
+
+	  Affected Neoverse-N2 cores could overwrite up to 3 cache lines of trace
+	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
+	  the event of a WRAP event.
+
+	  Work around the issue by always making sure we move the TRBPTR_EL1 by
+	  256 bytes before enabling the buffer and filling the first 256 bytes of
+	  the buffer with ETM ignore packets upon disabling.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e2c20c036442..ccd757373f36 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -340,6 +340,18 @@ static const struct midr_range erratum_1463225[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2139208
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2119858
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+#endif
+	{},
+};
+#endif	/* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -533,6 +545,19 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_WORKAROUND_NVIDIA_CARMEL_CNP,
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
 	},
+#endif
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	{
+		/*
+		 * The erratum work around is handled within the TRBE
+		 * driver and can be applied per-cpu. So, we can allow
+		 * a late CPU to come online with this erratum.
+		 */
+		.desc = "ARM erratum 2119858 or 2139208",
+		.capability = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 49305c2e6dfd..1ccb92165bd8 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -53,6 +53,7 @@ WORKAROUND_1418040
 WORKAROUND_1463225
 WORKAROUND_1508412
 WORKAROUND_1542419
+WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115
-- 
2.25.4

