Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E12936058C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhDOJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229820AbhDOJWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:22:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 402A061222;
        Thu, 15 Apr 2021 09:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618478538;
        bh=dmI2KicrdiUzO7RCef4YkJ92842nyWjSe+ktGhQTC7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJdo4PtG0HvaOXOUynzZ07ekfPgGjk/j4YwBH6lGnEpk0I8G2yOE/89ZOBDS1nHmV
         QjVeCcFbgL4w43Ry3lsPhwX2Su/Pxw9bsd01yaZmnIWVa3hoQD93eelEd2seReN+Ac
         LcbSuJAnRInJkOxqNZbZbQRjkWbANWvczxLSB9l413mf89UhsrJeSpYoS8Vtwtu7e0
         Vz/s+YXO7W/DEC2RgrHi9n75eevQ9JrWIh3FQwDDl1pEEgvQWya51z02J0+WSZkmyV
         UV6rYhBq/QJu43mXUy9spO/3D8Om29tXHEDQcVZPpOoRsf7nZAVLwXSZximT3YTHOk
         FCPoTl5IM/SCA==
Date:   Thu, 15 Apr 2021 10:22:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stafford Horne <shorne@gmail.com>, Guo Ren <guoren@kernel.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC][PATCH] locking: Generic ticket-lock
Message-ID: <20210415092212.GA26151@willie-the-truck>
References: <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
 <20210414204734.GJ3288043@lianli.shorne-pla.net>
 <YHf00hgpB5C20tH3@hirez.programming.kicks-ass.net>
 <20210415090215.GA1015@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415090215.GA1015@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 10:02:18AM +0100, Catalin Marinas wrote:
> (fixed Will's email address)
> 
> On Thu, Apr 15, 2021 at 10:09:54AM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 15, 2021 at 05:47:34AM +0900, Stafford Horne wrote:
> > > > How's this then? Compile tested only on openrisc/simple_smp_defconfig.
> > > 
> > > I did my testing with this FPGA build SoC:
> > > 
> > >  https://github.com/stffrdhrn/de0_nano-multicore
> > > 
> > > Note, the CPU timer sync logic uses mb() and is a bit flaky.  So missing mb()
> > > might be a reason.  I thought we had defined mb() and l.msync, but it seems to
> > > have gotten lost.
> > > 
> > > With that said I could test out this ticket-lock implementation.  How would I
> > > tell if its better than qspinlock?
> > 
> > Mostly if it isn't worse, it's better for being *much* simpler. As you
> > can see, the guts of ticket is like 16 lines of C (lock+unlock) and you
> > only need the behaviour of atomic_fetch_add() to reason about behaviour
> > of the whole thing. qspinlock OTOH is mind bending painful to reason
> > about.
> > 
> > There are some spinlock tests in locktorture; but back when I had a
> > userspace copy of the lot and would measure min,avg,max acquire times
> > under various contention loads (making sure to only run a single task
> > per CPU etc.. to avoid lock holder preemption and other such 'fun'
> > things).
> > 
> > It took us a fair amount of work to get qspinlock to compete with ticket
> > for low contention cases (by far the most common in the kernel), and it
> > took a fairly large amount of CPUs for qspinlock to really win from
> > ticket on the contended case. Your hardware may vary. In particular the
> > access to the external cacheline (for queueing, see the queue: label in
> > queued_spin_lock_slowpath) is a pain-point and the relative cost of
> > cacheline misses for your arch determines where (and if) low contention
> > behaviour is competitive.
> > 
> > Also, less variance (the reason for the min/max measure) is better.
> > Large variance is typically a sign of fwd progress trouble.
> 
> IIRC, one issue we had with ticket spinlocks on arm64 was on big.LITTLE
> systems where the little CPUs were always last to get a ticket when
> racing with the big cores. That was with load/store exclusives (LR/SC
> style) and would have probably got better with atomics but we moved to
> qspinlocks eventually (the Juno board didn't have atomics).
> 
> (leaving the rest of the text below for Will's convenience)

Yes, I think it was this thread:

https://lore.kernel.org/lkml/alpine.DEB.2.20.1707261548560.2186@nanos

but I don't think you can really fix such hardware by changing the locking
algorithm (although my proposed cpu_relax() hack was worryingly effective).

Will
