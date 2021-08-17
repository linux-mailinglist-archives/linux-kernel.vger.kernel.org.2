Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFF93EEB70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhHQLSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHQLSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:18:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5104C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so5793846pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbFhnOIKT3ysTdikVaLaWvFlr5JSWfn5qlxGMQsVs+k=;
        b=oln2FJDWP6bW0xynP+gWjPL0zscHCD+zRro5d/2dl8EfouH9d/trnZH2r0OXme9tvu
         QaWAQW5wCM6x4O18uevCqnVMSnFg2Gn5OpAhXw6+0bMk1BKZXvBqpITcOtAee3fV+9JX
         +FWv3ln/VjAYQ+8+riY/MrMGCScbHLc82t64udOMAC/sPiHrlfLXHUxUffYHgOcKfKmd
         giEOKgJ7w8FpBRzVxWXAvmIuxwqTbgiMpMxXip4A83W69KP35//97TTl5fA1RHX5V4lI
         AoMaVDTbXS1/eQLlQ2W7uNvP9IA7Ulj2KnxrvIbYTWiMnd/Hpfp6NmNTA3eIixcuuMpw
         C5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbFhnOIKT3ysTdikVaLaWvFlr5JSWfn5qlxGMQsVs+k=;
        b=cI8gD7Xn+AH7TEvnlsdIW1odSvkP2NjYbIk7xedEbfGYuKwsynI/ZmgXl5Pk/Y81rN
         memPwzU1iBmDMeLPz0RuDDic5AEZXEvatiZWDi3j17JDqRoeosNbhOBMeJ4ql9g0DW67
         y6WC3NPXwyMGVS2RloD/pDSNB9oWXOr8d4PuZ8Of3bP1/21cAfZDq/jxVYT/F3DbeO1E
         pt2Xq1HUjkgQVM4OERkxR7r5csBvQ/YrKgOrvZ+3p7ihCRMGg6FukPk/+palOpKb0x2e
         aWylMUrjbzk2+QLLCji69OeVasasRzSmlDilp3BBvZWh+tVgc8efb4T3AeyZO+ApAZPQ
         ZIGw==
X-Gm-Message-State: AOAM533nofJfCYLs2jk3ZKMcu46Tu1EeiZedLhxQop5NvRY3H9LAiV7z
        HKSsr9YUzvY8EMlEeHc4io6XlO+/tnw=
X-Google-Smtp-Source: ABdhPJxizKGgel12qQem6V73j8kwV2P0WO26DBU/eEKKMIVrwIdDMwlDZh3jT8aOZlKlzoLxuhumKA==
X-Received: by 2002:a05:6a00:7cc:b029:3e0:e9f3:5835 with SMTP id n12-20020a056a0007ccb02903e0e9f35835mr3013123pfu.66.1629199081288;
        Tue, 17 Aug 2021 04:18:01 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id r10sm2383456pff.7.2021.08.17.04.18.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 04:18:01 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 1/6] workqueue: Rename "delayed" (delayed by active management) to "inactive"
Date:   Tue, 17 Aug 2021 09:32:34 +0800
Message-Id: <20210817013239.3921-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210817013239.3921-1-jiangshanlai@gmail.com>
References: <CAJhGHyBsn+rqVQzNqRw2RxtpHyrpQpa0kMtU1RcZP7TCbC6dqg@mail.gmail.com>
 <20210817013239.3921-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There are two kinds of "delayed" work items in workqueue subsystem.

One is for timer-delayed work items which are visible to workqueue users.
The other kind is for work items delayed by active management which can
not be directly visible to workqueue users.  We mixed the word "delayed"
for both kinds and caused somewhat ambiguity.

This patch renames the later one (delayed by active management) to
"inactive", because it is used for workqueue active management and
most of its related symbols are named with "active" or "activate".

