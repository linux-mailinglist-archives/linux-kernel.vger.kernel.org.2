Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7EC3EAA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhHLTDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhHLTDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:03:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E50610A4;
        Thu, 12 Aug 2021 19:02:34 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mEFyL-004c9r-68; Thu, 12 Aug 2021 20:02:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
Subject: [PATCH 4/5] arm64: Warn on booting at EL2 with HVC disabled
Date:   Thu, 12 Aug 2021 20:02:12 +0100
Message-Id: <20210812190213.2601506-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812190213.2601506-1-maz@kernel.org>
References: <20210812190213.2601506-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, zajec5@gmail.com, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, ardb@kernel.org, f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are able to paper over the gigantic stupidity that
booting at EL2 with SCR_EL3.HCE==0 is, let's taint WARN_TAINT()
when detecting this situation.

Yes, this is *LOUD*.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/virt.h | 10 ++++++++++
 arch/arm64/kernel/head.S      | 10 ++++++++++
 arch/arm64/kernel/smp.c       |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 7379f35ae2c6..89bf5ae522da 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -49,6 +49,9 @@
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
+/* Flags associated to the boot mode */
+#define BOOT_CPU_MODE_DOWNGRADED (1 << 0)
+
 #ifndef __ASSEMBLY__
 
 #include <asm/ptrace.h>
@@ -67,6 +70,13 @@
  */
 extern u32 __boot_cpu_mode[2];
 
+/*
+ * __boot_cpu_mode_flags records events that are associated with CPUs
+ * coming online. A CPU having been downgraded from EL2 to EL1 because
+ * of HVC not being enabled will have BOOT_CPU_MODE_DOWNGRADED set.
+ */
+extern u32 __boot_cpu_mode_flags[1];
+
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 void __hyp_reset_vectors(void);
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d6b2b05f5d3a..fdad6805868b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -530,7 +530,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	/*
 	 * HVC is unusable, so pretend we actually booted at EL1.
 	 * Once we have left EL2, there will be no going back.
+	 * set_cpu_boot_mode_flag will do the necessary CMOs for us.
 	 */
+	adr_l	x1, __boot_cpu_mode_flags
+	ldr	w0, [x1]
+	orr	w0, w0, BOOT_CPU_MODE_DOWNGRADED
+	str	w0, [x1]
+
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
 	msr	sctlr_el1, x0
 
@@ -623,6 +629,10 @@ SYM_DATA_START(__early_cpu_boot_status)
 	.quad 	0
 SYM_DATA_END(__early_cpu_boot_status)
 
+SYM_DATA_START(__boot_cpu_mode_flags)
+	.long	0
+SYM_DATA_END(__boot_cpu_mode_flags)
+
 	.popsection
 
 	/*
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6f6ff072acbd..43fad7ca9110 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -425,6 +425,9 @@ static void __init hyp_mode_check(void)
 	else if (is_hyp_mode_mismatched())
 		WARN_TAINT(1, TAINT_CPU_OUT_OF_SPEC,
 			   "CPU: CPUs started in inconsistent modes");
+	else if (__boot_cpu_mode_flags[0] & BOOT_CPU_MODE_DOWNGRADED)
+		WARN_TAINT(1, TAINT_CPU_OUT_OF_SPEC,
+			   "CPU: CPUs downgraded to EL1, HVC disabled");
 	else
 		pr_info("CPU: All CPU(s) started at EL1\n");
 	if (IS_ENABLED(CONFIG_KVM) && !is_kernel_in_hyp_mode()) {
-- 
2.30.2

