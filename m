Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31145F27B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhKZQyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:54:33 -0500
Received: from foss.arm.com ([217.140.110.172]:35702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236291AbhKZQwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:52:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B301042;
        Fri, 26 Nov 2021 08:49:19 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86E763F7B4;
        Fri, 26 Nov 2021 08:49:18 -0800 (PST)
From:   Valentin Schneider <Valentin.Schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Vincent Donnefort <Vincent.Donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a task
In-Reply-To: <CAKfTPtC4iXXaptm9+2bHvX2E3xAWU4M3xN0ZuwpFQ1RyXAyxyA@mail.gmail.com>
References: <20211124154239.3191366-1-vincent.donnefort@arm.com> <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com> <8735nkcwov.mognet@arm.com> <CAKfTPtDPskVdEd-KQ_cwe-R_zVFPQOgdbk9x+3eD12pKs8fGFw@mail.gmail.com> <87zgpsb6de.mognet@arm.com> <CAKfTPtCnusWJXJLDEudQ_q8MWaZYbPJK-QjAbBYWFW8Nw-J+Ww@mail.gmail.com> <87sfvjavqk.mognet@arm.com> <CAKfTPtC4iXXaptm9+2bHvX2E3xAWU4M3xN0ZuwpFQ1RyXAyxyA@mail.gmail.com>
Date:   Fri, 26 Nov 2021 16:49:12 +0000
Message-ID: <87pmqmc16f.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/21 15:40, Vincent Guittot wrote:
> On Fri, 26 Nov 2021 at 14:32, Valentin Schneider
> <Valentin.Schneider@arm.com> wrote:
>>         /*
>> -        * Allow a per-cpu kthread to stack with the wakee if the
>> -        * kworker thread and the tasks previous CPUs are the same.
>> -        * The assumption is that the wakee queued work for the
>> -        * per-cpu kthread that is now complete and the wakeup is
>> -        * essentially a sync wakeup. An obvious example of this
>> +        * Allow a per-cpu kthread to stack with the wakee if the kworker thread
>> +        * and the tasks previous CPUs are the same.  The assumption is that the
>> +        * wakee queued work for the per-cpu kthread that is now complete and
>> +        * the wakeup is essentially a sync wakeup. An obvious example of this
>>          * pattern is IO completions.
>> +        *
>> +        * Ensure the wakeup is issued by the kthread itself, and don't match
>> +        * against the idle task because that could override the
>> +        * available_idle_cpu(target) check done higher up.
>>          */
>> -       if (is_per_cpu_kthread(current) &&
>> +       if (is_per_cpu_kthread(current) && !is_idle_task(current) &&
>
> still i don't see the need of !is_idle_task(current)
>

Admittedly, belts and braces. The existing condition checks rq->nr_running <= 1
which can lead to coscheduling when the wakeup is issued by the idle task
(or even if rq->nr_running == 0, you can have rq->ttwu_pending without
having sent an IPI due to polling). Essentially this overrides the first
check in sis() that uses idle_cpu(target) (prev == smp_processor_id() ==
target).

I couldn't prove such wakeups can happen right now, but if/when they do
(AIUI it would just take someone to add a wake_up_process() down some
smp_call_function() callback) then we'll need the above. If you're still
not convinced by now, I won't push it further.

>
>> +           in_task() &&
>>             prev == smp_processor_id() &&
>>             this_rq()->nr_running <= 1) {
>>                 return prev;
>>
