Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A5A38B64C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhETStC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236139AbhETSsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:48:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7259B61355;
        Thu, 20 May 2021 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621536451;
        bh=2qJHn0NYcRsiDGsS+gVNRop9M5cOLWda5mJZcN1WsXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sdx2dYon4xoRVs0Hz9wbxFz/wOK1BTycjLW9cBydCYtm/VH0eAyZG6m3En+vo1Yf3
         lo6laU2hralBSiIMoHmfqZuDOaqL53t4nBs5tjyonbHm6GvAzPI1pZmaYqmn1N4G/t
         v5nZhCozGEs9wRc358hWiwS3J6cEHWeOMKg0oQZ3kLmNVDyrM4QqjHYiqk97sTN7a8
         GDd5AVdlecdpFocPg0vtdwCa+ge0mVFobtxpJjUYMElVFqnLDo7S0WPQGsglQS296M
         GDrdxgKpVKo3ldBHnyi3PdUsZyMO3ocQ5MDkf0uIpb9AndExtM3kv5RAOIGyF0+rIm
         yPNCEg//JrvWA==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com
Subject: [PATCH 4/5] tick/broadcast: Program wakeup timer when entering idle if required
Date:   Thu, 20 May 2021 19:47:04 +0100
Message-Id: <20210520184705.10845-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520184705.10845-1-will@kernel.org>
References: <20210520184705.10845-1-will@kernel.org>
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
 kernel/time/tick-broadcast.c | 38 +++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 8bd8cd69c8c9..ba5264e210d9 100644
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
@@ -116,6 +125,7 @@ static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
 	if (curdev && newdev->rating <= curdev->rating)
 		return false;
 
+	newdev->event_handler = tick_oneshot_wakeup_handler;
 set_device:
 	per_cpu(tick_oneshot_wakeup_device, cpu) = newdev;
 	return true;
@@ -903,16 +913,42 @@ static int ___tick_broadcast_oneshot_control(enum tick_broadcast_state state,
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
+	if (state == TICK_BROADCAST_ENTER) {
+		clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT_STOPPED);
+		clockevents_switch_state(wd, CLOCK_EVT_STATE_ONESHOT);
+		clockevents_program_event(wd, dev->next_event, 1);
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

