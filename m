Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A811307B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhA1Q6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:58:46 -0500
Received: from foss.arm.com ([217.140.110.172]:35640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhA1Q6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:58:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2819913A1;
        Thu, 28 Jan 2021 08:57:35 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45BC83F7C3;
        Thu, 28 Jan 2021 08:57:33 -0800 (PST)
Date:   Thu, 28 Jan 2021 16:57:30 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
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
Message-ID: <20210128165730.dg7zpogob5viyhng@e107158-lin>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/21 10:09, Joel Fernandes wrote:
> > > > Qais mentioned half of the time being used by
> > > > sugov_next_freq_shared(). Are there any frequency changes resulting in
> > > > this call ?
> > >
> > > I do not see a frequency update happening at the time of the problem. However
> > > note that sugov_iowait_boost() does run even if frequency is not being
> > > updated. IIRC, this function is also not that light weight and I am not sure
> > > if it is a good idea to call this that often.
> >
> > Scheduler can't make any assumption about how often schedutil/cpufreq
> > wants to be called. Some are fast and straightforward and can be
> > called very often to adjust frequency; Others can't handle much
> > updates. The rate limit mechanism in schedutil and io-boost should be
> > there for such purpose.
> 
> Sure, I know that's the intention.

How about the below patch to help with reducing the impact of
sugov_update_shared()?

I basically made sure it'll bail out immediately if it gets 2 calls within the
defined rate_limit_us value.

And tweaked the way we call cpufreq_update_util() from
update_blocked_averages() too so that we first update blocked load on all cpus,
then we ask for the frequency update. Combined with above this should result to
a single call to sugov_update_shared() for each policy. Each call should see
the final state of what is the load really is.

Only compile tested!

Thanks

--
Qais Yousef

----->8-----


diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 6931f0cdeb80..bd83e9343749 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -109,7 +109,6 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 		return false;
 
 	sg_policy->next_freq = next_freq;
-	sg_policy->last_freq_update_time = time;
 
 	return true;
 }
@@ -554,20 +553,23 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	raw_spin_lock(&sg_policy->update_lock);
 
+	ignore_dl_rate_limit(sg_cpu, sg_policy);
+
+	if (!sugov_should_update_freq(sg_policy, time))
+		goto out;
+
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	ignore_dl_rate_limit(sg_cpu, sg_policy);
-
-	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_cpu, time);
+	next_f = sugov_next_freq_shared(sg_cpu, time);
 
-		if (sg_policy->policy->fast_switch_enabled)
-			sugov_fast_switch(sg_policy, time, next_f);
-		else
-			sugov_deferred_update(sg_policy, time, next_f);
-	}
+	if (sg_policy->policy->fast_switch_enabled)
+		sugov_fast_switch(sg_policy, time, next_f);
+	else
+		sugov_deferred_update(sg_policy, time, next_f);
 
+	sg_policy->last_freq_update_time = time;
+out:
 	raw_spin_unlock(&sg_policy->update_lock);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..47bd8be03a6c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8033,7 +8033,7 @@ static unsigned long task_h_load(struct task_struct *p)
 }
 #endif
 
-static void update_blocked_averages(int cpu)
+static void update_blocked_averages(int cpu, bool update_freq)
 {
 	bool decayed = false, done = true;
 	struct rq *rq = cpu_rq(cpu);
@@ -8046,7 +8046,7 @@ static void update_blocked_averages(int cpu)
 	decayed |= __update_blocked_fair(rq, &done);
 
 	update_blocked_load_status(rq, !done);
-	if (decayed)
+	if (decayed && update_freq)
 		cpufreq_update_util(rq, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -8384,7 +8384,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
 	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
 		return true;
 
-	update_blocked_averages(cpu);
+	update_blocked_averages(cpu, false);
 
 	return rq->has_blocked_load;
 #else
@@ -8454,6 +8454,15 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		}
 	}
 
+	/*
+	 * We did a bunch a blocked average updates, let cpufreq know about
+	 * them in one go. For system with a lot of cpus on a frequency domain
+	 * this will make sure we take all the changes that affects the policy
+	 * in one go.
+	 */
+	for_each_cpu_and(i, sched_group_span(group), env->cpus)
+		cpufreq_update_util(cpu_rq(i), 0);
+
 	/* Check if dst CPU is idle and preferred to this group */
 	if (env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE &&
@@ -10464,7 +10473,7 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 
 	/* Newly idle CPU doesn't need an update */
 	if (idle != CPU_NEWLY_IDLE) {
-		update_blocked_averages(this_cpu);
+		update_blocked_averages(this_cpu, false);
 		has_blocked_load |= this_rq->has_blocked_load;
 	}
 
@@ -10478,6 +10487,15 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	ret = true;
 
 abort:
+	/*
+	 * We did a bunch a blocked average updates, let cpufreq know about
+	 * them in one go. For system with a lot of cpus on a frequency domain
+	 * this will make sure we take all the changes that affects the policy
+	 * in one go.
+	 */
+	for_each_cpu(balance_cpu, nohz.idle_cpus_mask)
+		cpufreq_update_util(cpu_rq(balance_cpu), 0);
+
 	/* There is still blocked load, enable periodic update */
 	if (has_blocked_load)
 		WRITE_ONCE(nohz.has_blocked, 1);
@@ -10603,7 +10621,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	raw_spin_unlock(&this_rq->lock);
 
-	update_blocked_averages(this_cpu);
+	update_blocked_averages(this_cpu, true);
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		int continue_balancing = 1;
@@ -10691,7 +10709,7 @@ static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 		return;
 
 	/* normal load balance */
-	update_blocked_averages(this_rq->cpu);
+	update_blocked_averages(this_rq->cpu, true);
 	rebalance_domains(this_rq, idle);
 }
 
