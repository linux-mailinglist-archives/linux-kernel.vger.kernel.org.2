Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3E33FCA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 02:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCRBZf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Mar 2021 21:25:35 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59702 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhCRBZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:25:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0USLDttW_1616030695;
Received: from 30.25.254.31(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0USLDttW_1616030695)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Mar 2021 09:25:27 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS bandwidth
 burst
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <YFG4hEOe65cbCo26@hirez.programming.kicks-ass.net>
Date:   Thu, 18 Mar 2021 09:26:58 +0800
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
Message-Id: <EA9BCA7F-8B57-4A87-A32E-DBBF8E7BAD8F@linux.alibaba.com>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
 <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
 <B75EDF95-96B3-44E4-8169-3C1FCBC30A7B@linux.alibaba.com>
 <YFG4hEOe65cbCo26@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 17, 2021, at 4:06 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Wed, Mar 17, 2021 at 03:16:18PM +0800, changhuaixin wrote:
> 
>>> Why do you allow such a large burst? I would expect something like:
>>> 
>>> 	if (burst > quote)
>>> 		return -EINVAL;
>>> 
>>> That limits the variance in the system. Allowing super long bursts seems
>>> to defeat the entire purpose of bandwidth control.
>> 
>> I understand your concern. Surely large burst value might allow super
>> long bursts thus preventing bandwidth control entirely for a long
>> time.
>> 
>> However, I am afraid it is hard to decide what the maximum burst
>> should be from the bandwidth control mechanism itself. Allowing some
>> burst to the maximum of quota is helpful, but not enough. There are
>> cases where workloads are bursty that they need many times more than
>> quota in a single period. In such cases, limiting burst to the maximum
>> of quota fails to meet the needs.
>> 
>> Thus, I wonder whether is it acceptable to leave the maximum burst to
>> users. If the desired behavior is to allow some burst, configure burst
>> accordingly. If that is causing variance, use share or other fairness
>> mechanism. And if fairness mechanism still fails to coordinate, do not
>> use burst maybe.
> 
> It's not fairness, bandwidth control is about isolation, and burst
> introduces interference.
> 
>> In this way, cfs_b->buffer can be removed while cfs_b->max_overrun is
>> still needed maybe.
> 
> So what is the typical avg,stdev,max and mode for the workloads where you find
> you need this?
> 
> I would really like to put a limit on the burst. IMO a workload that has
> a burst many times longer than the quota is plain broken.

I see. Then the problem comes down to how large the limit on burst shall be.

I have sampled the CPU usage of a bursty container in 100ms periods. The statistics are:
average	: 42.2%
stddev	: 81.5%
max		: 844.5%
P95		: 183.3%
P99		: 437.0%

If quota is 100000ms, burst buffer needs to be 8 times more in order for this workload not to be throttled.
I can't say this is typical, but these workloads exist. On a machine running Kubernetes containers,
where there is often room for such burst and the interference is hard to notice, users would prefer
allowing such burst to being throttled occasionally.

In this sense, I suggest limit burst buffer to 16 times of quota or around. That should be enough for users to
improve tail latency caused by throttling. And users might choose a smaller one or even none, if the interference
is unacceptable. What do you think?
