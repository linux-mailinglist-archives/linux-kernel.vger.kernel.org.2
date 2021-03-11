Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7863372D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhCKMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233167AbhCKMhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A41F864FE7;
        Thu, 11 Mar 2021 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466243;
        bh=tWJG8XyIOuDvmB3DrOnKsLIOoV6EuxGTr/dpTqOJcm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQiTBJxmJ8J8whPrtGyYb2wD1fdS3xLxSaCWC//ZxAK8Bckgu/ex8e/KjkJDFjL4F
         S+/ICE5SJHo80mCVN4BXiI2uFkbS/qGu77aFccXe3lPB97/7lJZX7/skT5VZO7FAbV
         +QdvNVBYd2WMg0CAUoqvw7eUfiIhqMcAyxLft9khHffFYbqFDSrJNFzhOe8QDOtADa
         TtWncVc6SZcVVzP0cZKlABchPJaggb7yF7Qpz+7t4MHEf5/CLzCUPTTuP5otRv52ze
         lJJ70X4ttubgRXpHFknmRJOFSEYo4LSIIENotBQe/aADhFr+ahQVqBD0ys1zcFF8pE
         XrEUqocDEmqvg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 03/10] tick/nohz: Conditionally restart tick on idle exit
Date:   Thu, 11 Mar 2021 13:37:01 +0100
Message-Id: <20210311123708.23501-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311123708.23501-1-frederic@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
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
 kernel/time/tick-sched.c | 50 ++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index af76cfa51b57..77dc8cd61dc8 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -922,26 +922,30 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	tick_nohz_restart(ts, now);
 }
 
-static void tick_nohz_full_update_tick(struct tick_sched *ts)
+static void __tick_nohz_full_update_tick(struct tick_sched *ts,
+					 ktime_t now)
 {
 #ifdef CONFIG_NO_HZ_FULL
-	int cpu;
-
-	if (!tick_nohz_full_this_cpu())
-		return;
-
-	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
-		return;
-
-	cpu = smp_processor_id();
+	int cpu = smp_processor_id();
 
 	if (can_stop_full_tick(cpu, ts))
 		tick_nohz_stop_sched_tick(ts, cpu);
 	else if (ts->tick_stopped)
-		tick_nohz_restart_sched_tick(ts, ktime_get());
+		tick_nohz_restart_sched_tick(ts, now);
 #endif
 }
 
+static void tick_nohz_full_update_tick(struct tick_sched *ts)
+{
+	if (!tick_nohz_full_this_cpu())
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
@@ -1209,18 +1213,24 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
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
+	if (tick_nohz_full_this_cpu())
+		__tick_nohz_full_update_tick(ts, now);
+	else
+		tick_nohz_restart_sched_tick(ts, now);
+
+	tick_nohz_account_idle_ticks(ts);
 }
 
 /**
@@ -1252,7 +1262,7 @@ void tick_nohz_idle_exit(void)
 		tick_nohz_stop_idle(ts, now);
 
 	if (tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, now);
+		tick_nohz_idle_update_tick(ts, now);
 
 	local_irq_enable();
 }
-- 
2.25.1

