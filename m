Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7783E36EC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 21:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhHGTOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 15:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGTOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 15:14:51 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4118C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 12:14:33 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id x13-20020a5eda0d0000b02905976d643e4cso887664ioj.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ch4+rbPUJmHH8DosrW567IDIn+nflyhDIsZ9mYXBdfs=;
        b=dVkBm548MK64m+dZUmust+2D2P6VZffiXHvIVy21engZx2i11OHGA6reT9H64M/t8g
         ib5euvY/t40m1kMFSyGtmDKKHN1hdTw+/FjiU0zYSf598mikoZuTUu1XVy/wMnaENxej
         NO8gtaaDvld2an6mwTvC9BjiRW01Qmv4RU/P0xy+U2vf8OHVecx/7mCzGJ8kOFf6WRAr
         4EDqcB21FE2lxKk/BECqujPr+fdHJQ3pWMNZtYfV+KBE1H+AYYV6kRJENU6fnF++LeDk
         5VAWQi0bnI5n3yz0gR23NNNQ2bGkwJa+iEt8EXZnnjaOrxAHvq/BBLfGmHbVbVxeHORU
         C+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ch4+rbPUJmHH8DosrW567IDIn+nflyhDIsZ9mYXBdfs=;
        b=BaXznmp7lR7eN0ONq7rqMhK3vz3Z4ELZuzEjKRr5K0aDyLUpu24vjQJNGyM2sBQe2V
         ywa+7kjKOIsSxDYtP7taK+O8Wv/Q9hTqMOsRxUCzNKSxWIFJpLdnc4I0z5NAKlhvN/rz
         iKqInyjL0n586BNaImeeU4wIUV+tq5KXM+/0cv7MZlqM3xJEMHISuk8z9koQHnZXchzk
         bL5TwzQeUTEjvjYy9osenH0CoQyvtG095jC/xcC/HAZXI2DgaGojp++63Im9/RK6+Ek9
         5ODeradxFHP1iTLjzx40pUhJ2tOr5g+L+uy6ItN/Slw+CmYgY4sFmIXrCcgqoG6loPib
         9vPQ==
X-Gm-Message-State: AOAM532ekQVpWef749Jm0UrnbEoRI3716ZbByWri8kacSne9gZY6OKeH
        vE0dgXFHOUsrviV/FLns5MZWCraI/e4=
X-Google-Smtp-Source: ABdhPJysNcmmYAybHutaRNHL/WX6BYvD9prOvInMPt5PUjzVNf9xbVLalvZK9ut97lcWGPngcmNzX7bkNoI=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a5e:a914:: with SMTP id c20mr175366iod.188.1628363673010;
 Sat, 07 Aug 2021 12:14:33 -0700 (PDT)
Date:   Sat,  7 Aug 2021 19:14:28 +0000
Message-Id: <20210807191428.3488948-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2] clocksource/arm_arch_timer: Fix masking for high freq counters
From:   Oliver Upton <oupton@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
This patch was tested on QEMU, tweaked to provide a 1GHz system counter
frequency. The 'bp.refcounter.base_frequency' property does not seem to
have any affect on the 'ARMvA Base RevC AEM FVP', and instead provides a
100MHz counter.

Parent commit: 0c32706dac1b ("arm64: stacktrace: avoid tracing arch_stack_walk()")

 drivers/clocksource/arm_arch_timer.c | 32 ++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index be6d741d404c..f4816b22213c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -52,6 +52,12 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
+/*
+ * The minimum amount of time a generic counter is guaranteed to not roll over
+ * (40 years)
+ */
+#define MIN_ROLLOVER_SECS	(40ULL * 365 * 24 * 3600)
+
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base __ro_after_init;
@@ -205,13 +211,11 @@ static struct clocksource clocksource_counter = {
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
@@ -1004,9 +1008,26 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
 	return &arch_timer_kvm_info;
 }
 
+/*
+ * Makes an educated guess at a valid counter width based on the Generic Timer
+ * specification. Of note:
+ *   1) the system counter is at least 56 bits wide
+ *   2) a roll-over time of not less than 40 years
+ *
+ * See 'ARM DDI 0487G.a D11.1.2 ("The system counter")' for more details.
+ */
+static int __init arch_counter_get_width(void)
+{
+	u64 min_cycles = MIN_ROLLOVER_SECS * arch_timer_rate;
+
+	/* guarantee the returned width is within the valid range */
+	return clamp_val(ilog2(min_cycles), 56, 64);
+}
+
 static void __init arch_counter_register(unsigned type)
 {
 	u64 start_count;
+	int width;
 
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_TIMER_TYPE_CP15) {
@@ -1031,6 +1052,10 @@ static void __init arch_counter_register(unsigned type)
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 	}
 
+	width = arch_counter_get_width();
+	clocksource_counter.mask = CLOCKSOURCE_MASK(width);
+	cyclecounter.mask = CLOCKSOURCE_MASK(width);
+
 	if (!arch_counter_suspend_stop)
 		clocksource_counter.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 	start_count = arch_timer_read_counter();
@@ -1040,8 +1065,7 @@ static void __init arch_counter_register(unsigned type)
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
 
-	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register(arch_timer_read_counter, width, arch_timer_rate);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
-- 
2.32.0.605.g8dce9f2422-goog

