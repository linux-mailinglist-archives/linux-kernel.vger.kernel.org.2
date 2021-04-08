Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727E5359021
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 01:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhDHXFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 19:05:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:31016 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232265AbhDHXFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:05:37 -0400
IronPort-SDR: oul6KRsOXT/TRcrKWafdGSJgfvDt6wY9nxA5R58EQipzs8hj/TT2Aq19eoPU8l40jn+GYkkG+e
 A4RU2Z5xRWaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193688369"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="193688369"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 16:05:01 -0700
IronPort-SDR: +pAyck5dVwR2yRODKaI10GkRGqDRms+g3QUw9a5vf6xpSVgm/BNITqNv0b3klR1qnDnvSuT1fO
 HIopelaxnnTQ==
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="422459011"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.1.104])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 16:05:00 -0700
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
 <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com>
 <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com>
Date:   Thu, 8 Apr 2021 16:05:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 4/8/21 7:51 AM, Vincent Guittot wrote:

>> I was suprised to find the overall cpu% consumption of update_blocked_averages
>> and throughput of the benchmark still didn't change much.  So I took a
>> peek into the profile and found the update_blocked_averages calls shifted to the idle load balancer.
>> The call to update_locked_averages was reduced in newidle_balance so the patch did
>> what we intended.  But the overall rate of calls to
> 
> At least , we have removed the useless call to update_blocked_averages
> in newidle_balance when we will not perform any newly idle load
> balance
> 
>> update_blocked_averages remain roughly the same, shifting from
>> newidle_balance to run_rebalance_domains.
>>
>>    100.00%  (ffffffff810cf070)
>>             |
>>             ---update_blocked_averages
>>                |
>>                |--95.47%--run_rebalance_domains
>>                |          __do_softirq
>>                |          |
>>                |          |--94.27%--asm_call_irq_on_stack
>>                |          |          do_softirq_own_stack
> 
> The call of  update_blocked_averages mainly comes from SCHED_SOFTIRQ.
> And as a result, not from the new path
> do_idle()->nohz_run_idle_balance() which has been added by this patch
> to defer the call to update_nohz_stats() after newlyidle_balance and
> before entering idle.
> 
>>                |          |          |
>>                |          |          |--93.74%--irq_exit_rcu
>>                |          |          |          |
>>                |          |          |          |--88.20%--sysvec_apic_timer_interrupt
>>                |          |          |          |          asm_sysvec_apic_timer_interrupt
>>                |          |          |          |          |
>>                ...
>>                |
>>                |
>>                 --4.53%--newidle_balance
>>                           pick_next_task_fair
>>
>> I was expecting idle load balancer to be rate limited to 60 Hz, which
> 
> Why 60Hz ?
> 

My thinking is we will trigger load balance only after rq->next_balance.

void trigger_load_balance(struct rq *rq)
{
        /* Don't need to rebalance while attached to NULL domain */
        if (unlikely(on_null_domain(rq)))
                return;

        if (time_after_eq(jiffies, rq->next_balance))
                raise_softirq(SCHED_SOFTIRQ);

        nohz_balancer_kick(rq);
}

And it seems like next_balance is set to be 60 Hz

static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
{
        int continue_balancing = 1;
        int cpu = rq->cpu;
        int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
        unsigned long interval;
        struct sched_domain *sd;
        /* Earliest time when we have to do rebalance again */
        unsigned long next_balance = jiffies + 60*HZ;


>> should be 15 jiffies apart on the test system with CONFIG_HZ_250.
>> When I did a trace on a single CPU, I see that update_blocked_averages
>> are often called between 1 to 4 jiffies apart, which is at a much higher
>> rate than I expected.  I haven't taken a closer look yet.  But you may
> 
> 2 things can trigger a SCHED_SOFTIRQ/run_rebalance_domains:
> - the need for an update of blocked load which should not happen more
> than once every 32ms which means a rate of around 30Hz
> - the need for a load balance of a sched_domain. The min interval for
> a sched_domain is its weight when the CPU is idle which is usually few
> jiffies
> 
> The only idea that I have for now is that we spend less time in
> newidle_balance which changes the dynamic of your system.
> 
> In your trace, could you check if update_blocked_averages is called
> during the tick ? and Is the current task idle task ?

Here's a snapshot of the trace. However I didn't have the current task in my trace.
You can tell the frequency that update_blocked_averages is called on
cpu 2 by the jiffies value.  They are quite close together (1 to 3 jiffies apart).
When I have a chance to get on the machine, I'll take another look
at the current task and whether we got to trigger_load_balance() from scheduler_tick().


     3.505 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb731
     4.505 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb732
     6.484 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb733
     6.506 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb734
     9.503 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb737
    11.504 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb739
    11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
    11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
    11.642 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
    11.645 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
    11.977 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
    12.003 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
    12.015 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
    12.043 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
    12.567 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73a
    13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
    13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
    14.003 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
    14.159 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
    14.203 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
    14.223 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
    14.301 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
    14.504 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73c
    14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
    14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
    15.059 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
    15.083 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
    15.100 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
    15.103 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
    15.150 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
    15.227 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
    15.248 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
    15.311 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
    15.503 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73d
    16.140 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73d
    16.185 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73d
    16.224 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73d
    16.340 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73d
    16.384 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73d
    16.503 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73e
    16.993 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73e
    17.504 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73f
    17.630 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73f
    17.830 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
    18.015 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
    18.031 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
    18.036 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
    18.040 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
    18.502 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb740

Thanks for taking a look.

Tim
