Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F338F451BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354469AbhKPAIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:08:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:43577 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347730AbhKOTnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:43:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="233457949"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="233457949"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 11:40:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="592258773"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.107.156])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 11:40:10 -0800
Subject: Re: [PATCH 2/2] sched: sched: Fix rq->next_balance time updated to
 earlier than current time
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
References: <20211112100458.7958-1-vincent.guittot@linaro.org>
 <YY6GfilrilzTmhZx@hirez.programming.kicks-ass.net>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <272f4cee-251a-b107-78fe-9a38b33b1084@linux.intel.com>
Date:   Mon, 15 Nov 2021 11:40:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YY6GfilrilzTmhZx@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 7:21 AM, Peter Zijlstra wrote:
> On Fri, Nov 12, 2021 at 11:04:58AM +0100, Vincent Guittot wrote:
>> From: Tim Chen <tim.c.chen@linux.intel.com>
>>
>> In traces on newidle_balance(), this_rq->next_balance
>> time goes backward and earlier than current time jiffies, e.g.
>>
>> 11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
>> 11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>> 13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
>> 13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>> 14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
>> 14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
> 
> No explanation of what these numbers mean, or where they're taken from.

Sorry I should have added more explanation.  I put a probe on newidle_balance and dump
out the values of this_rq pointer, this_rq->next_balance and jiffies entering
newidle_balance using the following commands:

perf probe 'newidle_balance this_rq this_rq->next_balance jiffies'
perf trace -e probe:newidle_balance

In the first line of the trace, next_balance start off at 0x1004fb76c: 

11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739

and in the second line, next_balance actually goes backward to 0x1004fb731, and becomes less than the jiffies value 0x1004fb739.

11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739


> 
>> It doesn't make sense to have a next_balance in the past.
>> Fix newidle_balance() and update_next_balance() so the next
>> balance time is at least jiffies+1.
> 
> The changelog is deficient in that it doesn't explain how the times end
> up in the past, therefore we cannot evaluate if the provided solution is
> sufficient etc..
> 
>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>  kernel/sched/fair.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a162b0ec8963..1050037578a9 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10138,7 +10138,10 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
>>  
>>  	/* used by idle balance, so cpu_busy = 0 */
>>  	interval = get_sd_balance_interval(sd, 0);
>> -	next = sd->last_balance + interval;
>> +	if (time_after(jiffies+1, sd->last_balance + interval))
>> +		next = jiffies+1;
>> +	else
>> +		next = sd->last_balance + interval;
>>  
>>  	if (time_after(*next_balance, next))
>>  		*next_balance = next;
>> @@ -10974,6 +10977,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  
>>  out:
>>  	/* Move the next balance forward */
>> +	if (time_after(jiffies+1, this_rq->next_balance))
>> +		this_rq->next_balance = jiffies+1;
> 
> jiffies roll over here..
> 
> Also, what's the point of the update_next_balance() addition in the face
> of this one? AFAICT this hunk completely renders the other hunk useless.
> 
>>  	if (time_after(this_rq->next_balance, next_balance))
>>  		this_rq->next_balance = next_balance;
> 
> and you've violated your own premise :-)

Agree that this hunk is redundant.  Should only keep the update_next_balance() hunk.

> 
> Now, this pattern is repeated throughout, if it's a problem here, why
> isn't it a problem in say rebalance_domains() ?

In rebalance_domains, next_balance is assigned an initial value of jiffies+60*HZ
and could only increase.

So when we update this_rq-next_balance with next_balance computed,
it should always be more than current jiffies.

> 
> Can we please unify the code across sites instead of growing different
> hacks in different places?
> 

I'll take a closer look at the next_balance computation in other places.

Tim
