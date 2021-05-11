Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF937A342
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhEKJRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:17:50 -0400
Received: from foss.arm.com ([217.140.110.172]:43482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhEKJRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:17:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390C81688;
        Tue, 11 May 2021 02:16:42 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.29.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59DBB3F719;
        Tue, 11 May 2021 02:16:28 -0700 (PDT)
Date:   Tue, 11 May 2021 10:16:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, palmer@dabbelt.com,
        paulus@samba.org, paul.walmsley@sifive.com, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
Subject: Re: [PATCH 27/33] locking/atomic: powerpc: move to ARCH_ATOMIC
Message-ID: <20210511091621.GA6152@C02TD0UTHF1T.local>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <20210510093753.40683-28-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510093753.40683-28-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:37:47AM +0100, Mark Rutland wrote:
> We'd like all architectures to convert to ARCH_ATOMIC, as once all
> architectures are converted it will be possible to make significant
> cleanups to the atomics headers, and this will make it much easier to
> generically enable atomic functionality (e.g. debug logic in the
> instrumented wrappers).
> 
> As a step towards that, this patch migrates powerpc to ARCH_ATOMIC. The
> arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
> code wraps these with optional instrumentation to provide the regular
> functions.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/powerpc/Kconfig               |   1 +
>  arch/powerpc/include/asm/atomic.h  | 140 +++++++++++++++++++------------------
>  arch/powerpc/include/asm/cmpxchg.h |  30 ++++----
>  3 files changed, 89 insertions(+), 82 deletions(-)

The kbuild test robot spotted a couple of bits I'd got wrong; I've noted
those below (and both are now fixed in my kernel.org branch).

>  static __always_inline bool
> -atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
> +arch_atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)

Since this isn't part of the core atomic API, and is used directly by
powerpc's spinlock implementation, this should have stayed as-is (or we
should use the `arch_` prefix consitently and update the spinlock code).

I've dropped the `arch_` prefix for now.

[...]

>  /**
>   * atomic64_fetch_add_unless - add unless the number is a given value
> @@ -518,7 +524,7 @@ static __inline__ s64 atomic64_dec_if_positive(atomic64_t *v)
>   * Atomically adds @a to @v, so long as it was not @u.
>   * Returns the old value of @v.
>   */
> -static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
> +static __inline__ s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>  {
>  	s64 t;
>  
> @@ -539,7 +545,7 @@ static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>  
>  	return t;
>  }
> -#define atomic64_fetch_add_unless atomic64_fetch_add_unless
> +#define arch_atomic64_fetch_add_unless atomic64_fetch_add_unless

Looks like I forgot the `arch_` prefix on the right hand side here; this
should have been:

#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless

Thanks,
Mark.
