Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D4134BA2F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 00:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhC0X1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 19:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230512AbhC0X0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 19:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616887589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pDFJi1MrLhQ3cltVkxXj/9Uv+0NC+RlpUx2FjjQ39EU=;
        b=VvMm9d3L4qaQLMkEuBpR7xDRgQI3PzxV5NoBH3bMXwtaWr71SbhMLhjrtkoricpkk/2dw6
        Avfj5xXSnamFN2qjmR42bvLDGJRtY/aEjl78doLz54AgNY+kesQOfSeU5QwplpFXkfcWbx
        T6yjinbLTzMHhcaAxl4cthC15fFzEpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-jl-lSNv2MFKzLGWvBRRxgg-1; Sat, 27 Mar 2021 19:26:24 -0400
X-MC-Unique: jl-lSNv2MFKzLGWvBRRxgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 129351005D57;
        Sat, 27 Mar 2021 23:26:23 +0000 (UTC)
Received: from llong.com (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C71B58821;
        Sat, 27 Mar 2021 23:26:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] sched/debug: Use sched_debug_lock to serialize use of cgroup_path[] only
Date:   Sat, 27 Mar 2021 19:25:29 -0400
Message-Id: <20210327232529.2349-2-longman@redhat.com>
In-Reply-To: <20210327232529.2349-1-longman@redhat.com>
References: <20210327232529.2349-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of sched_debug_lock is to serialize the use of the global
cgroup_path[] buffer in print_cpu(). The rests of the printf calls
don't need serialization from sched_debug_lock. The printing of sched
debug data to console can take quite a while, taking sched_debug_lock
at the print_cpu() level will unnecessarily block the progress of other
print_cpu() users. Fix that by holding sched_debug_lock only when using
cgroup_path[] via task_group_path().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/debug.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c4ae8a0853a1..87168d13714f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -8,8 +8,6 @@
  */
 #include "sched.h"
 
-static DEFINE_SPINLOCK(sched_debug_lock);
-
 /*
  * This allows printing both to /proc/sched_debug and
  * to the console
@@ -470,6 +468,7 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
+static DEFINE_SPINLOCK(sched_debug_lock);
 static char group_path[PATH_MAX];
 
 static char *task_group_path(struct task_group *tg)
@@ -506,7 +505,9 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
 #endif
 #ifdef CONFIG_CGROUP_SCHED
+	spin_lock(&sched_debug_lock);
 	SEQ_printf(m, " %s", task_group_path(task_group(p)));
+	spin_unlock(&sched_debug_lock);
 #endif
 
 	SEQ_printf(m, "\n");
@@ -543,7 +544,9 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "\n");
+	spin_lock(&sched_debug_lock);
 	SEQ_printf(m, "cfs_rq[%d]:%s\n", cpu, task_group_path(cfs_rq->tg));
+	spin_unlock(&sched_debug_lock);
 #else
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
@@ -614,7 +617,9 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 {
 #ifdef CONFIG_RT_GROUP_SCHED
 	SEQ_printf(m, "\n");
+	spin_lock(&sched_debug_lock);
 	SEQ_printf(m, "rt_rq[%d]:%s\n", cpu, task_group_path(rt_rq->tg));
+	spin_unlock(&sched_debug_lock);
 #else
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "rt_rq[%d]:\n", cpu);
@@ -716,13 +721,11 @@ do {									\
 	}
 #undef P
 
-	spin_lock(&sched_debug_lock);
 	print_cfs_stats(m, cpu);
 	print_rt_stats(m, cpu);
 	print_dl_stats(m, cpu);
 
 	print_rq(m, rq, cpu);
-	spin_unlock(&sched_debug_lock);
 	SEQ_printf(m, "\n");
 }
 
-- 
2.18.1

