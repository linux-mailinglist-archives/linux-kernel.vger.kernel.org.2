Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA34454BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhKQR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:29:24 -0500
Received: from foss.arm.com ([217.140.110.172]:32920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237770AbhKQR3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:29:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E67ED6E;
        Wed, 17 Nov 2021 09:26:24 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D85C3F5A1;
        Wed, 17 Nov 2021 09:26:22 -0800 (PST)
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4ecdc3bf-9a20-c6a8-0aff-8bb7e55a7d34@arm.com>
Date:   Wed, 17 Nov 2021 18:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCzP_Xgos-yAiUxnKw_BvP22P5CH3xJjLiUQLeg0a-AxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.21 17:20, Vincent Guittot wrote:
> On Fri, 12 Nov 2021 at 15:14, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> cpu_util_cfs() was created by commit d4edd662ac16 ("sched/cpufreq: Use
>> the DEADLINE utilization signal") to enable the access to CPU
>> utilization from the Schedutil CPUfreq governor.
>>
>> Commit a07630b8b2c1 ("sched/cpufreq/schedutil: Use util_est for OPP
>> selection") added util_est support later.
>>
>> The only thing cpu_util() is doing on top of what cpu_util_cfs() already
>> does is to clamp the return value to the [0..capacity_orig] capacity
>> range of the CPU. Integrating this into cpu_util_cfs() is not harming
>> the existing users (Schedutil and CPUfreq cooling (latter via
>> sched_cpu_util() wrapper)).
> 
> Could you to update cpu_util_cfs() to use cpu as a parameter instead of rq ?

I could but I decided to use use `struct rq *rq` instead.

(A) We already know the rq in the following functions where we call
    cpu_util_cfs():

  update_sg_lb_stats()
  find_busiest_queue()
  update_numa_stats()
  sugov_get_util() (existing cpu_util_cfs() call *)

(B) For the following three functions we would call cpu_rq() outside
    cpu_util_cfs():

  cpu_overutilized()
  cpu_util_without()
  sched_cpu_util() (*)

So for (A) we wouldn't call cpu_rq(cpu) twice, avoiding issues with the
RELOC_HIDE() thing in per_cpu(runqueues, cpu).


And cpu_util_cfs()'s PELT counterparts, cpu_load() and cpu_runnable()
also use rq.

>> Remove cpu_util().
>>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>
>> I deliberately got rid of the comment on top of cpu_util(). It's from
>> the early days of using PELT utilization, it describes CPU utilization
>> behaviour before PELT time-scaling and talks about current capacity
>> which we don't maintain.
> 
> would be good to keep an updated version in this case. There are lot
> of interesting informations in the comment

Yes, can do.

Something like this:

/**
 * cpu_util_cfs() - Estimates the amount of CPU capacity used by CFS tasks.
 * @cpu: the CPU to get the utilization for.
 *
 * The unit of the return value must be the same as the one of CPU capacity
 * so that CPU utilization can be compared with CPU capacity.
 *
 * CPU utilization is the sum of running time of runnable tasks plus the
 * recent utilization of currently non-runnable tasks on that CPU.
 * It represents the amount of CPU capacity currently used by CFS tasks in
 * the range [0..max CPU capacity] with max CPU capacity being the CPU
 * capacity at f_max.
 *
 * The estimated CPU utilization is defined as the maximum between CPU
 * utilization and sum of the estimated utilization of the currently
 * runnable tasks on that CPU. It preserves a utilization "snapshot" of
 * previously-executed tasks, which helps better deduce how busy a CPU will
 * be when a long-sleeping task wake up. Such task's contribution to CPU
 * utilization would be decayed significantly at this point of time.
 *
 * CPU utilization can be higher than the current CPU capacity
 * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
 * of rounding errors as well as task migrations or wakeups of new tasks.
 * CPU utilization has to be capped to fit into the [0..max CPU capacity]
 * range. Otherwise a group of CPUs (CPU0 util = 121% + CPU1 util = 80%)
 * could be seen as over-utilized even though CPU1 has 20% of spare CPU
 * capacity. CPU utilization is allowed to overshoot current CPU capacity
 * though since this is useful for predicting the CPU capacity required
 * after task migrations (scheduler-driven DVFS).
 *
 * Return: (Estimated) utilization for the specified CPU.
 */

[...]
