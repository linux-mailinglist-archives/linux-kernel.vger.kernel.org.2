Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6B142C16F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhJMNfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:35:03 -0400
Received: from foss.arm.com ([217.140.110.172]:39328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhJMNfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:35:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3B31FB;
        Wed, 13 Oct 2021 06:32:58 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 222203F66F;
        Wed, 13 Oct 2021 06:32:57 -0700 (PDT)
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
In-Reply-To: <CAHn4DedEV953QULZLAPOuXyHAw_mWRTdFj8bSm6zk3rNjFJj-A@mail.gmail.com>
References: <20211012083521.973587-1-woodylin@google.com> <87zgrek1gl.mognet@arm.com> <CAHn4Dec0Jyc30vWMLAXwQ-ge4eS5S26hxfMky-e4f-TTtFrbEQ@mail.gmail.com> <87wnmijysj.mognet@arm.com> <CAHn4DedEV953QULZLAPOuXyHAw_mWRTdFj8bSm6zk3rNjFJj-A@mail.gmail.com>
Date:   Wed, 13 Oct 2021 14:32:51 +0100
Message-ID: <87tuhljbi4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/21 09:22, Woody Lin wrote:
> On Tue, Oct 12, 2021 at 6:57 PM Valentin Schneider <valentin.schneider@arm.com> wrote:
>> On 12/10/21 18:35, Woody Lin wrote:
>> > unpoison looks more like an one-time thing to me; the idle tasks will
>> > reuse the same stack pages until system resets, so I think we don't need
>> > to re-unpoison that during hotplugging as long as it's unpoisoned in
>> > 'init_idle'.
>> >
>>
>> I would tend to agree, but was bitten by s390 freeing some memory on
>> hot-unplug and re-allocating it upon hotplug:
>>
>>   6a942f578054 ("s390: preempt: Fix preempt_count initialization")
>>
>> This makes me doubt whether we can assert the idle task stack pages are
>> perennial vs hotplug on all architectures.
>
> I made a quick study on memory-hotplug and seems that only memory contains
> nothing other than migratable pages can be unplugged. So process stack
> pages should not be a concern for this, since which is an unmovable
> memory.
>
> However I don't have a chance to work on a system that enables
> memory-hotplug so far, so couldn't verify this assumption further. Guess
> we can create a separate thread to clarify this more.
>

That sounds sensible; I'll try to dig some more into this.

As for the SCS change, someone might argue for placing this elsewhere in
the hotplug path, but that looks fine to me:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Regards,
> Woody
>
>>
>> >>
>> >> >  }
>> >> >
>> >> > --
>> >> > 2.33.0.882.g93a45727a2-goog
