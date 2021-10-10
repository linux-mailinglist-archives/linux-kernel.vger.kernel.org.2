Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E1A4280FB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 13:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhJJL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 07:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhJJL6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 07:58:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 702F561074;
        Sun, 10 Oct 2021 11:56:56 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mZXEa-00FqFc-3P; Sun, 10 Oct 2021 12:43:16 +0100
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
Subject: [PATCH v3 15/17] arm64: Add CNT{P,V}CTSS_EL0 alternatives to cnt{p,v}ct_el0
Date:   Sun, 10 Oct 2021 12:43:04 +0100
Message-Id: <20211010114306.2910453-16-maz@kernel.org>
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

CNTPCTSS_EL0 and CNTVCTSS_EL0 are alternatives to the usual
CNTPCT_EL0 and CNTVCT_EL0 that do not require a previous ISB
to be synchronised (SS stands for Self-Synchronising).

Use the ARM64_HAS_ECV capability to control alternative sequences
that switch to these low(er)-cost primitives. Note that the
counter access in the VDSO is for now left alone until we decide
whether we want to allow this.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/arch_timer.h | 32 +++++++++++++++++++++--------
 arch/arm64/include/asm/sysreg.h     |  3 +++
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 519ac1f7f859..33a08fff0f06 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -64,14 +64,26 @@ DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 
 static inline notrace u64 arch_timer_read_cntpct_el0(void)
 {
-	isb();
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
-	isb();
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
@@ -174,8 +186,10 @@ static __always_inline u64 __arch_counter_get_cntpct(void)
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
@@ -193,8 +207,10 @@ static __always_inline u64 __arch_counter_get_cntvct(void)
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
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b268082d67ed..5ce70c034d37 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -507,6 +507,9 @@
 
 #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
 
+#define SYS_CNTPCTSS_EL0		sys_reg(3, 3, 14, 0, 5)
+#define SYS_CNTVCTSS_EL0		sys_reg(3, 3, 14, 0, 6)
+
 #define SYS_CNTP_TVAL_EL0		sys_reg(3, 3, 14, 2, 0)
 #define SYS_CNTP_CTL_EL0		sys_reg(3, 3, 14, 2, 1)
 #define SYS_CNTP_CVAL_EL0		sys_reg(3, 3, 14, 2, 2)
-- 
2.30.2

