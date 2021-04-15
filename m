Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF5360526
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhDOJCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231809AbhDOJCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:02:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE781611F1;
        Thu, 15 Apr 2021 09:02:20 +0000 (UTC)
Date:   Thu, 15 Apr 2021 10:02:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stafford Horne <shorne@gmail.com>, Guo Ren <guoren@kernel.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC][PATCH] locking: Generic ticket-lock
Message-ID: <20210415090215.GA1015@arm.com>
References: <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
 <20210414204734.GJ3288043@lianli.shorne-pla.net>
 <YHf00hgpB5C20tH3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHf00hgpB5C20tH3@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(fixed Will's email address)

On Thu, Apr 15, 2021 at 10:09:54AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 15, 2021 at 05:47:34AM +0900, Stafford Horne wrote:
> > > How's this then? Compile tested only on openrisc/simple_smp_defconfig.
> > 
> > I did my testing with this FPGA build SoC:
> > 
> >  https://github.com/stffrdhrn/de0_nano-multicore
> > 
> > Note, the CPU timer sync logic uses mb() and is a bit flaky.  So missing mb()
> > might be a reason.  I thought we had defined mb() and l.msync, but it seems to
> > have gotten lost.
> > 
> > With that said I could test out this ticket-lock implementation.  How would I
> > tell if its better than qspinlock?
> 
> Mostly if it isn't worse, it's better for being *much* simpler. As you
> can see, the guts of ticket is like 16 lines of C (lock+unlock) and you
> only need the behaviour of atomic_fetch_add() to reason about behaviour
> of the whole thing. qspinlock OTOH is mind bending painful to reason
> about.
> 
> There are some spinlock tests in locktorture; but back when I had a
> userspace copy of the lot and would measure min,avg,max acquire times
> under various contention loads (making sure to only run a single task
> per CPU etc.. to avoid lock holder preemption and other such 'fun'
> things).
> 
> It took us a fair amount of work to get qspinlock to compete with ticket
> for low contention cases (by far the most common in the kernel), and it
> took a fairly large amount of CPUs for qspinlock to really win from
> ticket on the contended case. Your hardware may vary. In particular the
> access to the external cacheline (for queueing, see the queue: label in
> queued_spin_lock_slowpath) is a pain-point and the relative cost of
> cacheline misses for your arch determines where (and if) low contention
> behaviour is competitive.
> 
> Also, less variance (the reason for the min/max measure) is better.
> Large variance is typically a sign of fwd progress trouble.

IIRC, one issue we had with ticket spinlocks on arm64 was on big.LITTLE
systems where the little CPUs were always last to get a ticket when
racing with the big cores. That was with load/store exclusives (LR/SC
style) and would have probably got better with atomics but we moved to
qspinlocks eventually (the Juno board didn't have atomics).

(leaving the rest of the text below for Will's convenience)

> That's not saying that qspinlock isn't awesome, but I'm arguing that you
> should get there by first trying all the simpler things. By gradually
> increasing complexity you can also find the problem spots (for your
> architecture) and you have something to fall back to in case of trouble.
> 
> Now, the obvious selling point of qspinlock is that due to the MCS style
> nature of the thing it doesn't bounce the lock around, but that comes at
> a cost of having to use that extra cacheline (due to the kernel liking
> sizeof(spinlock_t) == sizeof(u32)). But things like ARM64's WFE (see
> smp_cond_load_acquire()) can shift the balance quite a bit on that front
> as well (ARM has a similar thing but less useful, see it's spinlock.h
> and look for wfe() and dsb_sev()).
> 
> Once your arch hits NUMA, qspinlock is probably a win. However, low
> contention performance is still king for most workloads. Better high
> contention behaviour is nice.

-- 
Catalin
