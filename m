Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B693603EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhDOILU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhDOILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:11:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654CCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pNl50OnfrsTMw9KJLwf0kvnMVVjH09VJYTN9ZXHDw+M=; b=DCZRjJtg5q6QH3lkg0Ou4stg0O
        BbAQXLss0hhVEXlHG/YgG9f+mZJcp6HvmXJPNMs6/Z5DijH2isBJkudZ9lRksWBEQSD4ZoLSbDsm7
        zjtJ6b5I0pduCbWrSNLyIXJUvJMRxz8ajH+E2++KXIKnmt89PHrdDqg24L3iYPov0rHVOaVnY9vgt
        Q6W5c+4GAHo0SzjqiBcIMqKpEWwGs0hIIlTeZqiQXDjFgPcVPw+zoilG95xnoesbICYo3ncXTHMJH
        48cGFpMO26asbEcRiC3pEVv8ibVbe3MkxpHm/5hS/nDfaXjaz6tQ62ANszqtTNDdprgz7NFiSrkcY
        f6Jzh1Ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWx4W-008Gu6-Ec; Thu, 15 Apr 2021 08:09:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 268BB30021C;
        Thu, 15 Apr 2021 10:09:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E504820BF5EDB; Thu, 15 Apr 2021 10:09:54 +0200 (CEST)
Date:   Thu, 15 Apr 2021 10:09:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC][PATCH] locking: Generic ticket-lock
Message-ID: <YHf00hgpB5C20tH3@hirez.programming.kicks-ass.net>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
 <20210414204734.GJ3288043@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414204734.GJ3288043@lianli.shorne-pla.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 05:47:34AM +0900, Stafford Horne wrote:

> > How's this then? Compile tested only on openrisc/simple_smp_defconfig.
> 
> I did my testing with this FPGA build SoC:
> 
>  https://github.com/stffrdhrn/de0_nano-multicore
> 
> Note, the CPU timer sync logic uses mb() and is a bit flaky.  So missing mb()
> might be a reason.  I thought we had defined mb() and l.msync, but it seems to
> have gotten lost.
> 
> With that said I could test out this ticket-lock implementation.  How would I
> tell if its better than qspinlock?

Mostly if it isn't worse, it's better for being *much* simpler. As you
can see, the guts of ticket is like 16 lines of C (lock+unlock) and you
only need the behaviour of atomic_fetch_add() to reason about behaviour
of the whole thing. qspinlock OTOH is mind bending painful to reason
about.

There are some spinlock tests in locktorture; but back when I had a
userspace copy of the lot and would measure min,avg,max acquire times
under various contention loads (making sure to only run a single task
per CPU etc.. to avoid lock holder preemption and other such 'fun'
things).

It took us a fair amount of work to get qspinlock to compete with ticket
for low contention cases (by far the most common in the kernel), and it
took a fairly large amount of CPUs for qspinlock to really win from
ticket on the contended case. Your hardware may vary. In particular the
access to the external cacheline (for queueing, see the queue: label in
queued_spin_lock_slowpath) is a pain-point and the relative cost of
cacheline misses for your arch determines where (and if) low contention
behaviour is competitive.

Also, less variance (the reason for the min/max measure) is better.
Large variance is typically a sign of fwd progress trouble.

That's not saying that qspinlock isn't awesome, but I'm arguing that you
should get there by first trying all the simpler things. By gradually
increasing complexity you can also find the problem spots (for your
architecture) and you have something to fall back to in case of trouble.

Now, the obvious selling point of qspinlock is that due to the MCS style
nature of the thing it doesn't bounce the lock around, but that comes at
a cost of having to use that extra cacheline (due to the kernel liking
sizeof(spinlock_t) == sizeof(u32)). But things like ARM64's WFE (see
smp_cond_load_acquire()) can shift the balance quite a bit on that front
as well (ARM has a similar thing but less useful, see it's spinlock.h
and look for wfe() and dsb_sev()).

Once your arch hits NUMA, qspinlock is probably a win. However, low
contention performance is still king for most workloads. Better high
contention behaviour is nice.
