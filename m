Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8574E30A726
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBAMFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBAME7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:04:59 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3137C64E95;
        Mon,  1 Feb 2021 12:04:18 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l6XpM-00BG09-1H; Mon, 01 Feb 2021 11:57:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: [PATCH v6 19/21] arm64: cpufeatures: Allow disabling of BTI from the command-line
Date:   Mon,  1 Feb 2021 11:56:35 +0000
Message-Id: <20210201115637.3123740-20-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201115637.3123740-1-maz@kernel.org>
References: <20210201115637.3123740-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to disable BTI at runtime, whether it is
for testing purposes, or to work around HW issues, let's add
support for overriding the ID_AA64PFR1_EL1.BTI field.

This is further mapped on the arm64.nobti command-line alias.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Brazdil <dbrazdil@google.com>
Tested-by: Srinivas Ramana <sramana@codeaurora.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/arm64/include/asm/cpufeature.h             |  1 +
 arch/arm64/kernel/cpufeature.c                  |  4 +++-
 arch/arm64/kernel/idreg-override.c              | 11 +++++++++++
 arch/arm64/mm/mmu.c                             |  2 +-
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2786fd39a047..7599fd0f1ad7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -373,6 +373,9 @@
 	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
 			Format: <io>,<irq>,<nodeID>
 
+	arm64.nobti	[ARM64] Unconditionally disable Branch Target
+			Identification support
+
 	ataflop=	[HW,M68k]
 
 	atarimouse=	[HW,MOUSE] Atari Mouse
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 570f1b4ba3cc..30917b9a760b 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -819,6 +819,7 @@ static inline unsigned int get_vmid_bits(u64 mmfr1)
 }
 
 extern struct arm64_ftr_override id_aa64mmfr1_override;
+extern struct arm64_ftr_override id_aa64pfr1_override;
 
 u32 get_kvm_ipa_limit(void);
 void dump_cpu_features(void);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index faada5d8bea6..7fbeab497adb 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -558,6 +558,7 @@ static const struct arm64_ftr_bits ftr_raz[] = {
 #define ARM64_FTR_REG(id, table) ARM64_FTR_REG_OVERRIDE(id, table, &no_override)
 
 struct arm64_ftr_override __ro_after_init id_aa64mmfr1_override;
+struct arm64_ftr_override __ro_after_init id_aa64pfr1_override;
 
 static const struct __ftr_reg_entry {
 	u32			sys_id;
@@ -593,7 +594,8 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 0, CRm = 4 */
 	ARM64_FTR_REG(SYS_ID_AA64PFR0_EL1, ftr_id_aa64pfr0),
-	ARM64_FTR_REG(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1),
+	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1,
+			       &id_aa64pfr1_override),
 	ARM64_FTR_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0),
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 2b492ce73e74..dbe102504630 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -37,6 +37,15 @@ static const struct ftr_set_desc mmfr1 __initconst = {
 	},
 };
 
+static const struct ftr_set_desc pfr1 __initconst = {
+	.name		= "id_aa64pfr1",
+	.override	= &id_aa64pfr1_override,
+	.fields		= {
+	        { "bt", ID_AA64PFR1_BT_SHIFT },
+		{}
+	},
+};
+
 extern struct arm64_ftr_override kaslr_feature_override;
 
 static const struct ftr_set_desc kaslr __initconst = {
@@ -52,6 +61,7 @@ static const struct ftr_set_desc kaslr __initconst = {
 
 static const struct ftr_set_desc * const regs[] __initconst = {
 	&mmfr1,
+	&pfr1,
 	&kaslr,
 };
 
@@ -61,6 +71,7 @@ static const struct {
 } aliases[] __initconst = {
 	{ "kvm-arm.mode=nvhe",		"id_aa64mmfr1.vh=0" },
 	{ "kvm-arm.mode=protected",	"id_aa64mmfr1.vh=0" },
+	{ "arm64.nobti",		"id_aa64pfr1.bt=0" },
 	{ "nokaslr",			"kaslr.disabled=1" },
 };
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ae0c3d023824..617e704c980b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -628,7 +628,7 @@ static bool arm64_early_this_cpu_has_bti(void)
 	if (!IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
 		return false;
 
-	pfr1 = read_sysreg_s(SYS_ID_AA64PFR1_EL1);
+	pfr1 = __read_sysreg_by_encoding(SYS_ID_AA64PFR1_EL1);
 	return cpuid_feature_extract_unsigned_field(pfr1,
 						    ID_AA64PFR1_BT_SHIFT);
 }
-- 
2.29.2

