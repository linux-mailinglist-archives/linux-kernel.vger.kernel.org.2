Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAB438A7B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhJXPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:54:36 -0400
Received: from foss.arm.com ([217.140.110.172]:38378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhJXPyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:54:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F8BD6E;
        Sun, 24 Oct 2021 08:52:14 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33C773F5A1;
        Sun, 24 Oct 2021 08:52:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 3/3] irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime
In-Reply-To: <87o87gt4at.wl-maz@kernel.org>
References: <20211022103307.1711619-1-valentin.schneider@arm.com> <20211022103307.1711619-4-valentin.schneider@arm.com> <87o87gt4at.wl-maz@kernel.org>
Date:   Sun, 24 Oct 2021 16:52:10 +0100
Message-ID: <878ryiju8l.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/21 11:37, Marc Zyngier wrote:
> On Fri, 22 Oct 2021 11:33:07 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>> @@ -5234,6 +5243,11 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
>>      paddr = page_to_phys(pend_page);
>>      WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
>>
>> +out:
>> +	/* This only needs to run once per CPU */
>> +	if (cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
>> +		schedule_work(&rdist_memreserve_cpuhp_cleanup_work);
>
> Which makes me wonder. Do we actually need any flag at all if all we
> need to check is whether the CPU has been through the callback at
> least once? I have the strong feeling that we are tracking the same
> state multiple times here.
>

Agreed, cf. my reply on 2/3.

> Also, could the cpuhp callbacks ever run concurrently? If they could,
> two CPUs could schedule the cleanup work in parallel, with interesting
> results.  You'd need a cmpxchg on the cpuhp state in the workfn.
>

So I think the cpuhp callbacks may run concurrently, but at a quick glance
it seems like we can't get two instances of the same work executing
concurrently: schedule_work()->queue_work() doesn't re-queue a work if it's already
pending, and __queue_work() checks a work's previous pool in case it might
still be running there.

Regardless, that's one less thing to worry about if we make the cpuhp
callback body run at most once on each CPU (only a single CPU will be able
to queue the removal work).
