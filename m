Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C86C388D24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352133AbhESLo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:44:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:41094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234661AbhESLoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:44:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621424614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulmy6qzSuk6uBUtR7AcYBA8GfZqqhWse/qJqdxCDUSc=;
        b=JkYd08oK2Jm5fvtqS8zfv7YUk6C2+yfyP+fw9MNVDd6UN9l/676LOgrb1AxxUXuZNOiR0D
        VNkR/o4BxVgWn8y/sx4ks+fClHCG0rXQcfuZ632BfmX+w76GpkZ6v/b74RLSLaEkP/0FKi
        4QeXYMcqD1KfMrRYuWPIGlZqeXi3/vg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1934B028;
        Wed, 19 May 2021 11:43:34 +0000 (UTC)
Date:   Wed, 19 May 2021 13:43:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: Reliable handling of timestamps
Message-ID: <YKT55gw+RZfyoFf7@alley>
References: <20210517140612.222750-1-senozhatsky@chromium.org>
 <YKPfDQoN5hToB9nk@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKPfDQoN5hToB9nk@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 9bf3bc949f8aeefeacea4b ("watchdog: cleanup handling of false
positives") tried to handle a virtual host stopped by the host a more
straightforward and cleaner way.

But it introduced a risk of false softlockup reports. The virtual host
might be stopped at any time, for example between
kvm_check_and_clear_guest_paused() and is_softlockup().
As a result, is_softlockup() might read the updated jiffies
are detects softlockup.

A solution might be to put back kvm_check_and_clear_guest_paused()
after is_softlockup() and detect it. But it would put back
the cycle that complicates the logic.

In fact, the handling of all the timestamps is not reliable.
The code does not guarantee when and how many times the timestamps
are read. For example, "period_ts" might be touched anytime also
from NMI and re-read in is_softlockup(). It works just by chance.

Fix all the problems by making the code even more explicit.

1. Make sure that "now" and "period_ts" timestamps are read only
   once. They might be changed at anytime by NMI or when the virtual
   guest is stopped by the host. Note that "now" timestamp does
   this implicitly because "jiffies" is marked volatile.

2. "now" time must be read first. The state of "period_ts" will decide
   whether it will be used or the period will get restarted.

3. kvm_check_and_clear_guest_paused() must be called before reading
   "period_ts". It touches the variable when the guest was
   stopped.

As a result, "now" timestamp is used only when the watchdog was
not touched and the guest not stopped in the meantime. "period_ts"
is restarted in all other situations.

Fixes: 9bf3bc949f8aeefeacea4b ("watchdog: cleanup handling of false positives")
Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7c397907d0e9..92d3bcc5a5e0 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -302,10 +302,10 @@ void touch_softlockup_watchdog_sync(void)
 	__this_cpu_write(watchdog_report_ts, SOFTLOCKUP_DELAY_REPORT);
 }
 
-static int is_softlockup(unsigned long touch_ts, unsigned long period_ts)
+static int is_softlockup(unsigned long touch_ts,
+			 unsigned long period_ts,
+			 unsigned long now)
 {
-	unsigned long now = get_timestamp();
-
 	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
@@ -353,8 +353,7 @@ static int softlockup_fn(void *data)
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
-	unsigned long touch_ts = __this_cpu_read(watchdog_touch_ts);
-	unsigned long period_ts = __this_cpu_read(watchdog_report_ts);
+	unsigned long touch_ts, period_ts, now;
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
@@ -376,12 +375,23 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
 
+	/*
+	 * Read the current timestamp first. It might become invalid anytime
+	 * when a virtual machine is stopped by the host or when the watchog
+	 * is touched from NMI.
+	 */
+	now = get_timestamp();
 	/*
 	 * If a virtual machine is stopped by the host it can look to
-	 * the watchdog like a soft lockup. Check to see if the host
-	 * stopped the vm before we process the timestamps.
+	 * the watchdog like a soft lockup. This function touches the watchdog.
 	 */
 	kvm_check_and_clear_guest_paused();
+	/*
+	 * The stored timestamp is comparable with @now only when not touched.
+	 * It might get touched anytime from NMI. Make sure that is_softlockup()
+	 * uses the same (valid) value.
+	 */
+	period_ts = READ_ONCE(*this_cpu_ptr(&watchdog_report_ts));
 
 	/* Reset the interval when touched by known problematic code. */
 	if (period_ts == SOFTLOCKUP_DELAY_REPORT) {
@@ -398,13 +408,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		return HRTIMER_RESTART;
 	}
 
-	/* check for a softlockup
-	 * This is done by making sure a high priority task is
-	 * being scheduled.  The task touches the watchdog to
-	 * indicate it is getting cpu time.  If it hasn't then
-	 * this is a good indication some task is hogging the cpu
-	 */
-	duration = is_softlockup(touch_ts, period_ts);
+	/* Check for a softlockup. */
+	touch_ts = __this_cpu_read(watchdog_touch_ts);
+	duration = is_softlockup(touch_ts, period_ts, now);
 	if (unlikely(duration)) {
 		/*
 		 * Prevent multiple soft-lockup reports if one cpu is already
-- 
2.26.2

