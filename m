Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F644455CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhKDPAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhKDPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:00:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143A7C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:57:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b13so7664827plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+ZCnISwtxsUAsqH9KMGNvXPhNAreIquwqkrQpOb+zc=;
        b=OhgZAejsPZopBWPjEX25LJzSzCfTXiGe++Rd8tWt1kErPWS7SirsjlQLuKvrbWXbG1
         lT494W3ef++NFte7EY7OduZo7sNql5Oe4a17lvOjSQfJ1J0VjyS2AWhJMHmHJ+o9xrgE
         p8mAxtgc0b00DE2+NYOUN/QA7c9f1INDjZ5orjLOa3cD5RShPURHdj8M8pudIKjrdD5O
         oS8UMMnZRvNzMGlFZ2RSwIUZXg3dLljVEQQjXMb1ZwQWg7VdqlmVMykFW52megeny162
         tWg6UtA8MZhC0xgBSGi6/KJJ80X/qJO5T2QMEww9yVspEkUSQwyzSdBhPKtpXTfF6wBf
         3aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+ZCnISwtxsUAsqH9KMGNvXPhNAreIquwqkrQpOb+zc=;
        b=rRgbYkF7ZGmxcIF+08qoLhLt/GLvXT+XinX2w/E79zlZkvu40JUUtonE58xnP9yK+Z
         /i2oZzJLKOVJRGOpWjigm8/3lJv2VP6O6Bs6GJIXGfXElCAboNs4Pdz2MTf/IWZzm6XB
         AuZqlp/5UxjIHgCgp+AxmNg/twBZcfkbVJ7rqJ7bWrH6xlLrVduSRA3vMLNLQQkFeluA
         EpkjTMApIHlunVb5sQyYrAHH6wotxF+4V3aiNl5lvLEbhOBH9aPERcqjLN7wXi+u7Zlf
         TJzpiQ6HVp0eMqy7zCptuNJJqUdSMCtaYy5ziY46/BTzGn6XotK2TROO2+PIgc3KtZe1
         LFRw==
X-Gm-Message-State: AOAM533xVjlj2VpyILvUvvjafGQQuAgcRW6JV/+A9zsuGlrbz5yA51xj
        sDTSqYlqwjPYcXq8YCst4JA=
X-Google-Smtp-Source: ABdhPJw2zBZXMt+2afsxqA8pafBnG6nRflyjM78ATKC38n8rpeTuHNkCwnZIY9hASei9aUXtohArKw==
X-Received: by 2002:a17:902:9b8a:b0:13f:c286:a060 with SMTP id y10-20020a1709029b8a00b0013fc286a060mr45073995plp.66.1636037854652;
        Thu, 04 Nov 2021 07:57:34 -0700 (PDT)
Received: from localhost.localdomain ([140.82.17.67])
        by smtp.gmail.com with ESMTPSA id t8sm4328530pgk.66.2021.11.04.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:57:34 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [RFC PATCH 2/4] sched/fair: Introduce cfs_migration
Date:   Thu,  4 Nov 2021 14:57:11 +0000
Message-Id: <20211104145713.4419-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211104145713.4419-1-laoar.shao@gmail.com>
References: <20211104145713.4419-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new per-cpu kthread named "cfs_migration/N" is introduced to do
cfs specific balance works. It is a FIFO task with priority FIFO-1,
which means it can preempt any cfs tasks but can't preempt other FIFO
tasks. The kthreads as follows,

    PID     COMMAND
    13      [cfs_migration/0]
    20      [cfs_migration/1]
    25      [cfs_migration/2]
    32      [cfs_migration/3]
    38      [cfs_migration/4]
    ...

    $ cat /proc/13/sched
    ...
    policy                                       :                    1
    prio                                         :                   98
    ...

    $ cat /proc/13/status
    ...
    Cpus_allowed:	0001
    Cpus_allowed_list:	0
    ...

All the works need to be done will be queued into a singly linked list,
in which the first queued will be first serviced.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87db481e8a56..56b3fa91828b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -20,6 +20,8 @@
  *  Adaptive scheduling granularity, math enhancements by Peter Zijlstra
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
+#include <linux/smpboot.h>
+#include <linux/stop_machine.h>
 #include "sched.h"
 
 /*
@@ -11915,3 +11917,94 @@ int sched_trace_rq_nr_running(struct rq *rq)
         return rq ? rq->nr_running : -1;
 }
 EXPORT_SYMBOL_GPL(sched_trace_rq_nr_running);
+
+#ifdef CONFIG_SMP
+struct cfs_migrater {
+	struct task_struct *thread;
+	struct list_head works;
+	raw_spinlock_t lock;
+};
+
+DEFINE_PER_CPU(struct cfs_migrater, cfs_migrater);
+
+static int cfs_migration_should_run(unsigned int cpu)
+{
+	struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
+	unsigned long flags;
+	int run;
+
+	raw_spin_lock_irqsave(&migrater->lock, flags);
+	run = !list_empty(&migrater->works);
+	raw_spin_unlock_irqrestore(&migrater->lock, flags);
+
+	return run;
+}
+
+static void cfs_migration_setup(unsigned int cpu)
+{
+	/* cfs_migration should have a higher priority than normal tasks,
+	 * but a lower priority than other FIFO tasks.
+	 */
+	sched_set_fifo_low(current);
+}
+
+static void cfs_migrater_thread(unsigned int cpu)
+{
+	struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
+	struct cpu_stop_work *work;
+
+repeat:
+	work = NULL;
+	raw_spin_lock_irq(&migrater->lock);
+	if (!list_empty(&migrater->works)) {
+		work = list_first_entry(&migrater->works,
+					struct cpu_stop_work, list);
+		list_del_init(&work->list);
+	}
+	raw_spin_unlock_irq(&migrater->lock);
+
+	if (work) {
+		struct cpu_stop_done *done = work->done;
+		cpu_stop_fn_t fn = work->fn;
+		void *arg = work->arg;
+		int ret;
+
+		preempt_count_inc();
+		ret = fn(arg);
+		if (done) {
+			if (ret)
+				done->ret = ret;
+			cpu_stop_signal_done(done);
+		}
+		preempt_count_dec();
+		goto repeat;
+	}
+}
+
+static struct smp_hotplug_thread cfs_migration_threads = {
+	.store			= &cfs_migrater.thread,
+	.setup			= cfs_migration_setup,
+	.thread_fn		= cfs_migrater_thread,
+	.thread_comm		= "cfs_migration/%u",
+	.thread_should_run	= cfs_migration_should_run,
+};
+
+static int __init cfs_migration_init(void)
+{
+	struct cfs_migrater *cm = &per_cpu(cfs_migrater, raw_smp_processor_id());
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
+
+		raw_spin_lock_init(&migrater->lock);
+		INIT_LIST_HEAD(&migrater->works);
+	}
+
+	WARN_ON_ONCE(smpboot_register_percpu_thread(&cfs_migration_threads));
+	kthread_unpark(cm->thread);
+
+	return 0;
+}
+early_initcall(cfs_migration_init)
+#endif
-- 
2.17.1

