Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E6F38C2A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhEUJJv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 May 2021 05:09:51 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:15269 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235439AbhEUJJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:09:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UZb8F1R_1621588096;
Received: from 30.240.99.2(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UZb8F1R_1621588096)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 May 2021 17:08:17 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <CAFpoUr2mNO87XFAyHF=HA3f6KC8EkuGrwQQe54q4kmF1WgfG7w@mail.gmail.com>
Date:   Fri, 21 May 2021 17:09:55 +0800
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
Message-Id: <447D741B-F430-4502-BCA6-C2A12118A2D2@linux.alibaba.com>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
 <CAFpoUr2mNO87XFAyHF=HA3f6KC8EkuGrwQQe54q4kmF1WgfG7w@mail.gmail.com>
To:     Odin Ugedal <odin@uged.al>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 20, 2021, at 10:00 PM, Odin Ugedal <odin@uged.al> wrote:
> 
> Hi,
> 
> Here are some more thoughts and questions:
> 
>> The benefit of burst is seen when testing with schbench:
>> 
>>        echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
>>        echo 600000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
>>        echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_period_us
>>        echo 400000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us
>> 
>>        # The average CPU usage is around 500%, which is 200ms CPU time
>>        # every 40ms.
>>        ./schbench -m 1 -t 30 -r 10 -c 10000 -R 500
>> 
>>        Without burst:
>> 
>>        Latency percentiles (usec)
>>        50.0000th: 7
>>        75.0000th: 8
>>        90.0000th: 9
>>        95.0000th: 10
>>        *99.0000th: 933
>>        99.5000th: 981
>>        99.9000th: 3068
>>        min=0, max=20054
>>        rps: 498.31 p95 (usec) 10 p99 (usec) 933 p95/cputime 0.10% p99/cputime 9.33%
> 
> It should be noted that this was running on a 64 core machine (if that was
> the case, ref. your previous patch).
> 
> I am curious how much you have tried tweaking both the period and the quota
> for this workload. I assume a longer period can help such bursty application,
> and from the small slowdowns, a slightly higher quota could also help
> I guess. I am
> not saying this is a bad idea, but that we need to understand what it
> fixes, and how,
> in order to be able to understand how/if to use it.
> 

Yeah, it is a well tuned workload and configuration. I did this because for benchmarks
like schbench, workloads are generated in a fixed pattern without burst. So I set schbench
params carefully to generate burst during each 100ms periods, to show burst works. Longer
period or higher quota helps indeed, in which case more workloads can be used to generate
tail latency then.

In my view, burst is like the cfsb way of token bucket. For the present cfsb, bucket capacity
is strictly limited to quota. And that is changed into quota + burst now. And it shall be used when
tasks get throttled and CPU is under utilized for the whole system.

> Also, what value of the sysctl kernel.sched_cfs_bandwidth_slice_us are
> you using?
> What CONFIG_HZ you are using is also interesting, due to how bw is
> accounted for.
> There is some more info about it here: Documentation/scheduler/sched-bwc.rst. I
> assume a smaller slice value may also help, and it would be interesting to see
> what implications it gives. A high threads to (quota/period) ratio, together
> with a high bandwidth_slice will probably cause some throttling, so one has
> to choose between precision and overhead.
> 

Default value of kernel.sched_cfs_bandwidth_slice_us(5ms) and CONFIG_HZ(1000) is used.

The following case might be used to prevent getting throttled from many threads and high bandwidth
slice:

mkdir /sys/fs/cgroup/cpu/test
echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us

./schbench -m 1 -t 3 -r 20 -c 80000 -R 20

On my machine, two workers work for 80ms and sleep for 120ms in each round. The average utilization is
around 80%. This will work on a two-core system. It is recommended to  try it multiple times as getting
throttled doesn't necessarily cause tail latency for schbench.


> Also, here you give a burst of 66% the quota. Would that be a typical value
> for a cgroup, or is it just a result of testing? As I understand this

Yeah, it is not a typical value, and tuned for this test.

> patchset, your example
> would allow 600% constant CPU load, then one period with 1000% load,
> then another
> "long set" of periods with 600% load. Have you discussed a way of limiting how
> long burst can be "saved" before expiring?

Haven't thought about it much. It is interesting but I doubt the need to do that.

> 
>> @@ -9427,7 +9478,8 @@ static int cpu_max_show(struct seq_file *sf, void *v)
>> {
>>        struct task_group *tg = css_tg(seq_css(sf));
>> 
>> -       cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg));
>> +       cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg),
>> +                              tg_get_cfs_burst(tg));
>>        return 0;
>> }
> 
> The current cgroup v2 docs say the following:
> 
>>  cpu.max
>>    A read-write two value file which exists on non-root cgroups.
>>    The default is "max 100000".
> 
> This will become a "three value file", and I know a few user space projects
> who parse this file by splitting on the middle space. I am not sure if they are
> "wrong", but I don't think we usually break such things. Not sure what
> Tejun thinks about this.
> 

Thanks, it will be modified in the way Tejun suggests.

> Thanks
> Odin

