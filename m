Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34F41349F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhIUNnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:43:49 -0400
Received: from foss.arm.com ([217.140.110.172]:33956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhIUNnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:43:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9B6B106F;
        Tue, 21 Sep 2021 06:42:03 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1F033F40C;
        Tue, 21 Sep 2021 06:42:01 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 17/17] arm64: Advertise TRBE erratum workaround for write to out-of-range address
Date:   Tue, 21 Sep 2021 14:41:21 +0100
Message-Id: <20210921134121.2423546-18-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210921134121.2423546-1-suzuki.poulose@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig entries for the errata workarounds for TRBE writing
to an out-of-range address.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/arm64/silicon-errata.rst |  4 +++
 arch/arm64/Kconfig                     | 39 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

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
index 0764774e12bb..611ae02aabbd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -736,6 +736,45 @@ config ARM64_ERRATUM_2067961
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	bool
+
+config ARM64_ERRATUM_2253138
+	bool "Neoverse-N2: 2253138: workaround TRBE writing to address out-of-range"
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
-- 
2.24.1

