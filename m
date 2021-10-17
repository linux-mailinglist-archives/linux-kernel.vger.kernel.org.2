Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C257843091F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbhJQMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343615AbhJQMtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:49:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C350660EE3;
        Sun, 17 Oct 2021 12:46:52 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mc5V5-00HKfO-FY; Sun, 17 Oct 2021 13:42:51 +0100
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
Subject: [PATCH v4 12/17] clocksource/arm_arch_timer: Fix masking for high freq counters
Date:   Sun, 17 Oct 2021 13:42:20 +0100
Message-Id: <20211017124225.3018098-13-maz@kernel.org>
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

From: Oliver Upton <oupton@google.com>

Unfortunately, the architecture provides no means to determine the bit
width of the system counter. However, we do know the following from the
specification:

 - the system counter is at least 56 bits wide
 - Roll-over time of not less than 40 years

To date, the arch timer driver has depended on the first property,
assuming any system counter to be 56 bits wide and masking off the rest.
However, combining a narrow clocksource mask with a high frequency
counter could result in prematurely wrapping the system counter by a
significant margin. For example, a 56 bit wide, 1GHz system counter
would wrap in a mere 2.28 years!

This is a problem for two reasons: v8.6+ implementations are required to
provide a 64 bit, 1GHz system counter. Furthermore, before v8.6,
implementers may select a counter frequency of their choosing.

Fix the issue by deriving a valid clock mask based on the second
property from above. Set the floor at 56 bits, since we know no system
counter is narrower than that.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
[maz: fixed width computation not to lose the last bit, added
      max delta generation for the timer]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210807191428.3488948-1-oupton@google.com
---
 drivers/clocksource/arm_arch_timer.c | 34 ++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6e20bc12dc35..9a04eacc4412 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -52,6 +52,12 @@
 #define CNTV_CVAL_LO	0x30
 #define CNTV_CTL	0x3c
 
+/*
+ * The minimum amount of time a generic counter is guaranteed to not roll over
+ * (40 years)
+ */
+#define MIN_ROLLOVER_SECS	(40ULL * 365 * 24 * 3600)
+
 static unsigned arch_timers_present __initdata;
 
 struct arch_timer {
@@ -95,6 +101,22 @@ static int __init early_evtstrm_cfg(char *buf)
 }
 early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
 
+/*
+ * Makes an educated guess at a valid counter width based on the Generic Timer
+ * specification. Of note:
+ *   1) the system counter is at least 56 bits wide
+ *   2) a roll-over time of not less than 40 years
+ *
+ * See 'ARM DDI 0487G.a D11.1.2 ("The system counter")' for more details.
+ */
+static int arch_counter_get_width(void)
+{
+	u64 min_cycles = MIN_ROLLOVER_SECS * arch_timer_rate;
+
+	/* guarantee the returned width is within the valid range */
+	return clamp_val(ilog2(min_cycles - 1) + 1, 56, 64);
+}
+
 /*
  * Architected system timer support.
  */
@@ -212,13 +234,11 @@ static struct clocksource clocksource_counter = {
 	.id	= CSID_ARM_ARCH_COUNTER,
 	.rating	= 400,
 	.read	= arch_counter_read,
-	.mask	= CLOCKSOURCE_MASK(56),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static struct cyclecounter cyclecounter __ro_after_init = {
 	.read	= arch_counter_read_cc,
-	.mask	= CLOCKSOURCE_MASK(56),
 };
 
 struct ate_acpi_oem_info {
@@ -790,7 +810,7 @@ static u64 __arch_timer_check_delta(void)
 		return CLOCKSOURCE_MASK(32);
 	}
 #endif
-	return CLOCKSOURCE_MASK(56);
+	return CLOCKSOURCE_MASK(arch_counter_get_width());
 }
 
 static void __arch_timer_setup(unsigned type,
@@ -1035,6 +1055,7 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
 static void __init arch_counter_register(unsigned type)
 {
 	u64 start_count;
+	int width;
 
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_TIMER_TYPE_CP15) {
@@ -1059,6 +1080,10 @@ static void __init arch_counter_register(unsigned type)
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 	}
 
+	width = arch_counter_get_width();
+	clocksource_counter.mask = CLOCKSOURCE_MASK(width);
+	cyclecounter.mask = CLOCKSOURCE_MASK(width);
+
 	if (!arch_counter_suspend_stop)
 		clocksource_counter.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 	start_count = arch_timer_read_counter();
@@ -1068,8 +1093,7 @@ static void __init arch_counter_register(unsigned type)
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
 
-	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register(arch_timer_read_counter, width, arch_timer_rate);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
-- 
2.30.2

