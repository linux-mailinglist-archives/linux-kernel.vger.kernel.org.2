Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E58415291
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhIVVV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237903AbhIVVVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:21:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F6986115A;
        Wed, 22 Sep 2021 21:19:53 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mT9eh-00CPSk-Sx; Wed, 22 Sep 2021 22:19:51 +0100
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
Subject: [PATCH v2 03/16] clocksource/arm_arch_timer: Extend write side of timer register accessors to u64
Date:   Wed, 22 Sep 2021 22:19:28 +0100
Message-Id: <20210922211941.2756270-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922211941.2756270-1-maz@kernel.org>
References: <20210922211941.2756270-1-maz@kernel.org>
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

Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/arch_timer.h    | 10 +++++-----
 arch/arm64/include/asm/arch_timer.h  |  2 +-
 drivers/clocksource/arm_arch_timer.c | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 7d757085c61a..1482e70da7d3 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -24,15 +24,15 @@ int arch_timer_arch_init(void);
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
 		default:
 			BUILD_BUG();
@@ -40,10 +40,10 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
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
 		default:
 			BUILD_BUG();
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 8332fcfb08e8..43f827b680d0 100644
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
index 67bdc7288f59..a49bcefaa370 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -100,17 +100,17 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
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
 		default:
 			BUILD_BUG();
@@ -119,10 +119,10 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
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
 		default:
 			BUILD_BUG();
-- 
2.30.2

