Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA573D8FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhG1NyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:54:07 -0400
Received: from foss.arm.com ([217.140.110.172]:56948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237497AbhG1NxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:53:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A98E6106F;
        Wed, 28 Jul 2021 06:52:59 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 098B53F70D;
        Wed, 28 Jul 2021 06:52:57 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 07/10] arm64: Add erratum detection for TRBE overwrite in FILL mode
Date:   Wed, 28 Jul 2021 14:52:14 +0100
Message-Id: <20210728135217.591173-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210728135217.591173-1-suzuki.poulose@arm.com>
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
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

Note that the Kconfig entries will be added after we have added
the work around in the TRBE driver, which depends on the cpucap
from here.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 25 +++++++++++++++++++++++++
 arch/arm64/tools/cpucaps       |  1 +
 2 files changed, 26 insertions(+)

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
2.24.1

