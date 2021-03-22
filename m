Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7989A3452B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 00:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCVXDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 19:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCVXDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:03:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 16:03:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g25so10080191wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DXrkB6IjWOjCnajI5iwkJOTPzE9Rp5wKBjGagS51tx0=;
        b=fe8Fp0Oo7v7tTyPHjXdX0kTTNfbikf5oMPoTi7J1uznby9uZPMiBgwRRaTskOC+erI
         TMJgazby9voYYvLw7/muw9BI+ABPmNOgmZsP5EdyHiGQFbofNw2LeVLSXBDwWxAidsCv
         zevqWlQq1PBxBbiELorkqVz2VWkLfg5xOjGFBYMae9D3hGlvilalKhcNKRDGDmWgFtDN
         kIQWxCxozHfi+vLHVIfpCTqUC5GZ1LYl+vBKjXGexoFcoGkyjfNqRBj1UxPwJpRNvYPa
         ZCdiY0NsEXTjV2IK8NvTFHip13jOhndOhdI/aE8Tb3Mnw8S/Ud3ZOjbOcErkBWaGdpzf
         eZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=DXrkB6IjWOjCnajI5iwkJOTPzE9Rp5wKBjGagS51tx0=;
        b=Pyb0371NvwdPUhZmYJM/HC+7inAia7aHZjgJ01eXrW1F8yjOxr2Hm2GNhIvi8VGamo
         TATjWxlGQ9HcfiaBrh7IJo+Xcp2KYVtNSxdNw75bfDj0/CYbg3BdBVapEPXjFlfbOzuG
         /VPQNWhNOcz50nJJJnu5aegX7J3tEvbAiap760Kk8VwQ3iQryK71hGmhIf1TzCPh1G+k
         Pvq97eBCCaJl/JNjUThGJVHfUlZlSe8DYgtGmsDPNxwWjLoACsWFBjibvQvrjvXjXwV7
         11IolLi4nt3h19K2VLGLVqesLUoXgoaeRLUta+poIrfLUgOcirMQUKdZ7xv1G+0IxkS7
         3gdg==
X-Gm-Message-State: AOAM532eA0jVdPNxGwFx9us7Kr8P3qNTCHw+aujE88T3Lbky4mJZ5FWl
        /C51C+4GOa7kYH8mMaOLZAT6YxhoxUw=
X-Google-Smtp-Source: ABdhPJxusL1XNlVeH5NOO6IyAAt6+LmpedOhrwU96+fmt4DMtmXGdZUamKj2hTuzdH1w4h0SmErGOw==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr629357wmi.60.1616454181168;
        Mon, 22 Mar 2021 16:03:01 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h20sm740712wmm.19.2021.03.22.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 16:03:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 23 Mar 2021 00:02:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix various typos in comments
Message-ID: <20210322230258.GA1983587@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul,

Was working on automation to make it a bit more straightforward to fix 
typos within comments (which we tend to reintroduce during 
development), and here are the ones it found in the RCU code.

Thanks,

	Ingo

=========>
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 22 Mar 2021 23:57:26 +0100
Subject: [PATCH] rcu: Fix various typos in comments

Fix ~12 single-word typos in RCU code comments.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/rcu/srcutree.c                                           | 4 ++--
 kernel/rcu/sync.c                                               | 2 +-
 kernel/rcu/tasks.h                                              | 8 ++++----
 kernel/rcu/tree.c                                               | 4 ++--
 kernel/rcu/tree.h                                               | 2 +-
 kernel/rcu/tree_plugin.h                                        | 2 +-
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e26547b34ad3..036ff5499ad5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -777,9 +777,9 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	spin_unlock_irqrestore_rcu_node(sdp, flags);
 
 	/*
-	 * No local callbacks, so probabalistically probe global state.
+	 * No local callbacks, so probabilistically probe global state.
 	 * Exact information would require acquiring locks, which would
-	 * kill scalability, hence the probabalistic nature of the probe.
+	 * kill scalability, hence the probabilistic nature of the probe.
 	 */
 
 	/* First, see if enough time has passed since the last GP. */
diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index d4558ab7a07d..3eeb871cf0de 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -94,7 +94,7 @@ static void rcu_sync_func(struct rcu_head *rhp)
 		rcu_sync_call(rsp);
 	} else {
 		/*
-		 * We're at least a GP after the last rcu_sync_exit(); eveybody
+		 * We're at least a GP after the last rcu_sync_exit(); everybody
 		 * will now have observed the write side critical section.
 		 * Let 'em rip!.
 		 */
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index af7c19439f4e..ac3c362e08a3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -23,7 +23,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * Definition for a Tasks-RCU-like mechanism.
  * @cbs_head: Head of callback list.
  * @cbs_tail: Tail pointer for callback list.
- * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
+ * @cbs_wq: Wait queue allowing new callback to get kthread's attention.
  * @cbs_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
@@ -504,7 +504,7 @@ DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
  * or transition to usermode execution.  As such, there are no read-side
  * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
  * this primitive is intended to determine that all tasks have passed
- * through a safe state, not so much for data-strcuture synchronization.
+ * through a safe state, not so much for data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -637,7 +637,7 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  * there are no read-side primitives analogous to rcu_read_lock() and
  * rcu_read_unlock() because this primitive is intended to determine
  * that all tasks have passed through a safe state, not so much for
- * data-strcuture synchronization.
+ * data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -1127,7 +1127,7 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
  * there are no read-side primitives analogous to rcu_read_lock() and
  * rcu_read_unlock() because this primitive is intended to determine
  * that all tasks have passed through a safe state, not so much for
- * data-strcuture synchronization.
+ * data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f5213fb74..ab5bd5b391e6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2490,7 +2490,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 
 /*
  * Invoke any RCU callbacks that have made it to the end of their grace
- * period.  Thottle as specified by rdp->blimit.
+ * period.  Throttle as specified by rdp->blimit.
  */
 static void rcu_do_batch(struct rcu_data *rdp)
 {
@@ -4013,7 +4013,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
 /*
  * Propagate ->qsinitmask bits up the rcu_node tree to account for the
  * first CPU in a given leaf rcu_node structure coming online.  The caller
- * must hold the corresponding leaf rcu_node ->lock with interrrupts
+ * must hold the corresponding leaf rcu_node ->lock with interrupts
  * disabled.
  */
 static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 71821d59d95c..abff7abd59ee 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -153,7 +153,7 @@ struct rcu_data {
 	unsigned long	gp_seq;		/* Track rsp->gp_seq counter. */
 	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
-	bool		core_needs_qs;	/* Core waits for quiesc state. */
+	bool		core_needs_qs;	/* Core waits for quiescent state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
 	bool		exp_deferred_qs; /* This CPU awaiting a deferred QS? */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d603771c7dc..2a28f05cf467 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2772,7 +2772,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	wastimer = timer_pending(&rdp->nocb_bypass_timer);
 	wassleep = swait_active(&rdp->nocb_gp_wq);
 	if (!rdp->nocb_gp_sleep && !waslocked && !wastimer && !wassleep)
-		return;  /* Nothing untowards. */
+		return;  /* Nothing untoward. */
 
 	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c%c %c\n",
 		"lL"[waslocked],
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
index cf6938d679d7..1e24827f96f1 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
@@ -174,7 +174,7 @@ static inline bool spin_trylock(spinlock_t *lock)
 }
 
 struct completion {
-	/* Hopefuly this won't overflow. */
+	/* Hopefully this won't overflow. */
 	unsigned int count;
 };
 
