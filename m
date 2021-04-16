Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D69361DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbhDPJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:44:07 -0400
Received: from foss.arm.com ([217.140.110.172]:37412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235027AbhDPJoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:44:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AF21106F;
        Fri, 16 Apr 2021 02:43:42 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCC153FA35;
        Fri, 16 Apr 2021 02:43:40 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
In-Reply-To: <a5abd06c61e4152b483043f8b180ba041f0464d1.camel@surriel.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com> <20210415175846.494385-3-valentin.schneider@arm.com> <a5abd06c61e4152b483043f8b180ba041f0464d1.camel@surriel.com>
Date:   Fri, 16 Apr 2021 10:43:38 +0100
Message-ID: <87tuo6lg39.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/21 16:39, Rik van Riel wrote:
> On Thu, 2021-04-15 at 18:58 +0100, Valentin Schneider wrote:
>> Consider the following topology:
>>
>> Long story short, preempted misfit tasks are affected by task_hot(),
>> while
>> currently running misfit tasks are intentionally preempted by the
>> stopper
>> task to migrate them over to a higher-capacity CPU.
>>
>> Align detach_tasks() with the active-balance logic and let it pick a
>> cache-hot misfit task when the destination CPU can provide a capacity
>> uplift.
>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>
> Reviewed-by: Rik van Riel <riel@surriel.com>
>

Thanks!

>
> This patch looks good, but...
>
>> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p,
>> struct lb_env *env)
>>      if (tsk_cache_hot == -1)
>>              tsk_cache_hot = task_hot(p, env);
>>
>> +	/*
>> +	 * On a (sane) asymmetric CPU capacity system, the increase in
>> compute
>> +	 * capacity should offset any potential performance hit caused
>> by a
>> +	 * migration.
>> +	 */
>> +	if ((env->dst_grp_type == group_has_spare) &&
>> +	    !migrate_degrades_capacity(p, env))
>> +		tsk_cache_hot = 0;
>
> ... I'm starting to wonder if we should not rename the
> tsk_cache_hot variable to something else to make this
> code more readable. Probably in another patch :)
>

I'd tend to agree, but naming is hard. "migration_harmful" ?

> --
> All Rights Reversed.
