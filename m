Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88870308B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhA2RbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhA2R2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:28:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199B1C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:27:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m13so9628204wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vx+ymLIzoIGnTAVLW2PC+SZRlXgMqWC+NVC9BY3W+qo=;
        b=mbS2xQdL4qL2a5C01GNnk/sByctkQfkn3Qm+oQ6T3uEO2aOZWZWP2qads0ycyW/FJL
         SwfZNpgs9lchb+xljHJoc8nhUkVYKby/pFlFSfKVPf5NV38XESVKmNj3k6fE/9TdpJlZ
         Us8LcXDLnG5IJaULURMo74Hx6jQ6RjY7b1Fc03bGHvea8BJa2SMnhNtVC5d6h7N5tu8M
         rGmVFIpJZMJ4Gukm2J0M8yftm094FpDOFb4Ic5k5O9yoKjDJUM+aqH3ZjR+bRjHw3kTd
         GgP7JZjlGdLNMLU4e52r7jmzENxvj4R9b9v+V7IpdnRg0NyTftQskuyvKZlebSM/CQTt
         kXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vx+ymLIzoIGnTAVLW2PC+SZRlXgMqWC+NVC9BY3W+qo=;
        b=nU6zND7UH9aHXCNwzWqAWYp+Ov5Z+BIbAn72L6kzVJRI8rRfcPv8e6hLcMf0YMbusA
         B/IO0kZhI/pbvfUqVpd/GqWKuMUBAM3rqqaAL2h98N2MzejirAPfIrQ7uTuTh+NDz5x9
         3UogK/vI8ti5f7fbYnNG6/VHZ9Nv0tVhZH6L2N1sQan+8dGjDoLI45IDnAuNvQz5F6dj
         HJJ+sTcSLbT+mowXyGDbjSF9euvIqwoV2jjvBUGCk0ClN6fZIn8+GxA+LZUAMkG0yeWT
         fRSn76SfgmSqEAHXKWKlFqg+TDLfYUvY6bQc3laYVJCf1edAeBI73b5ZJPJTLIjrUhUb
         A8Ag==
X-Gm-Message-State: AOAM5338Qh0uwWMcpehx3kNPAPBiuRSwaDqQkeBRtdIegNiOYAu4iUXh
        IvrJgmtfXpAYHoVPfLMBJs9Ukw==
X-Google-Smtp-Source: ABdhPJyIK6cEvCrLctXISaMn9CH5FOsuPHe9zJIRcmHrxMT1p2iHlGkmNoiDMqgRvuw9c9JmSJQ3TA==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr5752519wrr.93.1611941250580;
        Fri, 29 Jan 2021 09:27:30 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:45f1:c7a4:f4c0:af])
        by smtp.gmail.com with ESMTPSA id o9sm13656205wrw.81.2021.01.29.09.27.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jan 2021 09:27:29 -0800 (PST)
