Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AC44B36D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243830AbhKITpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbhKITpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:45:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82CFC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5XIGjkcGERAZzzieuikWA1xHtahXazjRcK+wygMzymM=; b=WKWDuZNuWlOOcpDVQuK6Xl1kSY
        Ed13XediStqyXCnxwD9QZzahRcQMBaWkAsAHnY2SGUIKfgx63Y2nHmc0++fR9fqIu+fdUpb/grb/J
        ClsuHE03J3dqw76LVtLWs77d0VTO+wYQ8u4VIclk2S39zvs90ZkBCkZjrKE36+Kej+8e6hfuA1B9s
        tWYvCmsP9yx2TNmthj7PMno1BEYAJ2ITWNTQixWtrHeIodrSkBzcjGVK6BrWpiqpStusU+/xSYBaa
        sAuyY6ESdY+50u3pjB1kJefmDMpk2pwEH1QO8CWmslMwxeOwOyosy86BzS+McIG788gv5Jxt4UN9s
        H9ETOffQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkX0n-001I9n-EV; Tue, 09 Nov 2021 19:42:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC6D03000A3;
        Tue,  9 Nov 2021 20:42:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC2292C525D3C; Tue,  9 Nov 2021 20:42:29 +0100 (CET)
Date:   Tue, 9 Nov 2021 20:42:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 3/7] static_call: use helper to access non-exported
 key
Message-ID: <YYrPJXlyQV5pXPHt@hirez.programming.kicks-ass.net>
References: <20211109164549.1724710-1-ardb@kernel.org>
 <20211109164549.1724710-4-ardb@kernel.org>
 <YYrDkUsJVcOzxMPL@hirez.programming.kicks-ass.net>
 <CAMj1kXEW72y1p-qR+X6EBqM8Rf5+fZnEs2WSSz7b+eU=zvPt6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEW72y1p-qR+X6EBqM8Rf5+fZnEs2WSSz7b+eU=zvPt6w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 07:54:23PM +0100, Ard Biesheuvel wrote:
> On Tue, 9 Nov 2021 at 19:53, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 09, 2021 at 05:45:45PM +0100, Ard Biesheuvel wrote:
> > > @@ -196,13 +190,21 @@ extern long __static_call_return0(void);
> > >       EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));                       \
> > >       EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> > >
> > > +#define EXPORT_STATIC_CALL_GETKEY_HELPER(name)                               \
> > > +     struct static_call_key *STATIC_CALL_GETKEY(name)(void) {        \
> > > +             BUG_ON(!core_kernel_text(                               \
> > > +                     (unsigned long)__builtin_return_address(0)));   \
> > > +             return &STATIC_CALL_KEY(name);                          \
> > > +     }                                                               \
> > > +     EXPORT_SYMBOL_GPL(STATIC_CALL_GETKEY(name))
> >
> > So if I were a nevarious module, I would look up the above symbol from
> > kallsyms (it is exported and easily obtainable) and then simply
> > read the text to discover the key address and we're in business.
> >
> 
> Yeah I realised that. So would you prefer to have a
> .static_call_tramp_key section in each module and look up the keys in
> the module loader?

Think so... do you actually have a need for this?
