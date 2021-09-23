Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BCA4162B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbhIWQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242411AbhIWQGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:06:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016C4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:04:36 -0700 (PDT)
Message-ID: <20210923153339.932440049@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632413074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JQi9muCOtWdtSbjLAkQ9NXZ6f98b+9fHYaFbQmWo6ws=;
        b=baWMEYyq7kV3ilUhCs6YH+wCZHzehCEBjmupJNGpMtwG1H9+Ip2p5iZM1h7uhj8fBXn79C
        vZLaMj0kUBYhUFk3gp78BNktCU840Q5PYr+dDXf0PPBM7dovsxc8WLHFObvTx3lZ/sbljd
        xMvAiLCU2DEDR7/4jdn5RB4FqVaAjdhtzpnY0xt4TVupfcv+WLEITz2aRxzsrYPQqrSCvR
        3RmCW+dN8d3vhcoUuUBcwkvMV7G/gJYjiQDvZ30zeb0zoEdXUGsiDd/vi33FytOlMFaetr
        6gNXb87uMliz5aOWFtOHTxnSbr4chQ7kNYfRwFqFqwVafPmK0Qp+fhAmpJilqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632413074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JQi9muCOtWdtSbjLAkQ9NXZ6f98b+9fHYaFbQmWo6ws=;
        b=rI5qEhstOSU2blbeOypZSh2TOVyfcgWx/3w0MM15vwpbXSheRdoZf/fTgPF4KeBkFP3htt
        2C6f0Ef4YwEfUUBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>
Subject: [patch 09/11] posix-timers: Fixup stale commnt and reduce ifdeffery
References: <20210923153311.225307347@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:04:34 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When chasing all invocations of hrtimer_forward() the comment in
posix_timer_fn() turned out to be stale and misleading.

When it was written there was an idea floating around to actually let
periodic posix timers which fail signal delivery due to SIG_IGN not rearm
the underlying hrtimer and restart the timer when SIG_IGN is lifted. In
principle a good idea, but all implementation attempts ended in creating
more problems than they solved. But the comment was left around and
suggests for 14 years now that this is going to be fixed soonish.

Rewrite it to reflect reality and replace the ifdeffery close to it with
IS_ENABLED().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -387,35 +387,27 @@ static enum hrtimer_restart posix_timer_
 			ktime_t now = hrtimer_cb_get_time(timer);
 
 			/*
-			 * FIXME: What we really want, is to stop this
-			 * timer completely and restart it in case the
-			 * SIG_IGN is removed. This is a non trivial
-			 * change which involves sighand locking
-			 * (sigh !), which we don't want to do late in
-			 * the release cycle.
-			 *
-			 * For now we just let timers with an interval
-			 * less than a jiffie expire every jiffie to
-			 * avoid softirq starvation in case of SIG_IGN
-			 * and a very small interval, which would put
-			 * the timer right back on the softirq pending
-			 * list. By moving now ahead of time we trick
-			 * hrtimer_forward() to expire the timer
-			 * later, while we still maintain the overrun
-			 * accuracy, but have some inconsistency in
-			 * the timer_gettime() case. This is at least
-			 * better than a starved softirq. A more
-			 * complex fix which solves also another related
-			 * inconsistency is already in the pipeline.
+			 * What we really want, is to stop this timer
+			 * completely and restart it in case the SIG_IGN is
+			 * removed. That's not trivial. For now we just let
+			 * timers with an interval less than a jiffie
+			 * expire every jiffie to avoid softirq starvation
+			 * in case of SIG_IGN and a very small interval,
+			 * which would put the timer right back on the
+			 * softirq pending list. By moving now ahead of
+			 * time we trick hrtimer_forward() to expire the
+			 * timer later, while we still maintain the overrun
+			 * accuracy, but have some inconsistency in the
+			 * timer_gettime() case. This is at least better
+			 * than a starved softirq.
 			 */
-#ifdef CONFIG_HIGH_RES_TIMERS
-			{
+			if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS)) {
 				ktime_t kj = NSEC_PER_SEC / HZ;
 
 				if (timr->it_interval < kj)
 					now = ktime_add(now, kj);
 			}
-#endif
+
 			timr->it_overrun += hrtimer_forward(timer, now,
 							    timr->it_interval);
 			ret = HRTIMER_RESTART;

