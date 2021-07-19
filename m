Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10313CEC6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377890AbhGSRcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:32:15 -0400
Received: from foss.arm.com ([217.140.110.172]:36276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346338AbhGSPsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:48:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B00F1FB;
        Mon, 19 Jul 2021 09:28:50 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C87B3F73D;
        Mon, 19 Jul 2021 09:28:49 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 2/2] sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle
In-Reply-To: <e8dffbaf-71cb-d3b3-04e8-64fc8e6256af@arm.com>
References: <20210719103117.3624936-1-valentin.schneider@arm.com> <20210719103117.3624936-3-valentin.schneider@arm.com> <e8dffbaf-71cb-d3b3-04e8-64fc8e6256af@arm.com>
Date:   Mon, 19 Jul 2021 17:28:44 +0100
Message-ID: <878s22mfnn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/21 17:24, Dietmar Eggemann wrote:
> On 19/07/2021 12:31, Valentin Schneider wrote:
>
> [...]
>
>> @@ -10351,6 +10352,9 @@ static void nohz_balancer_kick(struct rq *rq)
>>  unlock:
>>      rcu_read_unlock();
>>  out:
>> +	if (READ_ONCE(nohz.needs_update))
>> +		flags |= NOHZ_NEXT_KICK;
>> +
>
> Since NOHZ_NEXT_KICK is part of NOHZ_KICK_MASK, some conditions above
> will already set it in flags. Is this intended?

So if no kick would be issued (e.g. flags == 0 because nohz.next_balance is
later in the future), then this does the right thing and issues a
NOHZ_NEXT_KICK one.

However you're right to point out that even if nohz.needs_update is false,
we can set NOHZ_NEXT_KICK into the ilb rq's NOHZ flags due to it being
included in NOHZ_KICK_MASK, which I think is a mistake. Looking at it now,
it shouldn't be part of NOHZ_KICK_MASK.

>
>>      if (flags)
>>              kick_ilb(flags);
>>  }
>> @@ -10447,12 +10451,13 @@ void nohz_balance_enter_idle(int cpu)
>>      /*
>>       * Ensures that if nohz_idle_balance() fails to observe our
>>       * @idle_cpus_mask store, it must observe the @has_blocked
>> -	 * store.
>> +	 * and @needs_update stores.
>>       */
>>      smp_mb__after_atomic();
>>
>>      set_cpu_sd_state_idle(cpu);
>>
>> +	WRITE_ONCE(nohz.needs_update, 1);
>>  out:
>>      /*
>>       * Each time a cpu enter idle, we assume that it has blocked load and
>> @@ -10501,13 +10506,17 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>
> function header would need update to incorporate the new 'update
> nohz.next_balance' functionality. It only talks about 'update of blocked
> load' and 'complete load balance' so far.
>
>>      /*
>>       * We assume there will be no idle load after this update and clear
>>       * the has_blocked flag. If a cpu enters idle in the mean time, it will
>> -	 * set the has_blocked flag and trig another update of idle load.
>> +	 * set the has_blocked flag and trigger another update of idle load.
>>       * Because a cpu that becomes idle, is added to idle_cpus_mask before
>>       * setting the flag, we are sure to not clear the state and not
>>       * check the load of an idle cpu.
>> +	 *
>> +	 * Same applies to idle_cpus_mask vs needs_update.
>>       */
>>      if (flags & NOHZ_STATS_KICK)
>>              WRITE_ONCE(nohz.has_blocked, 0);
>> +	if (flags & NOHZ_NEXT_KICK)
>> +		WRITE_ONCE(nohz.needs_update, 0);
>>
>>      /*
>>       * Ensures that if we miss the CPU, we must see the has_blocked
>> @@ -10531,6 +10540,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>>              if (need_resched()) {
>>                      if (flags & NOHZ_STATS_KICK)
>>                              has_blocked_load = true;
>
> This looks weird now? 'has_blocked_load = true' vs
> 'WRITE_ONCE(nohz.needs_update, 1)'.
>

Well, has_blocked_load lets us factorize the nohz.has_blocked write
(one is needed either when aborting or at the tail of the cpumask
iteration), whereas there is just a single write for nohz.needs_update
(when aborting).

>> +			if (flags & NOHZ_NEXT_KICK)
>> +				WRITE_ONCE(nohz.needs_update, 1);
>>                      goto abort;
>>              }
>>
>>
