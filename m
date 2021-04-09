Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC4035A5EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhDISkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:40:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958E9C061762;
        Fri,  9 Apr 2021 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vq2mKY4Er5jY56WUXtRXSXWKPyXxVb/r7fasw5y8Tf0=; b=aDsIQ4NwDHrs2jwstGFdoK1xvk
        Pj/sX5d67r5oi5/YIVJnYjdPCUnFNvVQvOywgUXqD1ep9UpIMwNiokjke8uNQi9f74SWN29ihKrIf
        eeQUdan+tABGvG3tK+Vamp8oYfZoCxJ8/OutF7EzUkSGp6b2udEbbvFyGqSTaVB9mhvcEu6Fuc5bJ
        2Y+bgn/9guMe+08zhCZf1L7RvAmPfwTglIYLnOLbARBQm+biE80oNJFoPQOTe9z8zrReDpVyDteXj
        IkM9aA7FZ1l4pzL1RoJaa9bmRgnQP6jNCKX8oNGWxEHiIgUoY5xBOEuAkl5bUBhjy2qEq4iPxeKdo
        E9pzkZKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUw2z-001MA7-OR; Fri, 09 Apr 2021 18:40:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E20830001B;
        Fri,  9 Apr 2021 20:40:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56DCA2C49B089; Fri,  9 Apr 2021 20:40:00 +0200 (CEST)
Date:   Fri, 9 Apr 2021 20:40:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
 <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
 <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
 <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
 <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net>
 <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
 <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
 <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 09:48:33AM -0400, David Malcolm wrote:
> You tried __pure on arch_static_branch; did you try it on
> static_branch_unlikely?

static_branch_unlikely() is a CPP macro that expands to a statement
expression, or as with the later patch, a _Generic(). I'm not sure how
to apply the attribute to either of them since it is a function
attribute.

I was hoping the attribute would percolate through, so to speak.

> With the caveat that my knowledge of GCC's middle-end is mostly about
> implementing warnings, rather than optimization, I did some
> experimentation, with gcc trunk on x86_64 FWIW.
> 
> Given:
> 
> int __attribute__((pure)) foo(void);
> 
> int t(void)
> {
>   int a;
>   if (foo())
>     a++;
>   if (foo())
>     a++;
>   if (foo())
>     a++;
>   return a;
> }
> 
> At -O1 and above this is optimized to a single call to foo, returning 0
> or 3 accordingly.
> 
> -fdump-tree-all shows that it's the "fre1" pass that eliminates the
> subsequent calls to foo, replacing them with reuses of the result of
> the first call.
> 
> This is in gcc/tree-ssa-sccvn.c, a value-numbering pass.
> 
> I think you want to somehow "teach" the compiler that:
>   static_branch_unlikely(&sched_schedstats)
> is "pure-ish", that for some portion of the surrounding code that you
> want the result to be treated as pure - though I suspect compiler
> maintainers with more experience than me are thinking "but which
> portion? what is it safe to assume, and what will users be annoyed
> about if we optimize away? what if t itself is inlined somewhere?" and
> similar concerns.

Right, pure or even const. As to the scope, as wide as possible. It
literally is a global constant, the value returned is the same
everywhere.

All we need GCC to do for the static_branch construct is to emit both
branches; that is, it must not treat the result as a constant and elide
the other branches. But it can consider consecutive calls (as far and
wide as it wants) to return the same value.

> Or maybe the asm stmt itself could somehow be marked as pure??? (with
> similar concerns about semantics as above)

Yeah, not sure, someone with more clue will have to inform us what, if
anything more than marking it either pure or const is required. Perhaps
that attribute is sufficient and the compiler just isn't optimizing for
an unrelated reason.

Regards,

Peter
