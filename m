Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7542071C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhJDIP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:15:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:34847 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhJDIPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:15:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="206140460"
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="206140460"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 01:12:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="482815518"
Received: from shearne-mobl.ger.corp.intel.com (HELO [10.213.208.122]) ([10.213.208.122])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 01:12:41 -0700
Subject: Re: [RFC 1/6] sched: Add nice value change notifier
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20210930171552.501553-1-tvrtko.ursulin@linux.intel.com>
 <20210930171552.501553-2-tvrtko.ursulin@linux.intel.com>
 <20210930183316.GC4323@worktop.programming.kicks-ass.net>
 <4aca656d-678f-4d61-38a4-d2e7a8fd89ab@linux.intel.com>
 <5c71ec04-9148-0587-c495-11dbd8f77d67@linux.intel.com>
 <YVct0D9kB1KtrwZ3@hirez.programming.kicks-ass.net>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <01a968c9-c427-f4c7-44d5-2f47f939f9eb@linux.intel.com>
Date:   Mon, 4 Oct 2021 09:12:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVct0D9kB1KtrwZ3@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/10/2021 16:48, Peter Zijlstra wrote:
> On Fri, Oct 01, 2021 at 11:32:16AM +0100, Tvrtko Ursulin wrote:
>>
>> On 01/10/2021 10:04, Tvrtko Ursulin wrote:
>>>
>>> Hi Peter,
>>>
>>> On 30/09/2021 19:33, Peter Zijlstra wrote:
>>>> On Thu, Sep 30, 2021 at 06:15:47PM +0100, Tvrtko Ursulin wrote:
>>>>>    void set_user_nice(struct task_struct *p, long nice)
>>>>>    {
>>>>>        bool queued, running;
>>>>> -    int old_prio;
>>>>> +    int old_prio, ret;
>>>>>        struct rq_flags rf;
>>>>>        struct rq *rq;
>>>>> @@ -6913,6 +6945,9 @@ void set_user_nice(struct task_struct *p,
>>>>> long nice)
>>>>>         */
>>>>>        p->sched_class->prio_changed(rq, p, old_prio);
>>>>> +    ret = atomic_notifier_call_chain(&user_nice_notifier_list,
>>>>> nice, p);
>>>>> +    WARN_ON_ONCE(ret != NOTIFY_DONE);
>>>>> +
>>>>>    out_unlock:
>>>>>        task_rq_unlock(rq, p, &rf);
>>>>>    }
>>>>
>>>> No, we're not going to call out to exported, and potentially unbounded,
>>>> functions under scheduler locks.
>>>
>>> Agreed, that's another good point why it is even more hairy, as I have
>>> generally alluded in the cover letter.
>>>
>>> Do you have any immediate thoughts on possible alternatives?
>>>
>>> Like for instance if I did a queue_work from set_user_nice and then ran
>>> a notifier chain async from a worker? I haven't looked at yet what
>>> repercussion would that have in terms of having to cancel the pending
>>> workers when tasks exit. I can try and prototype that and see how it
>>> would look.
>>
>> Hm or I simply move calling the notifier chain to after task_rq_unlock? That
>> would leave it run under the tasklist lock so probably still quite bad.
> 
> Hmm? That's for normalize_rt_tasks() only, right? Just don't have it
> call the notifier in that special case (that's a magic sysrq thing
> anyway).

You mean my talk about tasklist_lock? No, it is also on the syscall part 
I am interested in as well. Call chain looks like this:

sys_setpriority()
{
   ...
   rcu_read_lock();
   read_lock(&tasklist_lock);
   ...
   set_one_prio()
     set_user_nice()
     {
       ...
       task_rq_lock();
         -> my notifier from this RFC [1]
       task_rq_unlock();
         -> I can move the notifier here for _some_ improvement [2]
     }
   ...
   read_unlock(&tasklist_lock);
   rcu_read_unlock();
}

So this RFC had the notifier call chain at [1], which I understood was 
the thing you initially pointed was horrible, being under a scheduler lock.

I can trivially move it to [2] but that still leaves it under the 
tasklist lock. I don't have a good feel how much better that would be. 
If not good enough then I will look for a smarter solution with less 
opportunity for global impact.

Regards,

Tvrtko
