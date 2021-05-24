Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A110438F589
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhEXWUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234007AbhEXWUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:20:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B505461405;
        Mon, 24 May 2021 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621894720;
        bh=GxrE+yDYceaRyNnE+1ueYl8w5535JDVaw+e+3EtgLPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oworzg2s2LeJPRW6EN39g2gIjo4cSGObte/nCoWVn68qzmgiGgoYTBEs7L28f2st1
         Oe9VADBJ24tfctHLCr0CYH58HWwYIf2Xaea8arAIF0X9JKr+fBrubs8Y+PKTpepxDT
         MIHJm8N8LVkH7hfQT6fOx/jIStqTynm5LdHh97tquEssfyIIZMTQFcnqRFDPm2a6+F
         H1WlVUtjPboiwxmL6lY6HPbvNq0YkGRGfdhxEqzYNfoDvinpbsYbo8ZwfcqwzFbo3w
         zMkRWAtMRv9zGPReZmaClaMjDj7jqSptlIwLChWRqQ/mTI6azQxj5q2bs+oGf7kXxk
         0dYCYDihNKjUg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        kernel-team@android.com
Subject: [PATCH v2 4/5] tick/broadcast: Program wakeup timer when entering idle if required
Date:   Mon, 24 May 2021 23:18:17 +0100
Message-Id: <20210524221818.15850-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524221818.15850-1-will@kernel.org>
References: <20210524221818.15850-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When configuring the broadcast timer on entry to and exit from deep idle
states, prefer a per-CPU wakeup timer if one exists.

On entry to idle, stop the tick device and transfer the next event into
the oneshot wakeup device, which will serve as the wakeup from idle. To
avoid the overhead of additional hardware accesses on exit from idle,
leave the timer armed and treat the inevitable interrupt as a (possibly
spurious) tick event.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/time/tick-broadcast.c | 44 +++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 0e9e06d6cc5c..9b845212430b 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -96,6 +96,15 @@ static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
 	return per_cpu(tick_oneshot_wakeup_device, cpu);
 }
 
+static void tick_oneshot_wakeup_handler(struct clock_event_device *wd)
+{
+	/*
+	 * If we woke up early and the tick was reprogrammed in the
+	 * meantime then this may be spurious but harmless.
+	 */
+	tick_receive_broadcast();
+}
+
 static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
 					   int cpu)
 {
@@ -121,6 +130,7 @@ static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
 	if (!try_module_get(newdev->owner))
 		return false;
 
+	newdev->event_handler = tick_oneshot_wakeup_handler;
 set_device:
 	clockevents_exchange_device(curdev, newdev);
 	per_cpu(tick_oneshot_wakeup_device, cpu) = newdev;
@@ -909,16 +919,48 @@ static int ___tick_broadcast_oneshot_control(enum tick_broadcast_state state,
 	return ret;
 }
 
+static int tick_oneshot_wakeup_control(enum tick_broadcast_state state,
+				       struct tick_device *td,
+				       int cpu)
+{
+	struct clock_event_device *dev, *wd;
+
+	dev = td->evtdev;
+	if (td->mode != TICKDEV_MODE_ONESHOT)
+		return -EINVAL;
+
+	wd = tick_get_oneshot_wakeup_device(cpu);
+	if (!wd)
+		return -ENODEV;
+
+	switch (state) {
+	case TICK_BROADCAST_ENTER:
+		clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT_STOPPED);
+		clockevents_switch_state(wd, CLOCK_EVT_STATE_ONESHOT);
+		clockevents_program_event(wd, dev->next_event, 1);
+		break;
+	case TICK_BROADCAST_EXIT:
+		/* We may have transitioned to oneshot mode while idle */
+		if (clockevent_get_state(wd) != CLOCK_EVT_STATE_ONESHOT)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
 int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	int cpu = smp_processor_id();
 
+	if (!tick_oneshot_wakeup_control(state, td, cpu))
+		return 0;
+
 	if (tick_broadcast_device.evtdev)
 		return ___tick_broadcast_oneshot_control(state, td, cpu);
 
 	/*
-	 * If there is no broadcast device, tell the caller not
+	 * If there is no broadcast or wakeup device, tell the caller not
 	 * to go into deep idle.
 	 */
 	return -EBUSY;
-- 
2.31.1.818.g46aad6cb9e-goog

