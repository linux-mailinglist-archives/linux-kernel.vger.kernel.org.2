Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FED30D93E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhBCLzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:55:16 -0500
Received: from foss.arm.com ([217.140.110.172]:38638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234210AbhBCLzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:55:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D9FFD6E;
        Wed,  3 Feb 2021 03:54:28 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D0533F73B;
        Wed,  3 Feb 2021 03:54:25 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
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
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <09367fac-5184-56d1-3c86-998b5f2af838@arm.com>
Date:   Wed, 3 Feb 2021 12:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129172727.GA30719@vingu-book>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2021 18:27, Vincent Guittot wrote:
> Le vendredi 29 janv. 2021 ï¿½ 11:33:00 (+0100), Vincent Guittot a ï¿½crit :
>> On Thu, 28 Jan 2021 at 16:09, Joel Fernandes <joel@joelfernandes.org> wrote:
>>>
>>> Hi Vincent,
>>>
>>> On Thu, Jan 28, 2021 at 8:57 AM Vincent Guittot
>>> <vincent.guittot@linaro.org> wrote:
>>>>> On Mon, Jan 25, 2021 at 03:42:41PM +0100, Vincent Guittot wrote:
>>>>>> On Fri, 22 Jan 2021 at 20:10, Joel Fernandes <joel@joelfernandes.org> wrote:
>>>>>>> On Fri, Jan 22, 2021 at 05:56:22PM +0100, Vincent Guittot wrote:
>>>>>>>> On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
>>>>>>>> <joel@joelfernandes.org> wrote:

[...]

>> The only point that I agree with, is that running
>> update_blocked_averages with preempt and irq off is not a good thing
>> because we don't manage the number of csf_rq to update and I'm going
>> to provide a patchset for this
> 
> The patch below moves the update of the blocked load of CPUs outside newidle_balance().
> 
> Instead, the update is done with the usual idle load balance update. I'm working on an
> additonnal patch that will select this cpu that is about to become idle, instead of a
> random idle cpu but this 1st step fixe the problem of lot of update in newly idle.

I'm trying to understand the need for this extra patch.

The patch below moves away from doing update_blocked_averages() (1) for
all CPUs in sched groups of the sched domain:

newidle_balance()->load_balance()->
find_busiest_group()->update_sd_lb_stats()->update_sg_lb_stats()

to:

calling (1) for CPUs in nohz.idle_cpus_mask in _nohz_idle_balance() via
update_nohz_stats() and for the ilb CPU.

newidle_balance() calls (1) for newidle CPU already.

What would be the benefit to choose newidle CPU as ilb CPU?

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
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
