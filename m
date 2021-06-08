Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661A83A03C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhFHTVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbhFHTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:09:53 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BB6C0617A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 12:03:38 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o27so21262817qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imb9TzntNYlcLYZpWKt9HGa1hmkynvSoOuHRDCAcWgQ=;
        b=n9H5gnzqHVa9nx4HHhbkw8Cy/OEDElpOWG2K6MSgOaE46+ILbVjXByqwaaca0ldkW6
         5R9EzHMYD+Wii7FC3jdhRQUMwAj1DDsvnj1mhz0r7jalK8F9JtSmWnbe/4fx/a6x870r
         2fVtWZ/mO90dwE494arU7ppMQOY5Tuf6BQEt4XTZixKvEjo28uweWT5c381W0l0hMkUw
         84bU4fCPT2HbvQVZ2IEA7ofnwqGeZE3KI7toACf6/L8FYzRJZsNVn9y9kC8U4YCAsLCO
         Njt8swUXOc/F+pnStjUHkKm/YXtdnqrKDyNjyvS3W8XcpUsagGTNqc76CYtH43mpkdVX
         nOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imb9TzntNYlcLYZpWKt9HGa1hmkynvSoOuHRDCAcWgQ=;
        b=E4viiQpfzluQbSV8RbRfppqFPOdGHLHXMC9S5EC+aE4pbQRiu+dyezjyG6ooGTFOJj
         7aVVqVLdtwAiqtD6/6w7Mo9g7pMY4JZIgcKL6s/xcnpdD9J32lh3i9K2S/ixfNwTvZZE
         HOxsDCitDnGtO26L91glV2T6nSooQM+RAWBw8b6N34NT10p+jd1s0QrbiKjjhB8bjNuc
         ozWBPB48w9t3R3EcsMv04+i57xJjuVUbu9XV4WgI2cnCWHEAHf0TREfpnNdUr8FEpA+0
         KlCqMLZaWt/4dxrNP8FFX6TjC+QLIDNGtkdlfNMJh45IasOLw3v0roPnS70l1OCJ6zCC
         /teg==
X-Gm-Message-State: AOAM5338FEfC/o7i8hJvh6Af+mkktx9xzsTSvgTignDN3+z8zifnqXU1
        YJ0PTjB59m4U9N2g85EHBABi+w==
X-Google-Smtp-Source: ABdhPJwEKhA7PB19sjrSdAuf8tAfHdUNDs9xn8e4A4X39I51BZu6hMulwJ+1+B9xxMPWUfzdgV7q4A==
X-Received: by 2002:a37:7405:: with SMTP id p5mr22948066qkc.272.1623179017801;
        Tue, 08 Jun 2021 12:03:37 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 104sm11413196qta.90.2021.06.08.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:03:37 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Jared Pochtar <jpochtar@fb.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] psi: fix sampling artifact from pressure file read frequency
Date:   Tue,  8 Jun 2021 15:03:36 -0400
Message-Id: <20210608190336.77380-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, every time a psi pressure file is read, the per-cpu states
are collected and aggregated according to the CPU's non-idle time
weight. This dynamically changes the sampling period, which means read
frequency can introduce variance into the observed results. This is
somewhat unexpected for users and can be confusing, when e.g. two
nested cgroups with the same workload report different pressure levels
just because they have different consumers reading the pressure files.

Consider the following two CPU timelines:

	CPU0: [ STALL ] [ SLEEP ]
	CPU1: [  RUN  ] [  RUN  ]

If we sample and aggregate once for the whole period, we get the
following total stall time for CPU0:

	CPU0 = stall(1) + nonidle(1) / nonidle_total(3) = 0.3

But if we sample twice, the total for the period is higher:

	CPU0 = stall(1) + nonidle(1) / nonidle_total(2) = 0.5
	CPU0 = stall(0) + nonidle(0) / nonidle_total(1) = 0
                                                          ---
                                                          0.5

Neither answer is inherently wrong: if the user asks for pressure
after half the period, we can't know yet that the CPU will go to sleep
right after and its weight would be lower over the combined period.

We could normalize the weight averaging to a fixed window regardless
of how often stall times themselves are sampled. But that would make
reporting less adaptive to sudden changes when the user intentionally
uses poll() with short intervals in order to get a higher resolution.

For now, simply limit sampling of the pressure file contents to the
fixed two-second period already used by the aggregation worker.

psi_show() still needs to force a catch-up run in case the workload
went idle and periodic aggregation shut off. Since that can race with
periodic aggregation, worker and psi_show() need to fully serialize.
And with sampling becoming exclusive, whoever wins the race must also
requeue the worker if necessary. Move the locking, the aggregation
work, and the worker scheduling logic into update_averages(); use that
from the worker and psi_show().

poll() continues to use the proportional weight sampling window.

