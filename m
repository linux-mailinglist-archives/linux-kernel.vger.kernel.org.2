Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CE83AAF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhFQJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhFQJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:13:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13336C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2H4IM1xE7jxuGRrwhQQkIZ49SDStJc3NvFzU9prjeWc=; b=aZn7FZQiRpudLbgfubbkohBYEO
        9FK1IHIEHwUo2JKOBMvyv6r9O014hEOtqipWTqq06v26HmIBnxhSSabGP8LbKzJG0eErKE6bf2dah
        buzBGeXwKk4XAXLh6qx1uI/FeHRXRCJAPWG+AOQab3hFWKpWKjymz43dJTOh3RnfrNevpPcGd6qcp
        x3hxAEmVb5Hj1Ho9991+dW5pQ1L0AGKx2I8GW3FXMS5miiNoRJBoxs5ggwxR/zRyB+V9mgt/5YZOt
        Vcb9G9gkZWIxCxq6lhkRQ/7V39QRqfjxCusfK0B0lTdUqfRLgNmVUGgkL7Bp+JORug70EGkzExySk
        VgjvhOFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lto2c-008x6V-0J; Thu, 17 Jun 2021 09:10:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAB82300252;
        Thu, 17 Jun 2021 11:10:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9276D203C0549; Thu, 17 Jun 2021 11:10:25 +0200 (CEST)
Date:   Thu, 17 Jun 2021 11:10:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH] sched: Use lightweight hazard pointers to grab lazy
 mms
Message-ID: <YMsRgfKbcaW66/99@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:08:03AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 10:32:15PM -0700, Andy Lutomirski wrote:

> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -66,4 +66,9 @@ typedef struct {
>  void leave_mm(int cpu);
>  #define leave_mm leave_mm
>  
> +/* On x86, mm_cpumask(mm) contains all CPUs that might be lazily using mm */
> +#define for_each_possible_lazymm_cpu(cpu, mm) \
> +	for_each_cpu((cpu), mm_cpumask((mm)))
> +
> +
>  #endif /* _ASM_X86_MMU_H */

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8ac693d542f6..e102ec53c2f6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -19,6 +19,7 @@
>  

> +
> +#ifndef for_each_possible_lazymm_cpu
> +#define for_each_possible_lazymm_cpu(cpu, mm) for_each_online_cpu((cpu))
> +#endif
> +

Why can't the x86 implementation be the default? IIRC the problem with
mm_cpumask() is that (some) architectures don't clear bits, but IIRC
they all should be setting bits, or were there archs that didn't even do
that?

