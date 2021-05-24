Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03238F58A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhEXWUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234032AbhEXWUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:20:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07515613BF;
        Mon, 24 May 2021 22:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621894722;
        bh=ffWiERagTcZEV4ms3ZlV8yXc4bcuThcyGLbdb9sfjLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpjVEBTcJ6GmF8j8G5FpNJCRs0aIcpRtzJRssqXnp315cpuHjQ/w2zb4aH8JP2GIE
         earNDJRuiuwmvfTvQpjqMwn6byI5dCjc64DpxRBOlPsct4r+s73rwcfZbtEX5dd/S7
         G1G26gfLPQmkbpqjs4upQqCf43m18xg3rRJVV4UhBAJNa3lWCQNovAAY2Lt9b2F3hl
         qpTRzTj5x3B2GbIpvOXXUBodzNQw6H7nCsorRd+ojQzySSMhk00ZyogtkbxpoguyV7
         yopXY9WiZ15yjiGzfVpfyb6+4grGrz852kDeqJgjqU/oG9Hjx/JKzIwnNko+XtZh8m
         Pltzq5sk9VdyA==
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
Subject: [PATCH v2 5/5] timer_list: Print name of per-cpu wakeup device
Date:   Mon, 24 May 2021 23:18:18 +0100
Message-Id: <20210524221818.15850-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524221818.15850-1-will@kernel.org>
References: <20210524221818.15850-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of per-cpu wakeup devices that can be used in
preference to the broadcast timer, print the name of such devices when
they are available.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/time/tick-broadcast.c |  7 +++++++
 kernel/time/tick-internal.h  |  1 +
 kernel/time/timer_list.c     | 10 +++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 9b845212430b..f7fe6fe36173 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -63,6 +63,13 @@ struct cpumask *tick_get_broadcast_mask(void)
 	return tick_broadcast_mask;
 }
 
+static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu);
+
+const struct clock_event_device *tick_get_wakeup_device(int cpu)
+{
+	return tick_get_oneshot_wakeup_device(cpu);
+}
+
 /*
  * Start the device in periodic mode
  */
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 30c89639e305..6a742a29e545 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -71,6 +71,7 @@ extern void tick_set_periodic_handler(struct clock_event_device *dev, int broadc
 extern int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq);
 extern struct tick_device *tick_get_broadcast_device(void);
 extern struct cpumask *tick_get_broadcast_mask(void);
+extern const struct clock_event_device *tick_get_wakeup_device(int cpu);
 # else /* !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST: */
 static inline void tick_install_broadcast_device(struct clock_event_device *dev, int cpu) { }
 static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 6939140ab7c5..cca611edfd65 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -228,6 +228,14 @@ print_tickdevice(struct seq_file *m, struct tick_device *td, int cpu)
 	SEQ_printf(m, " event_handler:  %ps\n", dev->event_handler);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " retries:        %lu\n", dev->retries);
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+	if (cpu >= 0) {
+		const struct clock_event_device *wd =
+			tick_get_wakeup_device(cpu);
+		SEQ_printf(m, "Wakeup Device: %s\n", wd ? wd->name : "<NULL>");
+	}
+#endif
 	SEQ_printf(m, "\n");
 }
 
@@ -248,7 +256,7 @@ static void timer_list_show_tickdevices_header(struct seq_file *m)
 
 static inline void timer_list_header(struct seq_file *m, u64 now)
 {
-	SEQ_printf(m, "Timer List Version: v0.8\n");
+	SEQ_printf(m, "Timer List Version: v0.9\n");
 	SEQ_printf(m, "HRTIMER_MAX_CLOCK_BASES: %d\n", HRTIMER_MAX_CLOCK_BASES);
 	SEQ_printf(m, "now at %Ld nsecs\n", (unsigned long long)now);
 	SEQ_printf(m, "\n");
-- 
2.31.1.818.g46aad6cb9e-goog

