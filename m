Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6014311722
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBEXa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:30:29 -0500
Received: from foss.arm.com ([217.140.110.172]:35236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232578AbhBEOX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:23:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1EBA31B;
        Fri,  5 Feb 2021 06:05:41 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EDC63F719;
        Fri,  5 Feb 2021 06:05:40 -0800 (PST)
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
Subject: Re: [PATCH 1/8] sched/fair: Clean up active balance nr_balance_failed trickery
In-Reply-To: <CAKfTPtDrKrkZBQuaFSGvRo=aQAdF0vugxWervQpWeza21XL=yw@mail.gmail.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-2-valentin.schneider@arm.com> <CAKfTPtDrKrkZBQuaFSGvRo=aQAdF0vugxWervQpWeza21XL=yw@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 05 Feb 2021 14:05:35 +0000
Message-ID: <jhjy2g21ufk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 14:51, Vincent Guittot wrote:
> On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> When triggering an active load balance, sd->nr_balance_failed is set to
>> such a value that any further can_migrate_task() using said sd will ignore
>> the output of task_hot().
>>
>> This behaviour makes sense, as active load balance intentionally preempts a
>> rq's running task to migrate it right away, but this asynchronous write is
>> a bit shoddy, as the stopper thread might run active_load_balance_cpu_stop
>> before the sd->nr_balance_failed write either becomes visible to the
>> stopper's CPU or even happens on the CPU that appended the stopper work.
>>
>> Add a struct lb_env flag to denote active balancing, and use it in
>> can_migrate_task(). Remove the sd->nr_balance_failed write that served the
>> same purpose.
>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  kernel/sched/fair.c | 17 ++++++++++-------
>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 197a51473e0c..0f6a4e58ce3c 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7423,6 +7423,7 @@ enum migration_type {
>>  #define LBF_SOME_PINNED        0x08
>>  #define LBF_NOHZ_STATS 0x10
>>  #define LBF_NOHZ_AGAIN 0x20
>> +#define LBF_ACTIVE_LB  0x40
>>
>>  struct lb_env {
>>         struct sched_domain     *sd;
>> @@ -7608,10 +7609,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>
>>         /*
>>          * Aggressive migration if:
>> -        * 1) destination numa is preferred
>> -        * 2) task is cache cold, or
>> -        * 3) too many balance attempts have failed.
>> +        * 1) active balance
>> +        * 2) destination numa is preferred
>> +        * 3) task is cache cold, or
>> +        * 4) too many balance attempts have failed.
>>          */
>> +       if (env->flags & LBF_ACTIVE_LB)
>> +               return 1;
>> +
>
> This changes the behavior for numa system because it skips
> migrate_degrades_locality() which can return 1 and prevent active
> migration whatever nr_balance_failed
>
> Is that intentional ?
>

If I read this right, the result of migrate_degrades_locality() is
(currently) ignored if

  env->sd->nr_balance_failed > env->sd->cache_nice_tries

While on the load_balance() side, we have:

  /* We've kicked active balancing, force task migration. */
  sd->nr_balance_failed = sd->cache_nice_tries+1;

So we should currently be ignoring migrate_degrades_locality() in the
active balance case - what I wrote in the changelog for task_hot() still
applies to migrate_degrades_locality().
