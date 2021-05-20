Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302D738B64B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhETStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:49:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236085AbhETSsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:48:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5429F611AE;
        Thu, 20 May 2021 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621536449;
        bh=5M3iD+6AYgGmTxRsjr17d+oS5yIoXNVuSfoJm4ysB5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/m4YnaEcrFXutACKlfnFds4FMzkNxpALBpbe73uYs03ELhEuXwJGYgJPUTV6Ds8S
         qc/lhFKc/G6CoecfM65h/UA7ZukCb3NyZ9GgZcBEuRPy9zsw5qODbQ+cdWmCoFZ7+4
         z1yz5UeAZ2OwO+FPDXLvXP1H0KWDgxGIIWysce9TArYQdVC754iOvuRkdoor3TDcgb
         Jw+SBbKiLUdb0NcRfGUQFb4vd9RkwXZx4UPScBWEAVMGZfddixqqwC5eKklF9lKyxs
         qEQ2y2fzr3Z38Wa7nC1QAj+ATfEHFiC3tq0a4gj6gsSZQJL8YSigjK3DCRUukPM1/z
         uv1hGx0/aYg1g==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com
Subject: [PATCH 3/5] tick/broadcast: Prefer per-cpu oneshot wakeup timers to broadcast
Date:   Thu, 20 May 2021 19:47:03 +0100
Message-Id: <20210520184705.10845-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520184705.10845-1-will@kernel.org>
References: <20210520184705.10845-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs have two per-cpu timer implementations where the timer with
the higher rating stops in deep idle (i.e. suffers from
CLOCK_EVT_FEAT_C3STOP) but is otherwise preferable to the timer with the
lower rating. In such a design, we rely on a global broadcast timer and
IPIs to wake up from deep idle states.

To avoid the reliance on a global broadcast timer and also to reduce the
overhead associated with the IPI wakeups, extend
tick_install_broadcast_device() to manage per-cpu wakeup timers
separately from the broadcast device.

For now, these timers remain unused.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/time/tick-broadcast.c | 57 +++++++++++++++++++++++++++++++++++-
 kernel/time/tick-common.c    |  2 +-
 kernel/time/tick-internal.h  |  4 +--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index f3f2f4ba4321..8bd8cd69c8c9 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -33,6 +33,8 @@ static int tick_broadcast_forced;
 static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
 
 #ifdef CONFIG_TICK_ONESHOT
+static DEFINE_PER_CPU(struct clock_event_device *, tick_oneshot_wakeup_device);
+
 static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
 static void tick_broadcast_clear_oneshot(int cpu);
 static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
@@ -88,13 +90,59 @@ static bool tick_check_broadcast_device(struct clock_event_device *curdev,
 	return !curdev || newdev->rating > curdev->rating;
 }
 
+#ifdef CONFIG_TICK_ONESHOT
+static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
+{
+	return per_cpu(tick_oneshot_wakeup_device, cpu);
+}
+
+static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
+					   int cpu)
+{
+	struct clock_event_device *curdev;
+
+	if (!newdev)
+		goto set_device;
+
+	if ((newdev->features & CLOCK_EVT_FEAT_DUMMY) ||
+	    (newdev->features & CLOCK_EVT_FEAT_C3STOP) ||
+	    !(newdev->features & CLOCK_EVT_FEAT_ONESHOT))
+		return false;
+
+	if (!cpumask_equal(newdev->cpumask, cpumask_of(cpu)))
+		return false;
+
+	curdev = tick_get_oneshot_wakeup_device(cpu);
+	if (curdev && newdev->rating <= curdev->rating)
+		return false;
+
+set_device:
+	per_cpu(tick_oneshot_wakeup_device, cpu) = newdev;
+	return true;
+}
+#else
+static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
+{
+	return NULL;
+}
+
+static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
+					   int cpu)
+{
+	return false;
+}
+#endif
+
 /*
  * Conditionally install/replace broadcast device
  */
-void tick_install_broadcast_device(struct clock_event_device *dev)
+void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
 {
 	struct clock_event_device *cur = tick_broadcast_device.evtdev;
 
+	if (tick_set_oneshot_wakeup_device(dev, cpu))
+		return;
+
 	if (!tick_check_broadcast_device(cur, dev))
 		return;
 
@@ -996,6 +1044,13 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
  */
 static void tick_broadcast_oneshot_offline(unsigned int cpu)
 {
+	struct clock_event_device *dev = tick_get_oneshot_wakeup_device(cpu);
+
+	if (dev) {
+		clockevents_switch_state(dev, CLOCK_EVT_STATE_DETACHED);
+		tick_set_oneshot_wakeup_device(NULL, cpu);
+	}
+
 	/*
 	 * Clear the broadcast masks for the dead cpu, but do not stop
 	 * the broadcast device!
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index e15bc0ef1912..d663249652ef 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -373,7 +373,7 @@ void tick_check_new_device(struct clock_event_device *newdev)
 	/*
 	 * Can the new device be used as a broadcast device ?
 	 */
-	tick_install_broadcast_device(newdev);
+	tick_install_broadcast_device(newdev, cpu);
 }
 
 /**
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 7a981c9e87a4..30c89639e305 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -61,7 +61,7 @@ extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
 /* Broadcasting support */
 # ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
-extern void tick_install_broadcast_device(struct clock_event_device *dev);
+extern void tick_install_broadcast_device(struct clock_event_device *dev, int cpu);
 extern int tick_is_broadcast_device(struct clock_event_device *dev);
 extern void tick_suspend_broadcast(void);
 extern void tick_resume_broadcast(void);
@@ -72,7 +72,7 @@ extern int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq);
 extern struct tick_device *tick_get_broadcast_device(void);
 extern struct cpumask *tick_get_broadcast_mask(void);
 # else /* !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST: */
-static inline void tick_install_broadcast_device(struct clock_event_device *dev) { }
+static inline void tick_install_broadcast_device(struct clock_event_device *dev, int cpu) { }
 static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
 static inline int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu) { return 0; }
 static inline void tick_do_periodic_broadcast(struct clock_event_device *d) { }
-- 
2.31.1.818.g46aad6cb9e-goog

