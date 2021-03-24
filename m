Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7079D3479D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhCXNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhCXNom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:44:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFEAC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:44:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so1220093wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=J37VkdshrC8HSrLaq/97r1Z6wBQ8fO91WSA6CxyYaAQ=;
        b=N/pYUNSEAZiXnPvwkyQUDlOjh99h/mPd5ckp94E49an/gbP4bIV7UGvahm/YxqcvJO
         jiyrjAje2twXmQ54AP9Et1jO/ZznC9LTJ/y9q2+Ch3TNKou2WNUN49ntGi/jDhNyVx+z
         TMwiMZ4vqzVGoeqCAvrQbLdD/QZzkBO9SJ9wgVe1foquj0qa/Cx386PIXKq55bQ7oSk6
         na4CB1t8erCK/TWSnZ4yIBBirfnm8IoVPMF7SNifn/YcWvzEuL8zYupgR3JYlAMRtoyY
         HGJxEpyI8mUbjWXeDCVBuDsU7Dffr8R0Qmjycc2uofNH61DXy1repFTvdPYB0OynSwKe
         yW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J37VkdshrC8HSrLaq/97r1Z6wBQ8fO91WSA6CxyYaAQ=;
        b=ZhWHeRFk4rJ7EZFB2M6ctIQlR7gy9B8Oe7yNJe9rNr/1P7+4vKb95bn+wcUmU8ahn4
         OkLgNHQdNw9Kc0iEr1U0gcKmELRNiCs5pEVUoz+PdUVDJRkiMuk1a6jls3b3SCfu+LLA
         VAe614i+tGLkhNhn4byBodwl/5+Rp/XByLAE9SekcdQZgFTKkhpcJWyYoWtcnYEECEG7
         /eblcwMca+qhi9LjbjxHy0c6eod3/x1Lm0KUicIUjC/yqv56rXloeBSfpaEnhFydhgRS
         ZMAZeeg9cKmXbtbQB4A/Y2fshcmJJNlvW7PmBg6kzCxbSuT81U94TUdyzUI2RlpuzCOi
         WEiQ==
X-Gm-Message-State: AOAM531mSzgiIaCMNaK6uaErtiD1UE2v8lzRfJAAQ5wDmGwAMB+yfTRT
        ctDFMir3mDf+LFiMIKmoMpTCwA==
X-Google-Smtp-Source: ABdhPJyq05OZht0Dyt4xa6qqeEUCGuBbNPAtZQ0J8Z3K1V5xDSgoTS+8PgmJzVnL/u9gIYyKF1Uklg==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr3010390wmj.38.1616593480315;
        Wed, 24 Mar 2021 06:44:40 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:8538:7ab6:5bbd:db0a])
        by smtp.gmail.com with ESMTPSA id u20sm3459737wru.6.2021.03.24.06.44.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Mar 2021 06:44:39 -0700 (PDT)
Date:   Wed, 24 Mar 2021 14:44:37 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to
 update_blocked_averages() for NOHZ
Message-ID: <20210324134437.GA17675@vingu-book>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book>
 <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Le mardi 23 mars 2021 à 14:37:59 (-0700), Tim Chen a écrit :
