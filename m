Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9593E4922
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhHIPtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235757AbhHIPsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:48:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D606101E;
        Mon,  9 Aug 2021 15:48:23 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mD7B6-003qjI-O5; Mon, 09 Aug 2021 16:27:00 +0100
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
Subject: [PATCH 13/13] arm64: Add CNT{P,V}CTSS_EL0 alternatives to cnt{p,v}ct_el0
Date:   Mon,  9 Aug 2021 16:26:51 +0100
Message-Id: <20210809152651.2297337-14-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809152651.2297337-1-maz@kernel.org>
References: <20210809152651.2297337-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, will@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CNTPCTSS_EL0 and CNTVCTSS_EL0 are alternatives to the usual
CNTPCT_EL0 and CNTVCT_EL0 that do not require a previous ISB
to be synchronised (SS stands for Self-Synchronising).

Use the ARM64_HAS_ECV capability to control alternative sequences
that switch to these low(er)-cost primitives. Note that the
counter access in the VDSO is for now left alone until we decide
whether we want to allow this.

For a good measure, wire the cntvct hooks to also handle CNTVCTSS.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/arch_timer.h | 30 +++++++++++++++++++++++------
 arch/arm64/include/asm/esr.h        |  6 ++++++
 arch/arm64/include/asm/sysreg.h     |  3 +++
 arch/arm64/kernel/traps.c           | 11 +++++++++++
 4 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index b2f056db1225..785411a48512 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -64,12 +64,26 @@ DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 
 static inline notrace u64 arch_timer_read_cntpct_el0(void)
 {
-	return read_sysreg(cntpct_el0);
+	u64 cnt;
+
+	asm volatile(ALTERNATIVE("isb\n mrs %x0, cntpct_el0",
+				 "nop\n" __mrs_s("%x0", SYS_CNTPCTSS_EL0),
+				 ARM64_HAS_ECV)
+		     : "=r" (cnt));
+
+	return cnt;
 }
 
 static inline notrace u64 arch_timer_read_cntvct_el0(void)
 {
-	return read_sysreg(cntvct_el0);
+	u64 cnt;
+
+	asm volatile(ALTERNATIVE("isb\n mrs %x0, cntvct_el0",
+				 "nop\n" __mrs_s("%x0", SYS_CNTVCTSS_EL0),
+				 ARM64_HAS_ECV)
+		     : "=r" (cnt));
+
+	return cnt;
 }
 
 #define arch_timer_reg_read_stable(reg)					\
@@ -166,8 +180,10 @@ static __always_inline u64 __arch_counter_get_cntpct(void)
 {
 	u64 cnt;
 
-	isb();
-	cnt = read_sysreg(cntpct_el0);
+	asm volatile(ALTERNATIVE("isb\n mrs %x0, cntpct_el0",
+				 "nop\n" __mrs_s("%x0", SYS_CNTPCTSS_EL0),
+				 ARM64_HAS_ECV)
+		     : "=r" (cnt));
 	arch_counter_enforce_ordering(cnt);
 	return cnt;
 }
@@ -186,8 +202,10 @@ static __always_inline u64 __arch_counter_get_cntvct(void)
 {
 	u64 cnt;
 
-	isb();
-	cnt = read_sysreg(cntvct_el0);
+	asm volatile(ALTERNATIVE("isb\n mrs %x0, cntvct_el0",
+				 "nop\n" __mrs_s("%x0", SYS_CNTVCTSS_EL0),
+				 ARM64_HAS_ECV)
+		     : "=r" (cnt));
 	arch_counter_enforce_ordering(cnt);
 	return cnt;
 }
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 29f97eb3dad4..a305ce256090 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -227,6 +227,9 @@
 #define ESR_ELx_SYS64_ISS_SYS_CNTVCT	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 2, 14, 0) | \
 					 ESR_ELx_SYS64_ISS_DIR_READ)
 
+#define ESR_ELx_SYS64_ISS_SYS_CNTVCTSS	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 6, 14, 0) | \
+					 ESR_ELx_SYS64_ISS_DIR_READ)
+
 #define ESR_ELx_SYS64_ISS_SYS_CNTFRQ	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 0, 14, 0) | \
 					 ESR_ELx_SYS64_ISS_DIR_READ)
 
@@ -317,6 +320,9 @@
 #define ESR_ELx_CP15_64_ISS_SYS_CNTVCT	(ESR_ELx_CP15_64_ISS_SYS_VAL(1, 14) | \
 					 ESR_ELx_CP15_64_ISS_DIR_READ)
 
+#define ESR_ELx_CP15_64_ISS_SYS_CNTVCTSS (ESR_ELx_CP15_64_ISS_SYS_VAL(9, 14) | \
+					 ESR_ELx_CP15_64_ISS_DIR_READ)
+
 #define ESR_ELx_CP15_32_ISS_SYS_CNTFRQ	(ESR_ELx_CP15_32_ISS_SYS_VAL(0, 0, 14, 0) |\
 					 ESR_ELx_CP15_32_ISS_DIR_READ)
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7b9c3acba684..897f9c882895 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -506,6 +506,9 @@
 
 #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
 
+#define SYS_CNTPCTSS_EL0		sys_reg(3, 3, 14, 0, 5)
+#define SYS_CNTVCTSS_EL0		sys_reg(3, 3, 14, 0, 6)
+
 #define SYS_CNTP_TVAL_EL0		sys_reg(3, 3, 14, 2, 0)
 #define SYS_CNTP_CTL_EL0		sys_reg(3, 3, 14, 2, 1)
 #define SYS_CNTP_CVAL_EL0		sys_reg(3, 3, 14, 2, 2)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b03e383d944a..16710ca55fbb 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -653,6 +653,12 @@ static const struct sys64_hook sys64_hooks[] = {
 		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTVCT,
 		.handler = cntvct_read_handler,
 	},
+	{
+		/* Trap read access to CNTVCTSS_EL0 */
+		.esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
+		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTVCTSS,
+		.handler = cntvct_read_handler,
+	},
 	{
 		/* Trap read access to CNTFRQ_EL0 */
 		.esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
@@ -729,6 +735,11 @@ static const struct sys64_hook cp15_64_hooks[] = {
 		.esr_val = ESR_ELx_CP15_64_ISS_SYS_CNTVCT,
 		.handler = compat_cntvct_read_handler,
 	},
+	{
+		.esr_mask = ESR_ELx_CP15_64_ISS_SYS_MASK,
+		.esr_val = ESR_ELx_CP15_64_ISS_SYS_CNTVCTSS,
+		.handler = compat_cntvct_read_handler,
+	},
 	{},
 };
 
-- 
2.30.2

