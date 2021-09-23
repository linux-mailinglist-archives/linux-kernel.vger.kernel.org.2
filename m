Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5864162B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbhIWQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbhIWQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:06:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A551C061766
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:04:39 -0700 (PDT)
Message-ID: <20210923153340.054751351@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632413078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KAg3uMm6koiZSQOSDJG3NWvQRbutAeBpTdCjlZlVP94=;
        b=dvfjOcbJ65dolVX+1AVB8UX+/wyhkmQbXiDylsOgpKGDCzI/puwJpB/SdeRGfnA/ZB9/rh
        1tVg1cHjFnyaiXM6XRbqzLXbWEoq0Yct7AQDEGcxf9BGMEuCBdURFu/l4Ad5O+i2GEYFeS
        27HolhRjPYTEDCQSJOLFEa60btrTg33Tpf8Db0oNKm/x8748AlPcWg6WrLr6wYo5s/WpDo
        u9Gf5xfXYtrXBMh9ljFVKpJZw/VzQ3Rm0DS5FeOAQmgla7vWEPw6TU5iRt0lMGsAWWZIYr
        /xwsenQbsYKfE/d1MqD0aUjICiYbRpqQL2t9ycrSAKie6X8tLM0tqVb7pmWUfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632413078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KAg3uMm6koiZSQOSDJG3NWvQRbutAeBpTdCjlZlVP94=;
        b=jkTA7LNMwxPlpy33gACkxHTAoaeI8bD67GDgjwBAFRUm2/JFWe5FiCSB+l+NpM93R/pNG0
        n6D+fOcy3fDXSaDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>
Subject: [patch 11/11] hrtimer: Make hrtimer_forward() private to core timer code
References: <20210923153311.225307347@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:04:37 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hrtimer_forward() invites to be used in the wrong way and there is no real
requirement to have it outside of the timers core code.

All users outside of the timer core code have been converted to
hrtimer_forward_now() which provides all what the non-core code usage
needs.

Export hrtimer_forward_now() instead and move the prototype to a timer core
header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h     |   26 +-------------------------
 kernel/time/hrtimer.c       |   23 ++++++++++++++++++++++-
 kernel/time/posix-timers.c  |    1 +
 kernel/time/tick-internal.h |    1 +
 4 files changed, 25 insertions(+), 26 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -480,31 +480,7 @@ static inline int hrtimer_callback_runni
 	return timer->base->running == timer;
 }
 
-/* Forward a hrtimer so it expires after now: */
-extern u64
-hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
-
-/**
- * hrtimer_forward_now - forward the timer expiry so it expires after now
- * @timer:	hrtimer to forward
- * @interval:	the interval to forward
- *
- * Forward the timer expiry so it will expire after the current time
- * of the hrtimer clock base. Returns the number of overruns.
- *
- * Can be safely called from the callback function of @timer. If
- * called from other contexts @timer must neither be enqueued nor
- * running the callback and the caller needs to take care of
- * serialization.
- *
- * Note: This only updates the timer expiry value and does not requeue
- * the timer.
- */
-static inline u64 hrtimer_forward_now(struct hrtimer *timer,
-				      ktime_t interval)
-{
-	return hrtimer_forward(timer, timer->base->get_time(), interval);
-}
+extern u64 hrtimer_forward_now(struct hrtimer *timer, ktime_t interval);
 
 /* Precise sleep: */
 
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1067,7 +1067,28 @@ u64 hrtimer_forward(struct hrtimer *time
 
 	return orun;
 }
-EXPORT_SYMBOL_GPL(hrtimer_forward);
+
+/**
+ * hrtimer_forward_now - forward the timer expiry so it expires after now
+ * @timer:	hrtimer to forward
+ * @interval:	the interval to forward
+ *
+ * Forward the timer expiry so it will expire after the current time
+ * of the hrtimer clock base. Returns the number of overruns.
+ *
+ * Can be safely called from the callback function of @timer. If
+ * called from other contexts @timer must neither be enqueued nor
+ * running the callback and the caller needs to take care of
+ * serialization.
+ *
+ * Note: This only updates the timer expiry value and does not requeue
+ * the timer.
+ */
+extern u64 hrtimer_forward_now(struct hrtimer *timer, ktime_t interval)
+{
+	return hrtimer_forward(timer, timer->base->get_time(), interval);
+}
+EXPORT_SYMBOL_GPL(hrtimer_forward_now);
 
 /*
  * enqueue_hrtimer - internal function to (re)start a timer
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -33,6 +33,7 @@
 #include <linux/time_namespace.h>
 
 #include "timekeeping.h"
+#include "tick-internal.h"
 #include "posix-timers.h"
 
 /*
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -177,6 +177,7 @@ void clock_was_set(unsigned int bases);
 void clock_was_set_delayed(void);
 
 void hrtimers_resume_local(void);
+u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
 
 /* Since jiffies uses a simple TICK_NSEC multiplier
  * conversion, the .shift value could be zero. However

