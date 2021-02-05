Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0512B310AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhBELwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhBELt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:49:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0BC0617A9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:48:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d16so7307949wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XYl5WC2CeAwaSnwh84E7vNW/ABs0UQoT/VRBbEVSx+I=;
        b=seS8jvZ4myl28gge7/5j3ukycaaF1VHUEs2tVLw0mGm5gXHHavNDpC8OT77pzpzWds
         z/iNgNCo7Vmr9mTeQIPKqD8Ok2N4swfgAHNA7rpJQ9+r1VBfPhnKKDhU9emWEOHFiJqa
         BtKeT92MLFXmu9IR8w0TBjqmWX46q1EH05Q/qnRFkw1WsgilzG8f6CHj1RDop2NoOvF3
         43V9z1hwbq0H4/F3ZNqrznMTVm58qO9eE3RS0l+5WOQ7BI8PXe4k5Gwrd8deXVpIWwYu
         isSMR+39FBZgt58RhZHqBcclxr0DT90s1MQpX5NfS3dbupOgANg9CMtgCTfvRo3WgpIJ
         G9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XYl5WC2CeAwaSnwh84E7vNW/ABs0UQoT/VRBbEVSx+I=;
        b=QAvxJLKQNhuWk7iIjUgwTxAh67OIHtfeR7glrJYnaoS4anjfWMbLDDSL67Dec6CM0h
         dIfzIMzXyrsYuLZByyoQqYRxSbY6SD0F4dIQYT2kgIIJBw6oBhT2wcwiQt5SjIpjvHfD
         wzJ5pea8MsFiNIIM22gfYLr4qLVD7EDI0rf94rUGMK5fG+WhJBKxRoJXds4SmAw6EO2p
         tt77GoNAfMeDyQHdk2Y3hbYxrUQGpjWGCI31vYfieuqPxDdpbhf0JYfD+UbMdazdnWhR
         6Rs80cjbOckk8QyDCZMr3qmgS4kkwlQZOR7lUxhGCfAiudyBgSium3LA4rCV2EvnbVh6
         YJAw==
X-Gm-Message-State: AOAM532VNCh4PBrVkVJRFJ7XOXPx12PpDsdQ7Rav8p8p63atE8SqTXR3
        NT5K3raQFGS+hnJlMio2RKhMKA==
X-Google-Smtp-Source: ABdhPJzV48H4yXw49d2P5ea/ptVhtbk1sl25xUlKkhI7GcHrhWaqlPrkVhDSRFGLq2+6mzkjxWyT4Q==
X-Received: by 2002:a5d:6b42:: with SMTP id x2mr4562699wrw.117.1612525724861;
        Fri, 05 Feb 2021 03:48:44 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:442a:8956:28be:e500])
        by smtp.gmail.com with ESMTPSA id z4sm11647586wrw.38.2021.02.05.03.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:48:43 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC PATCH 5/6] sched/fair: trigger the update of blocked load on newly idle cpu
Date:   Fri,  5 Feb 2021 12:48:29 +0100
Message-Id: <20210205114830.781-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205114830.781-1-vincent.guittot@linaro.org>
References: <20210205114830.781-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of waking up a random and already idle CPU, we can take advantage
of this_cpu being about to enter idle to run the ILB and update the
blocked load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/nohz.h |  2 ++
 kernel/sched/fair.c        | 11 ++++++++---
 kernel/sched/idle.c        |  6 ++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 6d67e9a5af6b..74cdc4e87310 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -9,8 +9,10 @@
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
+extern void nohz_run_idle_balance(int cpu);
 #else
 static inline void nohz_balance_enter_idle(int cpu) { }
+static inline void nohz_run_idle_balance(int cpu) { }
 #endif
 
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 935594cd5430..3d2ab28d5736 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10461,6 +10461,11 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	return true;
 }
 
+void nohz_run_idle_balance(int cpu)
+{
+	nohz_idle_balance(cpu_rq(cpu), CPU_IDLE);
+}
+
 static void nohz_newidle_balance(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu;
@@ -10482,10 +10487,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
 		return;
 
 	/*
-	 * Blocked load of idle CPUs need to be updated.
-	 * Kick an ILB to update statistics.
+	 * Set the need to trigger ILB in order to update blocked load
+	 * before entering idle state.
 	 */
-	kick_ilb(NOHZ_STATS_KICK);
+	this_rq->nohz_idle_balance = NOHZ_STATS_KICK;
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 305727ea0677..52a4e9ce2f9b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -261,6 +261,12 @@ static void cpuidle_idle_call(void)
 static void do_idle(void)
 {
 	int cpu = smp_processor_id();
+
+	/*
+	 * Check if we need to update some blocked load
+	 */
+	nohz_run_idle_balance(cpu);
+
 	/*
 	 * If the arch has a polling bit, we maintain an invariant:
 	 *
-- 
2.17.1

