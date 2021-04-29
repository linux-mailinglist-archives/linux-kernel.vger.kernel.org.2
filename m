Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E81336EA47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhD2MZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2MZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:25:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CCCC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:25:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n25so6208799edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bMCzCayKo+oaxS+XKUCVY6zmoeQfjen+136GbrzH+Q=;
        b=XV8XHaOTp/ZVSiCUzMZ1hob5SJbdOrU66EPiKA9iq8qHNTfxXLxDWEWNrPegF3IQ4D
         dqcUJTs3DAuVg5afJHOOLVvcf0AUGMNS2Sf1dpKiurxu8t0WV1H1z8yQSdoVei8InIiz
         oAhnlhOZ1LhT17SL+eOqNGbRNFHOH3rF02SOHNE07+BvxChyJR9ScE5P/hgJYZ291bVe
         E2U1Rpf+bGueb09cds+vVMSeJxv3jMq1S8aa9ZEp+HUxoT+1e9Fz4BwD1fAXSZDczWWK
         W/kAp691OnMMAbnOC4y47HQERxWcEzGzDd3CkMbQoKlcFRes2uzF3oXj60P93m1Y/GyG
         lgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bMCzCayKo+oaxS+XKUCVY6zmoeQfjen+136GbrzH+Q=;
        b=kuQrufdMVUmN8v3l1WNXWnM+dVgzXr7XuHc+74Co595b49YRibQxRVq9ayhE98idVk
         QSlhEZC2J3jWLqQjGIr/WZRrLTELBnjGljT78RUfvB/nUPVhQ1YqYdAojkNxUrxllUwy
         WFALQw4Z+0O8sfae6J2yTHYvWD/YnLPTMmLwweFU18j52nzVwQSpcmA5NvBCNbKj6lQO
         UzLzHTG/LehCbs5HrLiJQtPsL7xKvxzAPW2XrYdHlKDQ0N1jym7uk0koq+Gnf5cvRMLh
         8h4v9FRfQTsN7mqkE9esh7N4JlGk3nRidHPI5RpdeWbkyErTBFHQJEBMkG1eGpZa5bsP
         WQpg==
X-Gm-Message-State: AOAM5317wDPOl2HTRFuajME5lZPBtRRDLukBOWj7UHU5ZiR+//eArH4N
        Gg8q0WRc4ttIp0/i3Oa2jf8=
X-Google-Smtp-Source: ABdhPJzdXVfvxPL3Lde7rq6WV3I1HBqUqCA44TRm1xwMmW7kgZalsB5E1XetS9bv6sGrLErBE/Ynjg==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr17941106edu.350.1619699100876;
        Thu, 29 Apr 2021 05:25:00 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id aj8sm1720324ejc.64.2021.04.29.05.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 05:25:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        outreachy-kernel@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] sched: Replace 'unsigned' with 'unsigned int'
Date:   Thu, 29 Apr 2021 14:24:54 +0200
Message-Id: <20210429122454.9936-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced 'unsigned' with 'unsigned int' because the second is preferred.
Detected by checkpatch.pl.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 kernel/sched/core.c     |  4 ++--
 kernel/sched/fair.c     |  6 +++---
 kernel/sched/sched.h    |  6 +++---
 kernel/sched/wait.c     |  8 ++++----
 kernel/sched/wait_bit.c | 12 ++++++------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a9983da4408..383e47a2f0df 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4342,7 +4342,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 	exception_exit(prev_state);
 }
 
-int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
+int default_wake_function(wait_queue_entry_t *curr, unsigned int mode, int wake_flags,
 			  void *key)
 {
 	return try_to_wake_up(curr->private, mode, wake_flags);
@@ -5479,7 +5479,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	return retval;
 }
 
