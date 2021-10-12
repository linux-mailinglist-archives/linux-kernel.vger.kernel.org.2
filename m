Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E657542A2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhJLK7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:59:40 -0400
Received: from foss.arm.com ([217.140.110.172]:35274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236036AbhJLK7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:59:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E050D101E;
        Tue, 12 Oct 2021 03:57:35 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E9B3F694;
        Tue, 12 Oct 2021 03:57:34 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Woody Lin <woodylin@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Ben Segall <bsegall@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/scs: Reset the shadow stack when idle_task_exit
In-Reply-To: <CAHn4Dec0Jyc30vWMLAXwQ-ge4eS5S26hxfMky-e4f-TTtFrbEQ@mail.gmail.com>
References: <20211012083521.973587-1-woodylin@google.com> <87zgrek1gl.mognet@arm.com> <CAHn4Dec0Jyc30vWMLAXwQ-ge4eS5S26hxfMky-e4f-TTtFrbEQ@mail.gmail.com>
Date:   Tue, 12 Oct 2021 11:57:32 +0100
Message-ID: <87wnmijysj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 18:35, Woody Lin wrote:
> On Tue, Oct 12, 2021 at 6:00 PM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> So AIUI for SCS that works just fine - one thing I'm unclear on is how the
>> following pops are going to work given the SP reset happens in the middle
>> of a call stack, but AFAICT that was already the case before I messed about
>> with init_idle(), so that must already be handled.
>
> Hi Valentin,
>
> Thanks for the question. The 'scs_task_reset' here resets only the
> '.thread_info.scs_sp' of the task, so the register (on arm64 it's x18)
> is still pointing to the same location for popping and storing call
> frames. The register will be updated to '.thread_info.scs_sp' in
> '__secondary_switched', which starts a new core and there is no popping
> after the updating, so it won't introduce an underflow.
>

I think I got it; __secondary_switched() -> init_cpu_task() -> scs_load()

Thanks!

>>
>> I'm not familiar enough with KASAN to say whether that
>> kasan_unpoison_task_stack() should rather happen upon hotplugging the CPU
>> back (rather than on hot-unplug). If that is the case, then maybe somewhere
>> around cpu_startup_entry() might work (and then you could bunch these two
>> "needs to be re-run at init for the idle task" functions into a common
>> helper).
>
> unpoison looks more like an one-time thing to me; the idle tasks will
> reuse the same stack pages until system resets, so I think we don't need
> to re-unpoison that during hotplugging as long as it's unpoisoned in
> 'init_idle'.
>

I would tend to agree, but was bitten by s390 freeing some memory on
hot-unplug and re-allocating it upon hotplug:

  6a942f578054 ("s390: preempt: Fix preempt_count initialization")

This makes me doubt whether we can assert the idle task stack pages are
perennial vs hotplug on all architectures.

>>
>> >  }
>> >
>> > --
>> > 2.33.0.882.g93a45727a2-goog
