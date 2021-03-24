Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399AF3481C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbhCXTUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbhCXTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:19:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA9C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8kgmSg2ylYXDNqcwANjFrVhrVwVzypEMPaaOndJGkCk=; b=BCtxHDwdxKWOhsxmruZlJyx6te
        39ldE0kuQTepQHtPTtDie7WFVMFAkNUY1taLDkcT6BEVORC6AcXimYfeeo3qmP9flKW8Ww6j2by9C
        pzoBPs7jM+DWDTTfdTQB231ncFIotdUYmManYwlYO6ovrX49ivrdyNJJygaRYRamIE0rzLCuZm0mJ
        1unkJWlzLw+iTJPxdVJLZv+2mPGrYaZOd72DMiIJRmFINNE9/4z+OOlus1ah8B9+iD52kuSeXIh0j
        01O2RfFZW/yobHjl0RqdMqLgQGfAoA0AIS4xbvPgLRkshpWBEMZzd5g2jG4YENTRcEI2ldkARxQpb
        c1Dq5C6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP8zA-00Bkwf-M9; Wed, 24 Mar 2021 19:16:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F6173062BA;
        Wed, 24 Mar 2021 20:16:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 093DA203D944F; Wed, 24 Mar 2021 20:16:07 +0100 (CET)
Date:   Wed, 24 Mar 2021 20:16:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] static_call: fix function type mismatch
Message-ID: <YFuP9sRT8tYShLUm@hirez.programming.kicks-ass.net>
References: <20210322170711.1855115-1-arnd@kernel.org>
 <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net>
 <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
 <20210322172921.56350a69@gandalf.local.home>
 <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
 <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk>
 <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
 <b2d77e78-751e-283c-8cff-e9c4f16e27ef@prevas.dk>
 <YFt382FImjQQ+10f@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFt382FImjQQ+10f@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 06:33:39PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 24, 2021 at 05:45:52PM +0100, Rasmus Villemoes wrote:
> > Sorry, I think I misread the code. The static calls are indeed
> > initialized with a function with the right prototype. Try adding
> > "preempt=full" on the command line so that we exercise these lines
> > 
> >                static_call_update(cond_resched,
> > (typeof(&__cond_resched)) __static_call_return0);
> >                 static_call_update(might_resched,
> > (typeof(&__cond_resched)) __static_call_return0);
> > 
> > I would expect that to blow up, since we end up calling a long (*)(void)
> > function using a function pointer of type int (*)(void).
> 
> Note that on x86 there won't actually be any calling of function
> pointers. See what arch/x86/kernel/static_call.c does :-)
> 
> But I think some of this code might need some __va_function() love when
> combined with CFI.
> 
> But yes, this is why I think something like -fcdecl might be a good
> idea, that ought to tell the compiler about the calling convention,
> which ought to be enough for the compiler to figure out that this magic
> really is ok.
> 
> Notable things we rely on:
> 
>  - caller cleanup of stack; the function caller sets up any stack
>    arguments and is also responsible for cleanin up the stack once the
>    function returns.

  - the arguments are pushed on stack right to left;

>  - the return value is in a register.
> 
> Per the first we can call a function that has a partial (empty per
> extremum) argument list. 

That extra constraint is required to make partial args work; as it
happens we only use empty args, and as such don't really care about this
atm.

> Per the second we can call a function with a
> different return type as long as they all fit in the same register.
> 
> The calling of a 'long (*)()' function for a 'int (*)()' type then
> becomes idential to something like: 'int x = (long)y', and that is
> something C is perfectly fine with.
> 
> We then slightly push things with the other __static_call_return0()
> usage in the kernel, where we basically end up with: 'void *x =
> (long)y', which is something C really rather would have a cast on.