Date:   Fri, 29 Jan 2021 18:27:27 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20210129172727.GA30719@vingu-book>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 29 janv. 2021 à 11:33:00 (+0100), Vincent Guittot a écrit :
> On Thu, 28 Jan 2021 at 16:09, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hi Vincent,
> >
> > On Thu, Jan 28, 2021 at 8:57 AM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > > > On Mon, Jan 25, 2021 at 03:42:41PM +0100, Vincent Guittot wrote:
> > > > > On Fri, 22 Jan 2021 at 20:10, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > On Fri, Jan 22, 2021 at 05:56:22PM +0100, Vincent Guittot wrote:
> > > > > > > On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
> > > > > > > <joel@joelfernandes.org> wrote:
> > > > > > > >
> > > > > > > > On an octacore ARM64 device running ChromeOS Linux kernel v5.4, I found
> > > > > > > > that there are a lot of calls to update_blocked_averages(). This causes
> > > > > > > > the schedule loop to slow down to taking upto 500 micro seconds at
> > > > > > > > times (due to newidle load balance). I have also seen this manifest in
> > > > > > > > the periodic balancer.
> > > > > > > >
> > > > > > > > Closer look shows that the problem is caused by the following
> > > > > > > > ingredients:
> > > > > > > > 1. If the system has a lot of inactive CGroups (thanks Dietmar for
> > > > > > > > suggesting to inspect /proc/sched_debug for this), this can make
> > > > > > > > __update_blocked_fair() take a long time.
> > > > > > >
> > > > > > > Inactive cgroups are removed from the list so they should not impact
> > > > > > > the duration
> > > > > >
> > > > > > I meant blocked CGroups. According to this code, a cfs_rq can be partially
> > > > > > decayed and not have any tasks running on it but its load needs to be
> > > > > > decayed, correct? That's what I meant by 'inactive'. I can reword it to
> > > > > > 'blocked'.
> > > > >
> > > > > How many blocked cgroups have you got ?
> > > >
> > > > I put a counter in for_each_leaf_cfs_rq_safe() { } to count how many times
> > > > this loop runs per new idle balance. When the problem happens I see this loop
> > > > run 35-40 times (for one single instance of newidle balance). So in total
> > > > there are at least these many cfs_rq load updates.
> > >
> > > Do you mean that you have 35-40 cgroups ? Or the 35-40 includes all CPUs ?
> >
> > All CPUs.
> >
> > > > I also see that new idle balance can be called 200-500 times per second.
> > >
> > > This is not surprising because newidle_balance() is called every time
> > > the CPU is about to become idle
> >
> > Sure.
> >
> > > > > >
> > > > > >                   * There can be a lot of idle CPU cgroups.  Don't let fully
> > > > > >                   * decayed cfs_rqs linger on the list.
> > > > > >                   */
> > > > > >                  if (cfs_rq_is_decayed(cfs_rq))
> > > > > >                          list_del_leaf_cfs_rq(cfs_rq);
> > > > > >
> > > > > > > > 2. The device has a lot of CPUs in a cluster which causes schedutil in a
> > > > > > > > shared frequency domain configuration to be slower than usual. (the load
> > > > > > >
> > > > > > > What do you mean exactly by it causes schedutil to be slower than usual ?
> > > > > >
> > > > > > sugov_next_freq_shared() is order number of CPUs in the a cluster. This
> > > > > > system is a 6+2 system with 6 CPUs in a cluster. schedutil shared policy
> > > > > > frequency update needs to go through utilization of other CPUs in the
> > > > > > cluster. I believe this could be adding to the problem but is not really
> > > > > > needed to optimize if we can rate limit the calls to update_blocked_averages
> > > > > > to begin with.
> > > > >
> > > > > Qais mentioned half of the time being used by
> > > > > sugov_next_freq_shared(). Are there any frequency changes resulting in
> > > > > this call ?
> > > >
> > > > I do not see a frequency update happening at the time of the problem. However
> > > > note that sugov_iowait_boost() does run even if frequency is not being
> > > > updated. IIRC, this function is also not that light weight and I am not sure
> > > > if it is a good idea to call this that often.
> > >
> > > Scheduler can't make any assumption about how often schedutil/cpufreq
> > > wants to be called. Some are fast and straightforward and can be
> > > called very often to adjust frequency; Others can't handle much
> > > updates. The rate limit mechanism in schedutil and io-boost should be
> > > there for such purpose.
> >
> > Sure, I know that's the intention.
> >
> > > > > > > > average updates also try to update the frequency in schedutil).
> > > > > > > >
> > > > > > > > 3. The CPU is running at a low frequency causing the scheduler/schedutil
> > > > > > > > code paths to take longer than when running at a high CPU frequency.
> > > > > > >
> > > > > > > Low frequency usually means low utilization so it should happen that much.
> > > > > >
> > > > > > It happens a lot as can be seen with schbench. It is super easy to reproduce.
> > > > >
> > > > > Happening a lot in itself is not a problem if there is nothing else to
> > > > > do so it's not a argument in itself
> > > >
> > > > It is a problem - it shows up in the preempt off critical section latency
> > >
> > > But this point is not related to the point above which is about how
> > > often it happens.
> >
> > It is related. A bad thing happening quite often is worse than a bad
> > thing happening infrequently. I agree it is not a root cause fix, but
> > it makes things "better".
> >
> > > > tracer. Are you saying its Ok for preemption to be disabled on system for 500
> > > > micro seconds?  That hurts real-time applications (audio etc).
> > >
> > > So. Is your problem related to real-time applications (audio etc) ?
> >
> > Yes it is. I don't have a reproducer and it could be the audio
> > buffering will hide the problem. But that doesn't mean that there is
> > no problem or that we cannot improve things. There will also likely be
> > power consumption improvement.
> >
> > > > > So why is it a problem for you ? You are mentioning newly idle load
> > > > > balance so I assume that your root problem is the scheduling delay
> > > > > generated by the newly idle load balance which then calls
> > > > > update_blocked_averages
> > > >
> > > > Yes, the new idle balance is when I see it happen quite often. I do see it
> > > > happen with other load balance as well, but it not that often as those LB
> > > > don't run as often as new idle balance.
> > >
> > > The update of average blocked load has been added in newidle_balance
> > > to take advantage of the cpu becoming idle but it seems to create a
> > > long preempt off sequence. I 'm going to prepare a patch to move it
> > > out the schedule path.
> >
> > Ok thanks, that would really help!
> >
> > > > > rate limiting the call to update_blocked_averages() will only reduce
> > > > > the number of time it happens but it will not prevent it to happen.
> > > >
> > > > Sure, but soft real-time issue can tolerate if the issue does not happen very
> > > > often. In this case though, it is frequent.
> > >
> > > Could you provide details of the problem that you are facing ? It's
> > > not clear for me what happens in your case at the end. Have you got an
> > > audio glitch as an example?
> > >
> > > "Not often" doesn't really give any clue.
> >
> > I believe from my side I have provided details. I shared output from a
> > function graph tracer and schbench micro benchmark clearly showing the
> > issue and improvements. Sorry, I don't have a real-world reproducer
> 
> In fact I disagree and I'm not sure that your results show the right
> problem but just a side effect related to your system.
> 
> With schbench -t 2 -m 2 -r 5, the test runs 1 task per CPU and newidle
> balance should never be triggered because tasks will get an idle cpus
> everytime. When I run schbench -t 3 -m 2 -r 5 (in order to get 8
> threads on my 8 cpus system), all threads directly wake up on an idle
> cpu and newidle balance is never involved. As a result, the schbench
> results are not impacted by newidle_balance whatever its duration.
> This means that a problem in newidle_balance doesn't impact schbench
> results with a correct task placement. This also means that in your
> case, some threads are placed on the same cpu and wait to be scheduled
> and finally a lot of things can generate the increased delay.... If
> you look at your results for schbench -t 2 -m 2 -r 5: The  *99.0th:
> 12656 (8 samples) shows a delayed of around 12ms which is the typical
> running time slice of a task when several tasks are fighting for the
> same cpu and one has to wait. So this results does not reflect the
> duration of newidle balance but instead that the task placement was
> wrong and one task has to wait before running. Your RFC patch probably
> changes the dynamic and as a result the task placement but it does not
> save 12ms and is irrelevant regarding the problem that you raised
> about the duration of update_blocked_load.
> 
> If I run schbench -t 3 -m 2 -r 5 on a dragonboard 845 (4 little, 4
> big) with schedutil and EAS enabled:
> /home/linaro/Bin/schbench -t 3 -m 2 -r 5
> Latency percentiles (usec) runtime 5 (s) (318 total samples)
> 50.0th: 315 (159 samples)
> 75.0th: 735 (80 samples)
> 90.0th: 773 (48 samples)
> 95.0th: 845 (16 samples)
> *99.0th: 12336 (12 samples)
> 99.5th: 15408 (2 samples)
> 99.9th: 17504 (1 samples)
> min=4, max=17473
> 
> I have similar results and a quick look at the trace shows that 2
> tasks are fighting for the same cpu whereas there are idle cpus. Then
> If I use another cpufreq governor than schedutil like ondemand as an
> example, the EAS is disabled and the results becomes:
> /home/linaro/Bin/schbench -t 3 -m 2 -r 5
> Latency percentiles (usec) runtime 5 (s) (318 total samples)
> 50.0th: 232 (159 samples)
> 75.0th: 268 (80 samples)
> 90.0th: 292 (49 samples)
> 95.0th: 307 (15 samples)
> *99.0th: 394 (12 samples)
> 99.5th: 397 (2 samples)
> 99.9th: 400 (1 samples)
> min=114, max=400
> 
> So a quick and wrong conclusion could be to say that you should disable EAS ;-)
> 
> All that to say that your schbench's results are not relevant and I
> disagree when you said that you have provided all details of your
> problem.
> 
> Then, your function graph shows a half millisecond duration but there
> are no details about the context. It seems that your trace happens
> after that sugov just changed the freq. But it would be not surprising
> to have such a large duration when running at the lowest
> capacity/frequency of the system as an example.
> 
> All that to say that the main reason of my questions is just to make
> sure that the problem is fully understood and the results are
> relevants, which doesn't seem to be the case for schbench at least.
> 
> The only point that I agree with, is that running
> update_blocked_averages with preempt and irq off is not a good thing
> because we don't manage the number of csf_rq to update and I'm going
> to provide a patchset for this

