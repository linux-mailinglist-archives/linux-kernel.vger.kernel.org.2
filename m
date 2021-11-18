Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41CD456049
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhKRQUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:20:21 -0500
Received: from foss.arm.com ([217.140.110.172]:42694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232858AbhKRQUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:20:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E66981042;
        Thu, 18 Nov 2021 08:17:19 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDB823F766;
        Thu, 18 Nov 2021 08:17:17 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Replace CFS internal cpu_util() with
 cpu_util_cfs()
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org
References: <20211112141349.155713-1-dietmar.eggemann@arm.com>
 <CAKfTPtCzP_Xgos-yAiUxnKw_BvP22P5CH3xJjLiUQLeg0a-AxQ@mail.gmail.com>
 <4ecdc3bf-9a20-c6a8-0aff-8bb7e55a7d34@arm.com>
 <CAKfTPtBZdpxMPP4-uRqmCxavKosf4NL14SF1S6=mrKJjVfX+Pw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2a800d9c-2dfc-e901-da46-5f858d6abd57@arm.com>
Date:   Thu, 18 Nov 2021 17:17:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBZdpxMPP4-uRqmCxavKosf4NL14SF1S6=mrKJjVfX+Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.21 09:07, Vincent Guittot wrote:
> On Wed, 17 Nov 2021 at 18:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 12.11.21 17:20, Vincent Guittot wrote:
>>> On Fri, 12 Nov 2021 at 15:14, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> cpu_util_cfs() was created by commit d4edd662ac16 ("sched/cpufreq: Use
>>>> the DEADLINE utilization signal") to enable the access to CPU
>>>> utilization from the Schedutil CPUfreq governor.
>>>>
>>>> Commit a07630b8b2c1 ("sched/cpufreq/schedutil: Use util_est for OPP
>>>> selection") added util_est support later.
>>>>
>>>> The only thing cpu_util() is doing on top of what cpu_util_cfs() already
>>>> does is to clamp the return value to the [0..capacity_orig] capacity
>>>> range of the CPU. Integrating this into cpu_util_cfs() is not harming
>>>> the existing users (Schedutil and CPUfreq cooling (latter via
>>>> sched_cpu_util() wrapper)).
>>>
>>> Could you to update cpu_util_cfs() to use cpu as a parameter instead of rq ?
>>
>> I could but I decided to use use `struct rq *rq` instead.
>>
>> (A) We already know the rq in the following functions where we call
>>     cpu_util_cfs():
> 
> The only user of cpu_util_cfs() is sugov_get_util() and it does
> cpu_util_cfs(cpu_rq(sg_cpu->cpu)) because rq is only used as a
> parameter of cpu_util_cfs()

Sure, I guess there is another user currently: cpufreq_cooling

get_load() -> sched_cpu_util() ->
effective_cpu_util(..., cpu_util_cfs(cpu_rq(cpu)), ...)
                        ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> all other ones are using cpu_util() which already uses cpu as a
> parameter so it's more straight forward to keep using cpu

OK, will do it this way, just wanted to mention the possibility to save
some of these cpu_rq(cpu) calls.

[...]

>> /**
>>  * cpu_util_cfs() - Estimates the amount of CPU capacity used by CFS tasks.
>>  * @cpu: the CPU to get the utilization for.
> 
> cpu is clearly the right parameter ;-)

Not very clever of me ;-)

[...]
