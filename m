Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4B341D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhCSMuX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Mar 2021 08:50:23 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:48699 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhCSMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:50:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0USc56Kw_1616158190;
Received: from 30.240.100.153(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0USc56Kw_1616158190)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Mar 2021 20:49:51 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS bandwidth
 burst
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <YFNNWumXTSa3Bssl@lorien.usersys.redhat.com>
Date:   Fri, 19 Mar 2021 20:51:59 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>, mgorman@suse.de,
        mingo@redhat.com, Odin Ugedal <odin@uged.al>,
        Odin Ugedal <odin@ugedal.com>, Paul Turner <pjt@google.com>,
        rostedt@goodmis.org, Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <CECB0471-7D8E-4FE0-9144-795553A3700B@linux.alibaba.com>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
 <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
 <B75EDF95-96B3-44E4-8169-3C1FCBC30A7B@linux.alibaba.com>
 <YFG4hEOe65cbCo26@hirez.programming.kicks-ass.net>
 <EA9BCA7F-8B57-4A87-A32E-DBBF8E7BAD8F@linux.alibaba.com>
 <YFNNWumXTSa3Bssl@lorien.usersys.redhat.com>
To:     Phil Auld <pauld@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 18, 2021, at 8:59 PM, Phil Auld <pauld@redhat.com> wrote:
> 
> On Thu, Mar 18, 2021 at 09:26:58AM +0800 changhuaixin wrote:
>> 
>> 
>>> On Mar 17, 2021, at 4:06 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>>> 
>>> On Wed, Mar 17, 2021 at 03:16:18PM +0800, changhuaixin wrote:
>>> 
>>>>> Why do you allow such a large burst? I would expect something like:
>>>>> 
>>>>> 	if (burst > quote)
>>>>> 		return -EINVAL;
>>>>> 
>>>>> That limits the variance in the system. Allowing super long bursts seems
>>>>> to defeat the entire purpose of bandwidth control.
>>>> 
>>>> I understand your concern. Surely large burst value might allow super
>>>> long bursts thus preventing bandwidth control entirely for a long
>>>> time.
>>>> 
>>>> However, I am afraid it is hard to decide what the maximum burst
>>>> should be from the bandwidth control mechanism itself. Allowing some
>>>> burst to the maximum of quota is helpful, but not enough. There are
>>>> cases where workloads are bursty that they need many times more than
>>>> quota in a single period. In such cases, limiting burst to the maximum
>>>> of quota fails to meet the needs.
>>>> 
>>>> Thus, I wonder whether is it acceptable to leave the maximum burst to
>>>> users. If the desired behavior is to allow some burst, configure burst
>>>> accordingly. If that is causing variance, use share or other fairness
>>>> mechanism. And if fairness mechanism still fails to coordinate, do not
>>>> use burst maybe.
>>> 
>>> It's not fairness, bandwidth control is about isolation, and burst
>>> introduces interference.
>>> 
>>>> In this way, cfs_b->buffer can be removed while cfs_b->max_overrun is
>>>> still needed maybe.
>>> 
>>> So what is the typical avg,stdev,max and mode for the workloads where you find
>>> you need this?
>>> 
>>> I would really like to put a limit on the burst. IMO a workload that has
>>> a burst many times longer than the quota is plain broken.
>> 
>> I see. Then the problem comes down to how large the limit on burst shall be.
>> 
>> I have sampled the CPU usage of a bursty container in 100ms periods. The statistics are:
>> average	: 42.2%
>> stddev	: 81.5%
>> max		: 844.5%
>> P95		: 183.3%
>> P99		: 437.0%
>> 
>> If quota is 100000ms, burst buffer needs to be 8 times more in order for this workload not to be throttled.
>> I can't say this is typical, but these workloads exist. On a machine running Kubernetes containers,
>> where there is often room for such burst and the interference is hard to notice, users would prefer
>> allowing such burst to being throttled occasionally.
>> 
> 
> I admit to not having followed all the history of this patch set. That said, when I see the above I just
> think your quota is too low for your workload.
> 

Yeah, more quota is helpful for this workload. But that usually prevents us from improving the total CPU
usage by putting more work onto a single machine.

> The burst (mis?)feature seems to be a way to bypass the quota.  And it sort of assumes cooperative
> containers that will only burst when they need it and then go back to normal. 
> 
>> In this sense, I suggest limit burst buffer to 16 times of quota or around. That should be enough for users to
>> improve tail latency caused by throttling. And users might choose a smaller one or even none, if the interference
>> is unacceptable. What do you think?
>> 
> 
> Having quotas that can regularly be exceeded by 16 times seems to make the concept of a quota
> meaningless.  I'd have thought a burst would be some small percentage.
> 
> What if several such containers burst at the same time? Can't that lead to overcommit that can effect
> other well-behaved containers?
> 

I see. Maybe there should be some calculation on the probabilities of that, as Peter has replied.

> 
> Cheers,
> Phil
> 
> -- 

