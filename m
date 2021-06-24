Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C18D3B2AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFXIr7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Jun 2021 04:47:59 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:58837 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhFXIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:47:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0UdVdJ.e_1624524334;
Received: from 30.240.109.243(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UdVdJ.e_1624524334)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jun 2021 16:45:35 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v6 1/3] sched/fair: Introduce the burstable CFS controller
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <CAFpoUr1Q-DuvXhPtX=bNdjg6xVcyBF=Qm8kz+HG7pGtNtu9X4A@mail.gmail.com>
Date:   Thu, 24 Jun 2021 16:45:33 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        pauld@redhead.com, Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, tommaso.cucinotta@santannapisa.it,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <2D5B4FA3-88BC-4BD2-9F58-72C9ABC667B0@linux.alibaba.com>
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
 <20210621092800.23714-2-changhuaixin@linux.alibaba.com>
 <CAFpoUr1Q-DuvXhPtX=bNdjg6xVcyBF=Qm8kz+HG7pGtNtu9X4A@mail.gmail.com>
To:     Odin Ugedal <odin@uged.al>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 22, 2021, at 11:27 PM, Odin Ugedal <odin@uged.al> wrote:
> 
> Hi,
> 
> Just some more thoughts.
> 
> man. 21. jun. 2021 kl. 11:28 skrev Huaixin Chang
> <changhuaixin@linux.alibaba.com>:
>> 
>> The CFS bandwidth controller limits CPU requests of a task group to
>> quota during each period. However, parallel workloads might be bursty
>> so that they get throttled even when their average utilization is under
>> quota. And they are latency sensitive at the same time so that
>> throttling them is undesired.
>> 
>> We borrow time now against our future underrun, at the cost of increased
>> interference against the other system users. All nicely bounded.
>> 
>> Traditional (UP-EDF) bandwidth control is something like:
>> 
>>  (U = \Sum u_i) <= 1
>> 
>> This guaranteeds both that every deadline is met and that the system is
>> stable. After all, if U were > 1, then for every second of walltime,
>> we'd have to run more than a second of program time, and obviously miss
>> our deadline, but the next deadline will be further out still, there is
>> never time to catch up, unbounded fail.
>> 
>> This work observes that a workload doesn't always executes the full
>> quota; this enables one to describe u_i as a statistical distribution.
>> 
>> For example, have u_i = {x,e}_i, where x is the p(95) and x+e p(100)
>> (the traditional WCET). This effectively allows u to be smaller,
>> increasing the efficiency (we can pack more tasks in the system), but at
>> the cost of missing deadlines when all the odds line up. However, it
>> does maintain stability, since every overrun must be paired with an
>> underrun as long as our x is above the average.
>> 
>> That is, suppose we have 2 tasks, both specify a p(95) value, then we
>> have a p(95)*p(95) = 90.25% chance both tasks are within their quota and
>> everything is good. At the same time we have a p(5)p(5) = 0.25% chance
>> both tasks will exceed their quota at the same time (guaranteed deadline
>> fail). Somewhere in between there's a threshold where one exceeds and
>> the other doesn't underrun enough to compensate; this depends on the
>> specific CDFs.
>> 
>> At the same time, we can say that the worst case deadline miss, will be
>> \Sum e_i; that is, there is a bounded tardiness (under the assumption
>> that x+e is indeed WCET).
>> 
>> The benefit of burst is seen when testing with schbench. Default value of
>> kernel.sched_cfs_bandwidth_slice_us(5ms) and CONFIG_HZ(1000) is used.
>> 
>>        mkdir /sys/fs/cgroup/cpu/test
>>        echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
>>        echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
>>        echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
>> 
>>        ./schbench -m 1 -t 3 -r 20 -c 80000 -R 10
>> 
>> The average CPU usage is at 80%. I run this for 10 times, and got long tail
>> latency for 6 times and got throttled for 8 times.
> 
> I don't think this is the best example of the benefit given by burst.
> If you double the period, to 200ms, all throttling is mitigated for this
> example. Doubling the period is ~the same as having burst=quota (not 100%)
> the same. It would be interesting to also see other workloads referred to here,
> and how they behave with a double in period vs "100%" burst. (eg. 50% burst
> is the ~the same as going from 100ms period to 150%).
> 
> The same way, using a 50ms period and 100% burst would cause throttling
> here as well.
> 
> For certain workloads using about 100% of their quota constantly, then a short
> burst over, would certainly benefit from this. However, those workloads should
> then probably have a higher quota as well, also mitigating that problem, unless
> we want it to be throttled.
> 
> Timing issues for refilling the cfs_b can also cause some throttling, and
> naturally giving more runtime will "fix" those issues, but I think there
> are better ways of solving it than adding new APIs.
> 
> 
> Overall, my biggest issue with this approach is that it would be hard for users
> to reason about what burst is, and what it "fixes", especially compared to
> the period length. I think a lot of people would benefit from using longer
> periods than 100ms when they have way more processes than the ratio between
> the quota and the period. I therefore think it would be best to use examples
> for when to use burst where a period change would not fix the issue.
> 

Hi,

Maybe using burst and changing period can be used at the same time, and burst feature
is not designed to replace changing period anyway. However I suggest burst shall be
considered prior to changing period, as doubling the period doubles the WCET. That is to say,
using burst avoids throttling and improved WCET in some way, compared to using larger periods
only.


> 
>> Tail latencies are shown below, and it wasn't the worst case.
>> 
>>        Latency percentiles (usec)
>>                50.0000th: 19872
>>                75.0000th: 21344
>>                90.0000th: 22176
>>                95.0000th: 22496
>>                *99.0000th: 22752
>>                99.5000th: 22752
>>                99.9000th: 22752
>>                min=0, max=22727
>>        rps: 9.90 p95 (usec) 22496 p99 (usec) 22752 p95/cputime 28.12% p99/cputime 28.44%
>> 
>> The interferenece when using burst is valued by the possibilities for
>> missing the deadline and the average WCET. Test results showed that when
>> there many cgroups or CPU is under utilized, the interference is
>> limited. More details are shown in:
>> https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/
>> 
>> Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
>> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
>> Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
>> ---
> 
> Anyways, this should also probably scale burst together with period and quota
> when the period is too short. Something like the diff below, as well as
> updating the message.
> 
> 
> Thanks
> Odin
> 
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bfaa6e1f6067..ab809bd11785 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5277,6 +5277,7 @@ static enum hrtimer_restart
> sched_cfs_period_timer(struct hrtimer *timer)
>                        if (new < max_cfs_quota_period) {
>                                cfs_b->period = ns_to_ktime(new);
>                                cfs_b->quota *= 2;
> +                               cfs_b->burst *= 2;
> 
>                                pr_warn_ratelimited(
>        "cfs_period_timer[cpu%d]: period too short, scaling up (new
> cfs_period_us = %lld, cfs_quota_us = %lld)\n",

