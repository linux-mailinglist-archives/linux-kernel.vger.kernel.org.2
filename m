Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8730E3AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhBCT5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBCT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:57:18 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55119C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:56:38 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id n8so654402qtp.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WbHKCeun4LZ1lqhxKUNNLeH/PFHuKTH7ogRBtILzOXA=;
        b=V4WcXqEeY5HaXWvXtHi4aq2pHTF0MbNoa2eLSBFJO9xrS1j9OZmzrPNxjRVTIlL+Jr
         4DAwMaIDrCW5gEsVrU9xmtRc6exC01BNuo/wxezc8H/9T/poiclYpn1CLcFARta6mbWf
         l1A5ZEGjrHjA3weC/V1WoBPMCZknUDcPx+2Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WbHKCeun4LZ1lqhxKUNNLeH/PFHuKTH7ogRBtILzOXA=;
        b=HD2h7As7a4b6tOzBsXZcr6ZqidQM1lYX57y7Nzu6GMwmAh/0IGXXtRKGkl3+Dl7Bmu
         oAnYxfCm3RTgbgrh8+4Q/YWC5F8FrvwHTJZkMlbpUKyVp+zyU9+vaaUDYPwoHR1Q3qG+
         r3lyda2aBnewGdU+F7+9dDEhMC2PGoWViUz8b2Pb8/yJJpq31SHfT1PM7Sn9sfsVVr9N
         8HNGW1fsnkWeLlw2kpj5N1uA1RmuI0Y81JGpDXMMRd4vR9hBDXpQ7MHa1ABqjo7UhoO+
         hXXMePstU5fpeur20etmW0rS8S88EY9u4ckBZQ23rMpCoZVVgZuqI7ok7AblcRApCKdm
         YqtQ==
X-Gm-Message-State: AOAM5330IEjmg+hzJ4d0RjScsHbOd+sDDllGkPw1khJy6Q/uKvLoBV8w
        1RMsOWKXAEROnET/KuS33bpLHw==
X-Google-Smtp-Source: ABdhPJwFd6MWwfzPj4Lr0iUp9S35ethbOrep3tSVVZcYwjiVpufU4q0nJnrbwT0HgJ692J1CIWLCtg==
X-Received: by 2002:ac8:524f:: with SMTP id y15mr4105755qtn.266.1612382197485;
        Wed, 03 Feb 2021 11:56:37 -0800 (PST)
Received: from localhost ([2620:15c:6:411:79c3:6d69:c53f:33bd])
        by smtp.gmail.com with ESMTPSA id j11sm2690375qkm.47.2021.02.03.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 11:56:36 -0800 (PST)
Date:   Wed, 3 Feb 2021 14:56:36 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to
 update_blocked_averages() for NOHZ
Message-ID: <YBr/9BqaofrBKjll@google.com>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129172727.GA30719@vingu-book>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 06:27:27PM +0100, Vincent Guittot wrote:
[...]
> > update_blocked_averages with preempt and irq off is not a good thing
> > because we don't manage the number of csf_rq to update and I'm going
> > to provide a patchset for this
> 
> The patch below moves the update of the blocked load of CPUs outside newidle_balance().
> 
> Instead, the update is done with the usual idle load balance update. I'm working on an
> additonnal patch that will select this cpu that is about to become idle, instead of a
> random idle cpu but this 1st step fixe the problem of lot of update in newly idle.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

I confirmed that with this patch, I don't see the preemptoff issues related
to update_blocked_averages() anymore (tested using preemptoff tracer).

I went through the patch and it looks correct to me, I will further review it
and await further reviews from others as well, and then backport the patch to
our kernels. Thanks Vince and everyone!

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel



