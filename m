Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391E53235E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 03:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhBXC5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 21:57:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:57634 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhBXC5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 21:57:40 -0500
IronPort-SDR: IpORc8lhrrAIx/xA/woP9+RRroz7cfgwQDX98UB3sT5ZYfS/u3CZTxM8Qbe/albU2PpT0bdBjX
 83rppBX7w5hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="172683092"
X-IronPort-AV: E=Sophos;i="5.81,201,1610438400"; 
   d="scan'208";a="172683092"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 18:55:52 -0800
IronPort-SDR: fYiic4xANDh3Mp95KdoJMn/yIv8nLdpVLaL+yruZfaT82YR/rJKpBqgVjN8hI6vsAFCced5F5+
 t3SWtRFVL4/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,201,1610438400"; 
   d="scan'208";a="433056773"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2021 18:55:48 -0800
Subject: Re: [RFC PATCH v1] sched/fair: limit load balance redo times at the
 same sched_domain level
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
 <CAKfTPtAxnsEDL436zUypLj2XyMQyhgPvJ8q_23835sQxWzGtxw@mail.gmail.com>
 <a99d59c3-2023-1e8f-83cd-d964e156ffd6@linux.intel.com>
 <CAKfTPtCCzy5keKcEOUX6D1+wty0dtYEfA5=oezWRgKY_beO5NQ@mail.gmail.com>
 <c7932851-c162-b77f-2802-9b5f46038a9f@linux.intel.com>
 <CAKfTPtAJ7Lcj0mckc6XRGpD54LOEJkSSLxvz-1JeTdeDwdvBtw@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <e01cc082-6332-2a49-9f2f-3a1144f4426d@linux.intel.com>
Date:   Wed, 24 Feb 2021 10:55:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAJ7Lcj0mckc6XRGpD54LOEJkSSLxvz-1JeTdeDwdvBtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/24 1:33, Vincent Guittot wrote:
> On Tue, 23 Feb 2021 at 06:41, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> Hi Vincent,
>>
>> Sorry for the delay, I just returned from Chinese New Year holiday.
>>
>> On 2021/1/25 22:51, Vincent Guittot wrote:
>>> On Mon, 25 Jan 2021 at 15:00, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>>>
>>>> On 2021/1/25 18:56, Vincent Guittot wrote:
>>>>> On Mon, 25 Jan 2021 at 06:50, Aubrey Li <aubrey.li@intel.com> wrote:
>>>>>>
>>>>>> A long-tail load balance cost is observed on the newly idle path,
>>>>>> this is caused by a race window between the first nr_running check
>>>>>> of the busiest runqueue and its nr_running recheck in detach_tasks.
>>>>>>
>>>>>> Before the busiest runqueue is locked, the tasks on the busiest
>>>>>> runqueue could be pulled by other CPUs and nr_running of the busiest
>>>>>> runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED
>>>>>
>>>>> We should better detect that when trying to detach task like below
>>>>
>>>> This should be a compromise from my understanding. If we give up load balance
>>>> this time due to the race condition, we do reduce the load balance cost on the
>>>> newly idle path, but if there is an imbalance indeed at the same sched_domain
>>>
>>> Redo path is there in case, LB has found an imbalance but it can't
>>> move some loads from this busiest rq to dest rq because of some cpu
>>> affinity. So it tries to fix the imbalance by moving load onto another
>>> rq of the group. In your case, the imbalance has disappeared because
>>> it has already been pulled by another rq so you don't have to try to
>>> find another imbalance. And I would even say you should not in order
>>> to let other level to take a chance to spread the load
>>>
>>>> level, we have to wait the next softirq entry to handle that imbalance. This
>>>> means the tasks on the second busiest runqueue have to stay longer, which could
>>>> introduce tail latency as well. That's why I introduced a variable to control
>>>> the redo loops. I'll send this to the benchmark queue to see if it makes any
>>>
>>> TBH, I don't like multiplying the number of knobs
>>
>> Sure, I can take your approach, :)
>>
>>>>>
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -7688,6 +7688,16 @@ static int detach_tasks(struct lb_env *env)
>>>>>
>>>>>         lockdep_assert_held(&env->src_rq->lock);
>>>>>
>>>>> +       /*
>>>>> +        * Another CPU has emptied this runqueue in the meantime.
>>>>> +        * Just return and leave the load_balance properly.
>>>>> +        */
>>>>> +       if (env->src_rq->nr_running <= 1 && !env->loop) {
>>
>> May I know why !env->loop is needed here? IIUC, if detach_tasks is invoked
> 
> IIRC,  my point was to do the test only when trying to detach the 1st
> task. A lot of things can happen when a break is involved but TBH I
> can't remember a precise UC. It may be over cautious

When the break happens, rq unlock and local irq restored, so it's still possible
the rq is emptied by another CPU.

> 
>> from LBF_NEED_BREAK, env->loop could be non-zero, but as long as src_rq's
>> nr_running <=1, we should return immediately with LBF_ALL_PINNED flag cleared.
>>
>> How about the following change?
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 04a3ce20da67..1761d33accaa 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7683,8 +7683,11 @@ static int detach_tasks(struct lb_env *env)
>>                  * We don't want to steal all, otherwise we may be treated likewise,
>>                  * which could at worst lead to a livelock crash.
>>                  */
>> -               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
>> +               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1) {
> 
> IMO, we must do the test before:  while (!list_empty(tasks)) {
> 
> because src_rq might have become empty if waiting tasks have been
> pulled by another cpu and the running one became idle in the meantime

Okay, after the running one became idle, it still has LBF_ALL_PINNED, which
needs to be cleared as well. Thanks!

> 
>> +                       /* Clear the flag as we will not test any task */
>> +                       env->flag &= ~LBF_ALL_PINNED;
>>                         break;
>> +               }
>>
>>                 p = list_last_entry(tasks, struct task_struct, se.group_node);
>>
>> Thanks,
>> -Aubrey

