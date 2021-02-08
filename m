Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A938B312EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBHK0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232353AbhBHKIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:08:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8F964E9C;
        Mon,  8 Feb 2021 10:04:42 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l93JA-00Ck14-Tq; Mon, 08 Feb 2021 09:58:17 +0000
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
Subject: [PATCH v7 23/23] [DO NOT MERGE] arm64: Cope with CPUs stuck in VHE mode
Date:   Mon,  8 Feb 2021 09:57:32 +0000
Message-Id: <20210208095732.3267263-24-maz@kernel.org>
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

It seems that the CPU known as Apple M1 has the terrible habit
of being stuck with HCR_EL2.E2H==1, in violation of the architecture.

Try and work around this deplorable state of affairs by detecting
the stuck bit early and short-circuit the nVHE dance. It is still
unknown whether there are many more such nuggets to be found...

Reported-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/head.S     | 33 ++++++++++++++++++++++++++++++---
 arch/arm64/kernel/hyp-stub.S | 28 ++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2e116ef255e1..bce66d6bda74 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -477,14 +477,13 @@ EXPORT_SYMBOL(kimage_vaddr)
  * booted in EL1 or EL2 respectively.
  */
 SYM_FUNC_START(init_kernel_el)
-	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
-	msr	sctlr_el1, x0
-
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.eq	init_el2
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr	sctlr_el1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
 	msr	spsr_el1, x0
@@ -504,6 +503,34 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	vbar_el2, x0
 	isb
 
+	/*
+	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1,
+	 * making it impossible to start in nVHE mode. Is that
+	 * compliant with the architecture? Absolutely not!
+	 */
+	mrs	x0, hcr_el2
+	and	x0, x0, #HCR_E2H
+	cbz	x0, 1f
+
+	/* Switching to VHE requires a sane SCTLR_EL1 as a start */
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr_s	SYS_SCTLR_EL12, x0
+
+	/*
+	 * Force an eret into a helper "function", and let it return
+	 * to our original caller... This makes sure that we have
+	 * initialised the basic PSTATE state.
+	 */
+	mov	x0, #INIT_PSTATE_EL2
+	msr	spsr_el1, x0
+	adr_l	x0, stick_to_vhe
+	msr	elr_el1, x0
+	eret
+
+1:
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr	sctlr_el1, x0
+
 	msr	elr_el2, lr
 	mov	w0, #BOOT_CPU_MODE_EL2
 	eret
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 3e08dcc924b5..b55ed4af4c4a 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -27,12 +27,12 @@ SYM_CODE_START(__hyp_stub_vectors)
 	ventry	el2_fiq_invalid			// FIQ EL2t
 	ventry	el2_error_invalid		// Error EL2t
 
-	ventry	el2_sync_invalid		// Synchronous EL2h
+	ventry	elx_sync			// Synchronous EL2h
 	ventry	el2_irq_invalid			// IRQ EL2h
 	ventry	el2_fiq_invalid			// FIQ EL2h
 	ventry	el2_error_invalid		// Error EL2h
 
-	ventry	el1_sync			// Synchronous 64-bit EL1
+	ventry	elx_sync			// Synchronous 64-bit EL1
 	ventry	el1_irq_invalid			// IRQ 64-bit EL1
 	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
 	ventry	el1_error_invalid		// Error 64-bit EL1
@@ -45,7 +45,7 @@ SYM_CODE_END(__hyp_stub_vectors)
 
 	.align 11
 
-SYM_CODE_START_LOCAL(el1_sync)
+SYM_CODE_START_LOCAL(elx_sync)
 	cmp	x0, #HVC_SET_VECTORS
 	b.ne	1f
 	msr	vbar_el2, x1
@@ -71,7 +71,7 @@ SYM_CODE_START_LOCAL(el1_sync)
 
 9:	mov	x0, xzr
 	eret
-SYM_CODE_END(el1_sync)
+SYM_CODE_END(elx_sync)
 
 // nVHE? No way! Give me the real thing!
 SYM_CODE_START_LOCAL(mutate_to_vhe)
@@ -227,3 +227,23 @@ SYM_FUNC_START(switch_to_vhe)
 #endif
 	ret
 SYM_FUNC_END(switch_to_vhe)
+
+SYM_FUNC_START(stick_to_vhe)
+	/*
+	 * Make sure the switch to VHE cannot fail, by overriding the
+	 * override. This is hilarious.
+	 */
+	adr_l	x1, id_aa64mmfr1_override
+	add	x1, x1, #FTR_OVR_MASK_OFFSET
+	dc 	civac, x1
+	dsb	sy
+	isb
+	ldr	x0, [x1]
+	bic	x0, x0, #(0xf << ID_AA64MMFR1_VHE_SHIFT)
+	str	x0, [x1]
+
+	mov	x0, #HVC_VHE_RESTART
+	hvc	#0
+	mov	x0, #BOOT_CPU_MODE_EL2
+	ret
+SYM_FUNC_END(stick_to_vhe)
-- 
2.29.2

