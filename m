Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20D83A3FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhFKKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:14:33 -0400
Received: from foss.arm.com ([217.140.110.172]:53874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhFKKOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:14:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D32051396;
        Fri, 11 Jun 2021 03:12:34 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 371A43F694;
        Fri, 11 Jun 2021 03:12:34 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about a8ea6fc9b089 ("sched: Stop PF_NO_SETAFFINITY from being inherited by various init system threads")
In-Reply-To: <20210610201713.GU4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210610170435.GA2187550@paulmck-ThinkPad-P17-Gen-1> <8735tpd15i.mognet@arm.com> <20210610201713.GU4397@paulmck-ThinkPad-P17-Gen-1>
Date:   Fri, 11 Jun 2021 11:12:29 +0100
Message-ID: <87zgvwbtgy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/21 13:17, Paul E. McKenney wrote:
> On Thu, Jun 10, 2021 at 07:28:57PM +0100, Valentin Schneider wrote:
>> On 10/06/21 10:04, Paul E. McKenney wrote:
>>
>> Hi,
>> > Hello, Frederic,
>> >
>> > This commit works well, but has the unfortunate side-effect of making
>> > smp_processor_id() complain when used in a preemptible region even
>> > though the kthread has been pinned onto a single CPU by a call to
>> > set_cpus_allowed_ptr().  (Which did return success.)
>> >
>>
>> On which tree are you encountering this?
>
> I bisected to this commit in -next tag next-20210609, and this commit
> could of course be an innocent bystander caught in the crossfire.
>
>> Looking at check_preemption_disabled() and CPU affinity, v5.13-rc5 has:
>>
>>         /*
>>          * Kernel threads bound to a single CPU can safely use
>>          * smp_processor_id():
>>          */
>>         if (current->nr_cpus_allowed == 1)
>>                 goto out;
>>
>> tip/sched/core additionally hinges that on PF_NO_SETAFFINITY:
>>
>>   570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed")
>>
>> The former shouldn't be affected by Frederic's patch, and the latter should
>> only cause warnings if the pinned task isn't a "proper" kthread (thus
>> doesn't have PF_NO_SETAFFINITY)... Exceptions that come to mind are things
>> like UMH which doesn't use kthread_create().
>
> And reverting 570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread()
> instead of nr_cpus_allowed") causes the kernel to once again be OK with
> smp_processor_id(), so thank you!  And apologies to Frederic for the
> false alarm.
>
> Added Yejune on CC.  Thoughts?
>

The way I see 570a752b7a9b is that, if a task is pinned to a single CPU but
doesn't have PF_NO_SETAFFINITY, then userspace can unpin it. This means it
ought to have entered check_preemption_disabled() with preemption disabled
- right now it may be pinned, but that can change at any minute, and
whatever code it is running needs to cope with that.

Could you share some details on which tasks you are hitting this with?
