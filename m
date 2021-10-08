Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE94270CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbhJHScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:32:12 -0400
Received: from foss.arm.com ([217.140.110.172]:41564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241081AbhJHSbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:31:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5A7813D5;
        Fri,  8 Oct 2021 11:29:49 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C1153F766;
        Fri,  8 Oct 2021 11:29:48 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, coresight@lists.linaro.org,
        maz@kernel.org, james.morse@arm.com, mark.rutland@arm.com,
        lcherian@marvell.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 15/16] arm64: errata: Advertise the workaround for TSB flush failures
Date:   Fri,  8 Oct 2021 19:29:05 +0100
Message-Id: <20211008182906.1688009-16-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211008182906.1688009-1-suzuki.poulose@arm.com>
References: <20211008182906.1688009-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise the workaround for the TSB flush failures via
Kconfig entries.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since previous:
  - Split the Kconfig/erratum updates to keep the conflicts
    minimal with the other Kconfig updates in TRBE errata
    I have retained the tags
---
 Documentation/arm64/silicon-errata.rst |  4 ++++
 arch/arm64/Kconfig                     | 31 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

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
index eac4030322df..0764774e12bb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -705,6 +705,37 @@ config ARM64_ERRATUM_2139208
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+	bool
+
+config ARM64_ERRATUM_2054223
+	bool "Cortex-A710: 2054223: workaround TSB instruction failing to flush trace"
+	default y
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
-- 
2.25.4

