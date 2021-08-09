Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4673E48CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhHIP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235754AbhHIP1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:27:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D2860F8F;
        Mon,  9 Aug 2021 15:27:00 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mD7B4-003qjI-Ds; Mon, 09 Aug 2021 16:26:58 +0100
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
Subject: [PATCH 08/13] clocksource/arm_arch_timer: Work around broken CVAL implementations
Date:   Mon,  9 Aug 2021 16:26:46 +0100
Message-Id: <20210809152651.2297337-9-maz@kernel.org>
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

The Applied Micro XGene-1 SoC has a busted implementation of the
CVAL register: it looks like it is based on TVAL instead of the
other way around. The net effect of this implementation blunder
is that the maximum deadline you can program in the timer is
32bit wide.

Detect the problematic case and limit the timer to 32bit deltas.
Note that we don't tie this bug to XGene specifically, as it may
also catch similar defects on other high-quality implementations.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 38 +++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 895844c33351..1c596cd3cc5c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -778,9 +778,42 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 	return 0;
 }
 
+static u64 __arch_timer_check_delta(void)
+{
+#ifdef CONFIG_ARM64
+	u64 tmp;
+
+	/*
+	 * XGene-1 implements CVAL in terms of TVAL, meaning that the
+	 * maximum timer range is 32bit. Shame on them. Detect the
+	 * issue by setting a timer to now+(1<<32), which will
+	 * immediately fire on the duff CPU.
+	 */
+	write_sysreg(0, cntv_ctl_el0);
+	isb();
+	tmp = read_sysreg(cntvct_el0) | BIT(32);
+	write_sysreg(tmp, cntv_cval_el0);
+	write_sysreg(ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_MASK,
+		     cntv_ctl_el0);
+	isb();
+
+	tmp = read_sysreg(cntv_ctl_el0);
+	write_sysreg(0, cntv_ctl_el0);
+	isb();
+
+	if (tmp & ARCH_TIMER_CTRL_IT_STAT) {
+		pr_warn_once("Detected broken implementation, limiting width to 32bits");
+		return CLOCKSOURCE_MASK(32);
+	}
+#endif
+	return CLOCKSOURCE_MASK(56);
+}
+
 static void __arch_timer_setup(unsigned type,
 			       struct clock_event_device *clk)
 {
+	u64 max_delta;
+
 	clk->features = CLOCK_EVT_FEAT_ONESHOT;
 
 	if (type == ARCH_TIMER_TYPE_CP15) {
@@ -812,6 +845,7 @@ static void __arch_timer_setup(unsigned type,
 		}
 
 		clk->set_next_event = sne;
+		max_delta = __arch_timer_check_delta();
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
@@ -828,11 +862,13 @@ static void __arch_timer_setup(unsigned type,
 			clk->set_next_event =
 				arch_timer_set_next_event_phys_mem;
 		}
+
+		max_delta = CLOCKSOURCE_MASK(56);
 	}
 
 	clk->set_state_shutdown(clk);
 
-	clockevents_config_and_register(clk, arch_timer_rate, 0xf, CLOCKSOURCE_MASK(56));
+	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
 }
 
 static void arch_timer_evtstrm_enable(int divider)
-- 
2.30.2

