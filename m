Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F268B3A0406
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbhFHTYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhFHTMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:12:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3092C061280
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 12:04:54 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c18so6204924qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jPcj/C6TRMQWZ0en2y4QiL1/nmkGIzkAV8/GV2D66g=;
        b=sA+MecloS58fnoElC0H+yTSvjBc41EROUjuFmWMYrN8etoMTh9udDwKLdcCqWwpf/L
         wTvrDLojEaDXmT1tpHkrc86ag8wA3vZc5OEglsn3qH+3UoR9Pces6beT9F3YdIXWrxAo
         L3BVpPQ3AdP9LfQqhRzfm1hH3Jbb/9hx8AKNHRRQm/thVgXGqWhGsTDgTogT29N2i6Tz
         4ZwC8Jk+rHzvtncWeElBcmAjDWYOqCUaqvY/HCOQoB3haYWbcUw9+bjrfxiMvRW2+hCB
         ccG9NMoYJ+JC2TGRZEJI3Fx7zRCfScetgWFtXsD5SpHG4LNWkBLsWOUoJIpWHKWBkBSN
         9pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jPcj/C6TRMQWZ0en2y4QiL1/nmkGIzkAV8/GV2D66g=;
        b=g1ERiP0AhankfADiv0oAcamGB822/IWWQ6rIiyLMTY1whincTcyRuxBRixLPQ4PHUP
         ZWGyFfh2pyTBJ7V4kP1DdXEIAYfBl0fDJYSjgFtCT9uJ8pkTAoVVVdQ5BRCmAA/hmM+o
         5//OTG8n6U6TMFvc5C64HMgk9oxhMHEV976K67YAEVW7MsT8H64Uq7FOahMJDM9HhNW8
         aFPPfQozvGGNnoCmywuPY+O2wD4HFRT5i5YHv6cMwro33/1qqVz3PdoqC96oHCyDqRfu
         ZOjbKJnLHPL3Sh6jqUVrZEAZHsTAOnM4Zo6voZxd+uXIUlXj3QE11/Fsm8icPD5PFBGC
         zb3Q==
X-Gm-Message-State: AOAM530UZgHvRW7Cx+r+4WwFaCDly3PopIlQsOPsXjx9IA8HtVAzcPmh
        mIKZjGZbYCCIvXvXzV0cZ5K+nnnsWFvPAQ==
X-Google-Smtp-Source: ABdhPJyzjXZFrbAERlLdgkoOpW6DC2YNv+L8A3+Ui8RxI9a0HNzM45aqkaw1M0LuvLfW+XBDoTBzsA==
X-Received: by 2002:a05:620a:20d7:: with SMTP id f23mr22466830qka.484.1623179093952;
        Tue, 08 Jun 2021 12:04:53 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id d24sm11792750qtm.70.2021.06.08.12.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:04:53 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] psi: clean up time collection functions
Date:   Tue,  8 Jun 2021 15:04:52 -0400
Message-Id: <20210608190452.77486-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions to read the per-cpu time buckets and aggregate them
don't have the greatest names and an awkward calling convention. Clean
this up to make things a bit more readable:

- Rename get_recent_times() to read_cpu_states() to make it clearer
  this is about extracting psi state from one cpu, and not just the
  times, either. Remove the pchanged_states return parameter and make
  it the function's return value; rename the local variable 'states',
  as it doesn't reflect changed states, but currently active ones.

- rename collect_percpu_times() to aggregate_cpus(), to indicate that
  actual data processing happens there

- move calc_avgs() out of the way, closer to where it's being used.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 90 ++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 48 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9d647d974f55..1faf383f6ec4 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -238,17 +238,15 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	}
 }
 
-static void get_recent_times(struct psi_group *group, int cpu,
-			     enum psi_aggregators aggregator, u32 *times,
-			     u32 *pchanged_states)
+static u32 snapshot_cpu_states(struct psi_group *group, int cpu,
+			       enum psi_aggregators aggregator, u32 *times)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
 	u64 now, state_start;
 	enum psi_states s;
 	unsigned int seq;
 	u32 state_mask;
-
-	*pchanged_states = 0;
+	u32 states = 0;
 
 	/* Snapshot a coherent view of the CPU state */
 	do {
@@ -279,37 +277,18 @@ static void get_recent_times(struct psi_group *group, int cpu,
 
 		times[s] = delta;
 		if (delta)
-			*pchanged_states |= (1 << s);
+			states |= (1 << s);
 	}
-}
 
-static void calc_avgs(unsigned long avg[3], int missed_periods,
-		      u64 time, u64 period)
-{
-	unsigned long pct;
-
-	/* Fill in zeroes for periods of no activity */
-	if (missed_periods) {
-		avg[0] = calc_load_n(avg[0], EXP_10s, 0, missed_periods);
-		avg[1] = calc_load_n(avg[1], EXP_60s, 0, missed_periods);
-		avg[2] = calc_load_n(avg[2], EXP_300s, 0, missed_periods);
-	}
-
-	/* Sample the most recent active period */
-	pct = div_u64(time * 100, period);
-	pct *= FIXED_1;
-	avg[0] = calc_load(avg[0], EXP_10s, pct);
-	avg[1] = calc_load(avg[1], EXP_60s, pct);
-	avg[2] = calc_load(avg[2], EXP_300s, pct);
+	return states;
 }
 
