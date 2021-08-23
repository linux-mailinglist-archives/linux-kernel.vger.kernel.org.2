Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE673F4B37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbhHWM6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:58:37 -0400
Received: from foss.arm.com ([217.140.110.172]:53086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236014AbhHWM6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:58:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77B2E101E;
        Mon, 23 Aug 2021 05:57:53 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A90F13F5A1;
        Mon, 23 Aug 2021 05:57:52 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 1/2] sched/fair: Add NOHZ balancer flag for nohz.next_balance updates
In-Reply-To: <YSONmyWL14mqV6zA@hirez.programming.kicks-ass.net>
References: <20210823111700.2842997-1-valentin.schneider@arm.com> <20210823111700.2842997-2-valentin.schneider@arm.com> <YSONmyWL14mqV6zA@hirez.programming.kicks-ass.net>
Date:   Mon, 23 Aug 2021 13:57:46 +0100
Message-ID: <87fsv02u9h.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/21 13:59, Peter Zijlstra wrote:
> On Mon, Aug 23, 2021 at 12:16:59PM +0100, Valentin Schneider wrote:
>
>> Gate NOHZ blocked load
>> update by the presence of NOHZ_STATS_KICK - currently all NOHZ balance
>> kicks will have the NOHZ_STATS_KICK flag set, so no change in behaviour is
>> expected.
>
>> @@ -10572,7 +10572,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>>       * setting the flag, we are sure to not clear the state and not
>>       * check the load of an idle cpu.
>>       */
>> -	WRITE_ONCE(nohz.has_blocked, 0);
>> +	if (flags & NOHZ_STATS_KICK)
>> +		WRITE_ONCE(nohz.has_blocked, 0);
>>
>>      /*
>>       * Ensures that if we miss the CPU, we must see the has_blocked
>> @@ -10594,13 +10595,15 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>>               * balancing owner will pick it up.
>>               */
>>              if (need_resched()) {
>> -			has_blocked_load = true;
>> +			if (flags & NOHZ_STATS_KICK)
>> +				has_blocked_load = true;
>>                      goto abort;
>>              }
>>
>>              rq = cpu_rq(balance_cpu);
>>
>> -		has_blocked_load |= update_nohz_stats(rq);
>> +		if (flags & NOHZ_STATS_KICK)
>> +			has_blocked_load |= update_nohz_stats(rq);
>>
>>              /*
>>               * If time for next balance is due,
>> @@ -10631,8 +10634,9 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>>      if (likely(update_next_balance))
>>              nohz.next_balance = next_balance;
>>
>> -	WRITE_ONCE(nohz.next_blocked,
>> -		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>> +	if (flags & NOHZ_STATS_KICK)
>> +		WRITE_ONCE(nohz.next_blocked,
>> +			   now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>>
>>  abort:
>>      /* There is still blocked load, enable periodic update */
>
> I'm a bit puzzled by this; that function has:
>
>   SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
>
> Which:
>
>  - isn't updated
>  - implies STATS must be set when BALANCE

Yup

>
> the latter gives rise to my confusion; why add that gate on STATS? It
> just doesn't make sense to do a BALANCE and not update STATS.

AFAIA that warning was only there to catch BALANCE && !STATS, so I didn't
tweak it.

Now, you could still end up with

  flags == NOHZ_NEXT_KICK

(e.g. nohz.next_balance is in the future, but a new CPU entered NOHZ-idle
and needs its own rq.next_balance collated into the nohz struct)

in which case you don't do any blocked load update, hence the
gate. In v1 I had that piggyback on NOHZ_STATS_KICK, but Vincent noted
that might not be the best given blocked load updates can be time
consuming - hence the separate flag.
