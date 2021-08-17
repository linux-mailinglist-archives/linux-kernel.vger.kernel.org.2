Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE13EEB75
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbhHQLTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbhHQLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:19:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F4C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q2so24496753plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZgTRL7Wgwjl7IC5i1br7yPq6CR5U9t78tg56mW0KMQ=;
        b=n8qbg6E+mjkI90YVenC4WkSL2VlrhKo1d+SVpagRDw6Y6Nn+S2ZeEaG3aj5qX3rnTS
         trZ4mdl6NKARtGk3iKZGDKPJDCOBGmFEb5UbMRAyrD3F/1a/FZgdNtQGsFhM+au38AfO
         fVyRpskcC28iByn+qmkTStj8c0W39tHC4oi0j0A5etND/bP+sUtLWEh0RndhsDRqHifn
         puLj2q2jVk87Y7UfkXzjya5vA6VtQX7uB4L7sITTUMkTxSEpKrfUvYVZA8Vlda604pto
         nxEf1CbQoMHF1mhna4siwRKk+9jX7WGldB3/Mx0UxJ9J9TaVYcWzk9r3VcgZt6uuFRTz
         EoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZgTRL7Wgwjl7IC5i1br7yPq6CR5U9t78tg56mW0KMQ=;
        b=XBPp2g7iyd7wXxvJHemqnprxeepFqk2aV9XxZjGEgWW+Sto4FDLDFAKhNVHPMcwqHA
         geR0+VWGDgnQPUTVu4rs8j/bzZC/IMPGNW3jCiDS4OW74Qfsz4s1YYZO9TJh6f8vCW2E
         C9esDGGsr5PYpaMM/LLUP6c7HnksddA218IBSxwr3jxUmW1/CcrCmkb/7DFtf2ciJ0Ta
         sJDJx8Xi+pkv+3J4HEY86U+fy4nqYwEASgaLJDjpaUZAw64iFKFVuiYAz/xo84q12Z4a
         EJhpx9musUkGryXXynBWEtrOqBIuFRUfBjWPNW52xnDFQf6ab4yl/UONvhcHMaVsLURO
         thyQ==
X-Gm-Message-State: AOAM5334IDNkuI1F+txyLgGaRvf7sFhE///URMUci+tTxcO6Yg4VW+6E
        D5BFscGG2VcqqwFO7NU+o4KegrmtKUY=
X-Google-Smtp-Source: ABdhPJw+SYSYhf6riZdpA5KLYHvlclPLmEC04pb32V12IBwspY7j4JB8sUT2jqkDp8sd5g9wM9A3WA==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr3071415pgv.370.1629199108836;
        Tue, 17 Aug 2021 04:18:28 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id b18sm2316504pfi.199.2021.08.17.04.18.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 04:18:28 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 5/6] workqueue: Assign a color to barrier work items
Date:   Tue, 17 Aug 2021 09:32:38 +0800
Message-Id: <20210817013239.3921-6-jiangshanlai@gmail.com>
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

There was no strong reason to or not to flush barrier work items in
flush_workqueue().  And we have to make barrier work items not participate
in nr_active so we had been using WORK_NO_COLOR for them which also makes
them can't be flushed by flush_workqueue().

And the users of flush_workqueue() often do not intend to wait barrier work
items issued by flush_work().  That made the choice sound perfect.

But barrier work items have reference to internal structure (pool_workqueue)
and the worker thread[s] is/are still busy for the workqueue user when the
barrrier work items are not done.  So it is reasonable to make flush_workqueue()
also watch for flush_work() to make it more robust.

And a problem[1] reported by Li Zhe shows that we need such robustness.
The warning logs are listed below:

WARNING: CPU: 0 PID: 19336 at kernel/workqueue.c:4430 destroy_workqueue+0x11a/0x2f0
*****
destroy_workqueue: test_workqueue9 has the following busy pwq
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/1 refcnt=2
      in-flight: 5658:wq_barrier_func
Showing busy workqueues and worker pools:
*****

It shows that even after drain_workqueue() returns, the barrier work item
is still in flight and the pwq (and a worker) is still busy on it.

The problem is caused by flush_workqueue() not watching flush_work():

Thread A				Worker
					/* normal work item with linked */
					process_scheduled_works()
destroy_workqueue()			  process_one_work()
  drain_workqueue()			    /* run normal work item */
				 /--	    pwq_dec_nr_in_flight()
    flush_workqueue()	    <---/
		/* the last normal work item is done */
  sanity_check				  process_one_work()
				       /--  raw_spin_unlock_irq(&pool->lock)
    raw_spin_lock_irq(&pool->lock)  <-/     /* maybe preempt */
    *WARNING*				    wq_barrier_func()
					    /* maybe preempt by cond_resched() */

