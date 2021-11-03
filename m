Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8A443FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhKCJya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhKCJy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 05:54:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B5C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 02:51:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u1so2581262wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=rmnAjDo5zQmWt4nT+J80TzUDckWP5ks3w3z2eKwc5pk=;
        b=fbSlUs3f6tcx/QJjoMf4QEAenyTkY4Gw3bWOHuObis18v6mcIh2JGy4o7QVtKdtGFY
         ZI5pRGGj2pznT60F8vSskxhBu4K9vvt2o6dY72o1A4LSQoKZWhzbbC6Vh5dPkpwuOmho
         0eCbM5aoPElxNa/s14Lzu+2kQvgAZFnwjjSGr6Wvfs+spUbCedpgQ8URorgWlbFFe5KO
         2sctOeF9zmhyqc0+Qz0/jqVLe10/lS8x252xzy9ioRhEFNb/iNwn58Ybq+poD30FkgOk
         BgNt3sx3yz4RkBoPhInjYJd1aZPq8NeohcgLVBTjhDtv0HD7xoBdg8DcOXEaNZgKVUlL
         qv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=rmnAjDo5zQmWt4nT+J80TzUDckWP5ks3w3z2eKwc5pk=;
        b=0xrZZ0OrvuwA9Ab/HNFi6bKmZu/4E7f5fpSlN4h5lrxA3I1KdK3MOynj68CdfqqNPW
         xy6PvxA/YBKoMRhuNWkLEKDQvX3brB+zn/HI2WYjUczkYj6u2aSeJusn6Y5QHSshznA7
         KHBMMmto7t1CjHaPR2HGDm60G85an+Jlh07Bot1cExI3CWL1ArnX96FKEau45A+PbXA5
         u+e4JcPx+hT3nC+cpk7TNUEC0pxVWXoA/ySSURs4monH7Mcb57CljkUSiUR2dZgNAkNY
         Hih/uJoqv3ynuQ4v4WZ1p6mJd8jeEPs1jaGCP5NQGc0mOH+gRnngQOr6zJnLqZJTDD20
         e7pA==
X-Gm-Message-State: AOAM532Wy3KjXHubHlFTNpCi/LYL4o4vAmQDymlsDv7wC+73PydEVTIZ
        dODesct2Lngu/Rv0VQwjIT3zETejGIWjWaH+
X-Google-Smtp-Source: ABdhPJxbDKo8q0CHeOA5zVH6nonZfepSES9yQ2ZqMqOdytXdSJiGG/c18teBu8GVf7fFHqLtwYdWRw==
X-Received: by 2002:adf:f489:: with SMTP id l9mr26932910wro.268.1635933111705;
        Wed, 03 Nov 2021 02:51:51 -0700 (PDT)
Received: from [192.168.24.132] (pd9fe9a3e.dip0.t-ipconnect.de. [217.254.154.62])
        by smtp.gmail.com with ESMTPSA id v185sm4881005wme.35.2021.11.03.02.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 02:51:51 -0700 (PDT)
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>
Cc:     Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211011172236.11223-1-mkoutny@suse.com>
 <CAKfTPtAQmqgAiNGqk9xRmiB4_dzHxaKK68+fWwea25mZv0kT2w@mail.gmail.com>
 <20211013142643.GA48428@blackbody.suse.cz>
 <20211102160228.GA57072@blackbody.suse.cz>
From:   Mathias Krause <minipli@grsecurity.net>
Subject: Re: task_group unthrottling and removal race (was Re: [PATCH]
 sched/fair: Use rq->lock when checking cfs_rq list) presence
Message-ID: <73b4bddb-335b-1f25-a203-199be546e44a@grsecurity.net>
Date:   Wed, 3 Nov 2021 10:51:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211102160228.GA57072@blackbody.suse.cz>
Content-Type: multipart/mixed;
 boundary="------------82D9AE8F839E59C2FAFA351C"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------82D9AE8F839E59C2FAFA351C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi!

Am 02.11.21 um 17:02 schrieb Michal Koutný:
> [snip]
> I have a reproducer (attached) that can hit this window quite easily
> after tuning.  I can observe consequences of it even with a recent 5.15
> kernel. (And I also have reports from real world workloads failing due
> to a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on
> unthrottle").)

Thanks for the reproducer!

To provide yet another data point, Kevin (on Cc) is running into this
bug as well very reliable with a production workload, so we started
looking into this too. His crashes indicate a use-after-free of a cfs_rq
in update_blocked_averages(), much like you already diagnosed in your
initial patch description -- there are live cfs_rq's (on_list=1) in an
about to be kfree()'d task group in free_fair_sched_group().

His kernel config happened to lead to a layout of struct sched_entity
that put the 'my_q' member directly into the middle of the object which
makes it incidentally overlap with SLUB's freelist pointer. That in
combination with SLAB_FREELIST_HARDENED's freelist pointer mangling
leads to a reliable access violation in form of a #GP which allowed us
to make the UAF fail fast.

As the real root cause cannot be seen from the crash backtrace only, we
tested a debug patch (attached) that unveiled that the real offender is
tg_unthrottle_up() getting called via sched_cfs_period_timer() via the
timer interrupt at an inconvenient time, namely when
unregister_fair_sched_group() unlinks all cfs_rq's from the dying task
group. It doesn't protect itself from getting interrupted, so if the
timer interrupt triggers while we iterate over all CPUs or after
unregister_fair_sched_group() has finished but prior to unlinking the
task group in sched_offline_group(), sched_cfs_period_timer() will
execute and walk the list of task groups, trying to unthrottle cfs_rq's
and possibly re-add them to the dying task group. These will later -- in
free_fair_sched_group() -- be kfree()'ed while still being linked,
leading to the fireworks Kevin and you are seeing.

We tried the below patch which, unfortunately, doesn't fix the issue. So
there must be something else. :(

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 978460f891a1..afee07e9faf9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9506,13 +9506,17 @@ void sched_offline_group(struct task_group *tg)
 {
 	unsigned long flags;

-	/* End participation in shares distribution: */
-	unregister_fair_sched_group(tg);
-
+	/*
+	 * Unlink first, to avoid walk_tg_tree_from() from finding us
+	 * (via sched_cfs_period_timer()).
+	 */
 	spin_lock_irqsave(&task_group_lock, flags);
 	list_del_rcu(&tg->list);
 	list_del_rcu(&tg->siblings);
 	spin_unlock_irqrestore(&task_group_lock, flags);
+
+	/* End participation in shares distribution: */
+	unregister_fair_sched_group(tg);
 }

 static void sched_change_group(struct task_struct *tsk, int type)

> [snip]
> 
> The possibilities for the current problem:
> 
> 1) Revert a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle") and its fixups.
> (Not exclusive with the other suggestions, rather a stop-gap for the
> time being.)
> 
> 2) Don't add offlined task_groups into the undecayed list
> - Your proposal with overloaded on_list=2 could serve as mark of that,
>   but it's a hack IMO.

