Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5233CB754
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhGPMYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:24:14 -0400
Received: from foss.arm.com ([217.140.110.172]:38388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbhGPMYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:24:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE4B4D6E;
        Fri, 16 Jul 2021 05:21:18 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.1.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04B863F774;
        Fri, 16 Jul 2021 05:21:16 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:21:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/5] locking/atomic: add generic arch_*() bitops
Message-ID: <20210716122114.GB78984@C02TD0UTHF1T.local>
References: <20210713105253.7615-1-mark.rutland@arm.com>
 <20210713105253.7615-6-mark.rutland@arm.com>
 <YPFkzNvUFUfc1vVp@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPFkzNvUFUfc1vVp@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:51:56PM +0200, Marco Elver wrote:
> On Tue, Jul 13, 2021 at 11:52AM +0100, Mark Rutland wrote:
> [...] 
> > As the generic non-atomic bitops use plain accesses, these will be
> > implicitly instrumented unless they are inlined into noinstr functions
> > (which is similar to arch_atomic*_read() when based on READ_ONCE()).
> > The wrappers are modified so that where the underlying arch_*() function
> > uses a plain access, no explicit instrumentation is added, as this is
> > redundant and could result in confusing reports.
> [...]
> > diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
> > index 37363d570b9b..e6c1540965d6 100644
> > --- a/include/asm-generic/bitops/instrumented-non-atomic.h
> > +++ b/include/asm-generic/bitops/instrumented-non-atomic.h
> [...]
> > @@ -131,7 +137,8 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
> >   */
> >  static inline bool test_bit(long nr, const volatile unsigned long *addr)
> >  {
> > -	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
> > +	if (!__is_defined(arch_test_bit_uses_plain_access))
> > +		instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
> >  	return arch_test_bit(nr, addr);
> >  }
> [...]
> > diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
> > index 7e10c4b50c5d..c8149cd52730 100644
> > --- a/include/asm-generic/bitops/non-atomic.h
> > +++ b/include/asm-generic/bitops/non-atomic.h
> > @@ -5,7 +5,7 @@
> >  #include <asm/types.h>
> [...] 
> >  /**
> > - * test_bit - Determine whether a bit is set
> > + * arch_test_bit - Determine whether a bit is set
> >   * @nr: bit number to test
> >   * @addr: Address to start counting from
> >   */
> > -static inline int test_bit(int nr, const volatile unsigned long *addr)
> > +static __always_inline int
> > +arch_test_bit(int nr, const volatile unsigned long *addr)
> >  {
> >  	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> >  }
> > +#define arch_test_bit_uses_plain_access
> > +
> > +#include <asm-generic/bitops/instrumented-non-atomic.h>
> 
> Why not just:
> 
> 	#define test_bit arch_test_bit
> 
> and similar for the ones that use plain accesses?
> 
> And not include instrumented-non-atomic.h here nor do the
> __is_defined(*_uses_plain_access) change to the instrumented header,
> which seems to overcomplicate things as it effectively just aliases the
> non-arch_ name to the arch_ name if *_uses_plain_access is defined.

I'd done that to still permit the compiler to out-of-line the non-arch
forms if it wanted to. That said, I see that for the atomics we forced
those to be __always_inline anyway, so maybe that's not a concern.

I'm happy either way.

Thanks,
Mark.
