Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1DB36965F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbhDWPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:48:47 -0400
Received: from foss.arm.com ([217.140.110.172]:36342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhDWPsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:48:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 346D11396;
        Fri, 23 Apr 2021 08:48:09 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A39773F774;
        Fri, 23 Apr 2021 08:48:06 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Fix negative energy delta in
 find_energy_efficient_cpu()
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com
Cc:     Lukasz.Luba@arm.com, Vincent.Donnefort@arm.com,
        qais.yousef@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qperret@qperret.net
References: <20210420125604.15796-1-Pierre.Gondois@arm.com>
 <cef37a82-75a8-f51e-522f-57f9a0d1750d@arm.com>
 <9c27a3aa-091d-59fc-1f47-97807954434f@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c6f3ee35-052a-52eb-019a-2cc192aaf4d8@arm.com>
Date:   Fri, 23 Apr 2021 17:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <9c27a3aa-091d-59fc-1f47-97807954434f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2021 11:44, Pierre Gondois wrote:
> Hi Dietmar,
> Thanks for the review,
> 
> On 4/20/21 6:25 PM, Dietmar Eggemann wrote:
> 
>> On 20/04/2021 14:56, Pierre.Gondois@arm.com wrote:
>>> From: Pierre Gondois <Pierre.Gondois@arm.com>

[...]

>> Did you run some tests to make sure you didn't regress on energy
>> consumption? You could run EAS' Energy tests w/ and w/o the patch
>> depicted in:
>>
>> https://lkml.kernel.org/r/20181203095628.11858-1-quentin.perret@arm.com
> 
> 
> I executed the energy test you pointed at using LISA on a Juno-r2 (2xA57
> + 4xA53). The initial tests made by Quentin was on a Juno-r0 and a
> Hikey960.
> 
> To recall the test:
> "10 iterations of between 10 and 50 periodic rt-app tasks (16ms period,
> 5% duty-cycle) for 30 seconds with energy measurement. Unit is Joules.
> The goal is to save energy, so lower is better."
> "Energy is measured with the onboard energy meter. Numbers include
> consumption of big and little CPUs."
> 
> +----------+-----------------+-------------------------+
> |          | Without patches | With patches            |
> +----------+--------+--------+------------------+------+
> | Tasks nb |  Mean  |    CI* | Mean             |  CI* |
> +----------+--------+--------+------------------+------+
> |       10 |   6.57 |   0.24 |   6.46 (-1.69%)  | 0.16 |
> |       20 |  12.44 |   0.21 |  12.40 (-0.33%)  | 0.11 |
> |       30 |  19.10 |   0.78 |  18.93 (-0.89%)  | 0.46 |
> |       40 |  27.27 |   0.53 |  27.49 (+0.81%   | 0.17 |
> |       50 |  36.55 |   0.42 |  37.21 (+1.80%)  | 0.81 |
> +----------+-----------------+-------------------------+
> CI: confidence interval
> 
> For each line, the intervals of values w/ wo/ the patches are
> overlapping (consider Mean +/- CI). Thus, the energy results shouldn't
> have been impacted.

Put this into the patch header so people see some testing has been done.

[...]

>>> +        if (compute_prev_delta) {
>>> +            prev_delta = compute_energy(p, prev_cpu, pd);
>>> +            /* Prevent negative deltas and select prev_cpu */
>> Not sure if this comment helps in understanding the code. We don't
>> comment that we return prev_cpu if !task_util_est(p) or we're not
>> entering the `Pick the best CPU ...` condition.
> I thought it was not obvious how (prev_delta < base_energy_pd) could
> happen. I'm ok to remove the comment, but maybe a sentence should be
> added in the function header or somewhere else.

Agreed. Remove the commend and add text in the patch header to
illustrate how you `fix negative energy delta ...`.

[...]

> Same comment: I'm ok to remove it, but we should explain what happens
> somewhere, maybe in the function header.

Same here.

[...]

>>> @@ -6674,25 +6688,20 @@ static int find_energy_efficient_cpu(struct
>>> task_struct *p, int prev_cpu)
>>>               }
>>>           }
>>>       }
>>> -unlock:
>>> -    rcu_read_unlock();
>> You don't close the RCU read-side critical section here anymore but
>> include the following if condition as well. Don't we always want to
>> close them as quick as possible? We could still return target (prev_cpu)
>> after the if condition below ...
> The computation should not take that long and this would make less code.
> Putting back the rcu_read_unlock() and returning faster instead of
> having a fall-through would also work for me.

I see but I would stay on the save side and keep the RCU read-side
critical section as short as possible.

>>>         /*
>>> -     * Pick the best CPU if prev_cpu cannot be used, or if it saves at
>>> -     * least 6% of the energy used by prev_cpu.
>>> +     * Pick the best CPU if:
>>> +     *  - prev_cpu cannot be used, or
>>> +     *  - it saves at least 6% of the energy used by prev_cpu
>>>        */
>> Why changing the layout of this comment?
> 
> I thought it was clearer to have bullet points. It can be reverted.

Please revert. Keep the changes as small as possible.

[...]
