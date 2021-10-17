Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8509143090E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbhJQMpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245744AbhJQMpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:45:01 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613F661260;
        Sun, 17 Oct 2021 12:42:52 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mc5V4-00HKfO-Hu; Sun, 17 Oct 2021 13:42:50 +0100
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
Subject: [PATCH v4 09/17] clocksource/arm_arch_timer: Work around broken CVAL implementations
Date:   Sun, 17 Oct 2021 13:42:17 +0100
Message-Id: <20211017124225.3018098-10-maz@kernel.org>
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

The Applied Micro XGene-1 SoC has a busted implementation of the
CVAL register: it looks like it is based on TVAL instead of the
other way around. The net effect of this implementation blunder
is that the maximum deadline you can program in the timer is
32bit wide.

Use a MIDR check to notice the broken CPU, and reduce the width
of the timer to 32bit.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 36e091412151..ef3f83865dcd 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -780,9 +780,32 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 	return 0;
 }
 
+static u64 __arch_timer_check_delta(void)
+{
+#ifdef CONFIG_ARM64
+	const struct midr_range broken_cval_midrs[] = {
+		/*
+		 * XGene-1 implements CVAL in terms of TVAL, meaning
+		 * that the maximum timer range is 32bit. Shame on them.
+		 */
+		MIDR_ALL_VERSIONS(MIDR_CPU_MODEL(ARM_CPU_IMP_APM,
+						 APM_CPU_PART_POTENZA)),
+		{},
+	};
+
+	if (is_midr_in_range_list(read_cpuid_id(), broken_cval_midrs)) {
+		pr_warn_once("Broken CNTx_CVAL_EL1, limiting width to 32bits");
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
@@ -814,6 +837,7 @@ static void __arch_timer_setup(unsigned type,
 		}
 
 		clk->set_next_event = sne;
+		max_delta = __arch_timer_check_delta();
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
@@ -830,11 +854,13 @@ static void __arch_timer_setup(unsigned type,
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

