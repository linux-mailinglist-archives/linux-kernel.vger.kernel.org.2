Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC1326D41
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 14:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhB0NuN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 27 Feb 2021 08:50:13 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53976 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230132AbhB0NtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 08:49:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UPj6v-U_1614433664;
Received: from 30.25.210.58(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UPj6v-U_1614433664)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 27 Feb 2021 21:48:15 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 0/4] sched/fair: Burstable CFS bandwidth controller
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <20210209131719.1193428-1-odin@uged.al>
Date:   Sat, 27 Feb 2021 21:48:01 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, pauld@redhead.com,
        peterz@infradead.org, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com, tj@kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6112D83C-9A5F-4317-8AF1-DF49132135FB@linux.alibaba.com>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <20210209131719.1193428-1-odin@uged.al>
To:     Odin Ugedal <odin@uged.al>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi，

Sorry for my late reply.

> On Feb 9, 2021, at 9:17 PM, Odin Ugedal <odin@uged.al> wrote:
> 
> 
> Hi! This looks quite useful, but I have a few quick thoughts. :)
> 
> I know of a lot of people who would love this (especially some
> Kubernetes users)! I really like how this allow users to use cfs
> in a more dynamic and flexible way, without interfering with those
> who like the enforce strict quotas.
> 
> 
>> +++ b/kernel/sched/core.c
>> @ -7900,7 +7910,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64
>> [...]
>> +	/* burst_onset needed */
>> +	if (cfs_b->quota != RUNTIME_INF &&
>> +			sysctl_sched_cfs_bw_burst_enabled &&
>> +			sysctl_sched_cfs_bw_burst_onset_percent > 0) {
>> +
>> +		burst_onset = do_div(burst, 100) *
>> +			sysctl_sched_cfs_bw_burst_onset_percent;
>> +
>> +		cfs_b->runtime += burst_onset;
>> +		cfs_b->runtime = min(max_cfs_runtime, cfs_b->runtime);
>> +	}
> 
> I saw a comment about this behavior, but I think this can lead to a bit of
> confusion. If sysctl_sched_cfs_bw_burst_onset_percent=0, the amount of
> bandwidth when the first process starts up will depend on the time between
> the quota was set and the startup of the process, and that feel a bit like
> a "timing" race that end user application then will have to think about.
> 
> I suspect contianer runtimes and/or tools like Kubernetes will then have
> to tell users to set the value to a certan amount in order to make it
> work as expected.
> 
> Another thing is that when a cgroup has saved some time into the
> "burst quota", updating the quota, period or burst will then reset the
> "burst quota", even though eg. only the burst was changed. Some tools
> use dynamic quotas, resulting in multiple changes in the quota over time,
> and I am a bit scared that don't allowing them to control "start burst"
> on a write can be limiting.
> 
> Maybe we can allow people to set the "start bandwidth" explicitly when setting
> cfs_burst if they want to do that? (edit: that might be hard for cgroup v1, but
> would I think that is a good solution on cgroup v2).
> 
> This is however just my thoughts, and I am not 100% sure about what the
> best solution is, but if we merge a certain behavior, we have no real
> chance of changing it later.
> 

If there are cases where the "start bandwidth" matters, I think there is need to expose the
"start bandwidth" explicitly too. However, I doubt the existence of such cases from my view
and the two examples above.

In my thoughts, this patchset keeps cgroup usage within the quota in the longer term, and allows 
cgroup to respond to a burst of work with the help of a reasonable burst buffer. If quota is set correctly
above average usage, and enough burst buffer is set to meet the needs of bursty work. In this
case, it makes no difference whether this cgroup runs with 0 start bandwidth or all of it.
Thus I used sysctl_sched_cfs_bw_burst_onset_percent to decided the start bandwidth
to leave some convenience here. If this sysctl interface is confusing, I wonder whether it
is a good idea not to expose this interface.

For the first case mentioned above, if Kubernet users care the "start bandwidth" for process startup,
maybe it is better to give all of it rather than a part?

For the second case with quota changes over time, I think it is important making sure each change works
long enough to enforce average quota limit. Does it really matter to control "start burst" on each change?



> 
>> +++ b/kernel/sched/sched.h
>> @@ -367,6 +367,7 @@ struct cfs_bandwidth {
>> 	u64			burst;
>> 	u64			buffer;
>> 	u64			max_overrun;
>> +	u64			previous_runtime;
>> 	s64			hierarchical_quota;
> 
> Maybe indicate that this was the remaining runtime _after_ the previous
> period ended? Not 100% sure, but maybe sometihing like
> 'remaining_runtime_prev_period' or 'end_runtime_prev_period'(as inspiration).   
> 

It is an copy of runtime at period start, and used to calculate burst time during a period.
Not quite remaining_runtime_prev_period.

> 
>> +++ b/kernel/sched/core.c
>> @@ -8234,6 +8236,10 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>> 		seq_printf(sf, "wait_sum %llu\n", ws);
>> 	}
>> 
>> +	seq_printf(sf, "current_bw %llu\n", cfs_b->runtime);
>> +	seq_printf(sf, "nr_burst %d\n", cfs_b->nr_burst);
>> +	seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
>> +
>> 	return 0;
>> }
> 
> Looks like these metrics are missing from the cgroup v2 stats.
> 

Thanks, cgroup v2 stats and documentation should be handled. I will add them
in the following patchset.

> Are we sure it is smart to start exposing cfs_b->runtime, since it makes it
> harder to change the implementation at a later time? I don't thin it is that
> usefull, and if it is only exposed for debugging purposes people can probably
> use kprobes instead? Also, it would not be usefull unless you know how much
> wall time is left in the current period. In that sense,
> cfs_b->previous_runtime would probably be more usefull, but still not sure if
> it deserves to be exposed to end users like this.
> 
> Also, will "cfs_b->runtime" keep updating if no processes are running, or
> will it be the the same here, but update (with burst via timer overrun)
> when a process starts again? If so, the runtime available when a process
> starts on cgroup inint can be hard to communicate if the value here doesn't
> update.
> 

Yeah, there is the updating problem. It is okey not to expose cfs_b->runtime then.

> 
>> +++ b/kernel/sched/fair.c
>> +void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b, int init)
>> [...]
>> +	/*
>> +	 * When period timer stops, quota for the following period is not
>> +	 * refilled, however period timer is already forwarded. We should
>> +	 * accumulate quota once more than overrun here.
>> +	 */
> 
> 
> Trying to wrap my head around this one... Is not refilling here, as the
> behavior before your patch causing "loss" in runtime and causing unnecessary
> possibly causing a cgroup throttle?.
> 

This comment does not mean any loss any unnecessary throttle for present cfsb.
All this means is that all quota refilling that is not done during timer stop should be
refilled on timer start, for the burstable cfsb.

Maybe I shall change this comment in some way if it is misleading?

> 
> A am not that familiar how cross subsystem patches like these are handled, but
> I am still adding the Tejun Heo (cgroup maintainer) as a CC. Should maybe cc to
> cgroup@ as well?
> 
> Sorry for a long mail, in retrospect it should have been one per patch...
> 

