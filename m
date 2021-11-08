Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42AC449794
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbhKHPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbhKHPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:09:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE0AC061766
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:06:53 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s13so27467430wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S5ldUzcoLxhlmVh1N5vleSY11wjNy51gW9xqGNpdqxw=;
        b=JXuXIu1kWlzRiL3cYgaODddGQyeaGz4T1qzx5wwOlu3H6pNIvgdQhbcqKSLqn0Px/y
         j0Pk7jzHrmjZK5Ndoq4PC4m9Mvheupsz/8m+B0lZ2U9qFLNTXAHm3SMjoA0cCiMsjAfH
         Y6VMayZVdmY5zKQa6IaxHmlQa9HvvSVe1NgKc/0O3slwdKJry6xNFXDRvB+FiJRKO5lX
         wOlvds47jF+2Pu/k3UypLX8lkAIJsF/kFAUvGxEBjYxHPVjBKeeyC45NFnMTNc2u8mRv
         okXABUD2P/3mNWnRJ4XTAQMOgbCQOEzDJsEFWVjDUdVV1eNXxQTP2bHly8BHu8hR1izB
         UaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S5ldUzcoLxhlmVh1N5vleSY11wjNy51gW9xqGNpdqxw=;
        b=PMQumHOITiqXYmrAACMCP249/9j5NaIUGf7dkbv3noXDYDj4LlnsY1TPxMRUUib+cb
         Y/jtH/mEipS240bJMF9clhINPpKfOjhRRqgqgbDlyvTgmBhVoDOWx4KLBs86jxS+IKsm
         blD6rysrInbNiwoF+RWehdPBAE+o3wEEWrUcWmkRFm5luq6aGfp1F/C3yv7JBiWJr00K
         6HwvAL0E7z7Jz5T5bsrKsiWtVxuW0fGmpIg5T8BETxswWtFt7EE8gBZuhWMDdECXcuqI
         ysQ9L0c1nmoYMn+6PuSJsyXKBCYia4T+WnIgxnOVoVjsAwd3ezR8DOnIDBCf05i4ZIS+
         Y8qA==
X-Gm-Message-State: AOAM530Mls5tUygWUBNyjJIqpw4Y1kBJsFGfWF0mgeGopVowIKfSZT6u
        ijYFzfN45KZy7o6OrSDKkKWNTQ==
X-Google-Smtp-Source: ABdhPJzT4/XnVbBKNGr2t81IHTFm8ZTDIevLLIF1YxdW1I3fZfbHYFQhIm6pZGEC6YGgBqzaGAbgbA==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr493664wru.316.1636384012059;
        Mon, 08 Nov 2021 07:06:52 -0800 (PST)
Received: from ?IPv6:2003:f6:af05:3300:973b:5a52:fb00:84af? (p200300f6af053300973b5a52fb0084af.dip0.t-ipconnect.de. [2003:f6:af05:3300:973b:5a52:fb00:84af])
        by smtp.gmail.com with ESMTPSA id n32sm21402736wms.1.2021.11.08.07.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 07:06:51 -0800 (PST)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
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
References: <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
 <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
 <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
 <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
 <20211105162914.215420-1-minipli@grsecurity.net>
 <20211106104854.GU174703@worktop.programming.kicks-ass.net>
 <9e8b2c49-2a10-2b34-e644-2b99708080bc@grsecurity.net>
 <YYkMoxLPgMt4uV/g@hirez.programming.kicks-ass.net>
From:   Mathias Krause <minipli@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
Message-ID: <655e2ca8-87b8-48bb-3c9b-aa30b003429a@grsecurity.net>
Date:   Mon, 8 Nov 2021 16:06:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YYkMoxLPgMt4uV/g@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.11.21 um 12:40 schrieb Peter Zijlstra:
> On Mon, Nov 08, 2021 at 11:27:57AM +0100, Mathias Krause wrote:
> 
>> The timers need to be destroyed prior to unregister_fair_sched_group()
>> via destroy_cfs_bandwidth(tg_cfs_bandwidth(tg)), i.e. move it from
>> free_fair_sched_group() to here, as I did in my patch. Otherwise the tg
>> might still be messed with and we don't want that.
> 
> Oh, duh, yes.

Well, still slightly wrong: "prior to unregister_fair_sched_group()"
means calling destroy_cfs_bandwidth() before not after ;)

> For consistency's sake, I've also added an unregister_*
> for the rt class, also destroying the bandwidth timer.