> ---
>  kernel/sched/fair.c | 32 +++-----------------------------
>  1 file changed, 3 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 197a51473e0c..8200b1d4df3d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7421,8 +7421,6 @@ enum migration_type {
>  #define LBF_NEED_BREAK	0x02
>  #define LBF_DST_PINNED  0x04
>  #define LBF_SOME_PINNED	0x08
> -#define LBF_NOHZ_STATS	0x10
> -#define LBF_NOHZ_AGAIN	0x20
>  
>  struct lb_env {
>  	struct sched_domain	*sd;
> @@ -8426,9 +8424,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		struct rq *rq = cpu_rq(i);
>  
> -		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
> -			env->flags |= LBF_NOHZ_AGAIN;
> -
>  		sgs->group_load += cpu_load(rq);
>  		sgs->group_util += cpu_util(i);
>  		sgs->group_runnable += cpu_runnable(rq);
> @@ -8969,11 +8964,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	struct sg_lb_stats tmp_sgs;
>  	int sg_status = 0;
>  
> -#ifdef CONFIG_NO_HZ_COMMON
> -	if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
> -		env->flags |= LBF_NOHZ_STATS;
> -#endif
> -
>  	do {
>  		struct sg_lb_stats *sgs = &tmp_sgs;
>  		int local_group;
> @@ -9010,15 +9000,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	/* Tag domain that child domain prefers tasks go to siblings first */
>  	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
>  
> -#ifdef CONFIG_NO_HZ_COMMON
> -	if ((env->flags & LBF_NOHZ_AGAIN) &&
> -	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
> -
> -		WRITE_ONCE(nohz.next_blocked,
> -			   jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
> -	}
> -#endif
> -
>  	if (env->sd->flags & SD_NUMA)
>  		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
>  
> @@ -10547,14 +10528,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
>  		return;
>  
>  	raw_spin_unlock(&this_rq->lock);
> -	/*
> -	 * This CPU is going to be idle and blocked load of idle CPUs
> -	 * need to be updated. Run the ilb locally as it is a good
> -	 * candidate for ilb instead of waking up another idle CPU.
> -	 * Kick an normal ilb if we failed to do the update.
> -	 */
> -	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
> -		kick_ilb(NOHZ_STATS_KICK);
> +	kick_ilb(NOHZ_STATS_KICK);
>  	raw_spin_lock(&this_rq->lock);
>  }
>  
> @@ -10616,8 +10590,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  			update_next_balance(sd, &next_balance);
>  		rcu_read_unlock();
>  
> -		nohz_newidle_balance(this_rq);
> -
>  		goto out;
>  	}
>  
> @@ -10683,6 +10655,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	if (pulled_task)
>  		this_rq->idle_stamp = 0;
> +	else
> +		nohz_newidle_balance(this_rq);
>  
>  	rq_repin_lock(this_rq, rf);
>  
> -- 
> 2.17.1
> 
> 
> > 
> > > for this.
> > >
> > > > Also update_blocked_averages was supposed called in newlyidle_balance
> > > > when the coming idle duration is expected to be long enough
> > >
> > > No, we do not want the schedule loop to take half a millisecond.
> > 
> > keep in mind that you are scaling frequency so everything takes time
> > at lowest frequency/capacity ...
> > 
> > >
> > > > > > IIUC, your real problem is that newidle_balance is running whereas a
> > > > > > task is about to wake up on the cpu and we don't abort quickly during
> > > > > > this load_balance
> > > > >
> > > > > Yes.
> > > > >
> > > > > > so we could also try to abort earlier in case of newly idle load balance
> > > > >
> > > > > I think interrupts are disabled when the load balance runs, so there's no way
> > > > > for say an audio interrupt to even run in order to wake up a task. How would
> > > > > you know to abort the new idle load balance?
> > > > >
> > > > > Could you elaborate more also on the drawback of the rate limiting patch we
> > > > > posted? Do you see a side effect?
> > > >
> > > > Your patch just tries to hide your problem and not to solve the root cause.
> > >
> > > Agreed, the solution presented is a band aid and not a proper fix. It
> > > was just intended to illustrate the problem and start a discussion. I
> > > should have marked it RFC for sure.
> > >
> > > thanks!
> > >
> > > - Joel
