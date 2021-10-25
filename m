Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B500D43999E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhJYPIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbhJYPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:08:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C909EC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7JEK7+9XyR/LYEB+jCRSfqzJeyFXsGmCq275MlF6qHY=; b=Z3h+TDRZci3jvRNL81hvKKd4ym
        Ucy3uISgZ3tbccPbsSc+Bv7dYzY3wjvJxkEl9blnrS1P1TT0F3toFnFN9q6yhUj0aeoFqMOjJODjl
        50VY9VGU60rTICMyAgRfGG20m1g76Z1yniP204ZH952ZqMER97tml/qc6UYEwuDudfuaOX2FcWekY
        1RKcO77iO0df/XSXpqtV5cb0idFw7FIxn45zEDkiN5ULzr4oEAg4vW+E0pbbvV5bPGALGj9o6i6M9
        Mw+F2gErKEKU8FKbHz4QDl9emqPQaiXSfBy0g3X7MrtyYgRkyv0WQHpHJBhDQ9biygergu+IGJj3f
        g/+nfQoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf1V8-00GCjZ-4N; Mon, 25 Oct 2021 15:03:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8B263002AE;
        Mon, 25 Oct 2021 17:03:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1D462B7E450C; Mon, 25 Oct 2021 17:03:00 +0200 (CEST)
Date:   Mon, 25 Oct 2021 17:03:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <YXbHJCtkBdMP/bF6@hirez.programming.kicks-ass.net>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
 <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
 <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net>
 <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
 <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 04:55:17PM +0200, Ard Biesheuvel wrote:
> On Mon, 25 Oct 2021 at 16:47, Peter Zijlstra <peterz@infradead.org> wrote:

> > Perhaps a little something like so.. Shaves 2 instructions off each
> > trampoline.
> >
> > --- a/arch/arm64/include/asm/static_call.h
> > +++ b/arch/arm64/include/asm/static_call.h
> > @@ -11,9 +11,7 @@
> >             "   hint    34      /* BTI C */                             \n" \
> >                 insn "                                                  \n" \
> >             "   ldr     x16, 0b                                         \n" \
> > -           "   cbz     x16, 1f                                         \n" \
> >             "   br      x16                                             \n" \
> > -           "1: ret                                                     \n" \
> >             "   .popsection                                             \n")
> >
> >  #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)                      \
> > --- a/arch/arm64/kernel/patching.c
> > +++ b/arch/arm64/kernel/patching.c
> > @@ -90,6 +90,11 @@ int __kprobes aarch64_insn_write(void *a
> >         return __aarch64_insn_write(addr, &i, AARCH64_INSN_SIZE);
> >  }
> >
> > +asm("__static_call_ret:                \n"
> > +    "  ret                     \n")
> > +
> 
> This breaks BTI as it lacks the landing pad, and it will be called indirectly.

Argh!

> > +extern void __static_call_ret(void);
> > +
> 
> Better to have an ordinary C function here (with consistent linkage),
> but we need to take the address in a way that works with Clang CFI.

There is that.

> As the two additional instructions are on an ice cold path anyway, I'm
> not sure this is an obvious improvement tbh.

For me it's both simpler -- by virtue of being more consistent, and
smaller. So double win :-)

That is; you're already relying on the literal being unconditionally
updated for the normal B foo -> NOP path, and having the RET -> NOP path
be handled differently is just confusing.

At least, that's how I'm seeing it today...
