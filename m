Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EAE37BCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhELMmZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 May 2021 08:42:25 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38891 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232965AbhELMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:41:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0UYewVyO_1620823231;
Received: from 30.240.101.97(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UYewVyO_1620823231)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 May 2021 20:40:32 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS bandwidth
 burst
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <YFNsKGKRL3SaJNZk@hirez.programming.kicks-ass.net>
Date:   Wed, 12 May 2021 20:41:20 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>, mgorman@suse.de,
        mingo@redhat.com, Odin Ugedal <odin@uged.al>,
        Odin Ugedal <odin@ugedal.com>, pauld@redhead.com,
        Paul Turner <pjt@google.com>, rostedt@goodmis.org,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com, dtcccc@linux.alibaba.com
Content-Transfer-Encoding: 8BIT
Message-Id: <5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
 <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
 <B75EDF95-96B3-44E4-8169-3C1FCBC30A7B@linux.alibaba.com>
 <YFG4hEOe65cbCo26@hirez.programming.kicks-ass.net>
 <EA9BCA7F-8B57-4A87-A32E-DBBF8E7BAD8F@linux.alibaba.com>
 <YFNsKGKRL3SaJNZk@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 18, 2021, at 11:05 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Mar 18, 2021 at 09:26:58AM +0800, changhuaixin wrote:
>>> On Mar 17, 2021, at 4:06 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
>>> So what is the typical avg,stdev,max and mode for the workloads where you find
>>> you need this?
>>> 
>>> I would really like to put a limit on the burst. IMO a workload that has
>>> a burst many times longer than the quota is plain broken.
>> 
>> I see. Then the problem comes down to how large the limit on burst shall be.
>> 
>> I have sampled the CPU usage of a bursty container in 100ms periods. The statistics are:
> 
> So CPU usage isn't exactly what is required, job execution time is what
> you're after. Assuming there is a relation...
> 
>> average	: 42.2%
>> stddev	: 81.5%
>> max		: 844.5%
>> P95		: 183.3%
>> P99		: 437.0%
> 
> Then your WCET is 844% of 100ms ? , which is .84s.
> 
> But you forgot your mode; what is the most common duration, given P95 is
> so high, I doubt that avg is representative of the most common duration.
> 
>> If quota is 100000ms, burst buffer needs to be 8 times more in order
>> for this workload not to be throttled.
> 
> Where does that 100s come from? And an 800s burst is bizarre.
> 
> Did you typo [us] as [ms] ?
> 
>> I can't say this is typical, but these workloads exist. On a machine
>> running Kubernetes containers, where there is often room for such
>> burst and the interference is hard to notice, users would prefer
>> allowing such burst to being throttled occasionally.
> 
> Users also want ponies. I've no idea what kubernetes actually is or what
> it has to do with containers. That's all just word salad.
> 
>> In this sense, I suggest limit burst buffer to 16 times of quota or
>> around. That should be enough for users to improve tail latency caused
>> by throttling. And users might choose a smaller one or even none, if
>> the interference is unacceptable. What do you think?
> 
> Well, normal RT theory would suggest you pick your runtime around 200%
> to get that P95 and then allow a full period burst to get your P99, but
> that same RT theory would also have you calculate the resulting
> interference and see if that works with the rest of the system...
> 
> 16 times is horrific.
> 
> 

Hi,

We have discussed much about the benefit of using the burst feature previously in the
thread[1]. This mail shows the interference on the rest of the system when burst buffer is used,
when runtime is under exponential[2], poisson[3] or pareto[4] distribution. Test results showed that,
interference is more sensitive to the average utilization and the number of cgroups, than to burst buffer
size. If there are many cgroups and CPU is under utilized, a large burst buffer is acceptable. If there are
a small number of cgroups or CPU utilization is high, burst buffer should not be used.

The calculation is done by simulating[5] the CPU utilization and CPU Bandwidth distribution,
and deciding whether deadline is broken in each period. Simulation is done for over 1M
periods to get stable results.We also tried queueing theory, such as Markov chains,
to do the simplest WCET calculation, and failed when the calculation gets more complicated.
Nor did we find any paper on this. 

