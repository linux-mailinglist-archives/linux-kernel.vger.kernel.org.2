Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826B835F463
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350776AbhDNM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbhDNM5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:57:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F4CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xvv1QEzJPf3S0gZF7Gup5VVBeUBTNACCxNNuZgdPkBs=; b=CO3wZOW6Mfb25oRUOR2ACzdI6x
        ILopvgZEOWCldFmiqIMGpnOEcMfpqhcSGI6VM16mkpHiqlYlibnvLdtR2xSwnSFm+tpoSoNM5wCI+
        noKQBvj8QIaOygEsA1/oQNlm0SJ4egamJCByKHuIKCmlGEUlbWUrYYhnQDNC9gpN3n88faM9GeWlo
        ds49BK+Ic3U52aJY98ydMPQodHo+tTUBP4nZJMQTp3AgPoJZsCVrNMSeWlYMZiImZ0K4ygFeVMNb9
        IlsQsqDhLngnjh7QbSIL7DQ1hC8LIzUREfjJx073+i1A3xhhT6axXPUJCHsQHAhWmhSoEelCZv5Px
        zJROLVMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWf3n-00782E-9P; Wed, 14 Apr 2021 12:56:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7F9C300222;
        Wed, 14 Apr 2021 14:55:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA4532065A47C; Wed, 14 Apr 2021 14:55:57 +0200 (CEST)
Date:   Wed, 14 Apr 2021 14:55:57 +0200
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
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [RFC][PATCH] locking: Generic ticket-lock
Message-ID: <YHbmXXvuG442ZDfN@hirez.programming.kicks-ass.net>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
 <CAJF2gTRsQQ=RunxK6R9MfK70dULt=RJOXXGCOT9oDPEsBgvKtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRsQQ=RunxK6R9MfK70dULt=RJOXXGCOT9oDPEsBgvKtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:39:33PM +0800, Guo Ren wrote:

> I've tested it on csky SMP*4 hw (860) & riscv SMP*4 hw (c910) and it's okay.

W00t :-)

> Hope you can keep
> typedef struct {
>         union {
>                 atomic_t lock;
>                 struct __raw_tickets {
> #ifdef __BIG_ENDIAN
>                         u16 next;
>                         u16 owner;
> #else
>                         u16 owner;
>                         u16 next;
> #endif
>                 } tickets;
>         };
> } arch_spinlock_t;
> 
> Using owner & next is much more readable.

That almost doubles the line-count of the thing ;-)


> > + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> > + * uses atomic_fetch_add() which is SC to create an RCsc lock.

This ^^^ then vvv

> > +static __always_inline void ticket_lock(arch_spinlock_t *lock)
> > +{
> > +       u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> atomic_fetch_add_acquire ?

Then we must rely on the arch to implement RCsc atomics. And I for one
can never tell wth Risc-V actually does.

> > +static __always_inline int ticket_is_locked(arch_spinlock_t *lock)
> > +{
> > +       u32 val = atomic_read(lock);
> > +
> > +       return ((val >> 16) != (val & 0xffff));
> I perfer:
> return !arch_spin_value_unlocked(READ_ONCE(*lock));
> > +}

> > +}
> > +
> > +static __always_inline int ticket_value_unlocked(arch_spinlock_t lock)
> > +{
> > +       return !ticket_is_locked(&lock);
> Are you sure to let ticket_is_locked->atomic_read(lock) again, the
> lock has contained all information?
> 
> return lock.tickets.owner == lock.tickets.next;

Yeah, I wrote then the wrong way around. Couldn't be bothered to go back
when I figured it out.

> > +
> > +static __always_inline int ticket_is_contended(arch_spinlock_t *lock)
> > +{
> > +       u32 val = atomic_read(lock);
> > +
> > +       return (s16)((val >> 16) - (val & 0xffff)) > 1;
> How big-endian ?

How not? Endian-ness only matters when you go poke at sub-words, which
the above does not. Only ticket_unlock() does and cares about that.

