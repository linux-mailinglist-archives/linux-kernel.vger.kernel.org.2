Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F53CA0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhGOOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:54:17 -0400
Received: from foss.arm.com ([217.140.110.172]:53382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231745AbhGOOyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:54:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8664B6D;
        Thu, 15 Jul 2021 07:51:22 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2B853F774;
        Thu, 15 Jul 2021 07:51:21 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/fair: Update nohz.next_balance for newly NOHZ-idle CPUs
In-Reply-To: <CAKfTPtCdKK97_6m5C9Jp1yDLraJqm7PF-XL+0h64Bmab-4Px+g@mail.gmail.com>
References: <20210714113928.2795632-1-valentin.schneider@arm.com> <CAKfTPtCKJEgm=hXkKz0pHDE2d3Bz+6wp1kkNB+P+OpzWcR1+wg@mail.gmail.com> <87lf67n63p.mognet@arm.com> <CAKfTPtCdKK97_6m5C9Jp1yDLraJqm7PF-XL+0h64Bmab-4Px+g@mail.gmail.com>
Date:   Thu, 15 Jul 2021 15:51:19 +0100
Message-ID: <87fswfmxzs.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/21 15:01, Vincent Guittot wrote:
> On Thu, 15 Jul 2021 at 13:56, Valentin Schneider <valentin.schneider@arm.com> wrote:
>> On 15/07/21 09:42, Vincent Guittot wrote:
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 44e44c235f1f..91c314f58982 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -10657,6 +10657,9 @@ static void nohz_newidle_balance(struct rq *this_rq)
>> >         if (this_rq->avg_idle < sysctl_sched_migration_cost)
>> >                 return;
>> >
>> > +       if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance))
>> > +               WRITE_ONCE(nohz.need_update, 1);
>> > +
>>
>> I think we have to do this unconditionally, as we can observe the old
>> nohz.next_balance while a NOHZ balance is ongoing (which will update
>> nohz.next_balance without taking into account this newly idle CPU).
>
> so maybe add this in nohz_balance_enter_idle() after the
> smp_mb__after_atomic(). Ilb will see the cpu in the idle_cpus_mask so
> even if nohz.next_balance is updated, it will take into account this
> newly idle cpu
>
> My goal was to use mechanism similar to what is used of nohz.has_blocked
>

OK, and then clearing it above the smp_mb() in _nohz_idle_balance() should
give us similar guarantees to nohz.has_blocked (i.e. if we don't observe
the cpumask write, then we'll observe the needs_update write).

Thanks for the suggestion, I'll go test this out.
