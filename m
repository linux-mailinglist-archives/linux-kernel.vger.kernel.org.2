Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18C54466FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhKEQcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhKEQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:32:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE000C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:29:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i5so14627054wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TT8Hc1gKR31BJRdmEZdAE+1rbO6Bg9GLzw7WQ1cjNys=;
        b=at/ZvijadB2S2IMcR7OKAB+Kc3nuxTxpECc0/9WquPfbGemZZvmFYrgEx6CL+aKpFN
         OqlHEYiVsSCJpoa9Gt5ekKTzCZrgWrIbj3EVT6uaabrP6/1fhB7Tq1s5FKbUYDJdRVdZ
         /ITceiG145GnL9uosj4C/26e2ryNJzKsK5aX/OQe1Npxh7FiIzHc7S2UnNoCMnAYbkoq
         Q459462loK/+A2Xp6Nn+lFZ5Mf2QTpm7CxDdjv4iK9KmygcNpbpS1yvdMnys7DmjoMWc
         qOQ3h6oAaYULhu6YuZcs8mTNVdSp8Pwydk3NIA1j4gi4Px10cMZviCyMvEUVrkzsvzxH
         hYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TT8Hc1gKR31BJRdmEZdAE+1rbO6Bg9GLzw7WQ1cjNys=;
        b=w+p4CCLq2PjGAVO2mOukaCrtATA/GzgtpaPVHRlAnOhsij8VacNsRKo7FdZqUs3ldP
         u+2Z+WT/+x1EhGNk15Hev7FRR4XCM7h8lS8u6svhcicIxIkmbxEks9+7X1uZmrZK4WI7
         cJ6thRBAwbr9qW+uD3tLd1MmPlNZ0oVvhL7SaA++csZDdNt6NW2BtQFYieHnGUEI3LAr
         MvrJMYP7FsYV+vVle7FgfYda19rP8HdivnhjvGwp3zwYyEQZwE2ZaTRQ3VIGJDElUVr1
         mQUKns7H8v8j7gc4UPBs/j5If2X1/tSEqYXRxrGyNdjSe2wHV0C0Y5MKCquwhOVPy4OI
         WN1A==
X-Gm-Message-State: AOAM533Ypqlw9be9mnqMp2xeGu2D5YSgras4nxDHYQKpt9pLluKMp9if
        wlSfVzaIkIlqDpYFUPJk6bAyLQ==
X-Google-Smtp-Source: ABdhPJysgkvTbhSl0WMbCKbV3vxgrZ4RnMdaaFqcdCrZfsPs5j84LJo2NmkJb8KMU7/QMxTLG1C7AQ==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr43501708wrt.65.1636129771464;
        Fri, 05 Nov 2021 09:29:31 -0700 (PDT)
Received: from bell.fritz.box (p200300f6af0453007c00c62bb3aa158b.dip0.t-ipconnect.de. [2003:f6:af04:5300:7c00:c62b:b3aa:158b])
        by smtp.gmail.com with ESMTPSA id c15sm8110316wrs.19.2021.11.05.09.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:29:31 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>,
        Mathias Krause <minipli@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining cfs_rq's
Date:   Fri,  5 Nov 2021 17:29:14 +0100
Message-Id: <20211105162914.215420-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net> <20211103190613.3595047-1-minipli@grsecurity.net> <xm26ilx86gmp.fsf@google.com> <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com> <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net> <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com> <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net> <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com> <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like it needs to be the kfree_rcu() one in this case. I'll prepare
> a patch.

Testing the below patch right now. Looking good so far. Will prepare a
proper patch later, if we all can agree that this covers all cases.

But the basic idea is to defer the kfree()'s to after the next RCU GP,
which also means we need to free the tg object itself later. Slightly
ugly. :/

Thanks,
Mathias

--8<--

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 978460f891a1..8b4c849bc892 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9439,12 +9439,19 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
 #endif
 }
 
+void tg_free(struct task_group *tg)
+{
+	kmem_cache_free(task_group_cache, tg);
+}
+
 static void sched_free_group(struct task_group *tg)
 {
-	free_fair_sched_group(tg);
+	bool delayed_free;
+	delayed_free = free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
-	kmem_cache_free(task_group_cache, tg);
+	if (!delayed_free)
+		tg_free(tg);
 }
 
 /* allocate runqueue etc for a new task group */
@@ -9506,9 +9513,19 @@ void sched_offline_group(struct task_group *tg)
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
+	 * sched_free_group() which is guarantied to get called only after the
+	 * current RCU grace period has expired.
+	 */
 	spin_lock_irqsave(&task_group_lock, flags);
 	list_del_rcu(&tg->list);
 	list_del_rcu(&tg->siblings);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 567c571d624f..54c1f7b571e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11287,12 +11287,11 @@ static void task_change_group_fair(struct task_struct *p, int type)
 	}
 }
 
-void free_fair_sched_group(struct task_group *tg)
+static void free_tg(struct rcu_head *rcu)
 {
+	struct task_group *tg = container_of(rcu, struct task_group, rcu);
 	int i;
 
-	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
-
 	for_each_possible_cpu(i) {
 		if (tg->cfs_rq)
 			kfree(tg->cfs_rq[i]);
@@ -11302,6 +11301,19 @@ void free_fair_sched_group(struct task_group *tg)
 
 	kfree(tg->cfs_rq);
 	kfree(tg->se);
+	tg_free(tg);
+}
+
+bool free_fair_sched_group(struct task_group *tg)
+{
+	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
+	unregister_fair_sched_group(tg);
+	/*
+	 * We have to wait for yet another RCU grace period to expire, as
+	 * print_cfs_stats() might run concurrently.
+	 */
+	call_rcu(&tg->rcu, free_tg);
+	return true;
 }
 
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
@@ -11459,7 +11471,10 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
 }
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
-void free_fair_sched_group(struct task_group *tg) { }
+bool free_fair_sched_group(struct task_group *tg)
+{
+	return false;
+}
 
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eaca971a3ee2..b45ba45d8bdc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -437,6 +437,8 @@ struct task_group {
 
 };
 
+extern void tg_free(struct task_group *tg);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
@@ -470,7 +472,7 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 
 extern int tg_nop(struct task_group *tg, void *data);
 
-extern void free_fair_sched_group(struct task_group *tg);
+extern bool free_fair_sched_group(struct task_group *tg);
 extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
 extern void online_fair_sched_group(struct task_group *tg);
 extern void unregister_fair_sched_group(struct task_group *tg);
