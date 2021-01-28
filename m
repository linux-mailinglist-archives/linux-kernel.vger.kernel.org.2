Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A991306DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 07:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhA1G4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 01:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhA1G4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 01:56:22 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD73C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 22:55:42 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so3417017qtv.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 22:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AnpZ7vIs85fcyF4eehrhRT2kiStXyZGgUORh+HQhf8=;
        b=T+QHBG4x+zOSFWT5cwRbG/xgWXKOH/WN6O2t4zmVt22fY9m5Cj1xYGyisOCPQif6IL
         fGZjg7jd3wz0xOojolbSBn5ezGZnL1LluEt2juXFsGqzlubGyxkWU7TtUmPzSdrZk9ea
         JdbREfidGjUTrcOXgJoLxig4kpI86U7tKSKL/pdeyjknlPQywkr48dF45iXX9vyy8RDv
         CRDTN2RQGAexMfb4EmjcfM4yZyeCrgwG5QzgkgWnTvaYVJ+b9xlw3q5+CzyWRQ+U9s7p
         6f5WYBk4z6qWnmdRydAfZxQKzI9iA6u29dKHEc+hy7hl63WTubT77CCk/3umvuzuHxLM
         y2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AnpZ7vIs85fcyF4eehrhRT2kiStXyZGgUORh+HQhf8=;
        b=k4stescs9C9eCFgU4oOdv2gQpRtHEBGQrHidI7/P6ui/OjzYd/icInefa8eUbVNM92
         nM9/CzXNzF3ik06lFT7lp+x0lOz0L9FKeVw+ejKof+5ys9kiocKhV1w6bKp2o1NXawLp
         SvBmLwKrMwjCsivjMUjP0ysYE1cik4fYJ9ZeUQbx+SF5W3Rb5PqcY3M75dT5xqhosFSK
         4KrOXqxCQeImDVY3mSsGX05Ad9E0o1jDrp/r+n7QxV2wlZXn+IneGGaRNaXVZ6XdLSOH
         T+el47d6yjcYraOAShjIjtPk1lX6AV5/RssJRRVYBgEwDMhqVLeI054PMD9JbXFjp4ve
         2upg==
X-Gm-Message-State: AOAM5333wwMMRAmMPjYOCVWKpm2B3SBWH/131ZVvvmYXLV98wFLkH6WG
        4emq39JZ2VQrysfBto2RPwQ=
X-Google-Smtp-Source: ABdhPJwONar8/yv1zUMvZiRGZRWGi+6L1AWdGuwbfA8X7o0a/RPIgARIV6pQTm+rKwaDNTjIb0EKTQ==
X-Received: by 2002:ac8:5cc2:: with SMTP id s2mr13318970qta.342.1611816941793;
        Wed, 27 Jan 2021 22:55:41 -0800 (PST)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com (177-131-92-6.dynamic.desktop.com.br. [177.131.92.6])
        by smtp.gmail.com with ESMTPSA id o56sm3040772qtb.0.2021.01.27.22.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 22:55:41 -0800 (PST)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Leonardo Bras <leobras.c@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] kernel/smp: Split call_single_queue into 3 queues
Date:   Thu, 28 Jan 2021 03:55:06 -0300
Message-Id: <20210128065506.618426-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, during flush_smp_call_function_queue():
- All items are transversed once, for inverting.
- The SYNC items are transversed twice.
- The ASYNC & IRQ_WORK items are transversed tree times.
- The TTWU items are transversed four times;.

Also, a lot of extra work is done to keep track and remove the items
already processed in each step.

By using three queues, it's possible to avoid all this work, and
all items in list are transversed only twice: once for inverting,
and once for processing..

In exchange, this requires 2 extra llist_del_all() in the beginning
of flush_smp_call_function_queue(), and some extra logic to decide
the correct queue to add the desired csd.

This is not supposed to cause any change in the order the items are
processed, but will change the order of printing (cpu offlining)
to the order the items will be proceessed.

