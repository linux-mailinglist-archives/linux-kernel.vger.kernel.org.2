Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF8B35A83A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 23:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhDIVHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 17:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233687AbhDIVHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 17:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618002440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vaqi7OpXmHE4q2aH4lgeYt11D1Lf+YszbQi2t7/zlLo=;
        b=OsjGgmtDuFjA84wGkF75V9OWCMNalW9hy42d0RDXZ/2igK+djqOP9W23WO+1VuHBjc1J3n
        C6399m0WPRriGA4IhpzK3cfpnPe2+mzKV13zzvjXWz0vUZLgNNcW8UxHSKk94wIdQwupjE
        nB9r0hXfjgY4bWsQcsQRAhHVofemZkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-Mdh62M6-Po2nyn6XDPtg8w-1; Fri, 09 Apr 2021 17:07:17 -0400
X-MC-Unique: Mdh62M6-Po2nyn6XDPtg8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A87028189C7;
        Fri,  9 Apr 2021 21:07:16 +0000 (UTC)
Received: from t14s.localdomain (ovpn-112-65.phx2.redhat.com [10.3.112.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE92844506;
        Fri,  9 Apr 2021 21:07:15 +0000 (UTC)
Message-ID: <5a07bde1a9fa9a056a19637399b0635252ddb303.camel@redhat.com>
Subject: Re: static_branch/jump_label vs branch merging
From:   David Malcolm <dmalcolm@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date:   Fri, 09 Apr 2021 17:07:15 -0400
In-Reply-To: <YHC0dgwhYS9hKcRT@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
         <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
         <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
         <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
         <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net>
         <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
         <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
         <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
         <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net>
         <0a9da587b0330bafdf612c3d51285e144b0b9e46.camel@redhat.com>
         <YHC0dgwhYS9hKcRT@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-09 at 22:09 +0200, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 03:21:49PM -0400, David Malcolm wrote:
> > [Caveat: I'm a gcc developer, not a kernel expert]
> > 
> > But it's not *quite* a global constant, or presumably you would be
> > simply using a global constant, right?  As the optimizer gets
> > smarter,
> > you don't want to have it one day decide that actually it really is
> > constant, and optimize away everything at compile-time (e.g. when
> > LTO
> > is turned on, or whatnot).
> 
> Right; as I said, the result is not a constant, but any invocation
> ever,
> will return the same result. Small but subtle difference :-)
> 
> > I get the impression that you're resorting to assembler because
> > you're
> > pushing beyond what the C language can express. 
> 
> Of course :-) I tend to always push waaaaay past what C considers
> sane.
> Lets say I'm firmly in the C-as-Optimizing-Assembler camp :-)

Yeah, I got that :)

> > Taking things to a slightly higher level, am I right in thinking
> > that
> > what you're trying to achieve is a control flow construct that
> > almost
> > always takes one of the given branches, but which can (very rarely)
> > be
> > switched to permanently take one of the other branches, and that
> > you
> > want the lowest possible overhead for the common case where the
> > control flow hasn't been touched yet? 
> 
> Correct, that's what it is. We do runtime code patching to flip the
> branch if/when needed. We've been doing this for many many years now.
> 
> The issue of today is all this clever stuff defeating some simple
> optimizations.

It's certainly clever - though, if you'll forgive me, that's not always
a good thing :)

> > (and presumably little overhead for when it
> > has been?)... and that you want to be able to merge repeated such
> > conditionals. 
> 
> This.. So the 'static' branches have been upstream and in use ever
> since
> GCC added asm-goto, it was in fact the driving force to get asm-goto
> implemented. This was 2010 according to git history.
> 
> So we emit, using asm goto, either a "NOP5" or "JMP.d32" (x86
> speaking),
> and a special section entry into which we encode the key address and
> the
> instruction address and the jump target.
> 
> GCC, not knowing what the asm does, only sees the 2 edges and all is
> well.
> 
> Then, at runtime, when we decide we want the other edge for a given
> key,
> we iterate our section and rewrite the code to either nop5 or jmp.d32
> with the correct jump target.
> 
> > It's kind of the opposite of "volatile" - something that the user
> > is
> > happy for the compiler to treat as not changing much, as opposed to
> > something the user is warning the compiler about changing from
> > under
> > it.  A "const-ish" value?
> 
> Just so. Encoded in text, not data.
> 
> > Sorry if I'm being incoherent; I'm kind of thinking aloud here.
> 
> No problem, we're way outside of what is generally considered normal,
> and I did somewhat assume people were familiar with our 'dodgy'
> construct (some on this list are more than others).
> 
> I hope it's all a little clearer now.

Yeah.  This is actually on two mailing lists; I'm only subscribed to
linux-toolchains, which AIUI is about sharing ideas between Linux and
the toolchains.

You've built a very specific thing out of asm-goto to fulfil the tough
requirements you outlined above - as well as the nops, there's a thing
in another section to contend with.

How to merge these asm-goto constructs?

Doing so feels very special-case to the kernel and not something that
other GCC users would find useful.

I can imagine a GCC plugin that implemented a custom optimization pass
for that - basically something that spots the asm-gotos in the gimple
IR and optimizes away duplicates by replacing them with jumps, but
having read about Linus's feelings about GCC plugins recently:
  https://lwn.net/Articles/851090/
I suspect that that isn't going to fly (and if you're going down the
route of adding an optimization pass via a plugin, there's probably a
way to do that that doesn't involve asm).  In theory, something to
optimize the asm-gotos could be relatively simple, but that said, we
don't really have a GCC plugin API; all of our internal APIs are
exposed, and are liable to change from release to release, which I know
is a pain (I've managed to break one of my own plugins with one of my
own API changes at least once).

Hope this is constructive
Dave


