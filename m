Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA9341D06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCSMh4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Mar 2021 08:37:56 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49740 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhCSMhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:37:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0USbqMlt_1616157458;
Received: from 30.240.100.153(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0USbqMlt_1616157458)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Mar 2021 20:37:40 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS bandwidth
 burst
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <YFNsKGKRL3SaJNZk@hirez.programming.kicks-ass.net>
Date:   Fri, 19 Mar 2021 20:39:47 +0800
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
        xiyou.wangcong@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <2F207CE6-F849-457A-B0A6-3A8BFFE0AFFB@linux.alibaba.com>
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

Yes, job execution time is important. To be specific, it is to improve the CPU usage of the whole
system to reduce the total cost of ownership, while not damaging job execution time. This
requires lower the average CPU resource of underutilized cgroups, and allowing their bursts
at the same time.

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

It is true.

>> If quota is 100000ms, burst buffer needs to be 8 times more in order
>> for this workload not to be throttled.
> 
> Where does that 100s come from? And an 800s burst is bizarre.
> 
> Did you typo [us] as [ms] ?
> 

Sorry, it should be 100000us.

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

I am sorry that I don't know much about the RT theory you mentioned, and can't provide
the desired calculation now. But I'd like to try and do some reading if that is needed.

> 16 times is horrific.

So can we decide on a more relative value now? Or is the interference probabilities still the
missing piece?

Is the paper you mentioned about called "Insensitivity results in statistical bandwidth sharing",
or some related ones on statistical bandwidth results under some kind of fairness?

