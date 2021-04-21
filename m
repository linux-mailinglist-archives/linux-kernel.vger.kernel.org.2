Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34377366982
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbhDUKxQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Apr 2021 06:53:16 -0400
Received: from foss.arm.com ([217.140.110.172]:59200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234632AbhDUKxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:53:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448F7113E;
        Wed, 21 Apr 2021 03:52:40 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCD903F73B;
        Wed, 21 Apr 2021 03:52:38 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
In-Reply-To: <CAKfTPtCLNeSzMLO_7uhj13k6CgtzAMhcW5aXJTYUOSYJZi220w@mail.gmail.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com> <20210415175846.494385-3-valentin.schneider@arm.com> <20210416135113.GA16445@vingu-book> <87blaakxji.mognet@arm.com> <CAKfTPtCLNeSzMLO_7uhj13k6CgtzAMhcW5aXJTYUOSYJZi220w@mail.gmail.com>
Date:   Wed, 21 Apr 2021 11:52:36 +0100
Message-ID: <878s5bvrij.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 16:33, Vincent Guittot wrote:
> On Mon, 19 Apr 2021 at 19:13, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> On 16/04/21 15:51, Vincent Guittot wrote:
>> > Le jeudi 15 avril 2021 ï¿½ 18:58:46 (+0100), Valentin Schneider a ï¿½crit :
>> >> +
>> >> +/*
>> >> + * What does migrating this task do to our capacity-aware scheduling criterion?
>> >> + *
>> >> + * Returns 1, if the task needs more capacity than the dst CPU can provide.
>> >> + * Returns 0, if the task needs the extra capacity provided by the dst CPU
>> >> + * Returns -1, if the task isn't impacted by the migration wrt capacity.
>> >> + */
>> >> +static int migrate_degrades_capacity(struct task_struct *p, struct lb_env *env)
>> >> +{
>> >> +    if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
>> >> +            return -1;
>> >> +
>> >> +    if (!task_fits_capacity(p, capacity_of(env->src_cpu))) {
>> >> +            if (cpu_capacity_greater(env->dst_cpu, env->src_cpu))
>> >> +                    return 0;
>> >> +            else if (cpu_capacity_greater(env->src_cpu, env->dst_cpu))
>> >> +                    return 1;
>> >> +            else
>> >> +                    return -1;
>> >> +    }
>> >
>> > Being there means that task fits src_cpu capacity so why testing p against dst_cpu ?
>> >
>>
>> Because if p fits on src_cpu, we don't want to move it to a dst_cpu on
>> which it *doesn't* fit.
>
> OK. I was confused because I thought that this was only to force
> migration in case of group_misfit_task but you tried to extend to
> other cases... I'm not convinced that you succeeded to cover all cases
>
> Also I found this function which returns 3 values a bit disturbing.
> IIUC you tried to align to migrate_degrades_capacity but you should
> have better aligned to task_hot and return only 0 or 1. -1 is not used
>

Ack, will do.

>> >> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>> >>      if (tsk_cache_hot == -1)
>> >>              tsk_cache_hot = task_hot(p, env);
>> >>
>> >> +    /*
>> >> +     * On a (sane) asymmetric CPU capacity system, the increase in compute
>> >> +     * capacity should offset any potential performance hit caused by a
>> >> +     * migration.
>> >> +     */
>> >> +    if ((env->dst_grp_type == group_has_spare) &&
>> >
>> > Shouldn't it be env->src_grp_type == group_misfit_task to only care of misfit task case as
>> > stated in $subject
>> >
>>
>> Previously this was env->idle != CPU_NOT_IDLE, but I figured dst_grp_type
>> could give us a better picture. Staring at this some more, this isn't so
>> true when the group size goes up - there's no guarantees the dst_cpu is the
>> one that has spare cycles, and the other CPUs might not be able to grant
>> the capacity uplift dst_cpu can.
>
> yeah you have to keep checking for env->idle != CPU_NOT_IDLE
>
>>
>> As for not using src_grp_type == group_misfit_task, this is pretty much the
>> same as [1]. CPU-bound (misfit) task + some other task on the same rq
>> implies group_overloaded classification when balancing at MC level (no SMT,
>> so one group per CPU).
>
> Is it something that happens often or just a sporadic/transient state
> ? I mean does it really worth the extra complexity and do you see
> performance improvement ?
>

"Unfortunately" yes, this is a relatively common scenario when running "1
big task per CPU" types of workloads. The expected behaviour for big.LITTLE
systems is to upmigrate tasks stuck on the LITTLE CPUs as soon as a big CPU
becomes free, usually via newidle balance (which, since they process work
faster than the LITTLEs, is bound to happen), and an extra task being
enqueued at "the wrong time" can prevent this from happening.

This usually means a misfit task can take a few dozen extra ms than it
should to be migrated - in the tests I run (which are pretty much this 1
hog per CPU workload) this happens about ~20% of the time.

> You should better focus on fixing the simple case of group_misfit_task
> task. This other cases looks far more complex with lot of corner cases
>
>>
>> [1]: http://lore.kernel.org/r/jhjblcuv2mo.mognet@arm.com
