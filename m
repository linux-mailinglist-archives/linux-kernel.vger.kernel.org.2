Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CCB4280FC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhJJL7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 07:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232052AbhJJL64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 07:58:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E6660F43;
        Sun, 10 Oct 2021 11:56:58 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mZXEa-00FqFc-TO; Sun, 10 Oct 2021 12:43:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v3 17/17] arm64: Add HWCAP for self-synchronising virtual counter
Date:   Sun, 10 Oct 2021 12:43:06 +0100
Message-Id: <20211010114306.2910453-18-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010114306.2910453-1-maz@kernel.org>
References: <20211010114306.2910453-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, will@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since userspace can make use of the CNTVSS_EL0 instruction, expose
it via a HWCAP.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/arm64/elf_hwcaps.rst  | 4 ++++
 arch/arm64/include/asm/hwcap.h      | 1 +
 arch/arm64/include/uapi/asm/hwcap.h | 1 +
 arch/arm64/kernel/cpufeature.c      | 3 ++-
 arch/arm64/kernel/cpuinfo.c         | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index ec1a5a63c1d0..af106af8e1c0 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -247,6 +247,10 @@ HWCAP2_MTE
     Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
     by Documentation/arm64/memory-tagging-extension.rst.
 
+HWCAP2_ECV
+
+    Functionality implied by ID_AA64MMFR0_EL1.ECV == 0b0001.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 8c129db8232a..b100e0055eab 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -105,6 +105,7 @@
 #define KERNEL_HWCAP_RNG		__khwcap2_feature(RNG)
 #define KERNEL_HWCAP_BTI		__khwcap2_feature(BTI)
 #define KERNEL_HWCAP_MTE		__khwcap2_feature(MTE)
+#define KERNEL_HWCAP_ECV		__khwcap2_feature(ECV)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index b8f41aa234ee..7b23b16f21ce 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -75,5 +75,6 @@
 #define HWCAP2_RNG		(1 << 16)
 #define HWCAP2_BTI		(1 << 17)
 #define HWCAP2_MTE		(1 << 18)
+#define HWCAP2_ECV		(1 << 19)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 26b11ce8fff6..97ed37c6ce5e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -279,7 +279,7 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_FGT_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_EXS_SHIFT, 4, 0),
 	/*
@@ -2457,6 +2457,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 #ifdef CONFIG_ARM64_MTE
 	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_MTE_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_MTE, CAP_HWCAP, KERNEL_HWCAP_MTE),
 #endif /* CONFIG_ARM64_MTE */
+	HWCAP_CAP(SYS_ID_AA64MMFR0_EL1, ID_AA64MMFR0_ECV_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 87731fea5e41..6e27b759056a 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -94,6 +94,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_RNG]		= "rng",
 	[KERNEL_HWCAP_BTI]		= "bti",
 	[KERNEL_HWCAP_MTE]		= "mte",
+	[KERNEL_HWCAP_ECV]		= "ecv",
 };
 
 #ifdef CONFIG_COMPAT
-- 
2.30.2