-static void collect_percpu_times(struct psi_group *group,
-				 enum psi_aggregators aggregator,
-				 u32 *pchanged_states)
+static u32 aggregate_cpus(struct psi_group *group,
+			  enum psi_aggregators aggregator)
 {
 	u64 deltas[NR_PSI_STATES - 1] = { 0, };
 	unsigned long nonidle_total = 0;
-	u32 changed_states = 0;
+	u32 states = 0;
 	int cpu;
 	int s;
 
@@ -324,11 +303,8 @@ static void collect_percpu_times(struct psi_group *group,
 	for_each_possible_cpu(cpu) {
 		u32 times[NR_PSI_STATES];
 		u32 nonidle;
-		u32 cpu_changed_states;
 
-		get_recent_times(group, cpu, aggregator, times,
-				&cpu_changed_states);
-		changed_states |= cpu_changed_states;
+		states |= snapshot_cpu_states(group, cpu, aggregator, times);
 
 		nonidle = nsecs_to_jiffies(times[PSI_NONIDLE]);
 		nonidle_total += nonidle;
@@ -354,15 +330,34 @@ static void collect_percpu_times(struct psi_group *group,
 		group->total[aggregator][s] +=
 				div_u64(deltas[s], max(nonidle_total, 1UL));
 
-	if (pchanged_states)
-		*pchanged_states = changed_states;
+	return states;
+}
+
+static void calc_avgs(unsigned long avg[3], int missed_periods,
+		      u64 time, u64 period)
+{
+	unsigned long pct;
+
+	/* Fill in zeroes for periods of no activity */
+	if (missed_periods) {
+		avg[0] = calc_load_n(avg[0], EXP_10s, 0, missed_periods);
+		avg[1] = calc_load_n(avg[1], EXP_60s, 0, missed_periods);
+		avg[2] = calc_load_n(avg[2], EXP_300s, 0, missed_periods);
+	}
+
+	/* Sample the most recent active period */
+	pct = div_u64(time * 100, period);
+	pct *= FIXED_1;
+	avg[0] = calc_load(avg[0], EXP_10s, pct);
+	avg[1] = calc_load(avg[1], EXP_60s, pct);
+	avg[2] = calc_load(avg[2], EXP_300s, pct);
 }
 
 static void update_averages(struct psi_group *group)
 {
 	unsigned long missed_periods = 0;
 	u64 now, expires, period;
-	u32 changed_states;
+	u32 states;
 	int s;
 
 	/* avgX= */
@@ -402,7 +397,7 @@ static void update_averages(struct psi_group *group)
 	group->avg_last_update = now;
 	group->avg_next_update = expires + ((1 + missed_periods) * psi_period);
 
-	collect_percpu_times(group, PSI_AVGS, &changed_states);
+	states = aggregate_cpus(group, PSI_AVGS);
 	for (s = 0; s < NR_PSI_STATES - 1; s++) {
 		u32 sample;
 
@@ -430,7 +425,7 @@ static void update_averages(struct psi_group *group)
 		calc_avgs(group->avg[s], missed_periods, sample, period);
 	}
 
-	if (changed_states & (1 << PSI_NONIDLE)) {
+	if (states & (1 << PSI_NONIDLE)) {
 		unsigned long delay;
 
 		delay = nsecs_to_jiffies(group->avg_next_update - now) + 1;
@@ -585,24 +580,24 @@ static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
 
 static void psi_poll_work(struct psi_group *group)
 {
-	u32 changed_states;
+	unsigned long delay;
+	u32 states;
 	u64 now;
 
 	mutex_lock(&group->trigger_lock);
 
 	now = sched_clock();
+	states = aggregate_cpus(group, PSI_POLL);
 
-	collect_percpu_times(group, PSI_POLL, &changed_states);
-
-	if (changed_states & group->poll_states) {
+	if (states & group->poll_states) {
 		/* Initialize trigger windows when entering polling mode */
 		if (now > group->polling_until)
 			init_triggers(group, now);
 
 		/*
-		 * Keep the monitor active for at least the duration of the
-		 * minimum tracking window as long as monitor states are
-		 * changing.
+		 * Keep the monitor active for at least the duration
+		 * of the minimum tracking window after a polled state
+		 * has been observed.
 		 */
 		group->polling_until = now +
 			group->poll_min_period * UPDATES_PER_WINDOW;
@@ -616,9 +611,8 @@ static void psi_poll_work(struct psi_group *group)
 	if (now >= group->polling_next_update)
 		group->polling_next_update = update_triggers(group, now);
 
-	psi_schedule_poll_work(group,
-		nsecs_to_jiffies(group->polling_next_update - now) + 1);
-
+	delay = nsecs_to_jiffies(group->polling_next_update - now) + 1;
+	psi_schedule_poll_work(group, delay);
 out:
 	mutex_unlock(&group->trigger_lock);
 }
-- 
2.32.0