All "delayed" and "DELAYED" are carefully checked and renamed one by
one to avoid accidentally changing the name of the other kind for
timer-delayed.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/workqueue.h |  4 +--
 kernel/workqueue.c        | 58 +++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d15a7730ee18..38e479bcdbfe 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -29,7 +29,7 @@ void delayed_work_timer_fn(struct timer_list *t);
 
 enum {
 	WORK_STRUCT_PENDING_BIT	= 0,	/* work item is pending execution */
-	WORK_STRUCT_DELAYED_BIT	= 1,	/* work item is delayed */
+	WORK_STRUCT_INACTIVE_BIT= 1,	/* work item is inactive */
 	WORK_STRUCT_PWQ_BIT	= 2,	/* data points to pwq */
 	WORK_STRUCT_LINKED_BIT	= 3,	/* next work is linked to this one */
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
@@ -42,7 +42,7 @@ enum {
 	WORK_STRUCT_COLOR_BITS	= 4,
 
 	WORK_STRUCT_PENDING	= 1 << WORK_STRUCT_PENDING_BIT,
-	WORK_STRUCT_DELAYED	= 1 << WORK_STRUCT_DELAYED_BIT,
+	WORK_STRUCT_INACTIVE	= 1 << WORK_STRUCT_INACTIVE_BIT,
 	WORK_STRUCT_PWQ		= 1 << WORK_STRUCT_PWQ_BIT,
 	WORK_STRUCT_LINKED	= 1 << WORK_STRUCT_LINKED_BIT,
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 50142fc08902..b2712807c403 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -207,7 +207,7 @@ struct pool_workqueue {
 						/* L: nr of in_flight works */
 	int			nr_active;	/* L: nr of active works */
 	int			max_active;	/* L: max active works */
-	struct list_head	delayed_works;	/* L: delayed works */
+	struct list_head	inactive_works;	/* L: inactive works */
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
 
@@ -1136,7 +1136,7 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 	}
 }
 
-static void pwq_activate_delayed_work(struct work_struct *work)
+static void pwq_activate_inactive_work(struct work_struct *work)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
 
@@ -1144,16 +1144,16 @@ static void pwq_activate_delayed_work(struct work_struct *work)
 	if (list_empty(&pwq->pool->worklist))
 		pwq->pool->watchdog_ts = jiffies;
 	move_linked_works(work, &pwq->pool->worklist, NULL);
-	__clear_bit(WORK_STRUCT_DELAYED_BIT, work_data_bits(work));
+	__clear_bit(WORK_STRUCT_INACTIVE_BIT, work_data_bits(work));
 	pwq->nr_active++;
 }
 
-static void pwq_activate_first_delayed(struct pool_workqueue *pwq)
+static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
 {
-	struct work_struct *work = list_first_entry(&pwq->delayed_works,
+	struct work_struct *work = list_first_entry(&pwq->inactive_works,
 						    struct work_struct, entry);
 
-	pwq_activate_delayed_work(work);
+	pwq_activate_inactive_work(work);
 }
 
 /**
@@ -1176,10 +1176,10 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 	pwq->nr_in_flight[color]--;
 
 	pwq->nr_active--;
-	if (!list_empty(&pwq->delayed_works)) {
-		/* one down, submit a delayed one */
+	if (!list_empty(&pwq->inactive_works)) {
+		/* one down, submit an inactive one */
 		if (pwq->nr_active < pwq->max_active)
-			pwq_activate_first_delayed(pwq);
+			pwq_activate_first_inactive(pwq);
 	}
 
 	/* is flush in progress and are we at the flushing tip? */
@@ -1281,14 +1281,14 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		debug_work_deactivate(work);
 
 		/*
-		 * A delayed work item cannot be grabbed directly because
+		 * An inactive work item cannot be grabbed directly because
 		 * it might have linked NO_COLOR work items which, if left
-		 * on the delayed_list, will confuse pwq->nr_active
+		 * on the inactive_works list, will confuse pwq->nr_active
 		 * management later on and cause stall.  Make sure the work
 		 * item is activated before grabbing.
 		 */
-		if (*work_data_bits(work) & WORK_STRUCT_DELAYED)
-			pwq_activate_delayed_work(work);
+		if (*work_data_bits(work) & WORK_STRUCT_INACTIVE)
+			pwq_activate_inactive_work(work);
 
 		list_del_init(&work->entry);
 		pwq_dec_nr_in_flight(pwq, get_work_color(work));
@@ -1490,8 +1490,8 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		if (list_empty(worklist))
 			pwq->pool->watchdog_ts = jiffies;
 	} else {
-		work_flags |= WORK_STRUCT_DELAYED;
-		worklist = &pwq->delayed_works;
+		work_flags |= WORK_STRUCT_INACTIVE;
+		worklist = &pwq->inactive_works;
 	}
 
 	debug_work_activate(work);
