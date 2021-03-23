Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09694346B35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhCWViR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:38:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:22783 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233615AbhCWViC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:38:02 -0400
IronPort-SDR: WGIp1a7ms5mgGnSzRpnmeUBvHz1XVa0kNmQkA/Qw3sSLgLFuUHJkEloYesVax45FoBwKFSXIz9
 MeJU/BTk4a4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="254570958"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="254570958"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 14:38:01 -0700
IronPort-SDR: VAdvdFdEJldWUrJzV9R65qdpWz8CtQ0f6g+Mw0vulM0WBIYTaJadyhStwa0UoY+d5o0/S6J9iw
 ZrerXI4uvrAw==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="607880678"
Received: from schen9-mobl.amr.corp.intel.com ([10.255.229.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 14:38:00 -0700
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>
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
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
Date:   Tue, 23 Mar 2021 14:37:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210129172727.GA30719@vingu-book>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/21 9:27 AM, Vincent Guittot wrote:
> 
> The patch below moves the update of the blocked load of CPUs outside newidle_balance().

On a well known database workload, we also saw a lot of overhead to do update_blocked_averages
in newidle_balance().  So changes to reduce this overhead is much welcomed.

Turning on cgroup induces 9% throughput degradation on a 2 socket 40 cores per socket Icelake system.  

A big part of the overhead in our database workload comes from updating
blocked averages in newidle_balance, caused by I/O threads making
some CPUs go in and out of idle frequently in the following code path:

----__blkdev_direct_IO_simple
          |          
          |----io_schedule_timeout
          |          |          
          |           ----schedule_timeout
          |                     |          
          |                      ----schedule
          |                                |          
          |                                 ----__schedule
          |                                           |          
          |                                            ----pick_next_task_fair
          |                                                      |          
          |                                                       ----newidle_balance
          |                                                                 |          
                                                                             ----update_blocked_averages

We found update_blocked_averages() now consumed most CPU time, eating up 2% of the CPU cycles once cgroup
gets turned on.

I hacked up Joe's original patch to rate limit the update of blocked
averages called from newidle_balance().  The 9% throughput degradation reduced to
5.4%.  We'll be testing Vincent's change to see if it can give
similar performance improvement.

Though in our test environment, sysctl_sched_migration_cost was kept
much lower (25000) compared to the default (500000), to encourage migrations to idle cpu
and reduce latency.  We got quite a lot of calls to update_blocked_averages directly 
and then try to load_balance in newidle_balance instead of relegating
the responsibility to idle load balancer.  (See code snippet in newidle_balance below)  


        if (this_rq->avg_idle < sysctl_sched_migration_cost ||       <-----sched_migration_cost check
            !READ_ONCE(this_rq->rd->overload)) {

                rcu_read_lock();
                sd = rcu_dereference_check_sched_domain(this_rq->sd);
                if (sd)
                        update_next_balance(sd, &next_balance);
                rcu_read_unlock();

                goto out;  <--- invoke idle load balancer
        }

        raw_spin_unlock(&this_rq->lock);

        update_blocked_averages(this_cpu);

	.... followed by load balance code ---


So the update_blocked_averages offload to idle_load_balancer in Vincent's patch is less 
effective in this case with small sched_migration_cost.

Looking at the code a bit more, we don't actually load balance every time in this code path
unless our avg_idle time exceeds some threshold.  Doing update_blocked_averages immediately 
is only needed if we do call load_balance().  If we don't do any load balance in the code path,
we can let the idle load balancer update the blocked averages lazily.

Something like the following perhaps on top of Vincent's patch?  We haven't really tested
this change yet but want to see if this change makes sense to you.

Tim

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 63950d80fd0b..b93f5f52658a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10591,6 +10591,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	struct sched_domain *sd;
 	int pulled_task = 0;
 	u64 curr_cost = 0;
+	bool updated_blocked_avg = false;
 
 	update_misfit_status(NULL, this_rq);
 	/*
@@ -10627,7 +10628,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	raw_spin_unlock(&this_rq->lock);
 
-	update_blocked_averages(this_cpu);
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		int continue_balancing = 1;
@@ -10639,6 +10639,11 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		}
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
+			if (!updated_blocked_avg) {
+				update_blocked_averages(this_cpu);
+				updated_blocked_avg = true;
+			}
+
 			t0 = sched_clock_cpu(this_cpu);
 
 			pulled_task = load_balance(this_cpu, this_rq,
 

