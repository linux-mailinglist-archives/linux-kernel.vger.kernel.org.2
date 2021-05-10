Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9337997E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhEJWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:00:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:59504 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhEJWAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:00:46 -0400
IronPort-SDR: yYmWw7mgOPyB5XER8hZNsb8uD6l/zVvD4Ttad2GFeeZ3reOjPJGsOHq874QTDIUV295+n+HKIy
 ZbUs8XexOPQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="197314972"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="197314972"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 14:59:41 -0700
IronPort-SDR: D/HVooyKbNssXp0NwS2XiCVZnvRmu036j47J+n1mSn7Vza8xdJ90LmLQMTwwo3y53iJ7bcLQaJ
 J6DjxhAnPgfA==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="461570180"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.130.234])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 14:59:40 -0700
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book>
 <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
 <20210324134437.GA17675@vingu-book>
 <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
 <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
 <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com>
 <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
 <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com>
 <CAKfTPtDJaTr_HR2t=9CQ-9x6keu-qzx6okci92AdW5cJG8J9zg@mail.gmail.com>
 <2d2294ce-f1d1-f827-754b-4541c1b43be8@linux.intel.com>
Message-ID: <ade18978-cd67-6215-28f0-4857c66a99fb@linux.intel.com>
Date:   Mon, 10 May 2021 14:59:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2d2294ce-f1d1-f827-754b-4541c1b43be8@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/21 10:59 AM, Tim Chen wrote:

>>>     11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
>>>     11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>>>     11.642 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>>>     11.645 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>>>     11.977 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>>>     12.003 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>>>     12.015 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>>>     12.043 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>>>     12.567 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73a
>>>     13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
>>>     13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>>>     14.003 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>>>     14.159 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>>>     14.203 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>>>     14.223 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>>>     14.301 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>>>     14.504 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73c

>> I don't know exactly what you track with "next_balance=" in
> 
> It is the rq->next_balance value as we enter the newidle_balance function.
> 
>> probe:newidle_balance but it always starts with the same value
>> 0x1004fb76c in the future to finish with a value 0x1004fb731 in the
>> past. 
> 
> This indeed is odd as the next_balance should move forward and not backward.


Vincent,

I found a bug in newidle_balance() that moved the next balance time
backward.  I fixed it in patch 1 below.  This corrects the
next_balance time update and we now have proper load balance rate limiting.

After putting in the other two changes previously discussed with you (patch 2 and 3 below), 
I see very good improvement (about +5%) in the database workload I was investigating.
The costly update_blocked_averages() function is called much less frequently and consumed 
only 0.2% of cpu cycles instead of 2.6% before the changes.

Including all three patches here together for easier review.  The patches
apply to the tip tree's sched/core branch.

Thanks.

Tim

--->8---

From 848eb8f45b53b45cacf70022c98f632daabefe77 Mon Sep 17 00:00:00 2001
Message-Id: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Fri, 7 May 2021 14:19:47 -0700
Subject: [PATCH 1/3] sched: Fix rq->next_balance time going backward

In traces on newidle_balance(), this_rq->next_balance
time goes backward from time to time, e.g.

11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c

This was due to newidle_balance() updated this_rq->next_balance
to an earlier time than its current value. The real intention
was to make sure next_balance move this_rq->next_balance forward
in its update:

out:
	/* Move the next balance forward */
	if (time_after(this_rq->next_balance, next_balance))
		this_rq->next_balance = next_balance;

The actual outcome was moving this_rq->next_balance backward,
in the wrong direction.

Fix the incorrect check on next_balance causing the problem.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d75af1ecfb4..b0b5698b2184 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10681,7 +10681,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 out:
 	/* Move the next balance forward */
-	if (time_after(this_rq->next_balance, next_balance))
+	if (time_after(next_balance, this_rq->next_balance))
 		this_rq->next_balance = next_balance;
 
 	if (pulled_task)
-- 
2.20.1


From f2c9af4af6438ad79076e1a664003dc01ad4fdf0 Mon Sep 17 00:00:00 2001
Message-Id: <f2c9af4af6438ad79076e1a664003dc01ad4fdf0.1620677280.git.tim.c.chen@linux.intel.com>
In-Reply-To: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
References: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 7 May 2021 14:38:10 -0700
Subject: [PATCH 2/3] sched: Skip update_blocked_averages if we are defering
 load balance

In newidle_balance(), the scheduler skips load balance to the new idle cpu when sd is this_rq and when

   this_rq->avg_idle < sd->max_newidle_lb_cost

Doing a costly call to update_blocked_averages() will
not be useful and simply adds overhead when this condition is true.

Check the condition early in newidle_balance() to skip update_blocked_averages()
when possible.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b0b5698b2184..f828b75488a0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10612,17 +10612,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 */
 	rq_unpin_lock(this_rq, rf);
 
+	rcu_read_lock();
+	sd = rcu_dereference_check_sched_domain(this_rq->sd);
+
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !READ_ONCE(this_rq->rd->overload)) {
+	    !READ_ONCE(this_rq->rd->overload) ||
+	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
-		rcu_read_lock();
-		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
 			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
 
 		goto out;
 	}
+	rcu_read_unlock();
 
 	raw_spin_unlock(&this_rq->lock);
 
-- 
2.20.1


From c45d13c6156c3cdc340ef3ba523b8750642a9c50 Mon Sep 17 00:00:00 2001
Message-Id: <c45d13c6156c3cdc340ef3ba523b8750642a9c50.1620677280.git.tim.c.chen@linux.intel.com>
In-Reply-To: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
References: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Fri, 7 May 2021 14:54:54 -0700
Subject: [PATCH 3/3] sched: Rate limit load balance in newidle_balance()

Currently newidle_balance() could do load balancng even if the cpu is not
due for a load balance.  Make newidle_balance() check the next_balance
time on the cpu's runqueue so it defers load balancing if it is not
due for its load balance.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f828b75488a0..8e00e1fdd6e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10617,6 +10617,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
 	    !READ_ONCE(this_rq->rd->overload) ||
+	    time_before(jiffies, this_rq->next_balance) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
 		if (sd)
-- 
2.20.1

