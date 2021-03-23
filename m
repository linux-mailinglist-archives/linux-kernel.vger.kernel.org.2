Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F8345DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhCWMHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:07:44 -0400
Received: from foss.arm.com ([217.140.110.172]:45102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhCWMHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:07:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5892113E;
        Tue, 23 Mar 2021 05:07:20 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62C5F3F719;
        Tue, 23 Mar 2021 05:07:19 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com, maz@kernel.org,
        catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 06/19] arm64: Add TRBE definitions
Date:   Tue, 23 Mar 2021 12:06:34 +0000
Message-Id: <20210323120647.454211-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210323120647.454211-1-suzuki.poulose@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <anshuman.khandual@arm.com>

This adds TRBE related registers and corresponding feature macros.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index d4a5fca984c3..a27ba8be46a2 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -333,6 +333,55 @@
 
 /*** End of Statistical Profiling Extension ***/
 
+/*
+ * TRBE Registers
+ */
+#define SYS_TRBLIMITR_EL1		sys_reg(3, 0, 9, 11, 0)
+#define SYS_TRBPTR_EL1			sys_reg(3, 0, 9, 11, 1)
+#define SYS_TRBBASER_EL1		sys_reg(3, 0, 9, 11, 2)
+#define SYS_TRBSR_EL1			sys_reg(3, 0, 9, 11, 3)
+#define SYS_TRBMAR_EL1			sys_reg(3, 0, 9, 11, 4)
+#define SYS_TRBTRG_EL1			sys_reg(3, 0, 9, 11, 6)
+#define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
+
+#define TRBLIMITR_LIMIT_MASK		GENMASK_ULL(51, 0)
+#define TRBLIMITR_LIMIT_SHIFT		12
+#define TRBLIMITR_NVM			BIT(5)
+#define TRBLIMITR_TRIG_MODE_MASK	GENMASK(1, 0)
+#define TRBLIMITR_TRIG_MODE_SHIFT	3
+#define TRBLIMITR_FILL_MODE_MASK	GENMASK(1, 0)
+#define TRBLIMITR_FILL_MODE_SHIFT	1
+#define TRBLIMITR_ENABLE		BIT(0)
+#define TRBPTR_PTR_MASK			GENMASK_ULL(63, 0)
+#define TRBPTR_PTR_SHIFT		0
+#define TRBBASER_BASE_MASK		GENMASK_ULL(51, 0)
+#define TRBBASER_BASE_SHIFT		12
+#define TRBSR_EC_MASK			GENMASK(5, 0)
+#define TRBSR_EC_SHIFT			26
+#define TRBSR_IRQ			BIT(22)
+#define TRBSR_TRG			BIT(21)
+#define TRBSR_WRAP			BIT(20)
+#define TRBSR_ABORT			BIT(18)
+#define TRBSR_STOP			BIT(17)
+#define TRBSR_MSS_MASK			GENMASK(15, 0)
+#define TRBSR_MSS_SHIFT			0
+#define TRBSR_BSC_MASK			GENMASK(5, 0)
+#define TRBSR_BSC_SHIFT			0
+#define TRBSR_FSC_MASK			GENMASK(5, 0)
+#define TRBSR_FSC_SHIFT			0
+#define TRBMAR_SHARE_MASK		GENMASK(1, 0)
+#define TRBMAR_SHARE_SHIFT		8
+#define TRBMAR_OUTER_MASK		GENMASK(3, 0)
+#define TRBMAR_OUTER_SHIFT		4
+#define TRBMAR_INNER_MASK		GENMASK(3, 0)
+#define TRBMAR_INNER_SHIFT		0
+#define TRBTRG_TRG_MASK			GENMASK(31, 0)
+#define TRBTRG_TRG_SHIFT		0
+#define TRBIDR_FLAG			BIT(5)
+#define TRBIDR_PROG			BIT(4)
+#define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
+#define TRBIDR_ALIGN_SHIFT		0
+
 #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
 #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
 
@@ -840,6 +889,7 @@
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
 /* id_aa64dfr0 */
+#define ID_AA64DFR0_TRBE_SHIFT		44
 #define ID_AA64DFR0_TRACE_FILT_SHIFT	40
 #define ID_AA64DFR0_DOUBLELOCK_SHIFT	36
 #define ID_AA64DFR0_PMSVER_SHIFT	32
-- 
2.24.1