The patch below moves the update of the blocked load of CPUs outside newidle_balance().

Instead, the update is done with the usual idle load balance update. I'm working on an
additonnal patch that will select this cpu that is about to become idle, instead of a
random idle cpu but this 1st step fixe the problem of lot of update in newly idle.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 197a51473e0c..8200b1d4df3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7421,8 +7421,6 @@ enum migration_type {
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
 #define LBF_SOME_PINNED	0x08
-#define LBF_NOHZ_STATS	0x10
-#define LBF_NOHZ_AGAIN	0x20
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -8426,9 +8424,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
 
-		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
-			env->flags |= LBF_NOHZ_AGAIN;
-
 		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->group_runnable += cpu_runnable(rq);
@@ -8969,11 +8964,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats tmp_sgs;
 	int sg_status = 0;
 
-#ifdef CONFIG_NO_HZ_COMMON
-	if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
-		env->flags |= LBF_NOHZ_STATS;
-#endif
-
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
 		int local_group;
@@ -9010,15 +9000,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	/* Tag domain that child domain prefers tasks go to siblings first */
 	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
 
-#ifdef CONFIG_NO_HZ_COMMON
-	if ((env->flags & LBF_NOHZ_AGAIN) &&
-	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
-
-		WRITE_ONCE(nohz.next_blocked,
-			   jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
-	}
-#endif
-
 	if (env->sd->flags & SD_NUMA)
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
 
@@ -10547,14 +10528,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 		return;
 
 	raw_spin_unlock(&this_rq->lock);
-	/*
-	 * This CPU is going to be idle and blocked load of idle CPUs
-	 * need to be updated. Run the ilb locally as it is a good
-	 * candidate for ilb instead of waking up another idle CPU.
-	 * Kick an normal ilb if we failed to do the update.
-	 */
-	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
-		kick_ilb(NOHZ_STATS_KICK);
+	kick_ilb(NOHZ_STATS_KICK);
 	raw_spin_lock(&this_rq->lock);
 }
 
@@ -10616,8 +10590,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
 
-		nohz_newidle_balance(this_rq);
-
 		goto out;
 	}
 
