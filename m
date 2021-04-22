Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D9367FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhDVMCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235957AbhDVMCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34FD96145C;
        Thu, 22 Apr 2021 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619092929;
        bh=OOGMUkUWgJMSjS0NeoPvri4si7it3X4PmC8L55Sni6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGzbuVEU8nk97Mu0M09dBBstKtfKTDLWaduM07JUJ5aXFiz49IMOcuVgDM7SeGEZh
         2jdIVMvgKyuzbXsRmJJUacey32W8rcndY9FNSS5Svap5VwiyV0YpSYzmAwmKryVC/L
         rSnf2LJtkG23BLv+HH4ReaYnBwLp2IA8hWTcPY/MDRmnMauAfFwHcKnQ/gNiaOFfLY
         ksiqIVkqtbT6UHY311W37jAZi6lkpcRibzquEUZyNjIEPLylEO211j7LO7ROp5LvXT
         H3QObbrP0cCuNYG5xRUI7tzFuz3B2gnJDjXANku81NRLrjriH9Bp/A/F6riq1cLJNX
         WEUhzCwRZXolg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 2/8] tick/nohz: Conditionally restart tick on idle exit
Date:   Thu, 22 Apr 2021 14:01:52 +0200
Message-Id: <20210422120158.33629-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422120158.33629-1-frederic@kernel.org>
References: <20210422120158.33629-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

In nohz_full mode, switching from idle to a task will unconditionally
issue a tick restart. If the task is alone in the runqueue or is the
highest priority, the tick will fire once then eventually stop. But that
alone is still undesired noise.

Therefore, only restart the tick on idle exit when it's strictly
necessary.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 46 +++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index e10a4af88737..c888445fb181 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -926,24 +926,30 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	tick_nohz_restart(ts, now);
 }
 
-static void tick_nohz_full_update_tick(struct tick_sched *ts)
+static void __tick_nohz_full_update_tick(struct tick_sched *ts,
+					 ktime_t now)
 {
 #ifdef CONFIG_NO_HZ_FULL
 	int cpu = smp_processor_id();
 
-	if (!tick_nohz_full_cpu(cpu))
-		return;
-
-	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
-		return;
-
 	if (can_stop_full_tick(cpu, ts))
 		tick_nohz_stop_sched_tick(ts, cpu);
 	else if (ts->tick_stopped)
-		tick_nohz_restart_sched_tick(ts, ktime_get());
+		tick_nohz_restart_sched_tick(ts, now);
 #endif
 }
 
+static void tick_nohz_full_update_tick(struct tick_sched *ts)
+{
+	if (!tick_nohz_full_cpu(smp_processor_id()))
+		return;
+
+	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
+		return;
+
+	__tick_nohz_full_update_tick(ts, ktime_get());
+}
+
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
 	/*
@@ -1205,18 +1211,24 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 #endif
 }
 
-static void __tick_nohz_idle_restart_tick(struct tick_sched *ts, ktime_t now)
-{
-	tick_nohz_restart_sched_tick(ts, now);
-	tick_nohz_account_idle_ticks(ts);
-}
-
 void tick_nohz_idle_restart_tick(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (ts->tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, ktime_get());
+	if (ts->tick_stopped) {
+		tick_nohz_restart_sched_tick(ts, ktime_get());
+		tick_nohz_account_idle_ticks(ts);
+	}
+}
+
+static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
+{
+	if (tick_nohz_full_cpu(smp_processor_id()))
+		__tick_nohz_full_update_tick(ts, now);
+	else
+		tick_nohz_restart_sched_tick(ts, now);
+
+	tick_nohz_account_idle_ticks(ts);
 }
 
 /**
@@ -1248,7 +1260,7 @@ void tick_nohz_idle_exit(void)
 		tick_nohz_stop_idle(ts, now);
 
 	if (tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, now);
+		tick_nohz_idle_update_tick(ts, now);
 
 	local_irq_enable();
 }
-- 
2.25.1

