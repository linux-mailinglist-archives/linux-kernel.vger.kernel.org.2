Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5A3EA0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhHLIiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhHLIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:38:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD297C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:38:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa17so8232615pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPXi/L03G+xhLyJENzKQFacy6ilJRAzk6F8DuWKL3Rc=;
        b=dTW9TE8/GMIJNjFxQgsDbea5evMGYyw/y5FRhuWI71AGpmDEgmbgIyyruvYVvIdprc
         QMJJ53m+CT84qAyKlojAympQPSZGL2SsyT31JmDWLHJ5118pq8ppv+z5JGWWuod4JLWi
         e5gRKGilmbj2qE4a56TLbNjFHBtGQhfwKqtSQXposyBBY9OgMhQ4PkZJKhdTeqEtZEiu
         TtSfhutZ3ZuK1oKCy4a3N/Xo5VxYoPAvZC5xTkbXAgeNeGaW1pnDfCVHPU9nGj0WPvVY
         5jyioP4KWOomOacVrMBqFO9BRu7VcHgQUP3Tvda1V96cwIivhkKJjHNbot7hsDxDHuXq
         RYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPXi/L03G+xhLyJENzKQFacy6ilJRAzk6F8DuWKL3Rc=;
        b=drf2RA5d6hstBai0HROgLOUdPDGMo3w3Y2//5ymD6QY6ia3Z54POgQlGZity3tBNm0
         6WTOz2BwSOUXfTwG4+uMf9/T/u3NafGMwGOMKl7Fo3XOHK5gR2lwGOFYKwHz/hF8sjZ4
         FR2ajZjeS/70cgYDMIOmT6djJPVQO6K1LBXBtH4ckn7CY196xIy4mz3baWZOdKHYgR26
         BExVySrl85cQJHSNhjiHRxpgT5qsxnwpe4ggDM3GjLLJQGMVGAefmkNTSom3mDFPWVOS
         N1rqKokuSELz/3+YsUkOgdcMbzz6/1AayaByCG8q5yWf4dQrS3dvQmRl/tuv+k9OEETl
         zyXw==
X-Gm-Message-State: AOAM533D3VksN5vLON/U20VayfycPmC93ttddnaoDyNI8hInOrEh2nVr
        XDvoFcw9XzLsqtha2WStuLiVaw==
X-Google-Smtp-Source: ABdhPJxpN3/K48BGuTcBeiMQ9C+UQbXv2eTOWVejsk8CA6hUEPuhHa5qoDmeLs34XCW0/VlBIerQSw==
X-Received: by 2002:a05:6a00:ccb:b029:3c6:803d:8e3 with SMTP id b11-20020a056a000ccbb02903c6803d08e3mr3185344pfv.0.1628757502466;
        Thu, 12 Aug 2021 01:38:22 -0700 (PDT)
Received: from MacBook-Pro.local.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d134sm2382656pfd.60.2021.08.12.01.38.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Aug 2021 01:38:22 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        Li Zhe <lizhe.67@bytedance.com>
Subject: [PATCH] workqueue: fix memory leak of struct pool_workqueue in destroy_workqueue()
Date:   Thu, 12 Aug 2021 16:38:14 +0800
Message-Id: <20210812083814.32453-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhe <lizhe.67@bytedance.com>

Even after def98c84b6cd, we may encount sanity check failures in
destroy_workqueue() although we call flush_work() before, which
result in memory leak of struct pool_workqueue.

The warning logs are listed below.

WARNING: CPU: 0 PID: 19336 at kernel/workqueue.c:4430 destroy_workqueue+0x11a/0x2f0
*****
destroy_workqueue: test_workqueue9 has the following busy pwq
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/1 refcnt=2
      in-flight: 5658:wq_barrier_func
Showing busy workqueues and worker pools:
*****

The possible stack which result in the failure is listed below.

thread A:
destroy_workqueue()
----raw_spin_lock_irq(&pwq->pool->lock)
----pwq_busy()

thread B:
----process_one_work()
----raw_spin_unlock_irq(&pool->lock)
----worker->current_func(work)
----cond_resched()
----raw_spin_lock_irq(&pool->lock)
----pwq_dec_nr_in_flight(pwq, work_color)

Thread A may get pool->lock before thread B, with the pwq->refcnt
is still 2, which result in memory leak and sanity check failures.

Notice that wq_barrier_func() only calls complete(), and it is not
suitable to expand struct work_struct considering of the memory cost,
this patch put complete() after obtaining pool->lock in function
process_one_work() to eliminate competition by identify the work as a
barrier with the work->func equal to NULL.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 kernel/workqueue.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f148eacda55a..02f77f35522c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -280,6 +280,12 @@ struct workqueue_struct {
 	struct pool_workqueue __rcu *numa_pwq_tbl[]; /* PWR: unbound pwqs indexed by node */
 };
 
+struct wq_barrier {
+	struct work_struct	work;
+	struct completion	done;
+	struct task_struct	*task;	/* purely informational */
+};
+
 static struct kmem_cache *pwq_cache;
 
 static cpumask_var_t *wq_numa_possible_cpumask;
@@ -2152,6 +2158,11 @@ static bool manage_workers(struct worker *worker)
 	return true;
 }
 
+static inline bool is_barrier_func(work_func_t func)
+{
+	return func == NULL;
+}
+
 /**
  * process_one_work - process single work
  * @worker: self
@@ -2273,7 +2284,8 @@ __acquires(&pool->lock)
 	 */
 	lockdep_invariant_state(true);
 	trace_workqueue_execute_start(work);
-	worker->current_func(work);
+	if (likely(!is_barrier_func(worker->current_func)))
+		worker->current_func(work);
 	/*
 	 * While we must be careful to not use "work" after this, the trace
 	 * point will only record its address.
@@ -2303,6 +2315,11 @@ __acquires(&pool->lock)
 
 	raw_spin_lock_irq(&pool->lock);
 
+	if (unlikely(is_barrier_func(worker->current_func))) {
+		struct wq_barrier *barr = container_of(work, struct wq_barrier, work);
+		complete(&barr->done);
+	}
+
 	/* clear cpu intensive status */
 	if (unlikely(cpu_intensive))
 		worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
@@ -2618,18 +2635,6 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
 		  target_wq->name, target_func);
 }
 
-struct wq_barrier {
-	struct work_struct	work;
-	struct completion	done;
-	struct task_struct	*task;	/* purely informational */
-};
-
-static void wq_barrier_func(struct work_struct *work)
-{
-	struct wq_barrier *barr = container_of(work, struct wq_barrier, work);
-	complete(&barr->done);
-}
-
 /**
  * insert_wq_barrier - insert a barrier work
  * @pwq: pwq to insert barrier into
@@ -2667,7 +2672,11 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 	 * checks and call back into the fixup functions where we
 	 * might deadlock.
 	 */
-	INIT_WORK_ONSTACK(&barr->work, wq_barrier_func);
+	/* no need to init func because complete() has been moved to
+	 * proccess_one_work(), which means that we use NULL to identify
+	 * if this work is a barrier
+	 */
+	INIT_WORK_ONSTACK(&barr->work, NULL);
 	__set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&barr->work));
 
 	init_completion_map(&barr->done, &target->lockdep_map);
@@ -4682,7 +4691,7 @@ static void pr_cont_pool_info(struct worker_pool *pool)
 
 static void pr_cont_work(bool comma, struct work_struct *work)
 {
-	if (work->func == wq_barrier_func) {
+	if (is_barrier_func(work->func)) {
 		struct wq_barrier *barr;
 
 		barr = container_of(work, struct wq_barrier, work);
-- 
2.11.0

