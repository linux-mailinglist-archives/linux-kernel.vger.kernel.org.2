Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E773111F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhBES1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:27:16 -0500
Received: from foss.arm.com ([217.140.110.172]:41352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhBESZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:25:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD627ED1;
        Fri,  5 Feb 2021 12:07:14 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AA4C3F718;
        Fri,  5 Feb 2021 12:07:13 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 3/8] sched/fair: Tweak misfit-related capacity checks
In-Reply-To: <CAKfTPtB_aJE0uDmARvKGe8_oX0Goaada_C5HKy7aaTbFGLxU-A@mail.gmail.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-4-valentin.schneider@arm.com> <CAKfTPtADn0X8=ENfvG5dhzM1KbTD+JCCoOm-i8=bVkh0ZBM2Xg@mail.gmail.com> <jhjv9b61md0.mognet@arm.com> <CAKfTPtB_aJE0uDmARvKGe8_oX0Goaada_C5HKy7aaTbFGLxU-A@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 05 Feb 2021 20:07:08 +0000
Message-ID: <jhjsg6a1doz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 18:17, Vincent Guittot wrote:
> On Fri, 5 Feb 2021 at 18:00, Valentin Schneider
>> >> @@ -8253,7 +8260,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>> >>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
>> >>  {
>> >>         return rq->misfit_task_load &&
>> >> -               (rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
>> >> +               (capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity_orig) ||
>> >
>> > Why do you add a margin here whereas there was no margin before ?
>> >
>>
>> Comparing capacities without any sort of filter can lead to ping-ponging
>> tasks around (capacity values very easily fluctuate by +/- 1, if not more).
>
> max_cpu_capacity reflects the max of the cpu_capacity_orig values
> don't aim to change and can be considered as static values.
> It would be better to fix this rounding problem (if any) in
> topology_get_cpu_scale instead of computing a margin every time it's
> used
>

That's embarrassing, I was convinced we had something updating
rd->max_cpu_capacity with actual rq->capacity values... But as you point
out that's absolutely not the case, it's all based on rq->capacity_orig,
which completely invalidates patch 5/8.

Welp.

Perhaps I can still keep 5/8 with something like

  if (!rq->misfit_task_load)
          return false;

  do {
          if (capacity_greater(group->sgc->max_capacity, rq->cpu_capacity))
                  return true;

          group = group->next;
  } while (group != sd->groups);

  return false;

This works somewhat well for big.LITTLE, but for DynamIQ systems under a
single L3 this ends up iterating over all the CPUs :/
