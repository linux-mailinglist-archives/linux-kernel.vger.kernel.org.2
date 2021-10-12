Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCF342A54D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhJLNUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:20:20 -0400
Received: from foss.arm.com ([217.140.110.172]:41686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236765AbhJLNUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:20:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E85ED1;
        Tue, 12 Oct 2021 06:18:14 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD1303F70D;
        Tue, 12 Oct 2021 06:18:12 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 04/15] arm64: errata: Add detection for TRBE write to out-of-range
Date:   Tue, 12 Oct 2021 14:17:32 +0100
Message-Id: <20211012131743.2040596-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211012131743.2040596-1-suzuki.poulose@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Neoverse-N2 and Cortex-A710 cores are affected by an erratum where the
trbe, under some circumstances, might write upto 64bytes to an address after
the Limit as programmed by the TRBLIMITR_EL1.LIMIT. This might -

  - Corrupt a page in the ring buffer, which may corrupt trace from a
    previous session, consumed by userspace.
  - Hit the guard page at the end of the vmalloc area and raise a fault.

To keep the handling simpler, we always leave the last page from the
range, which TRBE is allowed to write. This can be achieved by ensuring
that we always have more than a PAGE worth space in the range, while
calculating the LIMIT for TRBE. And then the LIMIT pointer can be adjusted
to leave the PAGE (TRBLIMITR.LIMIT -= PAGE_SIZE), out of the TRBE range
while enabling it. This makes sure that the TRBE will only write to an area
within its allowed limit (i.e, [head-head+size]) and we do not have to handle
address faults within the driver.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/arm64/silicon-errata.rst |  4 +++
 arch/arm64/Kconfig                     | 41 ++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         | 20 +++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 4 files changed, 66 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 569a92411dcd..5342e895fb60 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -96,6 +96,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -106,6 +108,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b9b181470f0f..87a07e895db9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -740,6 +740,47 @@ config ARM64_ERRATUM_2067961
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	bool
+
+config ARM64_ERRATUM_2253138
+	bool "Neoverse-N2: 2253138: workaround TRBE writing to address out-of-range"
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	default y
+	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	help
+	  This option adds the workaround for ARM Neoverse-N2 erratum 2253138.
+
+	  Affected Neoverse-N2 cores might write to an out-of-range address, not reserved
+	  for TRBE. Under some conditions, the TRBE might generate a write to the next
+	  virtually addressed page following the last page of the TRBE address space
+	  (i.e, the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
+
+	  We work around this in the driver by, always making sure that there is a
+	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_2224489
+	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	default y
+	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	help
+	  This option adds the workaround for ARM Cortex-A710 erratum 2224489.
+
+	  Affected Cortex-A710 cores might write to an out-of-range address, not reserved
+	  for TRBE. Under some conditions, the TRBE might generate a write to the next
+	  virtually addressed page following the last page of the TRBE address space
+	  (i.e, the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
+
+	  We work around this in the driver by, always making sure that there is a
+	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index bdbeac75ead6..e2978b89d4b8 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -364,6 +364,18 @@ static const struct midr_range tsb_flush_fail_cpus[] = {
 };
 #endif	/* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
 
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+static struct midr_range trbe_write_out_of_range_cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2253138
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2224489
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+#endif
+	{},
+};
+#endif /* CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE */
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -577,6 +589,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_WORKAROUND_TSB_FLUSH_FAILURE,
 		ERRATA_MIDR_RANGE_LIST(tsb_flush_fail_cpus),
 	},
+#endif
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	{
+		.desc = "ARM erratum 2253138 or 2224489",
+		.capability = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		CAP_MIDR_RANGE_LIST(trbe_write_out_of_range_cpus),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 2102e15af43d..90628638e0f9 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -55,6 +55,7 @@ WORKAROUND_1508412
 WORKAROUND_1542419
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
+WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
 WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115
-- 
2.25.4

