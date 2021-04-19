Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D665363D51
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbhDSITb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Apr 2021 04:19:31 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47489 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232548AbhDSITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:19:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UW0pRF7_1618820331;
Received: from 30.240.102.54(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UW0pRF7_1618820331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Apr 2021 16:18:52 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS bandwidth
 burst
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <YFNtesvbxUY4XTYR@hirez.programming.kicks-ass.net>
Date:   Mon, 19 Apr 2021 16:18:51 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Phil Auld <pauld@redhat.com>,
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
Message-Id: <81E6B011-D68E-4E4B-ABBD-CAEAAAFA0470@linux.alibaba.com>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
 <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
 <B75EDF95-96B3-44E4-8169-3C1FCBC30A7B@linux.alibaba.com>
 <YFG4hEOe65cbCo26@hirez.programming.kicks-ass.net>
 <EA9BCA7F-8B57-4A87-A32E-DBBF8E7BAD8F@linux.alibaba.com>
 <YFNNWumXTSa3Bssl@lorien.usersys.redhat.com>
 <YFNtesvbxUY4XTYR@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 18, 2021, at 11:10 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Mar 18, 2021 at 08:59:44AM -0400, Phil Auld wrote:
>> I admit to not having followed all the history of this patch set. That
>> said, when I see the above I just think your quota is too low for your
>> workload.
> 
> This.
> 
>> The burst (mis?)feature seems to be a way to bypass the quota.  And it
>> sort of assumes cooperative containers that will only burst when they
>> need it and then go back to normal. 
> 
> Its not entirely unreasonable or unheard of. There's soft realtime
> systems that use this to increase the utilization with the trade-off
> that you're going to miss deadlines once every so often.
> 
> If you do it right, you can calculate the probabilities. Or usually the
> other way around, you calculate the allowed variance/burst given a P
> value for making the deadline.
> 
> Input then isn't the WCET for each task, but a runtime distribution as
> measured for your workload on your system etc..
> 
> I used to have papers on this, but I can't seem to find them in a hurry.
> 

Hi, I have done some reading on queueing theory and done some problem definition.

Divide real time into discrete periods as cfs_b does. Assume there are m cgroups using
CFS Bandwidth Control. During each period, the i-th cgroup demands u_i CPU time,
where we assume u_i is under some distribution(exponential, Poisson or else).
At the end of a period, if the sum of u_i is under or equal to 100%, we call it an "idle" state.
The number of periods between two "idle" states stands for the WCET of tasks during these
periods.

Originally using quota, it is guaranteed that "idle" state comes at the end of each period. Thus,
the WCET is the length of period. When enabling CPU Burst, the sum of u_i may exceed 100%,
and the exceeded workload is handled in the following periods. The WCET is the number of periods
between two "idle" states.

Then, we are going to calculate the probabilities that WCET is longer than a period, and the average
WCET when using certain burst under some runtime distribution.

Basically, these are based on pervious mails. I am sending this email to see if there is anything wrong
on problem definition.
