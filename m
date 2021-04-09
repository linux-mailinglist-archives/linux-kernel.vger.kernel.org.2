Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65C335A6FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhDITWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234996AbhDITWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617996115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvRGwp2fcPDa5qN6iPQV9w0HMPktaVyEamHkl/VHIzU=;
        b=RDEnnkTilE6e5NsRfSpA+6n4E9YHJa5nRLYqp+8aRgVfP7A9AXwZajmHDLghgCWz2xdg0S
        w+Doiia+oayiLqt7Cvc/M8vRyZvZ3VORMxHoIQaYjgIVobeXouAKfqPl0mRovgw3rTwu/M
        ehfjU1SajgfQBrR4shkVQmS13rUip4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-GBYvIosFOR-5w54IiKmOzA-1; Fri, 09 Apr 2021 15:21:52 -0400
X-MC-Unique: GBYvIosFOR-5w54IiKmOzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1121D80D69E;
        Fri,  9 Apr 2021 19:21:51 +0000 (UTC)
Received: from t14s.localdomain (ovpn-112-65.phx2.redhat.com [10.3.112.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3577E6A97F;
        Fri,  9 Apr 2021 19:21:50 +0000 (UTC)
Message-ID: <0a9da587b0330bafdf612c3d51285e144b0b9e46.camel@redhat.com>
Subject: Re: static_branch/jump_label vs branch merging
From:   David Malcolm <dmalcolm@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date:   Fri, 09 Apr 2021 15:21:49 -0400
In-Reply-To: <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
         <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
         <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
         <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
         <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net>
         <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
         <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
         <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
         <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-09 at 20:40 +0200, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 09:48:33AM -0400, David Malcolm wrote:
> > You tried __pure on arch_static_branch; did you try it on
> > static_branch_unlikely?
> 
> static_branch_unlikely() is a CPP macro that expands to a statement
> expression, or as with the later patch, a _Generic(). I'm not sure
> how
> to apply the attribute to either of them since it is a function
> attribute.
> 
> I was hoping the attribute would percolate through, so to speak.
> 
> > With the caveat that my knowledge of GCC's middle-end is mostly
> > about
> > implementing warnings, rather than optimization, I did some
> > experimentation, with gcc trunk on x86_64 FWIW.
> > 
> > Given:
> > 
> > int __attribute__((pure)) foo(void);
> > 
> > int t(void)
> > {
> >   int a;
> >   if (foo())
> >     a++;
> >   if (foo())
> >     a++;
> >   if (foo())
> >     a++;
> >   return a;
> > }
> > 
> > At -O1 and above this is optimized to a single call to foo,
> > returning 0
> > or 3 accordingly.
> > 
> > -fdump-tree-all shows that it's the "fre1" pass that eliminates the
> > subsequent calls to foo, replacing them with reuses of the result
> > of
> > the first call.
> > 
> > This is in gcc/tree-ssa-sccvn.c, a value-numbering pass.
> > 
> > I think you want to somehow "teach" the compiler that:
> >   static_branch_unlikely(&sched_schedstats)
> > is "pure-ish", that for some portion of the surrounding code that
> > you
> > want the result to be treated as pure - though I suspect compiler
> > maintainers with more experience than me are thinking "but which
> > portion? what is it safe to assume, and what will users be annoyed
> > about if we optimize away? what if t itself is inlined somewhere?"
> > and
> > similar concerns.
> 
> Right, pure or even const. As to the scope, as wide as possible. It
> literally is a global constant, the value returned is the same
> everywhere.

[Caveat: I'm a gcc developer, not a kernel expert]

But it's not *quite* a global constant, or presumably you would be
simply using a global constant, right?  As the optimizer gets smarter,
you don't want to have it one day decide that actually it really is
constant, and optimize away everything at compile-time (e.g. when LTO
is turned on, or whatnot).

I get the impression that you're resorting to assembler because you're
pushing beyond what the C language can express.  Taking things to a
slightly higher level, am I right in thinking that what you're trying
to achieve is a control flow construct that almost always takes one of
the given branches, but which can (very rarely) be switched to
permanently take one of the other branches, and that you want the
lowest possible overhead for the common case where the control flow
hasn't been touched yet?  (and presumably little overhead for when it
has been?)... and that you want to be able to merge repeated such
conditionals.  Perhaps a __builtin_ to hint that a conditional should
work that way (analogous to __builtin_expect)?  I can imagine a way of
implementing such a construct in gcc's gimple and RTL representations,
but it would be a ton of work (and I have a full plate already)

Or maybe another way of thinking about it is that you're reading a
value and you would like the compiler to amortize away repeated reads
of the value (perhaps just within the current function).

It's kind of the opposite of "volatile" - something that the user is
happy for the compiler to treat as not changing much, as opposed to
something the user is warning the compiler about changing from under
it.  A "const-ish" value?

Sorry if I'm being incoherent; I'm kind of thinking aloud here.

Hope this is constructive
Dave


> 
> All we need GCC to do for the static_branch construct is to emit both
> branches; that is, it must not treat the result as a constant and
> elide
> the other branches. But it can consider consecutive calls (as far and
> wide as it wants) to return the same value.
> 
> > Or maybe the asm stmt itself could somehow be marked as pure???
> > (with
> > similar concerns about semantics as above)
> 
> Yeah, not sure, someone with more clue will have to inform us what,
> if
> anything more than marking it either pure or const is required.
> Perhaps
> that attribute is sufficient and the compiler just isn't optimizing
> for
> an unrelated reason.
> 
> Regards,
> 
> Peter
> 


