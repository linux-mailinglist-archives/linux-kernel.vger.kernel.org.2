Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16A835EBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhDNEga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhDNEgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E7556101B;
        Wed, 14 Apr 2021 04:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618374964;
        bh=Yfn5yDTg4kcZDXq6mz2EWpLGM7oURCg60iIsJzg2fMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvZFKNBgHfEHT6c7veMx1DLpZ6yk1IcCe7LOjltYcZR+DopGr8PSiIHfBzo2YCB8k
         vqJvgPFveO1hhLaChrYiR+VTl2jiDbVpQzlRtYC8lyVWYA6uHclR+a4XKPHnZn2g6O
         vUvH6OKK1/QX9qtdJXqa7ZP9U3aq/kbSb6vv49Hmcrbw9esZBK7tLv+ZZa9O4V9cwm
         9gq+uOITRyI4uaF5HwZlwycQmpgYNdt0quACByVEls5f0ayrDYSLrTkH7+pHrnYOeL
         av0zD+ZQz+PfFdVnMaq+jlYvcytSEb+ijc9COukxtgkGXOumLocZ3Rra3Nxjt+fcSE
         PEs1pxVpgxJnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 38C975C247F; Tue, 13 Apr 2021 21:36:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v8 clocksource 2/5] clocksource: Retry clock read if long delays detected
Date:   Tue, 13 Apr 2021 21:35:59 -0700
Message-Id: <20210414043602.2812981-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the clocksource watchdog marks a clock as unstable, this might
be due to that clock being unstable or it might be due to delays that
happen to occur between the reads of the two clocks.  Yes, interrupts are
disabled across those two reads, but there are no shortage of things that
can delay interrupts-disabled regions of code ranging from SMI handlers
to vCPU preemption.  It would be good to have some indication as to why
the clock was marked unstable.

Therefore, re-read the watchdog clock on either side of the read from
the clock under test.  If the watchdog clock shows an excessive time
delta between its pair of reads, the reads are retried.  The maximum
number of retries is specified by a new kernel boot parameter
clocksource.max_read_retries, which defaults to three, that is,
up to four reads, one initial and up to three retries.  If retries
were required, a message is printed on the console.  If the number of
retries is exceeded, the clock under test will be marked unstable.
However, the probability of this happening due to various sorts of
delays is quite small.  In addition, the reason (clock-read delays)
for the unstable marking will be apparent.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Reported-by: Chris Mason <clm@fb.com>
[ paulmck: Per-clocksource retries per Neeraj Upadhyay feedback. ]
[ paulmck: Don't reset injectfail per Neeraj Upadhyay feedback. ]
[ paulmck: Apply Thomas Gleixner feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 4be4391aa72f..3ac19a7859f5 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -124,6 +124,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
+#define WATCHDOG_MAX_SKEW (NSEC_PER_SEC >> 6)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -213,9 +214,10 @@ static void clocksource_watchdog_inject_delay(void)
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	struct clocksource *cs;
-	u64 csnow, wdnow, cslast, wdlast, delta;
-	int64_t wd_nsec, cs_nsec;
+	u64 csnow, wdnow, wdagain, cslast, wdlast, delta;
+	int64_t wd_nsec, wdagain_delta, wderr_nsec = 0, cs_nsec;
 	int next_cpu, reset_pending;
+	int nretries;
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -224,6 +226,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	reset_pending = atomic_read(&watchdog_reset_pending);
 
 	list_for_each_entry(cs, &watchdog_list, wd_list) {
+		nretries = 0;
 
 		/* Clocksource already marked unstable? */
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
@@ -232,11 +235,24 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
+retry:
 		local_irq_disable();
-		csnow = cs->read(cs);
-		clocksource_watchdog_inject_delay();
 		wdnow = watchdog->read(watchdog);
+		clocksource_watchdog_inject_delay();
+		csnow = cs->read(cs);
+		wdagain = watchdog->read(watchdog);
 		local_irq_enable();
+		delta = clocksource_delta(wdagain, wdnow, watchdog->mask);
+		wdagain_delta = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
+		if (wdagain_delta > WATCHDOG_MAX_SKEW) {
+			wderr_nsec = wdagain_delta;
+			if (nretries++ < max_read_retries)
+				goto retry;
+		}
+		if (nretries) {
+			pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d\n",
+				smp_processor_id(), watchdog->name, wderr_nsec, nretries);
+		}
 
 		/* Clocksource initialized ? */
 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
-- 
2.25.1

