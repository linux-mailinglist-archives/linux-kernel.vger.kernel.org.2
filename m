Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0D137A3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhEKJec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:34:32 -0400
Received: from foss.arm.com ([217.140.110.172]:43834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhEKJeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:34:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B9691692;
        Tue, 11 May 2021 02:33:18 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 227493F719;
        Tue, 11 May 2021 02:33:17 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, bristot@redhat.com, yejune.deng@gmail.com
Subject: Re: [PATCH 1/2] sched: Make the idle task quack like a per-CPU kthread
In-Reply-To: <YJozF+wmiMYuSa6/@gmail.com>
References: <20210510151024.2448573-1-valentin.schneider@arm.com> <20210510151024.2448573-2-valentin.schneider@arm.com> <87k0o6int0.mognet@arm.com> <YJozF+wmiMYuSa6/@gmail.com>
Date:   Tue, 11 May 2021 10:33:08 +0100
Message-ID: <871rad399n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/21 09:32, Ingo Molnar wrote:
> * Valentin Schneider <valentin.schneider@arm.com> wrote:
>> AFAICT the extra calls are due to idle_thread_get() (used in cpuhp)
>> calling init_idle(). However it looks to me that since
>>
>>   3bb5d2ee396a ("smp, idle: Allocate idle thread for each possible cpu during boot")
>>
>> we don't need to do that: we already have a
>>
>>   for_each_possible_cpu(cpu)
>>     init_idle(cpu)
>>
>> issued at init. So can't we "simply" rely on that init-time creation,
>> given it's done against the possible mask? I think the only thing that
>> might need doing at later hotplug is making sure the preempt count is
>> right (secondary startups seem to all prepare the idle task by issuing a
>> preempt_disable()).
>
> Best-case it works, worst-case we discover an unclean assumption in the
> init sequence and it works after we fix that.
>
> Win-win. :-)
>

Well I got something that seems to work, let me it test it some more and
convince myself it isn't completely bonkers and I'll toss it out.

> Thanks,
>
>       Ingo
