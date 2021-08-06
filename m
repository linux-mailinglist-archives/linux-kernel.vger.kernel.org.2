Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C353E2F31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhHFSTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhHFSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:19:21 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0E7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 11:19:05 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id 81-20020a6b02540000b02905824a68848bso5666582ioc.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4pt7QhWVdBAZAccNLJ7Co0Ahi/sO10ASBjVGlHUl104=;
        b=TjlQFXYBQNkXFps/LJl9th2cCqZwh9wckjZhg8+93+RDK9kLNxPtlAWMkFw2jSQA19
         QFCfZVmc0tZvKuATbvgkPOmRYvh4iYAnZgttZq3EwPdlO1+XVnyDfpZXIGjinuCn6+bp
         ceaLKPKw4cLSFABsChUYGBjEqoePv5lkOc12KtgQEQUQMK8mXo3wvIYmbKu5P8QCyIgF
         u/LjcDMsxvrGsJx8kyZ1Mt+rk3vAOZdWzRYOPHFOVealOwHLAHN0w1nae3rvbuWFkZH5
         GRbwu2ATnK7V089cVHG/nayW445reL3jHhNPM9LRs94xFmwUA20G/kUg6BhQdlAYAMEu
         /Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4pt7QhWVdBAZAccNLJ7Co0Ahi/sO10ASBjVGlHUl104=;
        b=EQTUE5AYejOeWMqlLmSeJ7HfI8cO4cAgg0gkIUuLc/32KdVaozeTybdxN0AUyENZw4
         S9priOm/rJaCKfcexLaZj2IBT79XDFOQUA8ZhghhHJYdzINYjjJtAk/03urjzIK/0p21
         sYZwAYOKdCqmfDiBuIiS9W/u8Ot7Iojc1mej57tQmWMwx/pvAK3mgDHZwybVkSmx19C1
         TDN2wN+AZ5hv3BXjXnc0TNgQVhkh0ml7XuNoUT5gaAPgB47CotLychhzDjEtA0AosS08
         rhtsMeRsOrIbVPJ6NsxwSPqRRYsyNrqRDag3oLN3gY1sPJuXN2+3zHCdVPXNqWMyhys/
         JKjg==
X-Gm-Message-State: AOAM530VXnulLgbl+to/kz08DEzZuLGdtsVv+Qlv1JEw1y46x/p88XZs
        7GvVNRqvAwOhb/S48JVp8q4w8gXWqZc=
X-Google-Smtp-Source: ABdhPJy9OszBxX0krnUQ0z3p9cmQEBtU97V6NU0I2norm2BVKVMMk50x+78rJsrwF6IIcSFTjWxg4Qud3mE=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a5d:8b51:: with SMTP id c17mr73477iot.119.1628273943313;
 Fri, 06 Aug 2021 11:19:03 -0700 (PDT)
Date:   Fri,  6 Aug 2021 18:18:55 +0000
Message-Id: <20210806181855.2841629-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH] clocksource/arm_arch_timer: Fix masking for high freq counters
From:   Oliver Upton <oupton@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linuxtronix.de>,
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
This patch was tested with QEMU, tweaked to provide a 1GHz system
counter frequency, as I could not easily figure out how to tweak the
base FVP to provide a 1GHz counter.

Parent commit: 0c32706dac1b ("arm64: stacktrace: avoid tracing arch_stack_walk()")

 drivers/clocksource/arm_arch_timer.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index be6d741d404c..8c41626a4c8a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -52,6 +52,12 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
+/*
+ * The minimum amount of time a generic timer is guaranteed to not roll over
+ * (40 years)
+ */
+#define MIN_ROLLOVER_SECS	(40ULL * 365 * 24 * 3600)
+
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base __ro_after_init;
@@ -1004,9 +1010,24 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
 	return &arch_timer_kvm_info;
 }
 
+/*
+ * Makes an educated guess at a valid counter width based on the Generic Timer
+ * specification. Of note:
+ *   1) the Generic Timer is at least 56 bits wide
+ *   2) a roll-over time of not less than 40 years
+ */
+static int __init arch_counter_get_width(void)
+{
+	u64 min_cycles = MIN_ROLLOVER_SECS * arch_timer_get_cntfrq();
+
+	/* guarantee the returned width is within the valid range */
+	return max(56, min(64, ilog2(min_cycles)));
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

