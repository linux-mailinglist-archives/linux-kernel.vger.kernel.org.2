Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36B145CBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350795AbhKXSJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:09:52 -0500
Received: from foss.arm.com ([217.140.110.172]:41722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350841AbhKXSHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:07:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42DB71FB;
        Wed, 24 Nov 2021 10:04:33 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE213F66F;
        Wed, 24 Nov 2021 10:04:32 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] sched/fair: Fix per-CPU kthread and wakee stacking for asym CPU capacity
In-Reply-To: <20211124175304.GA3221810@ubiquitous>
References: <20211124141435.3125147-1-vincent.donnefort@arm.com> <87fsrlcwcb.mognet@arm.com> <20211124175304.GA3221810@ubiquitous>
Date:   Wed, 24 Nov 2021 18:04:30 +0000
Message-ID: <87czmpctw1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/21 17:58, Vincent Donnefort wrote:
> On Wed, Nov 24, 2021 at 05:11:32PM +0000, Valentin Schneider wrote:
>> On 24/11/21 14:14, Vincent Donnefort wrote:
>> > A shortcut has been introduced in select_idle_sibling() to return prev_cpu
>> > if the wakee is woken up by a per-CPU kthread. This is an issue for
>> > asymmetric CPU capacity systems where the wakee might not fit prev_cpu
>> > anymore. Evaluate asym_fits_capacity() for prev_cpu before using that
>> > shortcut.
>> >
>> > Fixes: 52262ee567ad ("sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression")
>>
>> Shouldn't that rather be
>>
>>   b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
>
> Yes definitely, my bad!
>
>>
>> ? This is an ulterior commit to the one you point to, and before then
>> asymmetric CPU systems wouldn't use any of the sis() heuristics.
>>
>> I reportedly reviewed said commit back then, and don't recall anything
>> specific about that conditional... The cover-letter for v2 states:
>>
>>   https://lore.kernel.org/lkml/20201028174412.680-1-vincent.guittot@linaro.org/
>>   """
>>   don't check capacity for the per-cpu kthread UC because the assumption is
>>   that the wakee queued work for the per-cpu kthread that is now complete and
>>   the task was already on this cpu.
>>   """
>>
>> So the assumption here is that current is gonna sleep right after waking up
>> p, so current's utilization doesn't matter, and p was already on prev, so
>> it should fit there...
>
> I don't think the assumption that "p was already on prev should fit" is
> correct if we take into account uclamp min. That value can change from one
> activation to the other and make that task artificially too big for prev_cpu...
>

Humph, good point, hadn't thought of that.

>>
>> I'm thinking things should actually be OK with your other patch that
>> excludes 'current == swapper' from this condition.
>
> ...But indeed if we add [1] to the equation, this patch here would only
> protect against that specific corner case.
>
> (And probably also against the fact that this same task could have a value
> that doesn't fit this CPU anymore but didn't trigger misfit during its previous
> activation?)

That would imply crossing the misfit threshold right at the dequeue signal
update, but that can happen.
