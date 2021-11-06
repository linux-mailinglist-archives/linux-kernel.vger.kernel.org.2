Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2D446D7B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhKFKw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 06:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFKwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 06:52:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B63C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ngL4kkwgEo/O80l8efaNal6CPpRsGuCfvOFOTPEyZYI=; b=UodRppAyudMBR7V7aON7iUDpc1
        R6xh7R2a+nh2vyl+/L+WzV3bKCqGW3uQnW49eusjPmVGaqpqHOmCgFy6hoxCI2jxd4F8IHI5ATl8b
        5YxnqwAUTohHXGmj4T7VX3A7OpsZVYV+WxNIAk2Of7dwbHT9P623Ah1dwVKDa6/S6FRkv25fpkYZQ
        d4bOh6ZdS134DYmaDv2yp2HaEKrb7yFvGJ12bAd+8RcjUmfo2/TeLfKpuQhJv7RM/EQmG+2WIRugU
        cBd9D+5Dj5aOxavkxyCSxLIR/W4fqtZXn0nH+y5pzpqAGkOCCHpIGzmFkOOa1az2LUol8XmPEvWNj
        EFVcg3Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjJFn-00EUwT-V1; Sat, 06 Nov 2021 10:49:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A516B9862D4; Sat,  6 Nov 2021 11:48:54 +0100 (CET)
Date:   Sat, 6 Nov 2021 11:48:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
Message-ID: <20211106104854.GU174703@worktop.programming.kicks-ass.net>
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net>
 <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
 <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
 <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
 <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
 <20211105162914.215420-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105162914.215420-1-minipli@grsecurity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 05:29:14PM +0100, Mathias Krause wrote:
> > Looks like it needs to be the kfree_rcu() one in this case. I'll prepare
> > a patch.
> 
> Testing the below patch right now. Looking good so far. Will prepare a
> proper patch later, if we all can agree that this covers all cases.
> 
> But the basic idea is to defer the kfree()'s to after the next RCU GP,
> which also means we need to free the tg object itself later. Slightly
> ugly. :/

How's this then?

---
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2067080bb235..8629b37d118e 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -31,7 +31,7 @@ static inline void autogroup_destroy(struct kref *kref)
 	ag->tg->rt_se = NULL;
 	ag->tg->rt_rq = NULL;
 #endif
-	sched_offline_group(ag->tg);
+	sched_release_group(ag->tg);
 	sched_destroy_group(ag->tg);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9cb81ef8acc8..22528bd61ba5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9715,6 +9715,21 @@ static void sched_free_group(struct task_group *tg)
 	kmem_cache_free(task_group_cache, tg);
 }
 
+static void sched_free_group_rcu(struct rcu_head *rcu)
+{
+	sched_free_group(container_of(rcu, struct task_group, rcu_head));
+}
+
+static void sched_unregister_group(struct task_group *tg)
+{
+	unregister_fair_sched_group(tg);
+	/*
+	 * We have to wait for yet another RCU grace period to expire, as
+	 * print_cfs_stats() might run concurrently.
+	 */
+	call_rcu(&tg->rcu, sched_free_group_rcu);
+}
+
 /* allocate runqueue etc for a new task group */
 struct task_group *sched_create_group(struct task_group *parent)
 {
@@ -9735,7 +9750,7 @@ struct task_group *sched_create_group(struct task_group *parent)
 	return tg;
 
 err:
-	sched_free_group(tg);
+	sched_unregister_group(tg);
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -9758,25 +9773,35 @@ void sched_online_group(struct task_group *tg, struct task_group *parent)
 }
 
 /* rcu callback to free various structures associated with a task group */
-static void sched_free_group_rcu(struct rcu_head *rhp)
+static void sched_unregister_group_rcu(struct rcu_head *rhp)
 {
 	/* Now it should be safe to free those cfs_rqs: */
-	sched_free_group(container_of(rhp, struct task_group, rcu));
+	sched_unregister_group(container_of(rhp, struct task_group, rcu));
 }
 
 void sched_destroy_group(struct task_group *tg)
 {
 	/* Wait for possible concurrent references to cfs_rqs complete: */
-	call_rcu(&tg->rcu, sched_free_group_rcu);
+	call_rcu(&tg->rcu, sched_unregister_group_rcu);
 }
 
-void sched_offline_group(struct task_group *tg)
+void sched_release_group(struct task_group *tg)
 {
 	unsigned long flags;
 
-	/* End participation in shares distribution: */
-	unregister_fair_sched_group(tg);
-
+	/*
+	 * Unlink first, to avoid walk_tg_tree_from() from finding us (via
+	 * sched_cfs_period_timer()).
+	 *
+	 * For this to be effective, we have to wait for all pending users of
+	 * this task group to leave their RCU critical section to ensure no new
+	 * user will see our dying task group any more. Specifically ensure
+	 * that tg_unthrottle_up() won't add decayed cfs_rq's to it.
+	 *
+	 * We therefore defer calling unregister_fair_sched_group() to
+	 * sched_unregister_group() which is guarantied to get called only after the
+	 * current RCU grace period has expired.
+	 */
 	spin_lock_irqsave(&task_group_lock, flags);
 	list_del_rcu(&tg->list);
 	list_del_rcu(&tg->siblings);
@@ -9895,7 +9920,7 @@ static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
 
-	sched_offline_group(tg);
+	sched_release_group(tg);
 }
 
 static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
@@ -9905,7 +9930,7 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 	/*
 	 * Relies on the RCU grace period between css_released() and this.
 	 */
-	sched_free_group(tg);
+	sched_unregister_group(tg);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f0b249ec581d..20038274c57b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -504,7 +504,7 @@ extern struct task_group *sched_create_group(struct task_group *parent);
 extern void sched_online_group(struct task_group *tg,
 			       struct task_group *parent);
 extern void sched_destroy_group(struct task_group *tg);
-extern void sched_offline_group(struct task_group *tg);
+extern void sched_release_group(struct task_group *tg);
 
 extern void sched_move_task(struct task_struct *tsk);
 
