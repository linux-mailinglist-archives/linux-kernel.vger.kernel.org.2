Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9846E35F06A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhDNJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347494AbhDNJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:05:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sVZ5oTijaZNrM/7N+fR8kMqGAiZ5+mgph5nPY51AeFI=; b=fuKPx2mI+lTYdcTtph1vvvkh0t
        aHEekhZ9Q79VLwZQtZ9X04m8/GZU/Me8UQ3XMRdKOg/CqJ8iopAeKJU4w5Xbh4LFBHYSyoYsSYltx
        haTEQBzrENd2NprCBSyPZs54PoHgMjS0li7z1s3nv/LEGXX1WIqQvLUop8CowZ6uLIRSOgbBRBUFN
        tW6inVFDvF7RXj+Qg690cTZqWLZPBy5unA9IP6ZD/EvzeYqoRN+xLk52lamdMvjw9FBqWBnD3hkcc
        M+fq9WGSKBv6DmSA/lLQzHqJFD4DKGZbBRiiZ8Zru4n6diuMHHuc3SMPdz8iqZP41JKg8QomLWDHO
        /gnSUJuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWbSf-00C5jq-7I; Wed, 14 Apr 2021 09:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 796E0300222;
        Wed, 14 Apr 2021 11:05:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C0BF203CF7D7; Wed, 14 Apr 2021 11:05:24 +0200 (CEST)
Date:   Wed, 14 Apr 2021 11:05:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 09:08:18AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 14, 2021 at 10:26:57AM +0800, Guo Ren wrote:
> > Thx Peter,
> > 
> > On Tue, Apr 13, 2021 at 4:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Apr 13, 2021 at 10:03:01AM +0200, Peter Zijlstra wrote:
> > >
> > > > For ticket locks you really only needs atomic_fetch_add() and
> > > > smp_store_release() and an architectural guarantees that the
> > > > atomic_fetch_add() has fwd progress under contention and that a sub-word
> > > > store (through smp_store_release()) will fail the SC.
> > > >
> > > > Then you can do something like:
> > > >
> > > > void lock(atomic_t *lock)
> > > > {
> > > >       u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> > > >       u16 ticket = val >> 16;
> > > >
> > > >       for (;;) {
> > > >               if (ticket == (u16)val)
> > > >                       break;
> > > >               cpu_relax();
> > > >               val = atomic_read_acquire(lock);
> > > >       }
> > Should it be?
> >        for (;;) {
> >                if (ticket == (u16)val) {
> >                        __atomic_acquire_fence();
> >                        break;
> >                }
> 
> No, atomic_fetch_add() is full smp_mb(), it even has a comment on that
> says so.
> 
> Also, __atomic_acquire_fence() is an implementation detail of atomic,
> and architectures need not provide it. On top of that, IIRC the atomic
> _acquire/_release have RCpc ordering, where we want our locks to have
> RCsc ordering (and very much not weaker than RCtso). Even more so,
> adding barriers to atomics should really not be conditional.

That made me look at the qspinlock code, and queued_spin_*lock() uses
atomic_try_cmpxchg_acquire(), which means any arch that uses qspinlock
and has RCpc atomics will give us massive pain.

Current archs using qspinlock are: x86, arm64, power, sparc64, mips and
openrisc (WTF?!).

Of those, x86 and sparc are TSO archs with SC atomics, arm64 has RCsc
atomics, power has RCtso atomics (and is the arch we all hate for having
RCtso locks).

Now MIPS has all sorts of ill specified barriers, but last time looked
at it it didn't actually use any of that and stuck to using smp_mb(), so
it will have RCsc atomics.

/me goes look at wth openrisc is..  doesn't even appear to have
asm/barrier.h :-/ Looking at wikipedia it also doesn't appear to
actually have hardware ...

I'm thinking openrisc is a prime candidate for this ticket_lock.h we're
all talking about.
