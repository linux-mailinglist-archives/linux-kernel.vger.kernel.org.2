Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4338E3DB3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhG3GkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:40:09 -0400
Received: from mx20.baidu.com ([111.202.115.85]:40784 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237554AbhG3GkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:40:07 -0400
Received: from BC-Mail-Ex16.internal.baidu.com (unknown [172.31.51.56])
        by Forcepoint Email with ESMTPS id B643DA833D0AE2FA2D9E;
        Fri, 30 Jul 2021 14:40:00 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex16.internal.baidu.com (172.31.51.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 30 Jul 2021 14:40:00 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 30 Jul 2021 14:39:59 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <tj@kernel.org>, <jiangshanlai@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] workqueue: Fix typo in comments
Date:   Fri, 30 Jul 2021 14:39:51 +0800
Message-ID: <20210730063951.2745-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo:
*assing  ==> assign
*iff  ==> if
*alloced  ==> allocated
*Retun  ==> Return
*musn't  ==> mustn't
*excute  ==> execute

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 include/linux/workqueue.h |  2 +-
 kernel/workqueue.c        | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d15a7730ee18..5fcf3d048a5a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -324,7 +324,7 @@ enum {
 	 * to execute and tries to keep idle cores idle to conserve power;
 	 * however, for example, a per-cpu work item scheduled from an
 	 * interrupt handler on an idle CPU will force the scheduler to
-	 * excute the work item on that CPU breaking the idleness, which in
+	 * execute the work item on that CPU breaking the idleness, which in
 	 * turn may lead to more scheduling choices which are sub-optimal
 	 * in terms of power consumption.
 	 *
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f148eacda55a..b9b86f730b82 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -524,7 +524,7 @@ static inline void debug_work_deactivate(struct work_struct *work) { }
 #endif
 
 /**
- * worker_pool_assign_id - allocate ID and assing it to @pool
+ * worker_pool_assign_id - allocate ID and assign it to @pool
  * @pool: the pool pointer of interest
  *
  * Returns 0 if ID in [0, WORK_OFFQ_POOL_NONE) is allocated and assigned
@@ -1293,7 +1293,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		list_del_init(&work->entry);
 		pwq_dec_nr_in_flight(pwq, get_work_color(work));
 
-		/* work->data points to pwq iff queued, point to pool */
+		/* work->data points to pwq if queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
 
 		raw_spin_unlock(&pool->lock);
@@ -1357,7 +1357,7 @@ static bool is_chained_work(struct workqueue_struct *wq)
 
 	worker = current_wq_worker();
 	/*
-	 * Return %true iff I'm a worker executing a work item on @wq.  If
+	 * Return %true if I'm a worker executing a work item on @wq.  If
 	 * I'm @worker, it's safe to dereference it without locking.
 	 */
 	return worker && worker->current_pwq->wq == wq;
@@ -1792,7 +1792,7 @@ static void worker_enter_idle(struct worker *worker)
 	/*
 	 * Sanity check nr_running.  Because unbind_workers() releases
 	 * pool->lock between setting %WORKER_UNBOUND and zapping
-	 * nr_running, the warning may trigger spuriously.  Check iff
+	 * nr_running, the warning may trigger spuriously.  Check if
 	 * unbind is not in progress.
 	 */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
@@ -2540,7 +2540,7 @@ static int rescuer_thread(void *__rescuer)
 			if (pwq->nr_active && need_to_create_worker(pool)) {
 				raw_spin_lock(&wq_mayday_lock);
 				/*
-				 * Queue iff we aren't racing destruction
+				 * Queue if we aren't racing destruction
 				 * and somebody else hasn't queued it already.
 				 */
 				if (wq->rescuer && list_empty(&pwq->mayday_node)) {
@@ -3752,7 +3752,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 		 * Need to kick a worker after thawed or an unbound wq's
 		 * max_active is bumped. In realtime scenarios, always kicking a
 		 * worker will cause interference on the isolated cpu cores, so
-		 * let's kick iff work items were activated.
+		 * let's kick if work items were activated.
 		 */
 		if (kick)
 			wake_up_worker(pwq->pool);
@@ -3763,7 +3763,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 }
 
-/* initialize newly alloced @pwq which is associated with @wq and @pool */
+/* initialize newly allocated @pwq which is associated with @wq and @pool */
 static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 		     struct worker_pool *pool)
 {
@@ -5331,7 +5331,7 @@ static int workqueue_apply_unbound_cpumask(void)
  *  the affinity of all unbound workqueues.  This function check the @cpumask
  *  and apply it to all unbound workqueues and updates all pwqs of them.
  *
- *  Retun:	0	- Success
+ *  Return:	0	- Success
  *  		-EINVAL	- Invalid @cpumask
  *  		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
  */
@@ -5661,7 +5661,7 @@ static void wq_device_release(struct device *dev)
  * alloc_workqueue*() automatically calls this function if WQ_SYSFS is set
  * which is the preferred method.
  *
- * Workqueue user should use this function directly iff it wants to apply
+ * Workqueue user should use this function directly if it wants to apply
  * workqueue_attrs before making the workqueue visible in sysfs; otherwise,
  * apply_workqueue_attrs() may race against userland updating the
  * attributes.
@@ -5921,7 +5921,7 @@ static void __init wq_numa_init(void)
 		node = cpu_to_node(cpu);
 		if (WARN_ON(node == NUMA_NO_NODE)) {
 			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
-			/* happens iff arch is bonkers, let's just proceed */
+			/* happens if arch is bonkers, let's just proceed */
 			return;
 		}
 		cpumask_set_cpu(cpu, tbl[node]);
-- 
2.25.1

