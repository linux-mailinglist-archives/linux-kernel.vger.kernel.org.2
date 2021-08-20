Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E873F244B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 03:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbhHTBFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 21:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbhHTBFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 21:05:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A87C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:04:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t101-20020a25aaee0000b0290578c0c455b2so8239869ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5J7B6HTiYWuMaQeaJWDUpm5JlEBz0L5nAuq95gXkkjw=;
        b=PVVTSiQNC6CXTHrwVOS4mBwCJrNeoh8uf7ZrFMgHcNguQXa4QYxvyQrqpa2QRRZdD1
         ma7PEFC/Wi31tJuG/DwyMsRJBcbyUfJvu0mrl6p3A0vA9HR1pme+F6g/Ig2vAegFnUzN
         wV0nL0/OjXBCdtPGynw5BeC7X2Zw028zHu2Hv8bmFZsFsLOZgvgFNp7BuYxJIxhIcT5A
         xPvLCc+1j/xhxmvI5nwKXxr/OOK2VZtY4gAWp5Emy562h0FtWFnCm3My6qmwfHrubft3
         AcUyEMWchO3jWRpV2S7HC/RrbwvZtDHQVWxR2dMuIigP9f5gza4MTgBiYfVjX1kAEjal
         6ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5J7B6HTiYWuMaQeaJWDUpm5JlEBz0L5nAuq95gXkkjw=;
        b=ledL4etGrLWMr/ZocOeFPW4w38DnHvVQIzEts19Mu6WI+/BMduJbSgpP3+GTjd3PvP
         g/6mtnlhwx8mJ1PRc/XtDHQMKi1BGLjlCiDRCAaDiOfxfgPUluCS7OpdpMVRT5dHd0BU
         j/6OfLQ/7rupsly2rSzSzTu7FlPKr/bh4ZlktJEDOIoxAdR62SRzwqHL0q/+7rnG5R2h
         BvBWeyxSYdZshRawbXKOJ/VQqNSYEjqLhebxaqt8xaGCmSwFvHSqF8I7tE8g7OvUsagR
         7Jy+KRRjK49Y/aD7UFV+uA6YPqPssLL3OipcVkLnRz1xKhG1UlcpJFeZpyAftxM4eVC+
         rIeg==
X-Gm-Message-State: AOAM531j14cSyQGbbIZloh14x77lqOTl8tCIxoZzLLXpKopb1Qs9FzPn
        jpiGohJbQkkV9/jjXdoXi8sXPdG0cJu/
X-Google-Smtp-Source: ABdhPJxKRmE19kOoP7OUv/pUHJlhIupzPpT/AeeAvcoKrdvHBeV9jqCEapzA5vHFpZERPjqRC2/v/FRcTXv+
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:23c6:59ba:fc84:7672])
 (user=joshdon job=sendgmr) by 2002:a5b:648:: with SMTP id o8mr22306504ybq.260.1629421467933;
 Thu, 19 Aug 2021 18:04:27 -0700 (PDT)
Date:   Thu, 19 Aug 2021 18:04:01 -0700
In-Reply-To: <20210820010403.946838-1-joshdon@google.com>
Message-Id: <20210820010403.946838-3-joshdon@google.com>
Mime-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 2/4] sched: account number of SCHED_IDLE entities on each cfs_rq
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

Adds cfs_rq->idle_nr_running, which accounts the number of idle entities
directly enqueued on the cfs_rq.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  | 25 ++++++++++++++++++++++++-
 kernel/sched/sched.h |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 49716228efb4..33538579db9a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -608,6 +608,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
+			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
 			cfs_rq->idle_h_nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5aa3cfd15a2e..19a9244c140f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2995,6 +2995,8 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running++;
+	if (se_is_idle(se))
+		cfs_rq->idle_nr_running++;
 }
 
 static void
@@ -3008,6 +3010,8 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running--;
+	if (se_is_idle(se))
+		cfs_rq->idle_nr_running--;
 }
 
 /*
@@ -5573,6 +5577,17 @@ static int sched_idle_rq(struct rq *rq)
 			rq->nr_running);
 }
 
+/*
+ * Returns true if cfs_rq only has SCHED_IDLE entities enqueued. Note the use
+ * of idle_nr_running, which does not consider idle descendants of normal
+ * entities.
+ */
+static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->nr_running &&
+		cfs_rq->nr_running == cfs_rq->idle_nr_running;
+}
+
 #ifdef CONFIG_SMP
 static int sched_idle_cpu(int cpu)
 {
@@ -11556,7 +11571,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		struct sched_entity *se = tg->se[i];
-		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *parent_cfs_rq, *grp_cfs_rq = tg->cfs_rq[i];
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
@@ -11567,6 +11582,14 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 		if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
 			goto next_cpu;
 
+		if (se->on_rq) {
+			parent_cfs_rq = cfs_rq_of(se);
+			if (cfs_rq_is_idle(grp_cfs_rq))
+				parent_cfs_rq->idle_nr_running++;
+			else
+				parent_cfs_rq->idle_nr_running--;
+		}
+
 		idle_task_delta = grp_cfs_rq->h_nr_running -
 				  grp_cfs_rq->idle_h_nr_running;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dfad8fb756c..6af039e433fb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -530,6 +530,7 @@ struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
 	u64			exec_clock;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

