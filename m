Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96644313E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhBHTKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:10:45 -0500
Received: from foss.arm.com ([217.140.110.172]:39190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234365AbhBHRuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:50:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A75101042;
        Mon,  8 Feb 2021 09:49:10 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4997E3F73D;
        Mon,  8 Feb 2021 09:49:09 -0800 (PST)
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
In-Reply-To: <CAKfTPtA0FXsz7_T+t4WfYjhwuGNeKzbJJJoZNkD6Gz6yDf_ebA@mail.gmail.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-4-valentin.schneider@arm.com> <CAKfTPtADn0X8=ENfvG5dhzM1KbTD+JCCoOm-i8=bVkh0ZBM2Xg@mail.gmail.com> <jhjv9b61md0.mognet@arm.com> <CAKfTPtB_aJE0uDmARvKGe8_oX0Goaada_C5HKy7aaTbFGLxU-A@mail.gmail.com> <jhjsg6a1doz.mognet@arm.com> <CAKfTPtA0FXsz7_T+t4WfYjhwuGNeKzbJJJoZNkD6Gz6yDf_ebA@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Mon, 08 Feb 2021 17:49:00 +0000
Message-ID: <jhjmtwe1mcz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/21 16:29, Vincent Guittot wrote:
> On Fri, 5 Feb 2021 at 21:07, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> Perhaps I can still keep 5/8 with something like
>>
>>   if (!rq->misfit_task_load)
>>           return false;
>>
>>   do {
>>           if (capacity_greater(group->sgc->max_capacity, rq->cpu_capacity))
>>                   return true;
>>
>>           group = group->next;
>>   } while (group != sd->groups);
>
> I don't catch what you want to achieve with this  while loop compared
> to the original condition which is :
> trigger a load_balance :
> - if there is CPU with higher original capacity
> - or if the capacity of this cpu has significantly reduced because of
> pressure and there is maybe others with more capacity even if it's one
> with highest original capacity
>

If we had a root-domain-wide (dynamic) capacity maximum, we could make
check_misfit_status() return false if the CPU *is* pressured but there is
no better alternative - e.g. if all other CPUs are pressured even worse.

This isn't a correctness issue as the nohz load-balance will just not
migrate the misfit task, but it would be nice to prevent the nohz kick
altogether.

I might ditch this for now and revisit it later.

>>
>>   return false;
>>
>> This works somewhat well for big.LITTLE, but for DynamIQ systems under a
>> single L3 this ends up iterating over all the CPUs :/
