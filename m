Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B152733DB08
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhCPRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:32:00 -0400
Received: from foss.arm.com ([217.140.110.172]:52540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231637AbhCPRbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:31:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3918831B;
        Tue, 16 Mar 2021 10:31:39 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD80B3F70D;
        Tue, 16 Mar 2021 10:31:37 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v3 1/7] sched/fair: Ignore percpu threads for imbalance pulls
In-Reply-To: <bdea6c4f-262b-c3cb-637e-d4896e688dd3@arm.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com> <20210311120527.167870-2-valentin.schneider@arm.com> <bdea6c4f-262b-c3cb-637e-d4896e688dd3@arm.com>
Date:   Tue, 16 Mar 2021 17:31:32 +0000
Message-ID: <87pmzzronf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/21 16:49, Dietmar Eggemann wrote:
> On 11/03/2021 13:05, Valentin Schneider wrote:
>> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
>>
>> In load balancing, when balancing group is unable to pull task
>> due to ->cpus_ptr constraints from busy group, then it sets
>> LBF_SOME_PINNED to lb env flags, as a consequence, sgc->imbalance
>> is set for its parent domain level. which makes the group
>> classified as imbalance to get help from another balancing cpu.
>>
>> Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and
>
> Does it have to be a big.LITTLE system? I assume this issue also happens
> on an SMP system.
>

Aye, though the consequences are "worse" on asym CPU capacity systems.

>> CPUs 2-3 as Bigs with below scenario:
>> - CPU0 doing newly_idle balancing
>> - CPU1 running percpu kworker and RT task (small tasks)
>
> What's the role of the small RT task here in the story?
>

I don't think it matters much here.

>> - CPU2 running 2 big tasks
>> - CPU3 running 1 medium task
>>
>> While CPU0 is doing newly_idle load balance at MC level, it fails to
>> pull percpu kworker from CPU1 and sets LBF_SOME_PINNED to lb env flag
>> and set sgc->imbalance at DIE level domain. As LBF_ALL_PINNED not cleared,
>> it tries to redo the balancing by clearing CPU1 in env cpus, but it don't
>> find other busiest_group, so CPU0 stops balacing at MC level without
>> clearing 'sgc->imbalance' and restart the load balacing at DIE level.
>>
>> And CPU0 (balancing cpu) finds LITTLE's group as busiest_group with group
>> type as imbalance, and Bigs that classified the level below imbalance type
>> would be ignored to pick as busiest, and the balancing would be aborted
>> without pulling any tasks (by the time, CPU1 might not have running tasks).
>>
>> It is suboptimal decision to classify the group as imbalance due to
>> percpu threads. So don't use LBF_SOME_PINNED for per cpu threads.
>
> This sentence mentioned per-cpu threads (and so does the patch name) but
> the implementation (only) deals with per-cpu kernel threads. IMHO, it
> would be good to align this.
>

Tell you what, I'll go for:
1) how can pcpu kthreads cause LBF_SOME_PINNED
2) why we may not want this, but still ignore !kthread pcpu tasks
3) why this is even more important for big.LITTLE
