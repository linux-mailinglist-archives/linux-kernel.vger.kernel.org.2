Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504BA312B26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 08:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhBHHhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 02:37:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229881AbhBHHhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612769768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4bFBUnmaAnFS+YUr01yc5GSdgKepLaAje8ZfQ7GYuo=;
        b=MipJ6SlS8BZSP4l6X0LRRV/cXqAiIEjnVDEwZEQrfCUMVsMeSIAnCNpj46nsH60QzSziSH
        VO/zlaAVuNEk8AG5b7nBZuN4wiX3PKyuOi9Rh+mZQeD0fE4P5Of6cTQUyWdTdoD5tm5Hz1
        rLXA7Ax9I+j0FJEheETN3eevyTZAYuc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-cKBWyiNONwOgsS44UF4TRA-1; Mon, 08 Feb 2021 02:36:07 -0500
X-MC-Unique: cKBWyiNONwOgsS44UF4TRA-1
Received: by mail-ed1-f71.google.com with SMTP id t9so12697994edd.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 23:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4bFBUnmaAnFS+YUr01yc5GSdgKepLaAje8ZfQ7GYuo=;
        b=prTbRZXDtKb878zpxHAj0VQ9M/4b7gJztIJlTS3URHCC1NN4dPVngXnUbLcw6Fw1AM
         Zm0lagjaci+0raTICCT/dF5vK4AlEDDlnBEDB5lqtg2Gl3/o0eapf1ELw+QfYYiVrkm5
         ZxD1atxy3hxuxjkAeXCDFnuiaQH9bheKB/nqW4ti9ianmZ3nLtczMy7GVrby83wrd+/t
         s9Sk3LhIowaq8dogPUCAO5cm3yJSEzggEuSVORkoS+n1V4RiXqLYZdKJsqjKmagyL4mT
         Jx275CS8j6DxHsrfdbsY4vePNtT/hJOi/f9ZHK3KVTfVWF/myPzZKt15YLxDd1up0SPR
         I6Kw==
X-Gm-Message-State: AOAM533xvuWOM7moJkmuT59gQ1itEviE7T2JvyGdeModDKCH7JaH6WaM
        5UaBPW5I2Bs6qvYfjNGOiIWgR/U82NU8NFygWsjpK4J6lPYCoPALp95y4BNvNRnqTY2hDv3Xqa9
        QLEAwRzibqdh3bS03JI1px1bu
X-Received: by 2002:a05:6402:2707:: with SMTP id y7mr15410751edd.5.1612769765767;
        Sun, 07 Feb 2021 23:36:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzk5Pmf3tHmMTmeAvk3vV/hcPpmXpszwa7PFXlA8gYyCMyYKp5avikXFTDRkTFP1IxRCsacCw==
X-Received: by 2002:a05:6402:2707:: with SMTP id y7mr15410735edd.5.1612769765570;
        Sun, 07 Feb 2021 23:36:05 -0800 (PST)
Received: from localhost.localdomain.com ([151.34.162.6])
        by smtp.gmail.com with ESMTPSA id ec18sm8116317ejb.24.2021.02.07.23.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 23:36:05 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, lgoncalv@redhat.com, williams@redhat.com,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 2/2] sched/features: Distinguish between NORMAL and DEADLINE hrtick
Date:   Mon,  8 Feb 2021 08:35:54 +0100
Message-Id: <20210208073554.14629-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208073554.14629-1-juri.lelli@redhat.com>
References: <20210208073554.14629-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HRTICK feature has traditionally been servicing configurations that
need precise preemptions point for NORMAL tasks. More recently, the
feature has been extended to also service DEADLINE tasks with stringent
runtime enforcement needs (e.g., runtime < 1ms with HZ=1000).

Enabling HRTICK sched feature currently enables the additional timer and
task tick for both classes, which might introduced undesired overhead
for no additional benefit if one needed it only for one of the cases.

Separate HRTICK sched feature in two (and leave the traditional case
name unmodified) so that it can be selectively enabled when needed.

With

$ echo HRTICK > /sys/kernel/debug/sched_features

the NORMAL/fair hrtick gets enabled.

With

$ echo HRTICK_DL > /sys/kernel/debug/sched_features

the DEADLINE hrtick gets enabled.

Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Co-developed-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c |  4 ++--
 kernel/sched/fair.c     |  4 ++--
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    | 26 ++++++++++++++++++++++++--
 5 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2d79a2c30f5..15e2d7c1ac1a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4955,7 +4955,7 @@ static void __sched notrace __schedule(bool preempt)
 
 	schedule_debug(prev, preempt);
 
-	if (sched_feat(HRTICK))
+	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
 
 	local_irq_disable();
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1508d126e88b..7e28777b652c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1832,7 +1832,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (!first)
 		return;
 
-	if (hrtick_enabled(rq))
+	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, p);
 
 	if (rq->curr->sched_class != &dl_sched_class)
@@ -1895,7 +1895,7 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 	 * not being the leftmost task anymore. In that case NEED_RESCHED will
 	 * be set and schedule() will start a new hrtick for the next task.
 	 */
-	if (hrtick_enabled(rq) && queued && p->dl.runtime > 0 &&
+	if (hrtick_enabled_dl(rq) && queued && p->dl.runtime > 0 &&
 	    is_leftmost(p, &rq->dl))
 		start_hrtick_dl(rq, p);
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 59b645e3c4fd..8a8bd7b13634 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5429,7 +5429,7 @@ static void hrtick_update(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 
-	if (!hrtick_enabled(rq) || curr->sched_class != &fair_sched_class)
+	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
 
 	if (cfs_rq_of(&curr->se)->nr_running < sched_nr_latency)
@@ -7116,7 +7116,7 @@ done: __maybe_unused;
 	list_move(&p->se.group_node, &rq->cfs_tasks);
 #endif
 
-	if (hrtick_enabled(rq))
+	if (hrtick_enabled_fair(rq))
 		hrtick_start_fair(rq, p);
 
 	update_misfit_status(p, rq);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index e875eabb6600..1bc2b158fc51 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -38,6 +38,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
 SCHED_FEAT(HRTICK, false)
+SCHED_FEAT(HRTICK_DL, false)
 SCHED_FEAT(DOUBLE_TICK, false)
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e16dff206b3..ed0f347ab2f9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2104,17 +2104,39 @@ extern const_debug unsigned int sysctl_sched_migration_cost;
  */
 static inline int hrtick_enabled(struct rq *rq)
 {
-	if (!sched_feat(HRTICK))
-		return 0;
 	if (!cpu_active(cpu_of(rq)))
 		return 0;
 	return hrtimer_is_hres_active(&rq->hrtick_timer);
 }
 
+static inline int hrtick_enabled_fair(struct rq *rq)
+{
+	if (!sched_feat(HRTICK))
+		return 0;
+	return hrtick_enabled(rq);
+}
+
+static inline int hrtick_enabled_dl(struct rq *rq)
+{
+	if (!sched_feat(HRTICK_DL))
+		return 0;
+	return hrtick_enabled(rq);
+}
+
 void hrtick_start(struct rq *rq, u64 delay);
 
 #else
 
+static inline int hrtick_enabled_fair(struct rq *rq)
+{
+	return 0;
+}
+
+static inline int hrtick_enabled_dl(struct rq *rq)
+{
+	return 0;
+}
+
 static inline int hrtick_enabled(struct rq *rq)
 {
 	return 0;
-- 
2.29.2