> 
> 
> On 1/29/21 9:27 AM, Vincent Guittot wrote:
> > 
> > The patch below moves the update of the blocked load of CPUs outside newidle_balance().
> 
> On a well known database workload, we also saw a lot of overhead to do update_blocked_averages
> in newidle_balance().  So changes to reduce this overhead is much welcomed.
> 
> Turning on cgroup induces 9% throughput degradation on a 2 socket 40 cores per socket Icelake system.  
> 
> A big part of the overhead in our database workload comes from updating
> blocked averages in newidle_balance, caused by I/O threads making
> some CPUs go in and out of idle frequently in the following code path:
> 
> ----__blkdev_direct_IO_simple
>           |          
>           |----io_schedule_timeout
>           |          |          
>           |           ----schedule_timeout
>           |                     |          
>           |                      ----schedule
>           |                                |          
>           |                                 ----__schedule
>           |                                           |          
>           |                                            ----pick_next_task_fair
>           |                                                      |          
>           |                                                       ----newidle_balance
>           |                                                                 |          
>                                                                              ----update_blocked_averages
> 
> We found update_blocked_averages() now consumed most CPU time, eating up 2% of the CPU cycles once cgroup
> gets turned on.
> 
> I hacked up Joe's original patch to rate limit the update of blocked
> averages called from newidle_balance().  The 9% throughput degradation reduced to
> 5.4%.  We'll be testing Vincent's change to see if it can give
> similar performance improvement.
> 
> Though in our test environment, sysctl_sched_migration_cost was kept
> much lower (25000) compared to the default (500000), to encourage migrations to idle cpu
> and reduce latency.  We got quite a lot of calls to update_blocked_averages directly 
> and then try to load_balance in newidle_balance instead of relegating
> the responsibility to idle load balancer.  (See code snippet in newidle_balance below)  
> 
> 
>         if (this_rq->avg_idle < sysctl_sched_migration_cost ||       <-----sched_migration_cost check
>             !READ_ONCE(this_rq->rd->overload)) {
> 
>                 rcu_read_lock();
>                 sd = rcu_dereference_check_sched_domain(this_rq->sd);
>                 if (sd)
>                         update_next_balance(sd, &next_balance);
>                 rcu_read_unlock();
> 
>                 goto out;  <--- invoke idle load balancer
>         }
> 
>         raw_spin_unlock(&this_rq->lock);
> 
>         update_blocked_averages(this_cpu);
> 
> 	.... followed by load balance code ---
> 
 
> So the update_blocked_averages offload to idle_load_balancer in Vincent's patch is less 
> effective in this case with small sched_migration_cost.
> 
> Looking at the code a bit more, we don't actually load balance every time in this code path
> unless our avg_idle time exceeds some threshold.  Doing update_blocked_averages immediately 

IIUC your problem, we call update_blocked_averages() but because of:

		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
			update_next_balance(sd, &next_balance);
			break;
		}

the for_each_domain loop stops even before running load_balance on the 1st
sched domain level which means that update_blocked_averages() was called
unnecessarily. 

And this is even more true with a small sysctl_sched_migration_cost which allows newly
idle LB for very small this_rq->avg_idle. We could wonder why you set such a low value 
for sysctl_sched_migration_cost which is lower than the max_newidle_lb_cost of the
smallest domain but that's probably because of task_hot().

if avg_idle is lower than the sd->max_newidle_lb_cost of the 1st sched_domain, we should
skip spin_unlock/lock and for_each_domain() loop entirely

Maybe something like below:


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 76e33a70d575..08933e0d87ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10723,17 +10723,21 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
         */
        rq_unpin_lock(this_rq, rf);

+       rcu_read_lock();
+       sd = rcu_dereference_check_sched_domain(this_rq->sd);
+
        if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-           !READ_ONCE(this_rq->rd->overload)) {
+           !READ_ONCE(this_rq->rd->overload) ||
+           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

-               rcu_read_lock();
-               sd = rcu_dereference_check_sched_domain(this_rq->sd);
                if (sd)
                        update_next_balance(sd, &next_balance);
                rcu_read_unlock();

                goto out;
        }
+       rcu_read_unlock();
+

        raw_spin_unlock(&this_rq->lock);


> is only needed if we do call load_balance().  If we don't do any load balance in the code path,
> we can let the idle load balancer update the blocked averages lazily.
> 
> Something like the following perhaps on top of Vincent's patch?  We haven't really tested
> this change yet but want to see if this change makes sense to you.
> 
> Tim
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 63950d80fd0b..b93f5f52658a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10591,6 +10591,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	struct sched_domain *sd;
>  	int pulled_task = 0;
>  	u64 curr_cost = 0;
> +	bool updated_blocked_avg = false;
>  
>  	update_misfit_status(NULL, this_rq);
>  	/*
> @@ -10627,7 +10628,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	raw_spin_unlock(&this_rq->lock);
>  
> -	update_blocked_averages(this_cpu);
>  	rcu_read_lock();
>  	for_each_domain(this_cpu, sd) {
>  		int continue_balancing = 1;
> @@ -10639,6 +10639,11 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  		}
>  
>  		if (sd->flags & SD_BALANCE_NEWIDLE) {
> +			if (!updated_blocked_avg) {
> +				update_blocked_averages(this_cpu);
> +				updated_blocked_avg = true;
> +			}
> +
>  			t0 = sched_clock_cpu(this_cpu);
>  
>  			pulled_task = load_balance(this_cpu, this_rq,
>  
> 
