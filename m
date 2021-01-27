Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4527305764
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhA0JwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:52:24 -0500
Received: from foss.arm.com ([217.140.110.172]:32954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233049AbhA0I7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:59:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E35FF14FF;
        Wed, 27 Jan 2021 00:55:56 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.91.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E52C3F66B;
        Wed, 27 Jan 2021 00:55:52 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH V3 10/14] arm64: nvhe: Allow TRBE access at EL1
Date:   Wed, 27 Jan 2021 14:25:34 +0530
Message-Id: <1611737738-1493-11-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

When the kernel is booted at EL2 in a nvhe configuration,
enable the TRBE access to the EL1. The EL1 still can't trace
EL2, unless EL2 permits explicitly via TRFCR_EL2.E2TRE.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/el2_setup.h | 19 +++++++++++++++++++
 arch/arm64/include/asm/kvm_arm.h   |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index a7f5a1b..05ecce9 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -72,6 +72,25 @@
 .endif
 
 3:
+
+.ifeqs	"\mode", "nvhe"
+	/*
+	 * If the Trace Buffer is available, allow
+	 * the EL1 to own it. Note that EL1 cannot
+	 * trace the EL2, as it is prevented by
+	 * TRFCR_EL2.E2TRE == 0.
+	 */
+	ubfx	x0, x1, #ID_AA64DFR0_TRBE_SHIFT, #4
+	cbz	x0, 1f
+
+	mrs_s	x0, SYS_TRBIDR_EL1
+	and	x0, x0, TRBIDR_PROG
+	cbnz	x0, 1f
+	mov	x0, #(MDCR_EL2_E2TB_EL1_OWN << MDCR_EL2_E2TB_SHIFT)
+	orr	x2, x2, x0
+.endif
+
+1:
 	msr	mdcr_el2, x2			// Configure debug traps
 .endm
 
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 4e90c2d..ed8b789 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -281,6 +281,8 @@
 #define MDCR_EL2_TPMS		(1 << 14)
 #define MDCR_EL2_E2PB_MASK	(UL(0x3))
 #define MDCR_EL2_E2PB_SHIFT	(UL(12))
+#define MDCR_EL2_E2TB_EL1_OWN	(UL(0x3))
+#define MDCR_EL2_E2TB_SHIFT	(UL(24))
 #define MDCR_EL2_TDRA		(1 << 11)
 #define MDCR_EL2_TDOSA		(1 << 10)
 #define MDCR_EL2_TDA		(1 << 9)
-- 
2.7.4

