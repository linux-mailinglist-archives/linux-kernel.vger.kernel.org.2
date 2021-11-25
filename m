Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31CC45DE65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356594AbhKYQNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356312AbhKYQLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:11:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6BC561107;
        Thu, 25 Nov 2021 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637856519;
        bh=d+bFdpUIyO9jw/UFdit4nDOhOAOS+ttW7MZ7tgg4pBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTXjk+20j6QZHx8Guqt2ByWB4B/tpnqFKGdZazmyLAqr3eHorcC3hXbXsYpz7Y0Ik
         seG5ANdEfb3nh9qB9unfRNE0yrmVofHPmQ+avYu110ju2mnG2pPxuEPeDjwmQmCq63
         v3ujr7anHYPwvQ6LQoPnDc3tMjxXg9a1N9PkRpxNRduYq0hp080DHMSEaM8+hbb7tC
         eejZKNWVXJPKNcnN+uTtEXVZ/sa8fXWHp/DX+gjl3/Nsk5JprQiIENwd6FFsM/FkXM
         WeogogbxsLUexJ+lR6y3ZSGyd9Oh0BaoVyak+ce9ItbxWsLJ8nDdP/o98UsLNXatai
         O/XFbTzOIO7sg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 1/2] timers: Implement usleep_idle_range()
Date:   Thu, 25 Nov 2021 16:08:29 +0000
Message-Id: <20211125160830.30153-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211125160830.30153-1-sj@kernel.org>
References: <20211125160830.30153-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel threads such as DAMON could need to repeatedly sleep in
micro seconds level.  Because usleep_range() sleeps in uninterruptible
state, however, such threads would make /proc/loadavg reports fake load.

To help such cases, this commit implements a variant of usleep_range()
called usleep_idle_range().  It is same to usleep_range() but sets the
state of the current task as TASK_IDLE while sleeping.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/delay.h | 14 +++++++++++++-
 kernel/time/timer.c   | 16 +++++++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index 8eacf67eb212..039e7e0c7378 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -20,6 +20,7 @@
  */
 
 #include <linux/math.h>
+#include <linux/sched.h>
 
 extern unsigned long loops_per_jiffy;
 
@@ -58,7 +59,18 @@ void calibrate_delay(void);
 void __attribute__((weak)) calibration_delay_done(void);
 void msleep(unsigned int msecs);
 unsigned long msleep_interruptible(unsigned int msecs);
-void usleep_range(unsigned long min, unsigned long max);
+void usleep_range_state(unsigned long min, unsigned long max,
+			unsigned int state);
+
+static inline void usleep_range(unsigned long min, unsigned long max)
+{
+	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
+}
+
+static inline void usleep_idle_range(unsigned long min, unsigned long max)
+{
+	usleep_range_state(min, max, TASK_IDLE);
+}
 
 static inline void ssleep(unsigned int seconds)
 {
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e3d2c23c413d..85f1021ad459 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2054,26 +2054,28 @@ unsigned long msleep_interruptible(unsigned int msecs)
 EXPORT_SYMBOL(msleep_interruptible);
 
 /**
- * usleep_range - Sleep for an approximate time
- * @min: Minimum time in usecs to sleep
- * @max: Maximum time in usecs to sleep
+ * usleep_range_state - Sleep for an approximate time in a given state
+ * @min:	Minimum time in usecs to sleep
+ * @max:	Maximum time in usecs to sleep
+ * @state:	State of the current task that will be while sleeping
  *
  * In non-atomic context where the exact wakeup time is flexible, use
- * usleep_range() instead of udelay().  The sleep improves responsiveness
+ * usleep_range_state() instead of udelay().  The sleep improves responsiveness
  * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
  * power usage by allowing hrtimers to take advantage of an already-
  * scheduled interrupt instead of scheduling a new one just for this sleep.
  */
-void __sched usleep_range(unsigned long min, unsigned long max)
+void __sched usleep_range_state(unsigned long min, unsigned long max,
+				unsigned int state)
 {
 	ktime_t exp = ktime_add_us(ktime_get(), min);
 	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
 
 	for (;;) {
-		__set_current_state(TASK_UNINTERRUPTIBLE);
+		__set_current_state(state);
 		/* Do not return before the requested sleep time has elapsed */
 		if (!schedule_hrtimeout_range(&exp, delta, HRTIMER_MODE_ABS))
 			break;
 	}
 }
-EXPORT_SYMBOL(usleep_range);
+EXPORT_SYMBOL(usleep_range_state);
-- 
2.17.1

