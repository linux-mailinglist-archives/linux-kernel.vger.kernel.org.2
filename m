Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812CC3E48D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhHIP1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235598AbhHIP1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:27:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D926101D;
        Mon,  9 Aug 2021 15:26:59 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mD7B3-003qjI-NO; Mon, 09 Aug 2021 16:26:57 +0100
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
Subject: [PATCH 06/13] clocksource/arm_arch_timer: Move MMIO timer programming over to CVAL
Date:   Mon,  9 Aug 2021 16:26:44 +0100
Message-Id: <20210809152651.2297337-7-maz@kernel.org>
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

Similarily to the sysreg-based timer, move the MMIO over to using
the CVAL registers instead of TVAL. Note that there is no warranty
that the 64bit MMIO access will be atomic, but the timer is always
disabled at the point where we program CVAL.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/arch_timer.h    |  1 +
 drivers/clocksource/arm_arch_timer.c | 50 ++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index b48de9d26f27..d21a7f788d7b 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -7,6 +7,7 @@
 #include <asm/hwcap.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
 
 #include <clocksource/arm_arch_timer.h>
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ca7761d8459a..29544b16edf3 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -44,11 +44,13 @@
 #define CNTACR_RWVT	BIT(4)
 #define CNTACR_RWPT	BIT(5)
 
-#define CNTVCT_LO	0x08
-#define CNTVCT_HI	0x0c
+#define CNTVCT_LO	0x00
+#define CNTPCT_LO	0x08
 #define CNTFRQ		0x10
+#define CNTP_CVAL_LO	0x20
 #define CNTP_TVAL	0x28
 #define CNTP_CTL	0x2c
+#define CNTV_CVAL_LO	0x30
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
@@ -113,7 +115,12 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 			writel_relaxed((u32)val, timer->base + CNTP_TVAL);
 			break;
 		case ARCH_TIMER_REG_CVAL:
-			BUG();
+			/*
+			 * Not guaranteed to be atomic, so the timer
+			 * must be disabled at this point.
+			 */
+			writeq_relaxed(val, timer->base + CNTP_CVAL_LO);
+			break;
 		}
 	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
 		struct arch_timer *timer = to_arch_timer(clk);
@@ -125,7 +132,9 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 			writel_relaxed((u32)val, timer->base + CNTV_TVAL);
 			break;
 		case ARCH_TIMER_REG_CVAL:
-			BUG();
+			/* Same restriction as above */
+			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
+			break;
 		}
 	} else {
 		arch_timer_reg_write_cp15(access, reg, val);
@@ -722,15 +731,36 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
 	return 0;
 }
 
+static u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
+{
+	u32 cnt_lo, cnt_hi, tmp_hi;
+
+	do {
+		cnt_hi = readl_relaxed(t->base + offset_lo + 4);
+		cnt_lo = readl_relaxed(t->base + offset_lo);
+		tmp_hi = readl_relaxed(t->base + offset_lo + 4);
+	} while (cnt_hi != tmp_hi);
+
+	return ((u64) cnt_hi << 32) | cnt_lo;
+}
+
 static __always_inline void set_next_event_mem(const int access, unsigned long evt,
 					   struct clock_event_device *clk)
 {
+	struct arch_timer *timer = to_arch_timer(clk);
 	unsigned long ctrl;
+	u64 cnt;
+
 	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
 	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
 
-	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
+	if (access ==  ARCH_TIMER_MEM_VIRT_ACCESS)
+		cnt = arch_counter_get_cnt_mem(timer, CNTVCT_LO);
+	else
+		cnt = arch_counter_get_cnt_mem(timer, CNTPCT_LO);
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
@@ -972,15 +1002,7 @@ bool arch_timer_evtstrm_available(void)
 
 static u64 arch_counter_get_cntvct_mem(void)
 {
-	u32 vct_lo, vct_hi, tmp_hi;
-
-	do {
-		vct_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
-		vct_lo = readl_relaxed(arch_timer_mem->base + CNTVCT_LO);
-		tmp_hi = readl_relaxed(arch_timer_mem->base + CNTVCT_HI);
-	} while (vct_hi != tmp_hi);
-
-	return ((u64) vct_hi << 32) | vct_lo;
+	return arch_counter_get_cnt_mem(arch_timer_mem, CNTVCT_LO);
 }
 
 static struct arch_timer_kvm_info arch_timer_kvm_info;
-- 
2.30.2

