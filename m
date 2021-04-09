Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8135A7AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhDIUMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhDIUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:12:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE8EC061762;
        Fri,  9 Apr 2021 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8BsXWLXai2kinUSiApHJlWnUpJkTqiHUGDPRSpX6h4U=; b=JBBQT9we8i+Pfp72JPLtxuWiTz
        s0Car8+KvLacCfmVjJgWXYfWgMeGsUOsLKJytXj76s8mJFPud5sdN55G8lLu7Lf9uQKvMD5Y65EY1
        NEmP7laypEElZpHkqr8NyRnmAdsgb0c5FmvJWx5e9Jhf77k4NYXC5vXiJjBkJGCUmriXNJf/0dcb5
        VfvrORBOB8jVk8eiR2n1KOt+2wbmko7KrCpA1u7/C97RqYNlzzr0hJ+DZqpXni/Tn0Llhf9pKQo4U
        g7KbMuSduq0b8uD35oBoJP0n5s+xFVzSHQ14Ovt3Ox2vpN9jyBIOJ7OuAmE/bBJgkAYLYq5caK1dC
        mU6tx2Mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUxT4-000sVx-HP; Fri, 09 Apr 2021 20:11:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 034D4300036;
        Fri,  9 Apr 2021 22:11:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E77272C6D7C6F; Fri,  9 Apr 2021 22:11:01 +0200 (CEST)
Date:   Fri, 9 Apr 2021 22:11:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        dmalcolm@redhat.com
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YHC01St3wfXOlRUb@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
 <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
 <877dlbzq09.fsf@oldenburg.str.redhat.com>
 <YHA3iGyT5dMq7/06@hirez.programming.kicks-ass.net>
 <CAKwvOdnBXyR6gPgQjaXbHF8Ozx9Kk=OKgPv8_P7=jvvsWRVHEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnBXyR6gPgQjaXbHF8Ozx9Kk=OKgPv8_P7=jvvsWRVHEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 12:33:29PM -0700, Nick Desaulniers wrote:
> On Fri, Apr 9, 2021 at 4:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Apr 09, 2021 at 12:55:18PM +0200, Florian Weimer wrote:
> > > * Ard Biesheuvel:
> > >
> > > > Wouldn't that require the compiler to interpret the contents of the
> > > > asm() block?
> > >
> > > Yes and no.  It would require proper toolchain support, so in this case
> > > a new ELF relocation type, with compiler, assembler, and linker support
> > > to generate those relocations and process them.  As far as I understand
> > > it, the kernel doesn't do things this way.
> >
> > I don't think that all is needed. All we need is for the compiler to
> > recognise that:
> >
> >         if (cond) {
> >                 stmt-A;
> >         }
> >         if (cond) {
> >                 stmt-B;
> >         }
> >
> > both cond are equivalent and hence can merge the blocks like:
> >
> >         if (cond) {
> >                 stmt-A;
> >                 stmt-B;
> >         }
> >
> > But because @cond is some super opaque asm crap, the compiler throws up
> > it's imaginry hands and says it cannot possibly tell and leaves them as
> > is.
> 
> Right, because if `cond` has side effects (such as is implied by asm
> statements that are volatile qualified), suddenly those side effects
> would only occur once whereas previously they occurred twice.
> 
> Since asm goto is implicitly volatile qualified, it sounds like
> removing the implicit volatile qualifier from asm goto might help?
> Then if there were side effects but you forgot to inform the compiler
> that there were via an explicit volatile qualifier, and it performed
> the suggested merge, oh well.

So, as mentioned elsewhere in this thread, it would be nice if either
the pure or const function attribute could over-ride/constrain that
volatile side effect.

I'm fine with things going side-ways if we get it wrong, that's more or
less the game we're playing anyway ;-)
