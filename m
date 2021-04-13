Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA835DB64
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhDMJh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhDMJhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:37:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B37BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2nGPE59l8gWiF0CqV9jlYVOt/A6vHOQsPW2h6H+vfmY=; b=njzHTxASJJ2X0EikzjsaTCfbhp
        lLug7KEU5iaDbXwxTJVVGxKKWAY/U57Bh5gSWz7YYsj3H3UlKyKsy2HtKBjYALNuJm1doi6ZPQBtP
        f6bVmuh/l4f/MRJOLX7MM8U3TY6UJw5WRUIf/6lRlOsBGsEkxDAc9JrDxHuQaY1CIjrtrE84dEQMZ
        n7nE1c6o5xJVJEJX6KPhvu9lDyqCt8wp+TKsPWQZmmf8RSTSM0dSLTeS/j8PE9i0BAj0xQz7OU8RG
        bC2M6YyVC4utH/Tsxo4nT3NOEjs7jxTLmCNkC5j/2HNgJcok95Tm/iFpDR4wANIt/9Gn/dAfeB+vb
        xfEy/d8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWFSU-005Xmf-U9; Tue, 13 Apr 2021 09:36:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 933DC300033;
        Tue, 13 Apr 2021 11:35:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 534D02C4B2075; Tue, 13 Apr 2021 11:35:45 +0200 (CEST)
Date:   Tue, 13 Apr 2021 11:35:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YHVl8fFfdQDn+QYW@hirez.programming.kicks-ass.net>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:22:40AM +0200, Christoph Müllner wrote:

> > For ticket locks you really only needs atomic_fetch_add() and
> > smp_store_release() and an architectural guarantees that the
> > atomic_fetch_add() has fwd progress under contention and that a sub-word
> > store (through smp_store_release()) will fail the SC.
> >
> > Then you can do something like:
> >
> > void lock(atomic_t *lock)
> > {
> >         u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> >         u16 ticket = val >> 16;
> >
> >         for (;;) {
> >                 if (ticket == (u16)val)
> >                         break;
> >                 cpu_relax();
> >                 val = atomic_read_acquire(lock);
> >         }
> > }
> >
> > void unlock(atomic_t *lock)
> > {
> >         u16 *ptr = (u16 *)lock + (!!__BIG_ENDIAN__);
> >         u32 val = atomic_read(lock);
> >
> >         smp_store_release(ptr, (u16)val + 1);
> > }
> >
> > That's _almost_ as simple as a test-and-set :-) It isn't quite optimal
> > on x86 for not being allowed to use a memop on unlock, since its being
> > forced into a load-store because of all the volatile, but whatever.
> 
> What about trylock()?
> I.e. one could implement trylock() without a loop, by letting
> trylock() fail if the SC fails.
> That looks safe on first view, but nobody does this right now.

Generic code has to use cmpxchg(), and then you get something like this:

bool trylock(atomic_t *lock)
{
	u32 old = atomic_read(lock);

	if ((old >> 16) != (old & 0xffff))
		return false;

	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
}

That will try and do the full LL/SC loop, because it wants to complete
the cmpxchg, but in generic code we have no other option.

(Is this what C11's weak cmpxchg is for?)
