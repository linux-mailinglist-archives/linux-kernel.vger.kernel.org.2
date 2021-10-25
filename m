Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4155439865
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhJYOYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbhJYOYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:24:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86DC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5QjZHsLCWfclt/gshLXd4DimV0kevV4P/FZvwj5ddGQ=; b=U23lyUv3vqw5brD4hb6ZhLqOi4
        3YXQVi5pbFM+3udRnZzfpeWN47JoPzXTkDIqsIIF80FaUhhar0Wbvsz1jI28mUkDPQaxfxO6ceOHL
        M6aNI0gM5OTG3EwhfG5jMB3UmRHEHGhUnArCHnsbIwGD+ccsOCLraVoyihUafjX8urrKtgye+lAKs
        mIG5o0NmGmhYkkAnso0z9KSqkCMHs4sEHoyDneYLWOnkDsuXFynDUNSwxx5M2qj/fAztHNznHi2El
        cib9xn/xW34pMpC0doPNKWG/W628EuAEJ8qi8BUn4Eh/IpXI7DzkyVfAkdX7bHe75hUG0YpgH/W/w
        4K3BRhSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf0oo-00GAxF-0M; Mon, 25 Oct 2021 14:19:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C97E3002AE;
        Mon, 25 Oct 2021 16:19:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43DF720C6C147; Mon, 25 Oct 2021 16:19:16 +0200 (CEST)
Date:   Mon, 25 Oct 2021 16:19:16 +0200
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
Message-ID: <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
 <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 04:08:37PM +0200, Ard Biesheuvel wrote:
> On Mon, 25 Oct 2021 at 15:57, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 25, 2021 at 02:21:00PM +0200, Frederic Weisbecker wrote:
> >
> > > +#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insn)                      \
> > > +     asm("   .pushsection    .static_call.text, \"ax\"               \n" \
> > > +         "   .align          4                                       \n" \
> > > +         "   .globl          " STATIC_CALL_TRAMP_STR(name) "         \n" \
> > > +         "0: .quad   0x0                                             \n" \
> > > +         STATIC_CALL_TRAMP_STR(name) ":                              \n" \
> > > +         "   hint    34      /* BTI C */                             \n" \
> > > +             insn "                                                  \n" \
> > > +         "   ldr     x16, 0b                                         \n" \
> > > +         "   cbz     x16, 1f                                         \n" \
> > > +         "   br      x16                                             \n" \
> > > +         "1: ret                                                     \n" \
> > > +         "   .popsection                                             \n")
> >

> > OK, that's pretty magical...
> >
> > So you're writing the literal and the two instructions with 2 u64
> > stores. Relying on alignment to guarantee both are in a single page and
> > that copy_to_kernel_nofault() selects u64 writes.
> >
> 
> To be honest, it just seemed tidier and less likely to produce weird
> corner cases to put the literal and the patched insn in the smallest
> possible power-of-2 aligned window, as it ensures that the D-side view
> is always consistent.
> 
> However, the actual fetch of the instruction could still produce a
> stale value before the cache maintenance completes.
> 
> > By unconditionally writing the literal, you avoid there ever being an
> > stale value, which in turn avoids there being a race where you switch
> > from 'J @func' relative addressing to 'NOP; do-literal-thing' and cross
> > CPU execution gets the ordering inverted.
> >
> 
> Indeed.
> 
> > Ooohh, but what if you go from !func to NOP.
> >
> > assuming:
> >
> >         .literal = 0
> >         BTI C
> >         RET
> >
> > Then
> >
> >         CPU0                    CPU1
> >
> >         [S] literal = func      [I] NOP
> >         [S] insn[1] = NOP       [L] x16 = literal (NULL)
> >                                 b x16
> >                                 *BANG*
> >
> > Is that possible? (total lack of memory ordering etc..)
> >
> 
> The CBZ will branch to the RET instruction if x16 == 0x0, so this
> should not happen.

Oooh, I missed that :/ I was about to suggest writing the address of a
bare 'ret' trampoline instead of NULL into the literal.

> > On IRC you just alluded to the fact that this relies on it all being in
> > a single cacheline (i-fetch windows don't need to be cacheline sized,
> > but provided they're at least 16 bytes, this should still work given the
> > alignment).
> >
> > But is I$ and D$ coherent? One load is through I-fetch, the other is a
> > regular D-fetch.
> >
> > However, Will has previously expressed reluctance to rely on such
> > things.
> >
> 
> No they are not. That is why the CBZ is there. So the only issue we
> might see is where the branch instruction is out of sync with the
> literal, and so we may call the old function while switching to the
> new one and the I-cache maintenance hasn't completed yet.

OK, agreed. Perhaps put in a comment to explain some of this though. The
next poor sod trying to untangle this code is sure to have a question or
two :-)
