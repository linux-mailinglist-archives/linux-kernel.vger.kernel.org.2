Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8754270BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbhJHSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:31:28 -0400
Received: from foss.arm.com ([217.140.110.172]:41390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240176AbhJHSbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:31:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD3613A1;
        Fri,  8 Oct 2021 11:29:28 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83E983F766;
        Fri,  8 Oct 2021 11:29:26 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, coresight@lists.linaro.org,
        maz@kernel.org, james.morse@arm.com, mark.rutland@arm.com,
        lcherian@marvell.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 04/16] arm64: errata: Add detection for TRBE write to out-of-range
Date:   Fri,  8 Oct 2021 19:28:54 +0100
Message-Id: <20211008182906.1688009-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211008182906.1688009-1-suzuki.poulose@arm.com>
References: <20211008182906.1688009-1-suzuki.poulose@arm.com>
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
 arch/arm64/kernel/cpu_errata.c | 20 ++++++++++++++++++++
 arch/arm64/tools/cpucaps       |  1 +
 2 files changed, 21 insertions(+)

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