@@ -2531,7 +2531,7 @@ static int rescuer_thread(void *__rescuer)
 			/*
 			 * The above execution of rescued work items could
 			 * have created more to rescue through
-			 * pwq_activate_first_delayed() or chained
+			 * pwq_activate_first_inactive() or chained
 			 * queueing.  Let's put @pwq back on mayday list so
 			 * that such back-to-back work items, which may be
 			 * being used to relieve memory pressure, don't
@@ -2957,7 +2957,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		bool drained;
 
 		raw_spin_lock_irq(&pwq->pool->lock);
-		drained = !pwq->nr_active && list_empty(&pwq->delayed_works);
+		drained = !pwq->nr_active && list_empty(&pwq->inactive_works);
 		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
@@ -3707,7 +3707,7 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
  * @pwq: target pool_workqueue
  *
  * If @pwq isn't freezing, set @pwq->max_active to the associated
- * workqueue's saved_max_active and activate delayed work items
+ * workqueue's saved_max_active and activate inactive work items
  * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
  */
 static void pwq_adjust_max_active(struct pool_workqueue *pwq)
@@ -3736,9 +3736,9 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 
 		pwq->max_active = wq->saved_max_active;
 
-		while (!list_empty(&pwq->delayed_works) &&
+		while (!list_empty(&pwq->inactive_works) &&
 		       pwq->nr_active < pwq->max_active) {
-			pwq_activate_first_delayed(pwq);
+			pwq_activate_first_inactive(pwq);
 			kick = true;
 		}
 
@@ -3769,7 +3769,7 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 	pwq->wq = wq;
 	pwq->flush_color = -1;
 	pwq->refcnt = 1;
-	INIT_LIST_HEAD(&pwq->delayed_works);
+	INIT_LIST_HEAD(&pwq->inactive_works);
 	INIT_LIST_HEAD(&pwq->pwqs_node);
 	INIT_LIST_HEAD(&pwq->mayday_node);
 	INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
@@ -4356,7 +4356,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 
 	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
 		return true;
-	if (pwq->nr_active || !list_empty(&pwq->delayed_works))
+	if (pwq->nr_active || !list_empty(&pwq->inactive_works))
 		return true;
 
 	return false;
@@ -4552,7 +4552,7 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 	else
 		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
 
-	ret = !list_empty(&pwq->delayed_works);
+	ret = !list_empty(&pwq->inactive_works);
 	preempt_enable();
 	rcu_read_unlock();
 
@@ -4748,11 +4748,11 @@ static void show_pwq(struct pool_workqueue *pwq)
 		pr_cont("\n");
 	}
 
-	if (!list_empty(&pwq->delayed_works)) {
+	if (!list_empty(&pwq->inactive_works)) {
 		bool comma = false;
 
-		pr_info("    delayed:");
-		list_for_each_entry(work, &pwq->delayed_works, entry) {
+		pr_info("    inactive:");
+		list_for_each_entry(work, &pwq->inactive_works, entry) {
 			pr_cont_work(comma, work);
 			comma = !(*work_data_bits(work) & WORK_STRUCT_LINKED);
 		}
@@ -4782,7 +4782,7 @@ void show_workqueue_state(void)
 		bool idle = true;
 
 		for_each_pwq(pwq, wq) {
-			if (pwq->nr_active || !list_empty(&pwq->delayed_works)) {
+			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
 				idle = false;
 				break;
 			}
@@ -4794,7 +4794,7 @@ void show_workqueue_state(void)
 
 		for_each_pwq(pwq, wq) {
 			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->delayed_works))
+			if (pwq->nr_active || !list_empty(&pwq->inactive_works))
 				show_pwq(pwq);
 			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 			/*
@@ -5177,7 +5177,7 @@ EXPORT_SYMBOL_GPL(work_on_cpu_safe);
  * freeze_workqueues_begin - begin freezing workqueues
  *
  * Start freezing workqueues.  After this function returns, all freezable
- * workqueues will queue new works to their delayed_works list instead of
+ * workqueues will queue new works to their inactive_works list instead of
  * pool->worklist.
  *
  * CONTEXT:
-- 
2.19.1.6.gb485710b

