Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139BF35A7A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhDIUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDIUKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:10:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE5C061762;
        Fri,  9 Apr 2021 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RTRfESDMgp5WTWcYaOiBYP6gw6aHG5qvZbrxxN3CTDs=; b=t5U1qHTIa8JHz3diU+neb+7sk3
        E/T3zqkQdnaVCIrD7NeTNSEGUiq9rLD3FXlB0/K2BHFvGEbQHTBXOyScmzpGMaMgH7uFFnbpIozrq
        2JGRHy52WlsNCoXc1zbvfNomPmlX9ey+VzVHz5tYATnfk6y6zoV8a5v0Fb9kBxQiiGhPnbBcGfvJ1
        5yBiFlqe8IHPWdWg9eVui0zY2jzPefxdWHq4QRz3L1ewNrAEb2VplLLBpM+I9i3lr4OvkBHnOtjQM
        vFzYHMQTDgFBRNGsviKw9Oj/rSWhg3yvnhCQWKe5Vv55/au5VhHHAFF48YGX0lvZPAGCT1zul244T
        uR6FxTyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUxRY-000sNh-2n; Fri, 09 Apr 2021 20:09:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E77A5300033;
        Fri,  9 Apr 2021 22:09:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB94B2C6D7C6F; Fri,  9 Apr 2021 22:09:26 +0200 (CEST)
Date:   Fri, 9 Apr 2021 22:09:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YHC0dgwhYS9hKcRT@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a9da587b0330bafdf612c3d51285e144b0b9e46.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 03:21:49PM -0400, David Malcolm wrote:
> [Caveat: I'm a gcc developer, not a kernel expert]
> 
> But it's not *quite* a global constant, or presumably you would be
> simply using a global constant, right?  As the optimizer gets smarter,
> you don't want to have it one day decide that actually it really is
> constant, and optimize away everything at compile-time (e.g. when LTO
> is turned on, or whatnot).

Right; as I said, the result is not a constant, but any invocation ever,
will return the same result. Small but subtle difference :-)

> I get the impression that you're resorting to assembler because you're
> pushing beyond what the C language can express. 

Of course :-) I tend to always push waaaaay past what C considers sane.
Lets say I'm firmly in the C-as-Optimizing-Assembler camp :-)

> Taking things to a slightly higher level, am I right in thinking that
> what you're trying to achieve is a control flow construct that almost
> always takes one of the given branches, but which can (very rarely) be
> switched to permanently take one of the other branches, and that you
> want the lowest possible overhead for the common case where the
> control flow hasn't been touched yet? 

Correct, that's what it is. We do runtime code patching to flip the
branch if/when needed. We've been doing this for many many years now.

The issue of today is all this clever stuff defeating some simple
optimizations.

> (and presumably little overhead for when it
> has been?)... and that you want to be able to merge repeated such
> conditionals. 

This.. So the 'static' branches have been upstream and in use ever since
GCC added asm-goto, it was in fact the driving force to get asm-goto
implemented. This was 2010 according to git history.

So we emit, using asm goto, either a "NOP5" or "JMP.d32" (x86 speaking),
and a special section entry into which we encode the key address and the
instruction address and the jump target.

GCC, not knowing what the asm does, only sees the 2 edges and all is
well.

Then, at runtime, when we decide we want the other edge for a given key,
we iterate our section and rewrite the code to either nop5 or jmp.d32
with the correct jump target.

> It's kind of the opposite of "volatile" - something that the user is
> happy for the compiler to treat as not changing much, as opposed to
> something the user is warning the compiler about changing from under
> it.  A "const-ish" value?

Just so. Encoded in text, not data.

> Sorry if I'm being incoherent; I'm kind of thinking aloud here.

No problem, we're way outside of what is generally considered normal,
and I did somewhat assume people were familiar with our 'dodgy'
construct (some on this list are more than others).

I hope it's all a little clearer now.