-static int get_user_cpu_mask(unsigned long __user *user_mask_ptr, unsigned len,
+static int get_user_cpu_mask(unsigned long __user *user_mask_ptr, unsigned int len,
 			     struct cpumask *new_mask)
 {
 	if (len < cpumask_size())
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c1217bfe5e81..203e2ff5b935 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5945,15 +5945,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return target;
 
 	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
+	if ((unsigned int)i < nr_cpumask_bits)
 		return i;
 
 	i = select_idle_cpu(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
+	if ((unsigned int)i < nr_cpumask_bits)
 		return i;
 
 	i = select_idle_smt(p, target);
-	if ((unsigned)i < nr_cpumask_bits)
+	if ((unsigned int)i < nr_cpumask_bits)
 		return i;
 
 	return target;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9ea647835fd6..395e109bbadb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1910,9 +1910,9 @@ static inline int sched_tick_offload_init(void) { return 0; }
 static inline void sched_update_tick_dependency(struct rq *rq) { }
 #endif
 
-static inline void add_nr_running(struct rq *rq, unsigned count)
+static inline void add_nr_running(struct rq *rq, unsigned int count)
 {
-	unsigned prev_nr = rq->nr_running;
+	unsigned int prev_nr = rq->nr_running;
 
 	rq->nr_running = prev_nr + count;
 
@@ -1926,7 +1926,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	sched_update_tick_dependency(rq);
 }
 
-static inline void sub_nr_running(struct rq *rq, unsigned count)
+static inline void sub_nr_running(struct rq *rq, unsigned int count)
 {
 	rq->nr_running -= count;
 	/* Check if we still need preemption */
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index ba059fbfc53a..b44b9a519d60 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -84,7 +84,7 @@ static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 		return nr_exclusive;
 
 	list_for_each_entry_safe_from(curr, next, &wq_head->head, entry) {
-		unsigned flags = curr->flags;
+		unsigned int flags = curr->flags;
 		int ret;
 
 		if (flags & WQ_FLAG_BOOKMARK)
@@ -384,7 +384,7 @@ void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_en
 }
 EXPORT_SYMBOL(finish_wait);
 
-int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key)
+int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode, int sync, void *key)
 {
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
@@ -420,7 +420,7 @@ static inline bool is_kthread_should_stop(void)
  * }						smp_mb(); // C
  * remove_wait_queue(&wq_head, &wait);		wq_entry->flags |= WQ_FLAG_WOKEN;
  */
-long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
+long wait_woken(struct wait_queue_entry *wq_entry, unsigned int mode, long timeout)
 {
 	/*
 	 * The below executes an smp_mb(), which matches with the full barrier
@@ -445,7 +445,7 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
 }
 EXPORT_SYMBOL(wait_woken);
 
-int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key)
+int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode, int sync, void *key)
 {
 	/* Pairs with the smp_store_mb() in wait_woken(). */
 	smp_mb(); /* C */
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 02ce292b9bc0..80c5d07ac77d 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -18,7 +18,7 @@ wait_queue_head_t *bit_waitqueue(void *word, int bit)
 }
 EXPORT_SYMBOL(bit_waitqueue);
 
-int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *arg)
+int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned int mode, int sync, void *arg)
 {
 	struct wait_bit_key *key = arg;
 	struct wait_bit_queue_entry *wait_bit = container_of(wq_entry, struct wait_bit_queue_entry, wq_entry);
@@ -39,7 +39,7 @@ EXPORT_SYMBOL(wake_bit_function);
  */
 int __sched
 __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry,
-	      wait_bit_action_f *action, unsigned mode)
+	      wait_bit_action_f *action, unsigned int mode)
 {
 	int ret = 0;
 
@@ -56,7 +56,7 @@ __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_
 EXPORT_SYMBOL(__wait_on_bit);
 
 int __sched out_of_line_wait_on_bit(void *word, int bit,
-				    wait_bit_action_f *action, unsigned mode)
+				    wait_bit_action_f *action, unsigned int mode)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wq_entry, word, bit);
@@ -67,7 +67,7 @@ EXPORT_SYMBOL(out_of_line_wait_on_bit);
 
 int __sched out_of_line_wait_on_bit_timeout(
 	void *word, int bit, wait_bit_action_f *action,
-	unsigned mode, unsigned long timeout)
+	unsigned int mode, unsigned long timeout)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wq_entry, word, bit);
@@ -80,7 +80,7 @@ EXPORT_SYMBOL_GPL(out_of_line_wait_on_bit_timeout);
 
 int __sched
 __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry,
-			wait_bit_action_f *action, unsigned mode)
+			wait_bit_action_f *action, unsigned int mode)
 {
 	int ret = 0;
 
@@ -109,7 +109,7 @@ __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry
 EXPORT_SYMBOL(__wait_on_bit_lock);
 
 int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
-					 wait_bit_action_f *action, unsigned mode)
+					 wait_bit_action_f *action, unsigned int mode)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
 	DEFINE_WAIT_BIT(wq_entry, word, bit);
-- 
2.31.1

