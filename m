Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A596F3DE705
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhHCHJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:09:21 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58486 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234055AbhHCHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:09:17 -0400
X-UUID: 3a3ce6a915224716884bae033d7ccddf-20210803
X-UUID: 3a3ce6a915224716884bae033d7ccddf-20210803
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 57983639; Tue, 03 Aug 2021 15:09:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 15:08:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 15:08:42 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <nicholas.Tang@mediatek.com>, <Kuan-Ying.lee@mediatek.com>,
        <chinwen.chang@mediatek.com>, Yee Lee <yee.lee@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Vlastimil Babka" <vbabka@suse.cz>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Hector Martin" <marcan@marcan.st>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "David Brazdil" <dbrazdil@google.com>,
        Fuad Tabba <tabba@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 1/1] arm64/cpufeature: Optionally disable MTE via command-line
Date:   Tue, 3 Aug 2021 15:08:22 +0800
Message-ID: <20210803070824.7586-2-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210803070824.7586-1-yee.lee@mediatek.com>
References: <20210803070824.7586-1-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

MTE support needs to be optionally disabled in runtime 
for HW issue workaround, FW development and some 
evaluation works on system resource and performance.

This patch makes two changes:
(1) moves init of tag-allocation bits(ATA/ATA0) to
cpu_enable_mte() as not cached in TLB.

(2) allows ID_AA64PFR1_EL1.MTE to be overridden on
its shadow value by giving "arm64.nomte" on cmdline.

When the feature value is off, ATA and TCF will not set 
and the related functionalities are accordingly suppressed.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Yee Lee <yee.lee@mediatek.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/include/asm/sysreg.h                 | 3 +--
 arch/arm64/kernel/cpufeature.c                  | 3 +++
 arch/arm64/kernel/idreg-override.c              | 2 ++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..6f257e39d89e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -380,6 +380,9 @@
 	arm64.nopauth	[ARM64] Unconditionally disable Pointer Authentication
 			support
 
+	arm64.nomte	[ARM64] Unconditionally disable Memory Tagging Extension
+			support
+
 	ataflop=	[HW,M68k]
 
 	atarimouse=	[HW,MOUSE] Atari Mouse
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7b9c3acba684..e3e2c93b35f4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -698,8 +698,7 @@
 	(SCTLR_ELx_M    | SCTLR_ELx_C    | SCTLR_ELx_SA   | SCTLR_EL1_SA0   | \
 	 SCTLR_EL1_SED  | SCTLR_ELx_I    | SCTLR_EL1_DZE  | SCTLR_EL1_UCT   | \
 	 SCTLR_EL1_NTWE | SCTLR_ELx_IESB | SCTLR_EL1_SPAN | SCTLR_ELx_ITFSB | \
-	 SCTLR_ELx_ATA  | SCTLR_EL1_ATA0 | ENDIAN_SET_EL1 | SCTLR_EL1_UCI   | \
-	 SCTLR_EL1_EPAN | SCTLR_EL1_RES1)
+	 ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_EPAN | SCTLR_EL1_RES1)
 
 /* MAIR_ELx memory attributes (used by Linux) */
 #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0ead8bfedf20..51e6bf4bb7b5 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1843,6 +1843,9 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
 #ifdef CONFIG_ARM64_MTE
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
+	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
+	isb();
+
 	/*
 	 * Clear the tags in the zero page. This needs to be done via the
 	 * linear map which has the Tagged attribute.
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 53a381a7f65d..d8e606fe3c21 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -54,6 +54,7 @@ static const struct ftr_set_desc pfr1 __initconst = {
 	.override	= &id_aa64pfr1_override,
 	.fields		= {
 	        { "bt", ID_AA64PFR1_BT_SHIFT },
+		{ "mte", ID_AA64PFR1_MTE_SHIFT},
 		{}
 	},
 };
@@ -100,6 +101,7 @@ static const struct {
 	{ "arm64.nopauth",
 	  "id_aa64isar1.gpi=0 id_aa64isar1.gpa=0 "
 	  "id_aa64isar1.api=0 id_aa64isar1.apa=0"	   },
+	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"kaslr.disabled=1" },
 };
 
-- 
2.18.0