Looks good to me. Not strictly needed by the code as of now, but
shouldn't hurt either, to defer the final kfree() to the next RCU GP.

>> Beside that, looks good to me. Will you create a new proper patch or
>> should I do it?
> 
> Something like so good?
> 
> (I stripped the #PF splat, because I don't think it adds anything not
> covered by the text).

Well, me, personally, always searches for parts of a Oops splat first.
It sometimes finds related discussions or, even better, commits fixing
an issue. So I prefer keeping it. But, in this case, it should find this
Email thread and, in turn, this patch. So I'm fine with dropping it.

> ---
> Subject: sched/fair: Prevent dead task groups from regaining cfs_rq's
> From: Mathias Krause <minipli@grsecurity.net>
> Date: Wed, 3 Nov 2021 20:06:13 +0100
> 
> From: Mathias Krause <minipli@grsecurity.net>
> 
> Kevin is reporting crashes which point to a use-after-free of a cfs_rq
> in update_blocked_averages(). Initial debugging revealed that we've
> live cfs_rq's (on_list=1) in an about to be kfree()'d task group in
> free_fair_sched_group(). However, it was unclear how that can happen.
> 
> His kernel config happened to lead to a layout of struct sched_entity
> that put the 'my_q' member directly into the middle of the object
> which makes it incidentally overlap with SLUB's freelist pointer.
> That, in combination with SLAB_FREELIST_HARDENED's freelist pointer
> mangling, leads to a reliable access violation in form of a #GP which
> made the UAF fail fast.
> 
> Michal seems to have run into the same issue[1]. He already correctly
> diagnosed that commit a7b359fc6a37 ("sched/fair: Correctly insert
> cfs_rq's to list on unthrottle") is causing the preconditions for the
> UAF to happen by re-adding cfs_rq's also to task groups that have no
> more running tasks, i.e. also to dead ones. His analysis, however,
> misses the real root cause and it cannot be seen from the crash
> backtrace only, as the real offender is tg_unthrottle_up() getting
> called via sched_cfs_period_timer() via the timer interrupt at an
> inconvenient time.
> 
> When unregister_fair_sched_group() unlinks all cfs_rq's from the dying
> task group, it doesn't protect itself from getting interrupted. If the
> timer interrupt triggers while we iterate over all CPUs or after
> unregister_fair_sched_group() has finished but prior to unlinking the
> task group, sched_cfs_period_timer() will execute and walk the list of
> task groups, trying to unthrottle cfs_rq's, i.e. re-add them to the
> dying task group. These will later -- in free_fair_sched_group() -- be
> kfree()'ed while still being linked, leading to the fireworks Kevin
> and Michal are seeing.
> 
> To fix this race, ensure the dying task group gets unlinked first.
> However, simply switching the order of unregistering and unlinking the
> task group isn't sufficient, as concurrent RCU walkers might still see
> it, as can be seen below:
> 
>     CPU1:                                      CPU2:
>       :                                        timer IRQ:
>       :                                          do_sched_cfs_period_timer():
>       :                                            :
>       :                                            distribute_cfs_runtime():
>       :                                              rcu_read_lock();
>       :                                              :
>       :                                              unthrottle_cfs_rq():
>     sched_offline_group():                             :
>       :                                                walk_tg_tree_from(…,tg_unthrottle_up,…):
>       list_del_rcu(&tg->list);                           :
>  (1)  :                                                  list_for_each_entry_rcu(child, &parent->children, siblings)
>       :                                                    :
>  (2)  list_del_rcu(&tg->siblings);                         :
>       :                                                    tg_unthrottle_up():
>       unregister_fair_sched_group():                         struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>         :                                                    :
>         list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);               :
>         :                                                    :
>         :                                                    if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
>  (3)    :                                                        list_add_leaf_cfs_rq(cfs_rq);
>       :                                                      :
>       :                                                    :
>       :                                                  :
>       :                                                :
>       :                                              :
>  (4)  :                                              rcu_read_unlock();
> 
> CPU 2 walks the task group list in parallel to sched_offline_group(),
> specifically, it'll read the soon to be unlinked task group entry at
> (1). Unlinking it on CPU 1 at (2) therefore won't prevent CPU 2 from
> still passing it on to tg_unthrottle_up(). CPU 1 now tries to unlink
> all cfs_rq's via list_del_leaf_cfs_rq() in
> unregister_fair_sched_group().  Meanwhile CPU 2 will re-add some of
> these at (3), which is the cause of the UAF later on.
> 
> To prevent this additional race from happening, we need to wait until
> walk_tg_tree_from() has finished traversing the task groups, i.e.
> after the RCU read critical section ends in (4). Afterwards we're safe
> to call unregister_fair_sched_group(), as each new walk won't see the
> dying task group any more.
Replace the following paragraph, which is outdated by now,...:

> Using synchronize_rcu() might be seen as a too heavy hammer to nail
> this problem. However, the overall tear down sequence (e.g., as
> documented in css_free_rwork_fn()) already relies on quite a few
> assumptions regarding execution context and RCU grace periods from
> passing. Looking at the autogroup code, which calls
> sched_destroy_group() directly after sched_offline_group() and the
> apparent need to have at least one RCU grace period expire after
> unlinking the task group, prior to calling
> unregister_fair_sched_group(), there seems to be no better
> alternative.  Calling unregister_fair_sched_group() via call_rcu()
> will only lead to trouble in sched_offline_group() which also relies
> on (yet another) expired RCU grace period.

...with something like this (already mentioned in the code, btw):

On top of that, we need to wait yet another RCU grace period after
unregister_fair_sched_group() to ensure print_cfs_stats(), which might
run concurrently, always sees valid objects, i.e. not already free'd ones.

> 
> This patch survives Michal's reproducer[2] for 8h+ now, which used to
> trigger within minutes before.
> 
>   [1] https://lore.kernel.org/lkml/20211011172236.11223-1-mkoutny@suse.com/
>   [2] https://lore.kernel.org/lkml/20211102160228.GA57072@blackbody.suse.cz/
> 
> Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
> Reported-by: Kevin Tanguy <kevin.tanguy@corp.ovh.com>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> [peterz: shuffle code around a bit]
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/autogroup.c |    2 +-
>  kernel/sched/core.c      |   46 ++++++++++++++++++++++++++++++++++++----------
>  kernel/sched/fair.c      |    4 ++--
>  kernel/sched/rt.c        |   12 +++++++++---
>  kernel/sched/sched.h     |    3 ++-
>  5 files changed, 50 insertions(+), 17 deletions(-)
> 
> --- a/kernel/sched/autogroup.c
> +++ b/kernel/sched/autogroup.c
> @@ -31,7 +31,7 @@ static inline void autogroup_destroy(str
>  	ag->tg->rt_se = NULL;
>  	ag->tg->rt_rq = NULL;
>  #endif
> -	sched_offline_group(ag->tg);
> +	sched_release_group(ag->tg);
>  	sched_destroy_group(ag->tg);
>  }
>  
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9716,6 +9716,22 @@ static void sched_free_group(struct task
>  	kmem_cache_free(task_group_cache, tg);
>  }
>  
> +static void sched_free_group_rcu(struct rcu_head *rcu)
> +{
> +	sched_free_group(container_of(rcu, struct task_group, rcu));
> +}
> +
> +static void sched_unregister_group(struct task_group *tg)
> +{
> +	unregister_fair_sched_group(tg);
> +	unregister_rt_sched_group(tg);
> +	/*
> +	 * We have to wait for yet another RCU grace period to expire, as
> +	 * print_cfs_stats() might run concurrently.
> +	 */
> +	call_rcu(&tg->rcu, sched_free_group_rcu);
> +}
> +
>  /* allocate runqueue etc for a new task group */
>  struct task_group *sched_create_group(struct task_group *parent)
>  {
> @@ -9736,7 +9752,7 @@ struct task_group *sched_create_group(st
>  	return tg;
>  
>  err:
> -	sched_free_group(tg);
> +	sched_unregister_group(tg);

This can stay sched_free_group() as neither have the bandwidth timers
been started yet, nor was this tg made visible outside of this function.
So omitting the calls to destroy_{cfs,rt}_bandwidth() isn't a problem --
timers aren't running yet.

>  	return ERR_PTR(-ENOMEM);
>  }
>  
> @@ -9759,25 +9775,35 @@ void sched_online_group(struct task_grou
>  }
>  
>  /* rcu callback to free various structures associated with a task group */
> -static void sched_free_group_rcu(struct rcu_head *rhp)
> +static void sched_unregister_group_rcu(struct rcu_head *rhp)
>  {
>  	/* Now it should be safe to free those cfs_rqs: */
> -	sched_free_group(container_of(rhp, struct task_group, rcu));
> +	sched_unregister_group(container_of(rhp, struct task_group, rcu));
>  }
>  
>  void sched_destroy_group(struct task_group *tg)
>  {
>  	/* Wait for possible concurrent references to cfs_rqs complete: */
> -	call_rcu(&tg->rcu, sched_free_group_rcu);
> +	call_rcu(&tg->rcu, sched_unregister_group_rcu);
>  }
>  
> -void sched_offline_group(struct task_group *tg)
> +void sched_release_group(struct task_group *tg)
>  {
>  	unsigned long flags;
>  
> -	/* End participation in shares distribution: */
> -	unregister_fair_sched_group(tg);
> -
> +	/*
> +	 * Unlink first, to avoid walk_tg_tree_from() from finding us (via
> +	 * sched_cfs_period_timer()).
> +	 *
> +	 * For this to be effective, we have to wait for all pending users of
> +	 * this task group to leave their RCU critical section to ensure no new
> +	 * user will see our dying task group any more. Specifically ensure
> +	 * that tg_unthrottle_up() won't add decayed cfs_rq's to it.
> +	 *
> +	 * We therefore defer calling unregister_fair_sched_group() to
> +	 * sched_unregister_group() which is guarantied to get called only after the
> +	 * current RCU grace period has expired.
> +	 */
>  	spin_lock_irqsave(&task_group_lock, flags);
>  	list_del_rcu(&tg->list);
>  	list_del_rcu(&tg->siblings);
> @@ -9896,7 +9922,7 @@ static void cpu_cgroup_css_released(stru
>  {
>  	struct task_group *tg = css_tg(css);
>  
> -	sched_offline_group(tg);
> +	sched_release_group(tg);
>  }
>  
>  static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
> @@ -9906,7 +9932,7 @@ static void cpu_cgroup_css_free(struct c
>  	/*
>  	 * Relies on the RCU grace period between css_released() and this.
>  	 */
> -	sched_free_group(tg);
> +	sched_unregister_group(tg);
>  }
>  
>  /*
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11456,8 +11456,6 @@ void free_fair_sched_group(struct task_g
>  {
>  	int i;
>  
> -	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
> -
>  	for_each_possible_cpu(i) {
>  		if (tg->cfs_rq)
>  			kfree(tg->cfs_rq[i]);
> @@ -11551,6 +11549,8 @@ void unregister_fair_sched_group(struct
>  		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
>  		raw_spin_rq_unlock_irqrestore(rq, flags);
>  	}

> +
> +	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));

Move that hunk to the beginning of unregister_fair_sched_group() and
we're good.

>  }
>  
>  void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -137,13 +137,17 @@ static inline struct rq *rq_of_rt_se(str
>  	return rt_rq->rq;
>  }
>  
> -void free_rt_sched_group(struct task_group *tg)
> +void unregister_rt_sched_group(struct task_group *tg)
>  {
> -	int i;
> -
>  	if (tg->rt_se)
>  		destroy_rt_bandwidth(&tg->rt_bandwidth);
>  
> +}
> +
> +void free_rt_sched_group(struct task_group *tg)
> +{
> +	int i;
> +
>  	for_each_possible_cpu(i) {
>  		if (tg->rt_rq)
>  			kfree(tg->rt_rq[i]);
> @@ -250,6 +254,8 @@ static inline struct rt_rq *rt_rq_of_se(
>  	return &rq->rt;
>  }
>  
> +void unregister_rt_sched_group(struct task_group *tg) { }
> +
>  void free_rt_sched_group(struct task_group *tg) { }
>  
>  int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -488,6 +488,7 @@ extern void __refill_cfs_bandwidth_runti
>  extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
>  extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
>  
> +extern void unregister_rt_sched_group(struct task_group *tg);
>  extern void free_rt_sched_group(struct task_group *tg);
>  extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent);
>  extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
> @@ -503,7 +504,7 @@ extern struct task_group *sched_create_g
>  extern void sched_online_group(struct task_group *tg,
>  			       struct task_group *parent);
>  extern void sched_destroy_group(struct task_group *tg);
> -extern void sched_offline_group(struct task_group *tg);
> +extern void sched_release_group(struct task_group *tg);
>  
>  extern void sched_move_task(struct task_struct *tsk);
>  
> 

Thanks,
Mathias