(The above transversed count ignores the cpu-offlining case, in
which all items would be transversed again, in both cases.)

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 kernel/smp.c | 173 ++++++++++++++++++++++++++-------------------------
 1 file changed, 87 insertions(+), 86 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 1b6070bf97bb..67fb415873f9 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -37,7 +37,13 @@ struct call_function_data {
 
 static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
+struct call_multi_queue {
+	struct llist_head sync;
+	struct llist_head async_n_irq_work;
+	struct llist_head ttwu;
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct call_multi_queue, call_mq);
 
 static void flush_smp_call_function_queue(bool warn_cpu_offline);
 
@@ -93,8 +99,13 @@ void __init call_function_init(void)
 {
 	int i;
 
-	for_each_possible_cpu(i)
-		init_llist_head(&per_cpu(call_single_queue, i));
+	for_each_possible_cpu(i) {
+		struct call_multi_queue *cmq = &per_cpu(call_mq, i);
+
+		init_llist_head(&cmq->sync);
+		init_llist_head(&cmq->async_n_irq_work);
+		init_llist_head(&cmq->ttwu);
+	}
 
 	smpcfd_prepare_cpu(smp_processor_id());
 }
@@ -253,6 +264,31 @@ static __always_inline void csd_unlock(call_single_data_t *csd)
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
+static __always_inline bool smp_add_to_queue(int cpu, struct llist_node *node)
+{
+	struct llist_head *head;
+	call_single_data_t *csd = llist_entry(node, call_single_data_t, node.llist);
+	struct call_multi_queue *cmq = &per_cpu(call_mq, cpu);
+
+	switch (CSD_TYPE(csd)) {
+	case CSD_TYPE_SYNC:
+		head = &cmq->sync;
+		break;
+	case CSD_TYPE_ASYNC:
+	case CSD_TYPE_IRQ_WORK:
+		head = &cmq->async_n_irq_work;
+		break;
+	case CSD_TYPE_TTWU:
+		head = &cmq->ttwu;
+		break;
+	default:
+		pr_warn("IPI callback, unknown type %d blocked from %d\n", cpu, CSD_TYPE(csd));
+		return false;
+	}
+
+	return llist_add(node, head);
+}
+
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
 	/*
@@ -266,7 +302,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 	 * locking and barrier primitives. Generic code isn't really
 	 * equipped to do the right thing...
 	 */
-	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
+	if (smp_add_to_queue(cpu, node))
 		send_call_function_single_ipi(cpu);
 }
 
@@ -327,124 +363,89 @@ void generic_smp_call_function_single_interrupt(void)
  * to ensure that all pending IPI callbacks are run before it goes completely
  * offline.
  *
- * Loop through the call_single_queue and run all the queued callbacks.
+ * Loop through the call_multi_queue->* and run all the queued callbacks.
  * Must be called with interrupts disabled.
  */
 static void flush_smp_call_function_queue(bool warn_cpu_offline)
 {
-	call_single_data_t *csd, *csd_next;
-	struct llist_node *entry, *prev;
-	struct llist_head *head;
+	call_single_data_t *csd;
+	struct llist_node *entry_sync, *entry_async_n_irq_work, *entry_ttwu;
+	struct call_multi_queue *cmq;
 	static bool warned;
 
 	lockdep_assert_irqs_disabled();
 
-	head = this_cpu_ptr(&call_single_queue);
-	entry = llist_del_all(head);
-	entry = llist_reverse_order(entry);
+	cmq = this_cpu_ptr(&call_mq);
+	entry_sync = llist_del_all(&cmq->sync);
+	entry_async_n_irq_work = llist_del_all(&cmq->async_n_irq_work);
+	entry_ttwu = llist_del_all(&cmq->ttwu);
+
+	entry_sync = llist_reverse_order(entry_sync);
+	entry_async_n_irq_work = llist_reverse_order(entry_async_n_irq_work);
+	entry_ttwu = llist_reverse_order(entry_ttwu);
 
 	/* There shouldn't be any pending callbacks on an offline CPU. */
-	if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) &&
-		     !warned && !llist_empty(head))) {
+	if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) && !warned &&
+		     !llist_empty(&cmq->sync) && !llist_empty(&cmq->async_n_irq_work) &&
+		     !llist_empty(&cmq->ttwu))) {
 		warned = true;
 		WARN(1, "IPI on offline CPU %d\n", smp_processor_id());
 
-		/*
-		 * We don't have to use the _safe() variant here
-		 * because we are not invoking the IPI handlers yet.
-		 */
-		llist_for_each_entry(csd, entry, node.llist) {
-			switch (CSD_TYPE(csd)) {
-			case CSD_TYPE_ASYNC:
-			case CSD_TYPE_SYNC:
-			case CSD_TYPE_IRQ_WORK:
-				pr_warn("IPI callback %pS sent to offline CPU\n",
-					csd->func);
-				break;
-
-			case CSD_TYPE_TTWU:
-				pr_warn("IPI task-wakeup sent to offline CPU\n");
-				break;
-
-			default:
-				pr_warn("IPI callback, unknown type %d, sent to offline CPU\n",
-					CSD_TYPE(csd));
-				break;
-			}
-		}
+		llist_for_each_entry(csd, entry_sync, node.llist)
+			pr_warn("IPI callback %pS sent to offline CPU\n", csd->func);
+
+		llist_for_each_entry(csd, entry_async_n_irq_work, node.llist)
+			pr_warn("IPI callback %pS sent to offline CPU\n", csd->func);
+
+		llist_for_each_entry(csd, entry_ttwu, node.llist)
+			pr_warn("IPI task-wakeup sent to offline CPU\n");
 	}
 
 	/*
 	 * First; run all SYNC callbacks, people are waiting for us.
 	 */
