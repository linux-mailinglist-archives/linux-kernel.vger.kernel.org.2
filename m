Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33E638C69E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhEUMhw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 May 2021 08:37:52 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36030 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229912AbhEUMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:37:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UZcK7pL_1621600581;
Received: from 30.240.99.2(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UZcK7pL_1621600581)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 May 2021 20:36:22 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <CAFpoUr3nUEWYZjAj+cJp_FL7csOMMS-LE73sb-jjfRNY2fEBDA@mail.gmail.com>
Date:   Fri, 21 May 2021 20:38:00 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
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
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <E6F418FE-5C39-49FA-A4FF-66929EF4AD58@linux.alibaba.com>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
 <CAFpoUr2mNO87XFAyHF=HA3f6KC8EkuGrwQQe54q4kmF1WgfG7w@mail.gmail.com>
 <447D741B-F430-4502-BCA6-C2A12118A2D2@linux.alibaba.com>
 <CAFpoUr3nUEWYZjAj+cJp_FL7csOMMS-LE73sb-jjfRNY2fEBDA@mail.gmail.com>
To:     Odin Ugedal <odin@uged.al>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 21, 2021, at 5:38 PM, Odin Ugedal <odin@uged.al> wrote:
> 
> Hi,
> 
>> Yeah, it is a well tuned workload and configuration. I did this because for benchmarks
>> like schbench, workloads are generated in a fixed pattern without burst. So I set schbench
>> params carefully to generate burst during each 100ms periods, to show burst works. Longer
>> period or higher quota helps indeed, in which case more workloads can be used to generate
>> tail latency then.
> 
> Yeah, that makes sense. When it comes to fairness (you are talking
> about generating tail
> latency), I think configuration of cpu shares/weight between cgroups
> is more relevant.
> 
> How much more tail latency will a cgroup be able to "create" when
> doubling the period?
> 

Indeed, fairness is another factor relevant to tail latency. However, real workloads benefit from burst
feature, too. For java workloads with equal fairness between cgroups, a huge drop of tail latency from
500ms to 27ms is seen after enabling burst feature. I shouldn't delete this info in the msg.

I guess tail latency from schbench is small here, because schbench is simple and only measures wakeup
latency. For workloads measuring round trip time, the effect of getting throttled is more obvious.

> 
>> In my view, burst is like the cfsb way of token bucket. For the present cfsb, bucket capacity
>> is strictly limited to quota. And that is changed into quota + burst now. And it shall be used when
>> tasks get throttled and CPU is under utilized for the whole system.
> 
> Well, it is as strict as we can make it, depending on how one looks at it. We
> cannot guarantee anything more strict than the length of a jiffy or
> kernel.sched_cfs_bandwidth_slice_us (simplified ofc.), especially since we allow
> runtime from one period to be used in another. I think there is a
> "big" distinction between
> runtime transferred from the cfs_bw to cfs_rq's in a period compared
> to the actual runtime used.
> 
>> Default value of kernel.sched_cfs_bandwidth_slice_us(5ms) and CONFIG_HZ(1000) is used.
> 
> You should mention that in the msg then, since it is highly relevant
> to the results. Can you try to tweak

Sorry for causing trouble reproducing this. I'll add these info.

> kernel.sched_cfs_bandwidth_slice_us to something like 1ms, and see
> what the result will be?
> 

After using 1ms kernel.sched_cfs_bandwidth_slice_us I see 99.0th and 99.5th latency drop, and 99.9th
latency remains at several ms. I guess I can't tell it from some small spikes now. 

# 1ms kernel.sched_cfs_bandwidth_slice_us
echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
echo 600000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
#echo 400000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
cat /sys/fs/cgroup/cpu/test/cpu.stat | grep nr_throttled

./schbench -m 1 -t 30 -r 10 -c 10000 -R 500

Latency percentiles (usec)
	50.0000th: 8
	75.0000th: 8
	90.0000th: 9
	95.0000th: 10
	*99.0000th: 13
	99.5000th: 17
	99.9000th: 6408
	min=0, max=7576
rps: 497.44 p95 (usec) 10 p99 (usec) 13 p95/cputime 0.10% p99/cputime 0.13%


> For such a workload and high cfs_bw_slice, a smaller CONFIG_HZ might
> also be beneficial (although
> there are many things to consider when talking about that, and a lot
> of people know more about that than me).
> 
>> The following case might be used to prevent getting throttled from many threads and high bandwidth
>> slice:
>> 
>> mkdir /sys/fs/cgroup/cpu/test
>> echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
>> echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
>> echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
>> 
>> ./schbench -m 1 -t 3 -r 20 -c 80000 -R 20
>> 
>> On my machine, two workers work for 80ms and sleep for 120ms in each round. The average utilization is
>> around 80%. This will work on a two-core system. It is recommended to  try it multiple times as getting
>> throttled doesn't necessarily cause tail latency for schbench.
> 
> When I run this, I get the following results without cfs bandwidth enabled.
> 
> $ time ./schbench -m 1 -t 3 -r 20 -c 80000 -R 20
> Latency percentiles (usec) runtime 20 (s) (398 total samples)
>        50.0th: 22 (201 samples)
>        75.0th: 50 (158 samples)
>        90.0th: 50 (0 samples)
>        95.0th: 51 (38 samples)
>        *99.0th: 51 (0 samples)
>        99.5th: 51 (0 samples)
>        99.9th: 52 (1 samples)
>        min=5, max=52
> rps: 19900000.00 p95 (usec) 51 p99 (usec) 51 p95/cputime 0.06% p99/cputime 0.06%
> ./schbench -m 1 -t 3 -r 20 -c 80000 -R 20  31.85s user 0.00s system
> 159% cpu 20.021 total
> 
> In this case, I see 80% load on two cores, ending at a total of 160%. If setting
> period: 100ms and quota: 100ms (aka. 1 cpu), throttling is what
> you would expect, or?. In this case, burst wouldn't matter?
> 

Sorry for my mistake. The -R option should be 10 instead of 20. And the case should be:

# 1ms kernel.sched_cfs_bandwidth_slice_us
mkdir /sys/fs/cgroup/cpu/test
echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us

./schbench -m 1 -t 3 -r 20 -c 80000 -R 10

The average CPU usage is at 80%. I run this for 10 times, and got long tail latency for 6 times and got throttled
for 8 times.

Tail latencies are showed below, and it wasn't the worst case.

Latency percentiles (usec)
	50.0000th: 19872
	75.0000th: 21344
	90.0000th: 22176
	95.0000th: 22496
	*99.0000th: 22752
	99.5000th: 22752
	99.9000th: 22752
	min=0, max=22727
rps: 9.90 p95 (usec) 22496 p99 (usec) 22752 p95/cputime 28.12% p99/cputime 28.44%


Sometimes the measured period of schbench is not throttled and thus no tail latency is seen. Sometimes tasks do
not get throttled because the the offset of schbench worker start from period start matters too. In this case, these
two CPUs work for 80ms and sleeps for 120ms, If the 80ms burst period for 2 workers is cut into two cfsb periods,
they might not get throttled.

I'll use this case in the commit log.

> 
> Thanks
> Odin