Thread A can get the pool lock after the Worker unlocks the pool lock before
running wq_barrier_func().  And if there is any preemption happen around
wq_barrier_func(), destroy_workqueue()'s sanity check is more likely to
get the lock and catch it.  (Note: preemption is not necessary to cause the bug,
the unlocking is enough to possibly trigger the WARNING.)

A simple solution might be just executing all linked barrier work items
once without releasing pool lock after the head work item's
pwq_dec_nr_in_flight().  But this solution has two problems:

  1) the head work item might also be barrier work item when the user-queued
     work item is cancelled. For example:
	thread 1:		thread 2:
	queue_work(wq, &my_work)
	flush_work(&my_work)
				cancel_work_sync(&my_work);
	/* Neiter my_work nor the barrier work is scheduled. */
				destroy_workqueue(wq);
	/* This is an easier way to catch the WARNING. */

  2) there might be too much linked barrier work items and running them
     all once without releasing pool lock just causes trouble.

The only solution is to make flush_workqueue() aslo watch barrier work
items.  So we have to assign a color to these barrier work items which
is the color of the head (user-queued) work item.

Assigning a color doesn't cause any problem in ative management, because
the prvious patch made barrier work items not participate in nr_active
via WORK_STRUCT_INACTIVE rather than reliance on the (old) WORK_NO_COLOR.

[1]: https://lore.kernel.org/lkml/20210812083814.32453-1-lizhe.67@bytedance.com/
Reported-by: Li Zhe <lizhe.67@bytedance.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c          | 20 ++++++++++++--------
 kernel/workqueue_internal.h |  3 ++-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1b2792b397f0..803b0868433b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1197,10 +1197,6 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 		}
 	}
 
-	/* uncolored work items don't participate in flushing */
-	if (color == WORK_NO_COLOR)
-		goto out_put;
-
 	pwq->nr_in_flight[color]--;
 
 	/* is flush in progress and are we at the flushing tip? */
@@ -1307,7 +1303,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		 * canceled (see the comments in insert_wq_barrier()).
 		 *
 		 * An inactive work item cannot be grabbed directly because
-		 * it might have linked NO_COLOR work items which, if left
+		 * it might have linked barrier work items which, if left
 		 * on the inactive_works list, will confuse pwq->nr_active
 		 * management later on and cause stall.  Make sure the work
 		 * item is activated before grabbing.
@@ -2235,6 +2231,7 @@ __acquires(&pool->lock)
 	worker->current_func = work->func;
 	worker->current_pwq = pwq;
 	work_data = *work_data_bits(work);
+	worker->current_color = get_work_color(work_data);
 
 	/*
 	 * Record wq name for cmdline and debug reporting, may get
@@ -2340,6 +2337,7 @@ __acquires(&pool->lock)
 	worker->current_work = NULL;
 	worker->current_func = NULL;
 	worker->current_pwq = NULL;
+	worker->current_color = INT_MAX;
 	pwq_dec_nr_in_flight(pwq, work_data);
 }
 
@@ -2683,7 +2681,8 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 			      struct wq_barrier *barr,
 			      struct work_struct *target, struct worker *worker)
 {
-	unsigned int work_flags = work_color_to_flags(WORK_NO_COLOR);
+	unsigned int work_flags = 0;
+	unsigned int work_color;
 	struct list_head *head;
 
 	/*
@@ -2706,17 +2705,22 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 	 * If @target is currently being executed, schedule the
 	 * barrier to the worker; otherwise, put it after @target.
 	 */
-	if (worker)
+	if (worker) {
 		head = worker->scheduled.next;
-	else {
+		work_color = worker->current_color;
+	} else {
 		unsigned long *bits = work_data_bits(target);
 
 		head = target->entry.next;
 		/* there can already be other linked works, inherit and set */
 		work_flags |= *bits & WORK_STRUCT_LINKED;
+		work_color = get_work_color(*bits);
 		__set_bit(WORK_STRUCT_LINKED_BIT, bits);
 	}
 
+	pwq->nr_in_flight[work_color]++;
+	work_flags |= work_color_to_flags(work_color);
+
 	debug_work_activate(&barr->work);
 	insert_work(pwq, &barr->work, head, work_flags);
 }
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index 498de0e909a4..e00b1204a8e9 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -30,7 +30,8 @@ struct worker {
 
 	struct work_struct	*current_work;	/* L: work being processed */
 	work_func_t		current_func;	/* L: current_work's fn */
-	struct pool_workqueue	*current_pwq; /* L: current_work's pwq */
+	struct pool_workqueue	*current_pwq;	/* L: current_work's pwq */
+	unsigned int		current_color;	/* L: current_work's color */
 	struct list_head	scheduled;	/* L: scheduled works */
 
 	/* 64 bytes boundary on 64bit, 32 on 32bit */
-- 
2.19.1.6.gb485710b

