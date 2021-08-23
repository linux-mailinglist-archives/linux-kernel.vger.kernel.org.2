Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81313F4BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhHWNyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:54:02 -0400
Received: from foss.arm.com ([217.140.110.172]:53680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhHWNyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:54:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65E711042;
        Mon, 23 Aug 2021 06:53:18 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 903253F5A1;
        Mon, 23 Aug 2021 06:53:17 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] sched/fair: Add NOHZ balancer flag for
 nohz.next_balance updates
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20210823111700.2842997-1-valentin.schneider@arm.com>
 <20210823111700.2842997-2-valentin.schneider@arm.com>
 <YSONmyWL14mqV6zA@hirez.programming.kicks-ass.net>
 <87fsv02u9h.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <99b4c9d6-d20c-bc94-58c0-c1f5249b2636@arm.com>
Date:   Mon, 23 Aug 2021 15:53:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87fsv02u9h.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2021 14:57, Valentin Schneider wrote:
> On 23/08/21 13:59, Peter Zijlstra wrote:
>> On Mon, Aug 23, 2021 at 12:16:59PM +0100, Valentin Schneider wrote:
>>
>>> Gate NOHZ blocked load
>>> update by the presence of NOHZ_STATS_KICK - currently all NOHZ balance
>>> kicks will have the NOHZ_STATS_KICK flag set, so no change in behaviour is
>>> expected.
>>
>>> @@ -10572,7 +10572,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>>>       * setting the flag, we are sure to not clear the state and not
>>>       * check the load of an idle cpu.
>>>       */
>>> -	WRITE_ONCE(nohz.has_blocked, 0);
>>> +	if (flags & NOHZ_STATS_KICK)
>>> +		WRITE_ONCE(nohz.has_blocked, 0);
>>>
>>>      /*
>>>       * Ensures that if we miss the CPU, we must see the has_blocked
>>> @@ -10594,13 +10595,15 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>>>               * balancing owner will pick it up.
>>>               */
>>>              if (need_resched()) {
>>> -			has_blocked_load = true;
>>> +			if (flags & NOHZ_STATS_KICK)
>>> +				has_blocked_load = true;
>>>                      goto abort;
>>>              }
>>>
>>>              rq = cpu_rq(balance_cpu);
>>>
>>> -		has_blocked_load |= update_nohz_stats(rq);
>>> +		if (flags & NOHZ_STATS_KICK)
>>> +			has_blocked_load |= update_nohz_stats(rq);
>>>
>>>              /*
>>>               * If time for next balance is due,
>>> @@ -10631,8 +10634,9 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>>>      if (likely(update_next_balance))
>>>              nohz.next_balance = next_balance;
>>>
>>> -	WRITE_ONCE(nohz.next_blocked,
>>> -		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>>> +	if (flags & NOHZ_STATS_KICK)
>>> +		WRITE_ONCE(nohz.next_blocked,
>>> +			   now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>>>
>>>  abort:
>>>      /* There is still blocked load, enable periodic update */
>>
>> I'm a bit puzzled by this; that function has:
>>
>>   SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
>>
>> Which:
>>
>>  - isn't updated
>>  - implies STATS must be set when BALANCE
> 
> Yup
> 
>>
>> the latter gives rise to my confusion; why add that gate on STATS? It
>> just doesn't make sense to do a BALANCE and not update STATS.
> 
> AFAIA that warning was only there to catch BALANCE && !STATS, so I didn't
> tweak it.
> 
> Now, you could still end up with
> 
>   flags == NOHZ_NEXT_KICK
> 
> (e.g. nohz.next_balance is in the future, but a new CPU entered NOHZ-idle
> and needs its own rq.next_balance collated into the nohz struct)
> 
> in which case you don't do any blocked load update, hence the
> gate. In v1 I had that piggyback on NOHZ_STATS_KICK, but Vincent noted
> that might not be the best given blocked load updates can be time
> consuming - hence the separate flag.

Maybe the confusion stems from the fact that the NOHZ_NEXT_KICK-set
changes are only introduced in 2/2?

@@ -10417,6 +10418,9 @@ static void nohz_balancer_kick(struct rq *rq)
 unlock:
 	rcu_read_unlock();
 out:
+	if (READ_ONCE(nohz.needs_update))
+		flags |= NOHZ_NEXT_KICK;
+

@@ -10513,12 +10517,13 @@ void nohz_balance_enter_idle(int cpu)

...

+	WRITE_ONCE(nohz.needs_update, 1);
