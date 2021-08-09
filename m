Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C583E48D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbhHIP1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235661AbhHIP1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:27:18 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C714161051;
        Mon,  9 Aug 2021 15:26:57 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mD7B2-003qjI-88; Mon, 09 Aug 2021 16:26:56 +0100
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
Subject: [PATCH 02/13] clocksource/arm_arch_timer: Extend write side of timer register accessors to u64
Date:   Mon,  9 Aug 2021 16:26:40 +0100
Message-Id: <20210809152651.2297337-3-maz@kernel.org>
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

The various accessors for the timer sysreg and MMIO registers are
currently hardwired to 32bit. However, we are about to introduce
the use of the CVAL registers, which require a 64bit access.

Upgrade the write side of the accessors to take a 64bit value
(the read side is left untouched as we don't plan to ever read
back any of these registers).

No functional change expected.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/arch_timer.h    | 10 +++++-----
 arch/arm64/include/asm/arch_timer.h  |  2 +-
 drivers/clocksource/arm_arch_timer.c | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 0c09afaa590d..88075c7f4bfd 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -24,24 +24,24 @@ int arch_timer_arch_init(void);
  * the code. At least it does so with a recent GCC (4.6.3).
  */
 static __always_inline
-void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
+void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 {
 	if (access == ARCH_TIMER_PHYS_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" ((u32)val));
 			break;
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" ((u32)val));
 			break;
 		}
 	}
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 8e3b2ac60c30..107afb721749 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -89,7 +89,7 @@ static inline notrace u64 arch_timer_read_cntvct_el0(void)
  * the code.
  */
 static __always_inline
-void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
+void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 {
 	if (access == ARCH_TIMER_PHYS_ACCESS) {
 		switch (reg) {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9db5c16e31e7..0b2bac3ef7ce 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -100,27 +100,27 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
  */
 
 static __always_inline
-void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
+void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 			  struct clock_event_device *clk)
 {
 	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
 		struct arch_timer *timer = to_arch_timer(clk);
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed(val, timer->base + CNTP_CTL);
+			writel_relaxed((u32)val, timer->base + CNTP_CTL);
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed(val, timer->base + CNTP_TVAL);
+			writel_relaxed((u32)val, timer->base + CNTP_TVAL);
 			break;
 		}
 	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
 		struct arch_timer *timer = to_arch_timer(clk);
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed(val, timer->base + CNTV_CTL);
+			writel_relaxed((u32)val, timer->base + CNTV_CTL);
 			break;
 		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed(val, timer->base + CNTV_TVAL);
+			writel_relaxed((u32)val, timer->base + CNTV_TVAL);
 			break;
 		}
 	} else {
-- 
2.30.2

