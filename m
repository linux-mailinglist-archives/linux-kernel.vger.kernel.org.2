Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E373312E93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhBHKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232081AbhBHKBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:01:14 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3FE264E8C;
        Mon,  8 Feb 2021 09:57:55 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l93Io-00Ck14-4m; Mon, 08 Feb 2021 09:57:54 +0000
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
        Hector Martin <marcan@marcan.st>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: [PATCH v7 05/23] arm64: Initialise as nVHE before switching to VHE
Date:   Mon,  8 Feb 2021 09:57:14 +0000
Message-Id: <20210208095732.3267263-6-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208095732.3267263-1-maz@kernel.org>
References: <20210208095732.3267263-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, marcan@marcan.st, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are aiming to be able to control whether we enable VHE or
not, let's always drop down to EL1 first, and only then upgrade
to VHE if at all possible.

This means that if the kernel is booted at EL2, we always start
with a nVHE init, drop to EL1 to initialise the the kernel, and
only then upgrade the kernel EL to EL2 if possible (the process
is obviously shortened for secondary CPUs).

The resume path is handled similarly to a secondary CPU boot.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: David Brazdil <dbrazdil@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/head.S     | 38 ++----------------------------------
 arch/arm64/kernel/hyp-stub.S | 24 +++++++++++++++++++++++
 arch/arm64/kernel/sleep.S    |  1 +
 3 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 28e9735302df..07445fd976ef 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -433,6 +433,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
+	bl	switch_to_vhe
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
@@ -493,42 +494,6 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	eret
 
 SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
-#ifdef CONFIG_ARM64_VHE
-	/*
-	 * Check for VHE being present. x2 being non-zero indicates that we
-	 * do have VHE, and that the kernel is intended to run at EL2.
-	 */
-	mrs	x2, id_aa64mmfr1_el1
-	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
-#else
-	mov	x2, xzr
-#endif
-	cbz	x2, init_el2_nvhe
-
-	/*
-	 * When VHE _is_ in use, EL1 will not be used in the host and
-	 * requires no configuration, and all non-hyp-specific EL2 setup
-	 * will be done via the _EL1 system register aliases in __cpu_setup.
-	 */
-	mov_q	x0, HCR_HOST_VHE_FLAGS
-	msr	hcr_el2, x0
-	isb
-
-	init_el2_state vhe
-
-	isb
-
-	mov_q	x0, INIT_PSTATE_EL2
-	msr	spsr_el2, x0
-	msr	elr_el2, lr
-	mov	w0, #BOOT_CPU_MODE_EL2
-	eret
-
-SYM_INNER_LABEL(init_el2_nvhe, SYM_L_LOCAL)
-	/*
-	 * When VHE is not in use, early init of EL2 and EL1 needs to be
-	 * done here.
-	 */
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
 	msr	sctlr_el1, x0
 
@@ -623,6 +588,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
 	 */
+	bl	switch_to_vhe
 	bl	__cpu_secondary_check52bitva
 	bl	__cpu_setup			// initialise processor
 	adrp	x1, swapper_pg_dir
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 3f3dbbe8914d..373ed2213e1d 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -190,3 +190,27 @@ SYM_FUNC_START(__hyp_reset_vectors)
 	hvc	#0
 	ret
 SYM_FUNC_END(__hyp_reset_vectors)
+
+/*
+ * Entry point to switch to VHE if deemed capable
+ */
+SYM_FUNC_START(switch_to_vhe)
+#ifdef CONFIG_ARM64_VHE
+	// Need to have booted at EL2
+	adr_l	x1, __boot_cpu_mode
+	ldr	w0, [x1]
+	cmp	w0, #BOOT_CPU_MODE_EL2
+	b.ne	1f
+
+	// and still be at EL1
+	mrs	x0, CurrentEL
+	cmp	x0, #CurrentEL_EL1
+	b.ne	1f
+
+	// Turn the world upside down
+	mov	x0, #HVC_VHE_RESTART
+	hvc	#0
+1:
+#endif
+	ret
+SYM_FUNC_END(switch_to_vhe)
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 6bdef7362c0e..5bfd9b87f85d 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -100,6 +100,7 @@ SYM_FUNC_END(__cpu_suspend_enter)
 	.pushsection ".idmap.text", "awx"
 SYM_CODE_START(cpu_resume)
 	bl	init_kernel_el
+	bl	switch_to_vhe
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
 	adrp	x1, swapper_pg_dir
-- 
2.29.2