@@ -10683,6 +10655,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
+	else
+		nohz_newidle_balance(this_rq);
 
 	rq_repin_lock(this_rq, rf);
 
-- 
2.17.1


> 
> > for this.
> >
> > > Also update_blocked_averages was supposed called in newlyidle_balance
> > > when the coming idle duration is expected to be long enough
> >
> > No, we do not want the schedule loop to take half a millisecond.
> 
> keep in mind that you are scaling frequency so everything takes time
> at lowest frequency/capacity ...
> 
> >
> > > > > IIUC, your real problem is that newidle_balance is running whereas a
> > > > > task is about to wake up on the cpu and we don't abort quickly during
> > > > > this load_balance
> > > >
> > > > Yes.
> > > >
> > > > > so we could also try to abort earlier in case of newly idle load balance
> > > >
> > > > I think interrupts are disabled when the load balance runs, so there's no way
> > > > for say an audio interrupt to even run in order to wake up a task. How would
> > > > you know to abort the new idle load balance?
> > > >
> > > > Could you elaborate more also on the drawback of the rate limiting patch we
> > > > posted? Do you see a side effect?
> > >
> > > Your patch just tries to hide your problem and not to solve the root cause.
> >
> > Agreed, the solution presented is a band aid and not a proper fix. It
> > was just intended to illustrate the problem and start a discussion. I
> > should have marked it RFC for sure.
> >
> > thanks!
> >
> > - Joel
