Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C674D3572FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354786AbhDGRUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:20:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:23361 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347825AbhDGRUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:20:01 -0400
IronPort-SDR: Pi9QthZ/ngulVyms6LFvBZqMchvHXsPc0rnXbqP+xZ8hyxIOYTkysDRQ4SnU1hU7l5zjjY+y+U
 kQyBo5sdSSDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="173436659"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="173436659"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:19:51 -0700
IronPort-SDR: tELTzyjLBbUjyxEszFss+DNIGEQ4XUT6EnAFLQKPCqBwe31DF9aCrnAmpc9TUm0HfugW+WdMs1
 F1SiYFSdI6aQ==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="519515763"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.94.127])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:19:51 -0700
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
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
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
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
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com>
Date:   Wed, 7 Apr 2021 10:19:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/21 7:02 AM, Vincent Guittot wrote:
> Hi Tim,
> 
> On Wed, 24 Mar 2021 at 17:05, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>>
>>
>>
>> On 3/24/21 6:44 AM, Vincent Guittot wrote:
>>> Hi Tim,
>>
>>>
>>> IIUC your problem, we call update_blocked_averages() but because of:
>>>
>>>               if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
>>>                       update_next_balance(sd, &next_balance);
>>>                       break;
>>>               }
>>>
>>> the for_each_domain loop stops even before running load_balance on the 1st
>>> sched domain level which means that update_blocked_averages() was called
>>> unnecessarily.
>>>
>>
>> That's right
>>
>>> And this is even more true with a small sysctl_sched_migration_cost which allows newly
>>> idle LB for very small this_rq->avg_idle. We could wonder why you set such a low value
>>> for sysctl_sched_migration_cost which is lower than the max_newidle_lb_cost of the
>>> smallest domain but that's probably because of task_hot().
>>>
>>> if avg_idle is lower than the sd->max_newidle_lb_cost of the 1st sched_domain, we should
>>> skip spin_unlock/lock and for_each_domain() loop entirely
>>>
>>> Maybe something like below:
>>>
>>
>> The patch makes sense.  I'll ask our benchmark team to queue this patch for testing.
> 
> Do you have feedback from your benchmark team ?
> 

Vincent,

Thanks for following up. I just got some data back from the benchmark team.
The performance didn't change with your patch.  And the overall cpu% of update_blocked_averages
also remain at about the same level.  My first thought was perhaps this update
still didn't catch all the calls to update_blocked_averages

        if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-           !READ_ONCE(this_rq->rd->overload)) {
+           !READ_ONCE(this_rq->rd->overload) ||
+           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

To experiment, I added one more check on the next_balance to further limit
the path to actually do idle load balance with the next_balance time.

        if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-           !READ_ONCE(this_rq->rd->overload)) {
+	    time_before(jiffies, this_rq->next_balance) ||	    
+           !READ_ONCE(this_rq->rd->overload) ||
+           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

I was suprised to find the overall cpu% consumption of update_blocked_averages
and throughput of the benchmark still didn't change much.  So I took a 
peek into the profile and found the update_blocked_averages calls shifted to the idle load balancer.
The call to update_locked_averages was reduced in newidle_balance so the patch did
what we intended.  But the overall rate of calls to
update_blocked_averages remain roughly the same, shifting from
newidle_balance to run_rebalance_domains.

   100.00%  (ffffffff810cf070)
            |
            ---update_blocked_averages
               |          
               |--95.47%--run_rebalance_domains
               |          __do_softirq
               |          |          
               |          |--94.27%--asm_call_irq_on_stack
               |          |          do_softirq_own_stack
               |          |          |          
               |          |          |--93.74%--irq_exit_rcu
               |          |          |          |          
               |          |          |          |--88.20%--sysvec_apic_timer_interrupt
               |          |          |          |          asm_sysvec_apic_timer_interrupt
               |          |          |          |          |          
	       ...
	       |
               |          
                --4.53%--newidle_balance
                          pick_next_task_fair

I was expecting idle load balancer to be rate limited to 60 Hz, which
should be 15 jiffies apart on the test system with CONFIG_HZ_250.
When I did a trace on a single CPU, I see that update_blocked_averages
are often called between 1 to 4 jiffies apart, which is at a much higher
rate than I expected.  I haven't taken a closer look yet.  But you may
have a better idea.  I won't have access to the test system and workload
till probably next week.

Thanks.

Tim