-	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
-		/* Do we wait until *after* callback? */
-		if (CSD_TYPE(csd) == CSD_TYPE_SYNC) {
-			smp_call_func_t func = csd->func;
-			void *info = csd->info;
-
-			if (prev) {
-				prev->next = &csd_next->node.llist;
-			} else {
-				entry = &csd_next->node.llist;
-			}
+	llist_for_each_entry(csd, entry_sync, node.llist) {
+		smp_call_func_t func = csd->func;
+		void *info = csd->info;
 
-			csd_lock_record(csd);
-			func(info);
-			csd_unlock(csd);
-			csd_lock_record(NULL);
-		} else {
-			prev = &csd->node.llist;
-		}
+		csd_lock_record(csd);
+		func(info);
+		csd_unlock(csd);
+		csd_lock_record(NULL);
 	}
 
-	if (!entry)
-		return;
-
 	/*
-	 * Second; run all !SYNC callbacks.
+	 * Second; run all ASYNC & IRQ_WORK callbacks.
 	 */
-	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
-		int type = CSD_TYPE(csd);
-
-		if (type != CSD_TYPE_TTWU) {
-			if (prev) {
-				prev->next = &csd_next->node.llist;
-			} else {
-				entry = &csd_next->node.llist;
-			}
-
-			if (type == CSD_TYPE_ASYNC) {
-				smp_call_func_t func = csd->func;
-				void *info = csd->info;
-
-				csd_lock_record(csd);
-				csd_unlock(csd);
-				func(info);
-				csd_lock_record(NULL);
-			} else if (type == CSD_TYPE_IRQ_WORK) {
-				irq_work_single(csd);
-			}
+	llist_for_each_entry(csd, entry_async_n_irq_work, node.llist) {
+		smp_call_func_t func = csd->func;
+		void *info = csd->info;
 
+		if (CSD_TYPE(csd) == CSD_TYPE_ASYNC) {
+			csd_lock_record(csd);
+			csd_unlock(csd);
+			func(info);
+			csd_lock_record(NULL);
 		} else {
-			prev = &csd->node.llist;
+			/* CSD_TYPE_IRQ_WORK */
+			irq_work_single(csd);
 		}
 	}
 
 	/*
 	 * Third; only CSD_TYPE_TTWU is left, issue those.
 	 */
-	if (entry)
-		sched_ttwu_pending(entry);
+	if (entry_ttwu)
+		sched_ttwu_pending(entry_ttwu);
 }
 
 void flush_smp_call_function_from_idle(void)
 {
 	unsigned long flags;
+	struct call_multi_queue *cmq = this_cpu_ptr(&call_mq);
 
-	if (llist_empty(this_cpu_ptr(&call_single_queue)))
+	if (llist_empty(&cmq->sync) && llist_empty(&cmq->async_n_irq_work) &&
+	    llist_empty(&cmq->ttwu))
 		return;
 
 	local_irq_save(flags);
@@ -674,7 +675,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		csd->node.src = smp_processor_id();
 		csd->node.dst = cpu;
 #endif
-		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
+		if (smp_add_to_queue(cpu, &csd->node.llist))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
 
-- 
2.29.2

