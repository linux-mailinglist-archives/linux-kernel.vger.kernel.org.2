Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76428447F29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbhKHLz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:55:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77C3C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 03:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iGvLUtwPbdRsAfeVJOcAVPj61fXiSzd4nOb67Hfr9sw=; b=F+BJuQ+IrbziNIXT9xJu5L+UqB
        lraLF91ieb3EqV159cAYbdxPh16m+cadbOWiwl9jcekGoedIewYhnqSHhhBMR7qmFo6cNLMrEiTOH
        neMlc6vd2JUNmiVxh1iTSzLBHXGzM61RRdXD67CWRqKR3FZe0cFI6bFgVawRKX0mfGI9E1PFMJh2A
        FQkh+4azXrnUjFKS64DvsnAhK1VH8e2rMEzUhJ9/d7EDudfuZ9U0/a0FfeOZOhFvyNDTwD4qDu9GW
        guMvF6BRN4pe336JdFGkbJ6qabesfBb0AfOrYp4Ps9LBBs95b486GrznQjoZzSdl8F7ZQQyOJdQgk
        QpUumMpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk3CR-0009SK-Fj; Mon, 08 Nov 2021 11:52:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8764830030B;
        Mon,  8 Nov 2021 12:52:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EFD4202A0132; Mon,  8 Nov 2021 12:52:31 +0100 (CET)
Date:   Mon, 8 Nov 2021 12:52:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6 2/2] arm64: implement support for static call
 trampolines
Message-ID: <YYkPf6TgsiV3Da/y@hirez.programming.kicks-ass.net>
References: <20211105145917.2828911-1-ardb@kernel.org>
 <20211105145917.2828911-3-ardb@kernel.org>
 <YYj6ib6Mrp9rAjVJ@hirez.programming.kicks-ass.net>
 <CAMj1kXHEBc1XkTuHPXYV8rp5++HA9ruROUP-UApzEnVzvgFvTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHEBc1XkTuHPXYV8rp5++HA9ruROUP-UApzEnVzvgFvTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 12:29:04PM +0100, Ard Biesheuvel wrote:
> On Mon, 8 Nov 2021 at 11:23, Peter Zijlstra <peterz@infradead.org> wrote:

> > > +static void *strip_cfi_jt(void *addr)
> > > +{
> > > +     if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> > > +             void *p = addr;
> > > +             u32 insn;
> > > +
> > > +             /*
> > > +              * Taking the address of a function produces the address of the
> > > +              * jump table entry when Clang CFI is enabled. Such entries are
> > > +              * ordinary jump instructions, preceded by a BTI C instruction
> > > +              * if BTI is enabled for the kernel.
> > > +              */
> > > +             if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> > > +                     p += 4;
> >
> > Perhaps:
> >                 if (aarch64_insn_is_bti(le32_to_cpup(p)))
> 
> That instruction does not exist yet, and it begs the question which
> type of BTI instruction we want to detect.

Yeah, I actually checked, but I figured the intent was clear enough. I
figured all of them?

> >                         p += 4;
> >
> > Perhapser still, add:
> >                 else
> >                         WARN_ON(IS_ENABLED(CONFIG_ARM64_BTI_KERNEL));
> >
> 
> There's already a WARN() below that will trigger and return the
> original address if the entry did not have the expected layout, which
> means a direct branch at offset 0x0 or 0x4 depending on whether BTI is
> on.
> 
> So I could add a WARN() here as well, but I'd prefer to keep the one
> at the bottom, which makes the one here slightly redundant.

Sure, that works. The slightly more paranoid me would tell you that the
code as is might match something you didn't want it to.

Eg. without the extra WARN, you could accidentally match a B instruction
without BTI on a BTI kernel build. Or your initial version could even
match:

	RET;
	B ponies;

on a BTI kernel.

My point being that since we're not exactly sure what a future compiler
will generate for us here, we'd best be maximally paranoid about what
we're willing to accept.

> > > +
> > > +             insn = le32_to_cpup(p);
> > > +             if (aarch64_insn_is_b(insn))
> > > +                     return p + aarch64_get_branch_offset(insn);
> > > +
> > > +             WARN_ON(1);
> > > +     }
> > > +     return addr;
> > > +}
> >
> > Also, can this please have a comment decrying the lack of built-in for
> > this?
> 
> Sure.

Which ties in with that. Once it's a built-in, we can be sure the
compiler knows what it needs to do to undo it's own magic.