Reported-by: Jared Pochtar <jpochtar@fb.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 83 ++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3cff41f..9d647d974f55 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -358,17 +358,36 @@ static void collect_percpu_times(struct psi_group *group,
 		*pchanged_states = changed_states;
 }
 
-static u64 update_averages(struct psi_group *group, u64 now)
+static void update_averages(struct psi_group *group)
 {
 	unsigned long missed_periods = 0;
-	u64 expires, period;
-	u64 avg_next_update;
+	u64 now, expires, period;
+	u32 changed_states;
 	int s;
 
 	/* avgX= */
+	mutex_lock(&group->avgs_lock);
+
+	now = sched_clock();
 	expires = group->avg_next_update;
-	if (now - expires >= psi_period)
-		missed_periods = div_u64(now - expires, psi_period);
+
+	/*
+	 * Periodic aggregation.
+	 *
+	 * When tasks in the group are active, we make sure to
+	 * aggregate per-cpu samples and calculate the running
+	 * averages at exactly once per PSI_FREQ period.
+	 *
+	 * When tasks go idle, there is no point in keeping the
+	 * workers running, so we shut them down too. Once restarted,
+	 * we backfill zeroes for the missed periods in calc_avgs().
+	 *
+	 * We can get here from inside the aggregation worker, but
+	 * also from psi_show() as userspace may query pressure files
+	 * of an idle group whose aggregation worker shut down.
+	 */
+	if (now < expires)
+		goto unlock;
 
 	/*
 	 * The periodic clock tick can get delayed for various
@@ -377,10 +396,13 @@ static u64 update_averages(struct psi_group *group, u64 now)
 	 * But the deltas we sample out of the per-cpu buckets above
 	 * are based on the actual time elapsing between clock ticks.
 	 */
-	avg_next_update = expires + ((1 + missed_periods) * psi_period);
+	if (now - expires >= psi_period)
+		missed_periods = div_u64(now - expires, psi_period);
 	period = now - (group->avg_last_update + (missed_periods * psi_period));
 	group->avg_last_update = now;
+	group->avg_next_update = expires + ((1 + missed_periods) * psi_period);
 
+	collect_percpu_times(group, PSI_AVGS, &changed_states);
 	for (s = 0; s < NR_PSI_STATES - 1; s++) {
 		u32 sample;
 
@@ -408,42 +430,25 @@ static u64 update_averages(struct psi_group *group, u64 now)
 		calc_avgs(group->avg[s], missed_periods, sample, period);
 	}
 
-	return avg_next_update;
+	if (changed_states & (1 << PSI_NONIDLE)) {
+		unsigned long delay;
+
+		delay = nsecs_to_jiffies(group->avg_next_update - now) + 1;
+		schedule_delayed_work(&group->avgs_work, delay);
+	}
+unlock:
+	mutex_unlock(&group->avgs_lock);
 }
 
 static void psi_avgs_work(struct work_struct *work)
 {
 	struct delayed_work *dwork;
 	struct psi_group *group;
-	u32 changed_states;
-	bool nonidle;
-	u64 now;
 
 	dwork = to_delayed_work(work);
 	group = container_of(dwork, struct psi_group, avgs_work);
 
-	mutex_lock(&group->avgs_lock);
-
-	now = sched_clock();
-
-	collect_percpu_times(group, PSI_AVGS, &changed_states);
-	nonidle = changed_states & (1 << PSI_NONIDLE);
-	/*
-	 * If there is task activity, periodically fold the per-cpu
-	 * times and feed samples into the running averages. If things
-	 * are idle and there is no data to process, stop the clock.
-	 * Once restarted, we'll catch up the running averages in one
-	 * go - see calc_avgs() and missed_periods.
-	 */
-	if (now >= group->avg_next_update)
-		group->avg_next_update = update_averages(group, now);
-
-	if (nonidle) {
-		schedule_delayed_work(dwork, nsecs_to_jiffies(
-				group->avg_next_update - now) + 1);
-	}
-
-	mutex_unlock(&group->avgs_lock);
+	update_averages(group);
 }
 
 /* Trigger tracking window manipulations */
@@ -1029,18 +1034,16 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 {
 	int full;
-	u64 now;
 
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
-	/* Update averages before reporting them */
-	mutex_lock(&group->avgs_lock);
-	now = sched_clock();
-	collect_percpu_times(group, PSI_AVGS, NULL);
-	if (now >= group->avg_next_update)
-		group->avg_next_update = update_averages(group, now);
-	mutex_unlock(&group->avgs_lock);
+	/*
+	 * Periodic aggregation should do all the sampling for us, but
+	 * if the workload goes idle, the worker goes to sleep before
+	 * old stalls may have averaged out. Backfill any idle zeroes.
+	 */
+	update_averages(group);
 
 	for (full = 0; full < 2; full++) {
 		unsigned long avg[3];
-- 
2.32.0

