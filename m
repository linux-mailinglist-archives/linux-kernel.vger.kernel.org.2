Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79644AD82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbhKIMc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:32:26 -0500
Received: from foss.arm.com ([217.140.110.172]:33146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhKIMcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:32:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 188BDED1;
        Tue,  9 Nov 2021 04:29:39 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26B0F3F7F5;
        Tue,  9 Nov 2021 04:29:37 -0800 (PST)
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xuewen.yan@unisoc.com, Ke Wang <Ke.Wang@unisoc.com>
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org>
 <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
 <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com>
 <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
 <85c81ab7-49ed-aba5-6221-ea6a8f37f8ad@arm.com>
 <CAB8ipk_0YxWnS-k+HLPnL7DRR1MM+WH-xQfna7jD_+TQ0vKi8Q@mail.gmail.com>
 <CAGWkznGNb2X_V1ppD2AjBxaKrey_A7U==XO_bnXoNAh2emLs8A@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <25828616-1976-6e24-cd7d-a95b789f1bc0@arm.com>
Date:   Tue, 9 Nov 2021 13:29:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAGWkznGNb2X_V1ppD2AjBxaKrey_A7U==XO_bnXoNAh2emLs8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2021 10:20, Zhaoyang Huang wrote:
> On Mon, Nov 8, 2021 at 4:49 PM Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>>
>> Hi Dietmar
>>
>> On Sat, Nov 6, 2021 at 1:20 AM Dietmar Eggemann
>> <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 05/11/2021 06:58, Zhaoyang Huang wrote:

[...]

>>>>> This will let the idle task (swapper) pass. Is this indented? Or do you
>>>>> want to only let CFS tasks (including SCHED_IDLE) pass?
>>>> idle tasks will NOT call psi_memstall_xxx. We just want CFS tasks to
>>>> scale the STALL time.
>>>
>>> Not sure I  get this.
>>>
>>> __schedule() -> psi_sched_switch() -> psi_task_change() ->
>>> psi_group_change() -> record_times() -> psi_memtime_fixup()
>>>
>>> is something else than calling psi_memstall_enter() or _leave()?
>>>
>>> IMHO, at least record_times() can be called with current equal
>>> swapper/X. Or is it that PSI_MEM_SOME is never set for the idle task in
>>> this callstack? I don't know the PSI internals.
> According to my understanding, PSI_MEM_SOME represents the CORE's
> state within which there is at least one task trapped in memstall
> path(only counted in by calling PSI_MEMSTALL_ENTER). record_times is
> responsible for collecting the delta time of the CORE since it start.
> What we are doing is to make the delta time more precise. So idle task
> is irrelevant for these.

Coming back to the original snippet of the patch.

static unsigned long psi_memtime_fixup(u32 growth)
{

    if (!(current->policy == SCHED_NORMAL ||
          current->policy == SCHED_BATCH))
        return growth_fixed;

With this condition:

(1) you're not bailing when current is the idle task. It has policy
    equal 0 (SCHED_NORMAL)

(2) But you're bailing for a SCHED_IDLE (CFS) task.

I'm not sure that this is indented here?

Since you want to do the scaling later based on whats left for CFS tasks
from the CPU capacity my hunch is that you want to rather do:

    if (current->sched_class != &fair_sched_class)
        return growth_fixed;

What's the possible sched classes of current in psi_memtime_fixup?
