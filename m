Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D9545F051
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377886AbhKZPJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353992AbhKZPHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:07:36 -0500
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 06:50:25 PST
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB1BC06179E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 06:50:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFD53622A9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 14:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6469C9305D;
        Fri, 26 Nov 2021 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637938224;
        bh=s1q37RCQIwajhGA+DkImquqdXKMhY8FQHPrpGfdbiDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaKdSrXIxZ43L2Xkz38OnzQSwZgTzRECeokkA4sgMv7PvPo4C6lY/o/J1+BJhWSGl
         egNGLxcilg6B5KtrBF2Qf+0sX7YpkNW0UIEw5Vdt+l5crsi/3AmmvIXTagwHWfY8zX
         hcYlolNpfWaUrzJgZV3NGcDjk5JiJ74NyWXSou0Zjg2IEVGDAS8reLgVlxvANkKbLh
         IE2sDabIvZethf3RVkJ1T9PZJbVLVB4XuKrZETktdh2V8ripkdw6OkCrOqSBaX8TXR
         Y0fUFVyiEz/X5U0Bx94lyucRUkfPGbAb+Giv1uyOiqoYXgbK2zbYK3EI5NlwOY4D7f
         bymv0oP1ykmsA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     oleksandr@natalenko.name, john.stultz@linaro.org,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 1/2] timers: Implement usleep_idle_range()
Date:   Fri, 26 Nov 2021 14:50:14 +0000
Message-Id: <20211126145015.15862-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126145015.15862-1-sj@kernel.org>
References: <20211126145015.15862-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel threads such as DAMON could need to repeatedly sleep in
micro seconds level.  Because usleep_range() sleeps in uninterruptible
state, however, such threads would make /proc/loadavg reports fake load.

To help such cases, this commit implements a variant of usleep_range()
called usleep_idle_range().  It is same to usleep_range() but sets the
state of the current task as TASK_IDLE while sleeping.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
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

