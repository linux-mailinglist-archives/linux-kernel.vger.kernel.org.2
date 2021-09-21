Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15E4135DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhIUPJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhIUPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:09:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=51xDDiJrtSwBbdqPNC79+e2eW262m8hKT5dv7WsRzI8=; b=eOBa4TrKV62WYXSIGIQ/Mbs96S
        CsN5FtwT8YZKhYQ3gykcIo7/SeTXByScixpM5NUPG78WUbA3MXZXXEsj5MaAlJaG5AZyCRpq5bXQt
        N3jTK+JybpLRtlOs2BbsF37icBaQ86uPIn3MPLusPJ2iWm8GnVOxwFdHuSTC84awfpM4dwZFUqQha
        kcL5AuHHvQMaz+wNSe1Qh9f9F5Pk1UW6XB5UN/kxoLfs6CkLNtqry+jgXcQmQ3QTUxHkx2JzY8odH
        YiYwcgR/eTMEMKbw1K1wLACDZJpQauBBjLFDy/odaKaWx7+TpSxO+dSUpdH/GSAxaAYYNZmcVKgpU
        tk0W90mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mShNf-004mpq-Uv; Tue, 21 Sep 2021 15:08:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76DAB300252;
        Tue, 21 Sep 2021 17:08:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57D712019DA07; Tue, 21 Sep 2021 17:08:23 +0200 (CEST)
Date:   Tue, 21 Sep 2021 17:08:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <YUn1ZySphVBzaBfg@hirez.programming.kicks-ass.net>
References: <20210920233237.90463-1-frederic@kernel.org>
 <20210920233237.90463-3-frederic@kernel.org>
 <YUmFFvZCb2yXn3os@hirez.programming.kicks-ass.net>
 <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:44:56PM +0200, Ard Biesheuvel wrote:
> On Tue, 21 Sept 2021 at 09:10, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Sep 21, 2021 at 01:32:35AM +0200, Frederic Weisbecker wrote:
> >
> > > +#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, target)                            \
> > > +     asm("   .pushsection    .static_call.text, \"ax\"               \n" \
> > > +         "   .align          3                                       \n" \
> > > +         "   .globl          " STATIC_CALL_TRAMP_STR(name) "         \n" \
> > > +         STATIC_CALL_TRAMP_STR(name) ":                              \n" \
> > > +         "   hint    34      /* BTI C */                             \n" \
> > > +         "   adrp    x16, 1f                                         \n" \
> > > +         "   ldr     x16, [x16, :lo12:1f]                            \n" \
> > > +         "   cbz     x16, 0f                                         \n" \
> > > +         "   br      x16                                             \n" \
> > > +         "0: ret                                                     \n" \
> > > +         "   .popsection                                             \n" \
> > > +         "   .pushsection    .rodata, \"a\"                          \n" \
> > > +         "   .align          3                                       \n" \
> > > +         "1: .quad           " target "                              \n" \
> > > +         "   .popsection                                             \n")
> >
> > So I like what Christophe did for PPC32:
> >
> >   https://lkml.kernel.org/r/6ec2a7865ed6a5ec54ab46d026785bafe1d837ea.1630484892.git.christophe.leroy@csgroup.eu
> >
> > Where he starts with an unconditional jmp and uses that IFF the offset
> > fits and only does the data load when it doesn't. Ard, woulnd't that
> > also make sense on ARM64? I'm thinking most in-kernel function pointers
> > would actually fit, it's just the module muck that gets to have too
> > large pointers, no?
> >
> 
> Yeah, I'd have to page that back in. But it seems like the following
> 
>   bti c
>   <branch>
>   adrp x16, <literal>
>   ldr x16, [x16, ...]
>   br x16
> 
> with <branch> either set to 'b target' for the near targets, 'ret' for
> the NULL target, and 'nop' for the far targets should work, and the
> architecture permits patching branches into NOPs and vice versa
> without special synchronization. But I must be missing something here,
> or why did we have that long discussion before?

So the fundamental contraint is that we can only modify a single
instruction at the time and need to consider concurrent execution.

I think the first round of discussions was around getting the normal arm
pattern of constructing a long pointer 'working'. My initial suggestion
was to have 2 slots for that, then you came up with this data load
thing.