The inputs for our simulation program are: distribution, u_avg, m, and b. We let m cgroups
configured eqaul quota (1/m of the total) and buffer (b * quota). The CPU utilization for each period
is under certain distribution and averaged at u_avg of quota. Utilization of m cgroups is independent
identically distributed.

The WCET is counted as the number of periods till making the deadline. If a period ends with
more CPU needs that 100% after using burst, deadline is broken for this period. Without burst
feature, deadline can be guaranteed in each period.

We've conducted our experiments with variable inputs. The result is shown with the format of
E(WCET)/P(WCET>1), meaning the expectation of WCET and the probability when WCET>1.
The rows and cols(i.e. buffer=0) with all 1.0000/0% are omitted.

For exponential distribution[2], we set λ=u_avg/m for each cgroup.

m=5:
u_avg/buffer            100%              200%                    ∞
30%               1.0001/0.01%     1.0002/0.02%   1.0002/0.02%
50%               1.0176/1.66%     1.0301/2.76%    1.0352/3.15%
70%               1.1503/11.52%    1.2691/17.51%   1.4057/21.86%
90%               1.3042/21.17%    1.6701/34.19%  3.7937/60.02%

m=20:
u_avg/buffer            100%              200%                    ∞
50%               1.0000/0%        1.0001/0.01%    1.0002/0.02%
70%               1.0060/0.59%    1.0217/2.05%    1.0476/4.18%
90%               1.1989/14.07%    1.4467/24.46%  2.8603/46.26%

Since poisson distribution[3] is discrete, we convert u_avg to integer by multiplying 10 and normalize
the result, where X = n means utilization is at n * 10% of quota. We choose this way instead of others like
X = n requires n% or n/10% of quota because it generates more bursts, and thus more interference.

m=5:
u_avg/buffer            100%              200%                    ∞
70%               1.0071/0.69%      1.0071/0.69%   1.0071/0.70%
90%               1.4313/25.22%    1.5124/27.29%  1.5237/27.52%

m=20:
u_avg/buffer            100%              200%                    ∞
90%               1.0708/6.06%     1.0879/7.20%   1.0903/7.35%

It can be concluded that, compared to exponential distribution, tasks whose utilization is under
poisson distribution generate less interference after using burst. To generate more bursty workload, we also tested
the pareto distribution[4]. We set α=4 and adjust x_min accordingly so that the max demand is at about 500%
when u_avg is at 30% during 1M periods.

m=5:
u_avg/buffer            100%              200%                    ∞
30%               1.0000/0%        1.0000/0%        1.0001/0.01%
50%               1.0001/0.01%     1.0008/0.08%    1.0019/0.16%
70%               1.0117/1.11%       1.0234/2.11%     1.0308/2.38%
90%               1.3994/21.97      1.6059/26.49%  1.8296/28.78%

m=20:
u_avg/buffer            100%              200%                    ∞
70%               1.0000/0%         1.0001/0.01%      1.0013/0.12%
90%               1.0447/3.96%    1.0941/7.49%       1.1622/10.59%

References
[1]. https://lore.kernel.org/lkml/YFNtesvbxUY4XTYR@hirez.programming.kicks-ass.net/
[2]. https://en.wikipedia.org/wiki/Exponential_distribution
[3]. https://en.wikipedia.org/wiki/Poisson_distribution
[4]. https://en.wikipedia.org/wiki/Pareto_distribution
[5]. The pseudo code for our simulation program is as follows:

input: u_avg, m, b, distribution
output: wcet_list

for  (i = 0; i < nr_periods; i++) {
   free_cpu = 0;
   for (j = 0; j < m; j++) {
       needs[j] += new_needs(u_avg, m);
       if (needs[j] <= quota[j]) {
           free_cpu += quota[j] - needs[j];
           gather_token();
           needs[j] = 0;
       } else /* needs > quota */
           needs[j] -= quota[j];
   }

   /*
    * Additional free cpu is distrubted fairly among cgroups 
    * with more needs and burst buffer to meet needs.
    */
   distribute_free_cpu();

   for (j = 0; j < m; j++) {
       needs[j] -= free_cpu_use[j];
       use_token();
   }

   /* 
    * If deadline is met for this period.
    */
   if (free_cpu > 0 || !distribute_done) {
       /*
	 * Count periods when deadline is broken.
        */ 
       count_wcet_periods();
   }
}
