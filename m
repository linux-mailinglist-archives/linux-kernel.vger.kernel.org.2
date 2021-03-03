Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099EF32BCE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447423AbhCCPD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843073AbhCCKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD489C08ECAE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9y87D77CpzAQFasjvNcZbUvYXFL0FEiGiYgu9WotuuE=; b=b3XH1EFSXGvkfziyxNEW6rZvjr
        nFsJsPuloXai7GlhRjpMp5cQ/GmZqP3yTZDjfzlfg+xGh69qUrvHO2seOdFkvimywl/C+N4dSdF+v
        IHZ4hO9M0qpxC4cuFjATVo3FFbXGUjVPKDF4/YRC3TvPzmrmJDqNGFRzsCVkxaiZpqXh5JCiERWCg
        +vwyMb/VOpCZni3fw9yDLjerY4zbvkLnvApKxEYxzWZzliTszYVQ649s9fIyTIRILAx1F2FkUHdcB
        YRmVluuV6BG1iAJHMUujkvM7Ibwd0FR20lZqKiU3f9GZ4Tg02VJBRpqB4wzONcHApsYKRVxckRuws
        TNmpiPLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHOFB-0025dR-Mg; Wed, 03 Mar 2021 09:56:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4815C30018A;
        Wed,  3 Mar 2021 10:56:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28F9B20CC0618; Wed,  3 Mar 2021 10:56:34 +0100 (CET)
Date:   Wed, 3 Mar 2021 10:56:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>
Subject: Re: [PATCH] sched: Optimize __calc_delta.
Message-ID: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
References: <20210226195239.3905966-1-joshdon@google.com>
 <YDliCOPy9s1RdLwd@hirez.programming.kicks-ass.net>
 <CABk29Nv7iJEcDg3rgSvfTkXEM69ZeLByJAsZYuA5qpdj645nZw@mail.gmail.com>
 <CABk29Ntt88BfqGz=Rjd5Mwyj+N0YLv0Z9QsZp8DgB-n+FV1Zgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABk29Ntt88BfqGz=Rjd5Mwyj+N0YLv0Z9QsZp8DgB-n+FV1Zgw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 12:57:37PM -0800, Josh Don wrote:
> From: Clement Courbet <courbet@google.com>
> 
> A significant portion of __calc_delta time is spent in the loop
> shifting a u64 by 32 bits. Use `fls` instead of iterating.
> 
> This is ~7x faster on benchmarks.
> 
> The generic `fls` implementation (`generic_fls`) is still ~4x faster
> than the loop.
> Architectures that have a better implementation will make use of it. For
> example, on X86 we get an additional factor 2 in speed without dedicated
> implementation.
> 
> On gcc, the asm versions of `fls` are about the same speed as the
> builtin. On clang, the versions that use fls (fls,fls64) are more than
> twice as slow as the builtin. This is because the way the `fls` function
> is written, clang puts the value in memory:
> https://godbolt.org/z/EfMbYe. This can be fixed in a separate patch.
> 
> ```
> name                                   cpu/op
> BM_Calc<__calc_delta_loop>             9.57ms ±12%
> BM_Calc<__calc_delta_generic_fls>      2.36ms ±13%
> BM_Calc<__calc_delta_asm_fls>          2.45ms ±13%
> BM_Calc<__calc_delta_asm_fls_nomem>    1.66ms ±12%
> BM_Calc<__calc_delta_asm_fls64>        2.46ms ±13%
> BM_Calc<__calc_delta_asm_fls64_nomem>  1.34ms ±15%
> BM_Calc<__calc_delta_builtin>          1.32ms ±11%
> ```
> 
> Signed-off-by: Clement Courbet <courbet@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/fair.c  | 30 ++++++++++++++++++++++--------
>  kernel/sched/sched.h |  1 +
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a8bd7b13634..67e5a1d536ad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -214,6 +214,16 @@ static void __update_inv_weight(struct load_weight *lw)
>   lw->inv_weight = WMULT_CONST / w;
>  }
> 
> +/*
> + * An fls that handles an u32 value on architectures
> + * where `sizeof(unsigned int) < 32`.
> + */
> +#if (__SIZEOF_INT__ >= 32)

This should never happen, we use ILP32 or LP64 for Linux.

> +# define FLS_AT_LEAST_32(v) fls(v)
> +#else
> +# define FLS_AT_LEAST_32(v) fls64(v)
> +#endif
> +
>  /*
>   * delta_exec * weight / lw.weight
>   *   OR
> @@ -229,27 +239,31 @@ static void __update_inv_weight(struct load_weight *lw)
>  static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct
> load_weight *lw)
>  {
>   u64 fact = scale_load_down(weight);
> + u32 fact_hi = (u32)(fact >> 32);
>   int shift = WMULT_SHIFT;
> + int fs;
> 
>   __update_inv_weight(lw);
> 
> - if (unlikely(fact >> 32)) {
> - while (fact >> 32) {
> - fact >>= 1;
> - shift--;
> - }
> + if (unlikely(fact_hi)) {
> + fs = FLS_AT_LEAST_32(fact_hi);

you made fact_hi u32, why can't we unconditionally use fls() ?

> + shift -= fs;
> + fact >>= fs;
>   }
> 
>   fact = mul_u32_u32(fact, lw->inv_weight);
> 
> - while (fact >> 32) {
> - fact >>= 1;
> - shift--;
> + fact_hi = (u32)(fact >> 32);
> + if (fact_hi) {
> + fs = FLS_AT_LEAST_32(fact_hi);
> + shift -= fs;
> + fact >>= fs;
>   }
> 
>   return mul_u64_u32_shr(delta_exec, fact, shift);
>  }

Horrific whitespace damage..
