Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA83B9FD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhGBLeJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jul 2021 07:34:09 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33438 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhGBLeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:34:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UeT4pqW_1625225490;
Received: from 30.240.109.207(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UeT4pqW_1625225490)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Jul 2021 19:31:32 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v6 2/3] sched/fair: Add cfs bandwidth burst statistics
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <YNnkDnJtliEInwTY@hirez.programming.kicks-ass.net>
Date:   Fri, 2 Jul 2021 19:31:54 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, Odin Ugedal <odin@ugedal.com>,
        pauld@redhead.com, Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, tommaso.cucinotta@santannapisa.it,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8D470B39-00F8-4C87-92B8-BA645639AB24@linux.alibaba.com>
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
 <20210621092800.23714-3-changhuaixin@linux.alibaba.com>
 <YNnkDnJtliEInwTY@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 28, 2021, at 11:00 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Mon, Jun 21, 2021 at 05:27:59PM +0800, Huaixin Chang wrote:
>> The following statistics in cpu.stat file is added to show how much workload
>> is making use of cfs_b burst:
>> 
>> nr_bursts:  number of periods bandwidth burst occurs
>> burst_usec: cumulative wall-time that any cpus has
>> 	    used above quota in respective periods
>> 
>> The larger nr_bursts is, the more bursty periods there are. And the larger
>> burst_usec is, the more burst time is used by bursty workload.
> 
> That's what it does, but fails to explain why. How is this number
> useful.
> 

How about this？

The cfs_b burst feature avoids throttling by allowing bandwidth bursts. When using cfs_b
burst, users configure burst and see if it helps from workload latency and cfs_b interval
statistics like nr_throttled. Also two new statistics are introduced to show the internal of burst featrue
and explain why burst helps or not:

	nr_bursts:    number of periods bandwidth burst occurs
	burst_usec: cumulative wall-time that any cpus has
			    used above quota in respective periods


>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 53d7cc4d009b..62b73722e510 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4634,11 +4634,22 @@ static inline u64 sched_cfs_bandwidth_slice(void)
>>  */
>> void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>> {
>> +	u64 runtime;
>> +
>> 	if (unlikely(cfs_b->quota == RUNTIME_INF))
>> 		return;
>> 
>> +	if (cfs_b->runtime_at_period_start > cfs_b->runtime) {
>> +		runtime = cfs_b->runtime_at_period_start - cfs_b->runtime;
> 
> That comparison is the same as the subtraction; might as well write
> this:
> 
>> +		if (runtime > cfs_b->quota) {
>> +			cfs_b->burst_time += runtime - cfs_b->quota;
> 
> Same here.
> 
>> +			cfs_b->nr_burst++;
>> +		}
>> +	}
> 
> 
> Perhaps we can write that like:
> 
> 	s64 runtime = cfs_b->runtime_snapshot - cfs_b->runtime;
> 	if (runtime > 0) {
> 		s64 burstime = runtime - cfs_q->quota;
> 		if (burstime > 0) {
> 			cfs_b->bust_time += bursttime;
> 			cfs_b->nr_bursts++;
> 		}
> 	}
> 
> I was hoping we could get away with something simpler, like maybe:
> 

Got it.

> 	u64 old_runtim = cfs_b->runtime;
> 
> 	cfs_b->runtime += cfs_b->quota
> 	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
> 
> 	if (cfs_b->runtime - old_runtime > cfs_b->quota)
> 		cfs_b->nr_bursts++;
> 
> Would that be good enough?
> 
> 
>> +
>> 	cfs_b->runtime += cfs_b->quota;
>> 	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
>> +	cfs_b->runtime_at_period_start = cfs_b->runtime;
>> }
>> 
>> static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index d317ca74a48c..b770b553dfbb 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -367,6 +367,7 @@ struct cfs_bandwidth {
>> 	u64			quota;
>> 	u64			runtime;
>> 	u64			burst;
>> +	u64			runtime_at_period_start;
>> 	s64			hierarchical_quota;
> 
> As per the above, I don't really like that name, runtime_snapshot or
> perhaps runtime_snap is shorter and not less clear. But not having it at
> all would be even better.
