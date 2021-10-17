Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA742430906
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbhJQMpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237709AbhJQMo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:44:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9294961212;
        Sun, 17 Oct 2021 12:42:50 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mc5V2-00HKfO-RR; Sun, 17 Oct 2021 13:42:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v4 04/17] clocksource/arm_arch_timer: Move system register timer programming over to CVAL
Date:   Sun, 17 Oct 2021 13:42:12 +0100
Message-Id: <20211017124225.3018098-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211017124225.3018098-1-maz@kernel.org>
References: <20211017124225.3018098-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cope better with high frequency counters, move the
programming of the timers from the countdown timer (TVAL) over
to the comparator (CVAL).

The programming model is slightly different, as we now need to
read the current counter value to have an absolute deadline
instead of a relative one.

There is a small overhead to this change, which we will address
in the following patches.

Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/arch_timer.h    |  8 ++++----
 arch/arm64/include/asm/arch_timer.h  | 10 +++++-----
 drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++++++++++++---
 include/clocksource/arm_arch_timer.h |  1 +
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 1482e70da7d3..a9b2b721c7f9 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -31,8 +31,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" ((u32)val));
+		case ARCH_TIMER_REG_CVAL:
+			asm volatile("mcrr p15, 2, %Q0, %R0, c14" : : "r" (val));
 			break;
 		default:
 			BUILD_BUG();
@@ -42,8 +42,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" ((u32)val));
+		case ARCH_TIMER_REG_CVAL:
+			asm volatile("mcrr p15, 3, %Q0, %R0, c14" : : "r" (val));
 			break;
 		default:
 			BUILD_BUG();
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 43f827b680d0..4f4aa13dd01e 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -96,8 +96,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntp_ctl_el0);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			write_sysreg(val, cntp_tval_el0);
+		case ARCH_TIMER_REG_CVAL:
+			write_sysreg(val, cntp_cval_el0);
 			break;
 		default:
 			BUILD_BUG();
@@ -107,8 +107,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntv_ctl_el0);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			write_sysreg(val, cntv_tval_el0);
+		case ARCH_TIMER_REG_CVAL:
+			write_sysreg(val, cntv_cval_el0);
 			break;
 		default:
 			BUILD_BUG();
@@ -121,7 +121,7 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 }
 
 static __always_inline
-u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
+u64 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 {
 	if (access == ARCH_TIMER_PHYS_ACCESS) {
 		switch (reg) {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index a49bcefaa370..322165468edf 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -691,10 +691,18 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 					   struct clock_event_device *clk)
 {
 	unsigned long ctrl;
+	u64 cnt;
+
 	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
 	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
-	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
+
+	if (access == ARCH_TIMER_PHYS_ACCESS)
+		cnt = __arch_counter_get_cntpct();
+	else
+		cnt = __arch_counter_get_cntvct();
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
@@ -712,17 +720,29 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
 	return 0;
 }
 
+static __always_inline void set_next_event_mem(const int access, unsigned long evt,
+					   struct clock_event_device *clk)
+{
+	unsigned long ctrl;
+	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl |= ARCH_TIMER_CTRL_ENABLE;
+	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+}
+
 static int arch_timer_set_next_event_virt_mem(unsigned long evt,
 					      struct clock_event_device *clk)
 {
-	set_next_event(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
+	set_next_event_mem(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
 	return 0;
 }
 
 static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 					      struct clock_event_device *clk)
 {
-	set_next_event(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
+	set_next_event_mem(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
 	return 0;
 }
 
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 73c7139c866f..d59537afb29d 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -25,6 +25,7 @@
 enum arch_timer_reg {
 	ARCH_TIMER_REG_CTRL,
 	ARCH_TIMER_REG_TVAL,
+	ARCH_TIMER_REG_CVAL,
 };
 
 enum arch_timer_ppi_nr {
-- 
2.30.2

