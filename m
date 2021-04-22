Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC127368716
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhDVTUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:20:13 -0400
Received: from foss.arm.com ([217.140.110.172]:55162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236665AbhDVTUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:20:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE2B811D4;
        Thu, 22 Apr 2021 12:19:36 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 702183F694;
        Thu, 22 Apr 2021 12:19:35 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 1/2] sched/fair: Filter out locally-unsolvable misfit imbalances
In-Reply-To: <519f7b86-851b-24f7-39aa-4bbdce5c7cd3@arm.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com> <20210415175846.494385-2-valentin.schneider@arm.com> <519f7b86-851b-24f7-39aa-4bbdce5c7cd3@arm.com>
Date:   Thu, 22 Apr 2021 20:19:30 +0100
Message-ID: <87r1j2t9dp.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 11:48, Dietmar Eggemann wrote:
> On 15/04/2021 19:58, Valentin Schneider wrote:
>
> [...]
>
>> Aggregate a misfit task's load into sgs->group_misfit_task_load only if
>> env->dst_cpu would grant it a capacity uplift.
>>
>> Note that the aforementioned capacity vs sgc->max_capacity comparison was
>> meant to prevent misfit task downmigration: candidate groups classified as
>> group_misfit_task but with a higher (max) CPU capacity than the destination CPU
>> would be discarded. This change makes it so said group_misfit_task
>> classification can't happen anymore, which may cause some undesired
>> downmigrations.
>>
>> Further tweak find_busiest_queue() to ensure this doesn't happen.
>
> Maybe you can describe shortly here what's the new mechanism is you
> replace the old 'prevent misfit task downmigration' with.
>

Will do.

> Also note
>> find_busiest_queue() can now iterate over CPUs with a higher capacity than
>> the local CPU's, so add a capacity check there.
>
> [...]
>
>> +static inline void update_sg_lb_misfit_stats(struct lb_env *env,
>> +					     struct sched_group *group,
>
> Seems to be not used.
>

Right, that's an update_sg_lb_stats() copy/paste fail :-)

>
>> @@ -9288,6 +9310,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>>      if (!sds.busiest)
>>              goto out_balanced;
>>
>> +	env->src_grp_type = busiest->group_type;
>
> Maybe a short comment why you set it here in fbg(). It's only used later
> in fbq() for asym. CPU capacity sd but is set unconditionally.
>

Seeing as almost every other line there has an accompanying comment, I
think I'll do that.

> [...]
