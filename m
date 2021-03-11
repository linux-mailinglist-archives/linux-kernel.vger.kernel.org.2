Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD593372D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhCKMiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbhCKMh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38A0964FE2;
        Thu, 11 Mar 2021 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466248;
        bh=yrQS4de1iJm9J9n5XDfZaqFGWiDn0IAQujRInbLCvLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYGiE2vG11jxzOPcV2OcBnHSrVZ6Ffc2TUDAU4fZNT5MJpyrkkUUh+4fgCc2LBE3+
         VWZqgqkHsZB6dUkSTK2ajW126YhBebfXxccqe2ATWmm0TR0h30LhtyJRnSFtQaZtfe
         eoJJBCv2wzCJlQ1wOyqOOIPbIuH1P/PI33sJQP2bLoNT0g3EPnHaPUkGah+niTKTbW
         yNI+jEpTcg6Efm7x9PoYC2wGcTwLOOlGMNka9+V302uBd36aK74lIpLJPAdFSejBs6
         NI48h6O7ok+Y5VCuQz5cowMXQ9CWNkRvNdU/bcV/67dM8+2hdRuFlAjGC0sW+CN5lR
         Ydf1VOhFhHIAw==
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
Subject: [PATCH 05/10] tick/nohz: Update idle_exittime on actual idle exit
Date:   Thu, 11 Mar 2021 13:37:03 +0100
Message-Id: <20210311123708.23501-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311123708.23501-1-frederic@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

The idle_exittime field of tick_sched is used to record the time when
the idle state was left. but currently the idle_exittime is updated in
the function tick_nohz_restart_sched_tick(), which is not always in idle
state when nohz_full is configured:

  tick_irq_exit
    tick_nohz_irq_exit
      tick_nohz_full_update_tick
        tick_nohz_restart_sched_tick
          ts->idle_exittime = now;

It's thus overwritten by mistake on nohz_full tick restart. Move the
update to the appropriate idle exit path instead.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c86b586d65e0..2a041d0dc3eb 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -917,8 +917,6 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	 * Cancel the scheduled timer and restore the tick
 	 */
 	ts->tick_stopped  = 0;
-	ts->idle_exittime = now;
-
 	tick_nohz_restart(ts, now);
 }
 
@@ -1192,10 +1190,13 @@ unsigned long tick_nohz_get_idle_calls(void)
 	return ts->idle_calls;
 }
 
-static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
+static void tick_nohz_account_idle_time(struct tick_sched *ts,
+					ktime_t now)
 {
 	unsigned long ticks;
 
+	ts->idle_exittime = now;
+
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 	/*
@@ -1216,8 +1217,9 @@ void tick_nohz_idle_restart_tick(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (ts->tick_stopped) {
-		tick_nohz_restart_sched_tick(ts, ktime_get());
-		tick_nohz_account_idle_ticks(ts);
+		ktime_t now = ktime_get();
+		tick_nohz_restart_sched_tick(ts, now);
+		tick_nohz_account_idle_time(ts, now);
 	}
 }
 
@@ -1228,7 +1230,7 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 	else
 		tick_nohz_restart_sched_tick(ts, now);
 
-	tick_nohz_account_idle_ticks(ts);
+	tick_nohz_account_idle_time(ts, now);
 }
 
 /**
-- 
2.25.1

