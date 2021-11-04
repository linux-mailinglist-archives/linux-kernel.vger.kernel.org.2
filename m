Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01004455CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhKDPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhKDPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:00:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA5C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:57:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u17so7609374plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nBp+QaQse7J3/jad7Bm3iuNVpwEF6IjbmwPSB9lLhY=;
        b=KbGl/z2lMJbbxwodcTB1GKxcypoUAo6BQMQiXs1QDdWJjB6W+cO1lJ9I8W96uS0E4d
         NHJqiY8DK0EBY3oaDVAiCHoCDxmSsIfjxOX+teD1cdcWTk8L0Oot4erT9mIaXby4HmIn
         dDyNqr3KKAJDF/vzOyMKRVLVAvjNHu2iVLenAvMqz49EWqf36mkzcegIdS2zV5XazRwy
         pyVnvLl8yMvOIwB8a9dP1jgTd+yWja+o0G53lfiKFArAwgyUS72GAw0qbOcaznRlGeYU
         vh1NNg+TTWLkazHHHk0pROFPRBaAPa1IfOeHRB7Jo5BKM1fprIm1jwFO46Jf2TmJETMt
         VQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nBp+QaQse7J3/jad7Bm3iuNVpwEF6IjbmwPSB9lLhY=;
        b=1gK2p7F8wZzI+DXFfAWYkyeD8pQwITiWLealSEGg4VRvsAutTYUqBLLKry0DE7EVBn
         sYPQC0QG5PLkaeJRfkWZhyLp1v5BSKgG7kk0zhPhooAOkV5Se2HgDDCgbRbE9VyhSV5G
         KEgDw5D63qX/lPNNHAWozGNtNAwMnbxj5IiIwjbl2EZzfLrrHFzKhrzIXdYA2e6AM+xg
         ErZifycXr3UoaA2+tvK9QCeyH5csjrX2mwYK2MUekMl/drOTFoIfpy1BLtFWxrDB8+qF
         RKcPJJB0hBO1nns5+uHgGZ1HDiKmupWcxe/2iHeU9oCKkWFV/yRjwSte9geCS2Cvme50
         wG2Q==
X-Gm-Message-State: AOAM532RT++fOx7eLY6fjAmLHZvoq7YQ0mN7tKUjGxVq+94OoQKxKUr5
        XdZBXpQegsAs2+NZB+W6aV8=
X-Google-Smtp-Source: ABdhPJzLS5MGhl1WeR/9AuKSwq9P5lBAJis2lo8ho3tggUGTHDcBW0SDeSr7Cq8TVZ4ZAb2Kf6qBfA==
X-Received: by 2002:a17:902:ab47:b0:141:95b2:7eaf with SMTP id ij7-20020a170902ab4700b0014195b27eafmr43483386plb.40.1636037855547;
        Thu, 04 Nov 2021 07:57:35 -0700 (PDT)
Received: from localhost.localdomain ([140.82.17.67])
        by smtp.gmail.com with ESMTPSA id t8sm4328530pgk.66.2021.11.04.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:57:35 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [RFC PATCH 3/4] sched/fair: Do active load balance in cfs_migration
Date:   Thu,  4 Nov 2021 14:57:12 +0000
Message-Id: <20211104145713.4419-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211104145713.4419-1-laoar.shao@gmail.com>
References: <20211104145713.4419-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The active load balance has a known issue[1][2] that there is a race
window between waking up the migration thread on the busiest CPU and it
begins to preempt the current running CFS task. This race window may cause
unexpected behavior that the current running CFS task may be preempted
by a RT task first, and then the RT task will be preempted by this
waked migration thread. Per our tracing, the latency caused by this
preemption can be greater than 1ms, which is not a small latency for the
RT tasks.

Now as we have introduced cfs_migration, we can assign it to the active
load balance work. Then after we set latency sensitive RT tasks to a higher
priority, it can't be preempted again.

[1]. https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/
[2]. https://lore.kernel.org/lkml/20210615121551.31138-1-laoar.shao@gmail.com/

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 56b3fa91828b..932f63baeb82 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9807,6 +9807,8 @@ static int need_active_balance(struct lb_env *env)
 }
 
 static int active_load_balance_cpu_stop(void *data);
+static void wakeup_cfs_migrater_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
+				       struct cpu_stop_work *work_buf);
 
 static int should_we_balance(struct lb_env *env)
 {
@@ -10049,7 +10051,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			raw_spin_rq_unlock_irqrestore(busiest, flags);
 
 			if (active_balance) {
-				stop_one_cpu_nowait(cpu_of(busiest),
+				wakeup_cfs_migrater_nowait(cpu_of(busiest),
 					active_load_balance_cpu_stop, busiest,
 					&busiest->active_balance_work);
 			}
@@ -10147,7 +10149,7 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
 }
 
 /*
- * active_load_balance_cpu_stop is run by the CPU stopper. It pushes
+ * active_load_balance_cpu_stop is run by the CFS migrater. It pushes
  * running tasks off the busiest CPU onto idle CPUs. It requires at
  * least 1 task to be running on each physical CPU where possible, and
  * avoids physical / logical imbalances.
@@ -11927,6 +11929,37 @@ struct cfs_migrater {
 
 DEFINE_PER_CPU(struct cfs_migrater, cfs_migrater);
 
+static void __cfs_migration_queue_work(struct cfs_migrater *migrater,
+				       struct cpu_stop_work *work,
+				       struct wake_q_head *wakeq)
+{
+	list_add_tail(&work->list, &migrater->works);
+	wake_q_add(wakeq, migrater->thread);
+}
+
+/* queue @work to @migrater.  if offline, @work is completed immediately */
+static void cfs_migration_queue_work(unsigned int cpu, struct cpu_stop_work *work)
+{
+	struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
+	DEFINE_WAKE_Q(wakeq);
+	unsigned long flags;
+
+	preempt_disable();
+	raw_spin_lock_irqsave(&migrater->lock, flags);
+	__cfs_migration_queue_work(migrater, work, &wakeq);
+	raw_spin_unlock_irqrestore(&migrater->lock, flags);
+
+	wake_up_q(&wakeq);
+	preempt_enable();
+}
+
+static void wakeup_cfs_migrater_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
+				       struct cpu_stop_work *work_buf)
+{
+	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, .caller = _RET_IP_, };
+	cfs_migration_queue_work(cpu, work_buf);
+}
+
 static int cfs_migration_should_run(unsigned int cpu)
 {
 	struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
-- 
2.17.1

