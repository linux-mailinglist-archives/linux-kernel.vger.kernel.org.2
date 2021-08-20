Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28B83F244C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 03:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbhHTBFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 21:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbhHTBFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 21:05:09 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21C6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:04:32 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v21-20020a05620a0a9500b003d5c1e2f277so4523117qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KCMDAepgZ2nfyYw0ve3M2mzdc0NmPLZMESPuP6MhAfc=;
        b=pvEbEcnzEqtKv1Z7MU/deaJm9cgrp0E9Y9sR0kW4maWLZ/AGnOWzc2fQgILleWfk0w
         MWbb9tHd+5nXetpYidnAk4SyMWs8wVpKq2d7jRENQcZBu/KgvDfZfhBng0ZyAiixIkyu
         fwPoqC6sCzIH13fATqJ3VqJgkTls+QH8Z6MemfYHvfFcqH9uHxMJOXZaJsPMWsgKTSMe
         9XcN1ToPmjz8l6slQj5mMb+68hNK90nApAfMrGIYcEP3HdwWsVX7tYcW2DC0Fx9OgyLD
         8Nqbh8vs5v+ilfFpROa6ANW0xm2AlJpxP0WmxtgrhvSqLlydMRol5MaDt8DvRb0qdZxC
         DzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KCMDAepgZ2nfyYw0ve3M2mzdc0NmPLZMESPuP6MhAfc=;
        b=RcniMOtH1YRed5hpkqev0SdaW5nbyoi2QFeR55dZooTHPu4wtgE13S0y0sKXdJhlti
         pzRrccT67IS/vbQIf60YII0Mw6l/B+fhrp/OsgeStDbUIIX2kQme9dFwN6uj3kliIpkQ
         0pNbRqpLfuBluuv7He9WqUFcqYGvf2zUBrQDFNz+clYQafOxE6CqQj433aXhDumfWm9G
         t+g5euQDcreQtLoULKqG+/sqNFW/ziNiCpRYSncFHq2EiIGccQCSvJHP5livfRNTLhW0
         VWt/rAucY3ta3vSmLRkv/42W9Selw4peQUOySYiYrdrGWdpiO1xpkSSpSacw/Q9GEjQ9
         7D/w==
X-Gm-Message-State: AOAM530RLM5l8uBJUoMy/Szw+pyxtIcyDLZvE/+D6czijHDzHC81JL95
        yXtrG39/BzHePmtAmo1kRlsMkdD97AYT
X-Google-Smtp-Source: ABdhPJzM5lWFkcVBWjg9s18AfqqtuGWcfN8Sl7/fieOFJhO2uBLa1brUgWvl6JP+FKkNC5pUF+YahfaX9kmX
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:23c6:59ba:fc84:7672])
 (user=joshdon job=sendgmr) by 2002:a05:6214:124:: with SMTP id
 w4mr17417931qvs.35.1629421472010; Thu, 19 Aug 2021 18:04:32 -0700 (PDT)
Date:   Thu, 19 Aug 2021 18:04:02 -0700
In-Reply-To: <20210820010403.946838-1-joshdon@google.com>
Message-Id: <20210820010403.946838-4-joshdon@google.com>
Mime-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 3/4] sched: reduce sched slice for SCHED_IDLE entities
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a small, non-scaled min granularity for SCHED_IDLE entities, when
competing with normal entities. This reduces the latency of getting
a normal entity back on cpu, at the expense of increased context
switch frequency of SCHED_IDLE entities.

The benefit of this change is to reduce the round-robin latency for
normal entities when competing with a SCHED_IDLE entity.

Example: on a machine with HZ=1000, spawned two threads, one of which is
SCHED_IDLE, and affined to one cpu. Without this patch, the SCHED_IDLE
thread runs for 4ms then waits for 1.4s. With this patch, it runs for
1ms and waits 340ms (as it round-robins with the other thread).

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  | 29 ++++++++++++++++++++++++-----
 kernel/sched/sched.h |  1 +
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 33538579db9a..317ef560aa63 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -305,6 +305,7 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency);
 	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
+	debugfs_create_u32("idle_min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_idle_min_granularity);
 	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
 
 	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
@@ -806,6 +807,7 @@ static void sched_debug_header(struct seq_file *m)
 	SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
 	PN(sysctl_sched_latency);
 	PN(sysctl_sched_min_granularity);
+	PN(sysctl_sched_idle_min_granularity);
 	PN(sysctl_sched_wakeup_granularity);
 	P(sysctl_sched_child_runs_first);
 	P(sysctl_sched_features);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19a9244c140f..31f40aa005b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -59,6 +59,14 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
 unsigned int sysctl_sched_min_granularity			= 750000ULL;
 static unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
 
+/*
+ * Minimal preemption granularity for CPU-bound SCHED_IDLE tasks.
+ * Applies only when SCHED_IDLE tasks compete with normal tasks.
+ *
+ * (default: 0.75 msec)
+ */
+unsigned int sysctl_sched_idle_min_granularity			= 750000ULL;
+
 /*
  * This value is kept at sysctl_sched_latency/sysctl_sched_min_granularity
  */
@@ -665,6 +673,8 @@ static u64 __sched_period(unsigned long nr_running)
 		return sysctl_sched_latency;
 }
 
+static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
+
 /*
  * We calculate the wall-time slice from the period by taking a part
  * proportional to the weight.
@@ -674,6 +684,8 @@ static u64 __sched_period(unsigned long nr_running)
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	unsigned int nr_running = cfs_rq->nr_running;
+	struct sched_entity *init_se = se;
+	unsigned int min_gran;
 	u64 slice;
 
 	if (sched_feat(ALT_PERIOD))
@@ -684,12 +696,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct load_weight *load;
 		struct load_weight lw;
+		struct cfs_rq *qcfs_rq;
 
-		cfs_rq = cfs_rq_of(se);
-		load = &cfs_rq->load;
+		qcfs_rq = cfs_rq_of(se);
+		load = &qcfs_rq->load;
 
 		if (unlikely(!se->on_rq)) {
-			lw = cfs_rq->load;
+			lw = qcfs_rq->load;
 
 			update_load_add(&lw, se->load.weight);
 			load = &lw;
@@ -697,8 +710,14 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		slice = __calc_delta(slice, se->load.weight, load);
 	}
 
-	if (sched_feat(BASE_SLICE))
-		slice = max(slice, (u64)sysctl_sched_min_granularity);
+	if (sched_feat(BASE_SLICE)) {
+		if (se_is_idle(init_se) && !sched_idle_cfs_rq(cfs_rq))
+			min_gran = sysctl_sched_idle_min_granularity;
+		else
+			min_gran = sysctl_sched_min_granularity;
+
+		slice = max_t(u64, slice, min_gran);
+	}
 
 	return slice;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6af039e433fb..29846da35861 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2399,6 +2399,7 @@ extern const_debug unsigned int sysctl_sched_migration_cost;
 #ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
+extern unsigned int sysctl_sched_idle_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern int sysctl_resched_latency_warn_ms;
 extern int sysctl_resched_latency_warn_once;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

