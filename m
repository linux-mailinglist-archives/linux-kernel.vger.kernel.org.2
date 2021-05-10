Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC3E3791C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhEJPBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:01:22 -0400
Received: from foss.arm.com ([217.140.110.172]:60390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237108AbhEJO73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:59:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FFBA15BE;
        Mon, 10 May 2021 07:58:24 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B8743F719;
        Mon, 10 May 2021 07:58:07 -0700 (PDT)
Date:   Mon, 10 May 2021 15:57:59 +0100
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
Subject: Re: [PATCH 14/33] locking/atomic: arc: move to ARCH_ATOMIC
Message-ID: <20210510145759.GB92897@C02TD0UTHF1T.local>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <20210510093753.40683-15-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510093753.40683-15-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:37:34AM +0100, Mark Rutland wrote:
> We'd like all architectures to convert to ARCH_ATOMIC, as once all
> architectures are converted it will be possible to make significant
> cleanups to the atomics headers, and this will make it much easier to
> generically enable atomic functionality (e.g. debug logic in the
> instrumented wrappers).
> 
> As a step towards that, this patch migrates arc to ARCH_ATOMIC. The arch
> code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common code
> wraps these with optional instrumentation to provide the regular
> functions.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arc/Kconfig               |  1 +
>  arch/arc/include/asm/atomic.h  | 56 +++++++++++++++++++++---------------------
>  arch/arc/include/asm/cmpxchg.h |  8 +++---
>  3 files changed, 33 insertions(+), 32 deletions(-)

I evidently missed atomic_xchg() in asm/cmpxchg.h, so the fixup below is
needed. I've pushed that to my branch on kernel.org for now.

Mark.

---->8----
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 87666980b78a..d1781bdf6527 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -153,6 +153,6 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
  *         can't be clobbered by others. Thus no serialization required when
  *         atomic_xchg is involved.
  */
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #endif
