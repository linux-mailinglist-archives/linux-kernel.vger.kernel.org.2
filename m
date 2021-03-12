Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91764338EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCLNZP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 Mar 2021 08:25:15 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:58784 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhCLNZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:25:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0URgfvzG_1615555500;
Received: from 30.240.101.205(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0URgfvzG_1615555500)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Mar 2021 21:25:01 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 0/4] sched/fair: Burstable CFS bandwidth controller
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <CAFpoUr0jqE9T-PohSDNXuTacvK1=2F9-hbTGszcL0t28vbyehQ@mail.gmail.com>
Date:   Fri, 12 Mar 2021 21:26:30 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Odin Ugedal <odin@uged.al>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>, mgorman@suse.de,
        mingo@redhat.com, pauld@redhead.com, peterz@infradead.org,
        Paul Turner <pjt@google.com>, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com, Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <913F5DAA-A898-41E7-99AB-6E942A77B523@linux.alibaba.com>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <20210209131719.1193428-1-odin@uged.al>
 <6112D83C-9A5F-4317-8AF1-DF49132135FB@linux.alibaba.com>
 <CAFpoUr0jqE9T-PohSDNXuTacvK1=2F9-hbTGszcL0t28vbyehQ@mail.gmail.com>
To:     Odin Ugedal <odin@ugedal.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 10, 2021, at 7:11 PM, Odin Ugedal <odin@ugedal.com> wrote:
> 
> Hi,
> 
>> If there are cases where the "start bandwidth" matters, I think there is need to expose the
>> "start bandwidth" explicitly too. However, I doubt the existence of such cases from my view
>> and the two examples above.
> 
> Yeah, I don't think there will be any cases where users will be
> "depending" on having burst available,
> so I agree in that sense.
> 
>> In my thoughts, this patchset keeps cgroup usage within the quota in the longer term, and allows
>> cgroup to respond to a burst of work with the help of a reasonable burst buffer. If quota is set correctly
>> above average usage, and enough burst buffer is set to meet the needs of bursty work. In this
>> case, it makes no difference whether this cgroup runs with 0 start bandwidth or all of it.
>> Thus I used sysctl_sched_cfs_bw_burst_onset_percent to decided the start bandwidth
>> to leave some convenience here. If this sysctl interface is confusing, I wonder whether it
>> is a good idea not to expose this interface.
>> 
>> For the first case mentioned above, if Kubernet users care the "start bandwidth" for process startup,
>> maybe it is better to give all of it rather than a part?
> 
> Yeah, I am a bit afraid there will be some confusion, so not sure if
> the sysctl is the best way to do it.
> 
> But I would like feedback from others to highlight the problem as
> well, that would be helpful. I think a simple "API"
> where you get 0 burst or full burst on "set" (the one we decide on)
> would be best to avoid unnecessary complexity.
> 
> Start burst when starting up a new process in a new cgroup might be
> helpful, so maybe that is a vote for
> full burst? However, in long term that doesn't matter, so 0 burst on
> start would work as well.
> 
>> For the second case with quota changes over time, I think it is important making sure each change works
>> long enough to enforce average quota limit. Does it really matter to control "start burst" on each change?
> 
> No, I don't think so. Doing so would be another thing to set per
> cgroup, and that would just clutter the api
> more than necessary imo., since we cannot come up with any real use cases.
> 
>> It is an copy of runtime at period start, and used to calculate burst time during a period.
>> Not quite remaining_runtime_prev_period.
> 
> Ahh, I see, I misunderstood the code. So in a essence it is
> "runtime_at_period_start"?
> 

Yes, it is "runtime_at_preiod_start".

>> Yeah, there is the updating problem. It is okey not to expose cfs_b->runtime then.
> 
> Yeah, I think dropping it all together is the best solution.
> 
> 
>> This comment does not mean any loss any unnecessary throttle for present cfsb.
>> All this means is that all quota refilling that is not done during timer stop should be
>> refilled on timer start, for the burstable cfsb.
>> 
>> Maybe I shall change this comment in some way if it is misleading?
> 
> I think I formulated my question badly. The comment makes sense, I am
> just trying to compare how "start_cfs_bandwidth"
> works after your patch compared to how it works currently. As I
> understand, without this patch "start_cfs_bandwidth" will
> never refill runtime, while with your patch, it will refill even when
> overrun=0 with burst disabled. Is that an intended change in
> behavior, or am I not understanding the patch?
> 

Good point. The way "start_cfs_bandwidth" works is changed indeed. The present cfs_b doesn't
have to refill bandwidth because quota is not used during the period before timer stops. With this patch,
runtime is refilled no matter burst is enabled or not. Do you suggest not refilling runtime unless burst
is enabled here?

> 
> On another note, I have also been testing this patch, and I am not
> able to reproduce your schbench results. Both with and without burst,
> it gets the same result, and no nr_throttled stays at 0 (tested on a
> 32-core system). Can you try to rerun your tests with the mainline
> to see if you still get the same results? (Also, I see you are running
> with 30 threads. How many cores do your test setup have?). To actually
> say that the result is real, all cores used should maybe be
> exclusively reserved as well, to avoid issues where other processes
> cause a
> spike in latency.
> 

Spikes indeed cause trouble. If nr_throttle stays at 0, I suggest change quota from 700000 to 600000,
which is still above the average utilization 500%. I have rerun on a 64-core system and reproduced the
results. And I think it should work on a 32-core system too, as there are 20 active workers in each round.

If you still have trouble, I suggest test in the following way. And it should work on a two-core system.

mkdir /sys/fs/cgroup/cpu/test
echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
echo 300000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us

./schbench -m 1 -t 3 -r 20 -c 200000 -R 4

On my machine, two workers work for 200ms and sleep for 300ms in each round. The average utilization is
around 80%.
  

> 
> Odin