> - Proper way (tm) would be to use css_tryget_online() and css_put() when
>   dealing with the list (my favorite at the moment).

That might work, as -- at least in Kevin's case -- it all gets triggered
by a dying cgroup.

> 3) Narrowing the race-window dramatically
> - that is by moving list removal from unregister_fair_sched_group() to
>   free_fair_sched_group(),

That might work, too. However, the unlinking needs protection against
the timer interrupt (and other sources?) which might try to re-add
entries. Or won't that happen any more, as at lesat one RCU GP has
passed? Anyhow, the kfree() calls likely would need to become
kfree_rcu() to handle concurrent traversal of cfs_rq's.

> - <del>or use list_empty(tg->list) as indicator whether we're working
>   with onlined task_group.</del> (won't work for RCU list)
> 
> 4) Rework how throttled load is handled (hand waving)
> - There is remove_entity_load_avg() that moves the load to parent upon
>   final removal. Maybe it could be generalized for temporary removals by
>   throttling (so that unthrottling could again add only non-empty
>   cfs_rqs to the list and undecayed load won't skew fairness).
> - or the way of [1].
> 
> 5) <your ideas>

It should be something that can be backported to stable kernels, as this
seem to affect v5.13, too.


Thanks,
Mathias

--------------82D9AE8F839E59C2FAFA351C
Content-Type: text/x-patch; charset=UTF-8;
 name="5.14-sched-fair-dbg.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="5.14-sched-fair-dbg.diff"

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 567c571d624f..94d1fe0aec5a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -313,6 +313,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq=
 *cfs_rq)
 		 * the list, this means to put the child at the tail
 		 * of the list that starts by parent.
 		 */
+		WARN(cfs_rq->tg->parent->dead, "parent marked dead! (cfs_rq =3D %px, p=
arent =3D %px)", cfs_rq, cfs_rq->tg->parent);
 		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
 			&(cfs_rq->tg->parent->cfs_rq[cpu]->leaf_cfs_rq_list));
 		/*
@@ -329,6 +330,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq=
 *cfs_rq)
 		 * cfs rq without parent should be put
 		 * at the tail of the list.
 		 */
+		WARN(cfs_rq->tg->dead, "tg marked dead! (cfs_rq =3D %px, tg =3D %px)",=
 cfs_rq, cfs_rq->tg);
 		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
 			&rq->leaf_cfs_rq_list);
 		/*
@@ -345,6 +347,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq=
 *cfs_rq)
 	 * tmp_alone_branch points to the begin of the branch
 	 * where we will add parent.
 	 */
+	WARN(cfs_rq->tg->dead, "tg marked dead! (cfs_rq =3D %px, tg =3D %px)", =
cfs_rq, cfs_rq->tg);
 	list_add_rcu(&cfs_rq->leaf_cfs_rq_list, rq->tmp_alone_branch);
 	/*
 	 * update tmp_alone_branch to points to the new begin
@@ -3277,6 +3280,7 @@ static inline bool child_cfs_rq_on_list(struct cfs_=
rq *cfs_rq)
 		prev =3D rq->tmp_alone_branch;
 	}
=20
+	BUG_ON(prev =3D=3D LIST_POISON2);
 	prev_cfs_rq =3D container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
=20
 	return (prev_cfs_rq->tg->parent =3D=3D cfs_rq->tg);
@@ -11369,6 +11373,8 @@ void unregister_fair_sched_group(struct task_grou=
p *tg)
 	struct rq *rq;
 	int cpu;
=20
+	WARN(tg->dead, "tg already dead! (tg =3D %px)", tg);
+	tg->dead =3D 1;
 	for_each_possible_cpu(cpu) {
 		if (tg->se[cpu])
 			remove_entity_load_avg(tg->se[cpu]);
@@ -11386,6 +11392,10 @@ void unregister_fair_sched_group(struct task_gro=
up *tg)
 		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
 		raw_spin_rq_unlock_irqrestore(rq, flags);
 	}
+
+	for_each_possible_cpu(cpu) {
+		WARN(tg->cfs_rq[cpu]->on_list, "found on_list cfs_rq! (cpu =3D %d, cfs=
_rq =3D %px, tg =3D %px)", cpu, tg->cfs_rq[cpu], tg);
+	}
 }
=20
 void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eaca971a3ee2..218dead1f4db 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -395,6 +395,7 @@ struct task_group {
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
+	unsigned char       dead;
=20
 #ifdef	CONFIG_SMP
 	/*

--------------82D9AE8F839E59C2FAFA351C--
