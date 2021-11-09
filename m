Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E044B324
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbhKITZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbhKITZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:25:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975CC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iJZIo3STfY3lf2haVykR7BVPcS/nIvgKESoo2TuuPPo=; b=Ihy6ocXG5te82fzbfyuXsZFbuv
        Pt6LWuWw7qsPHsavKWVae0V/EKhdhvCYz73A4h3bvAKsQKdAuio/yRaBdc8maCTEKIi5GQzY3gvxo
        3WI+uBu93CVO3Utm6Lc8KXzkES9hiJvHpMLJjkjNc7NE46/QMZVv4Tgncx+hWc0ot9SkNwYq4PVYT
        tHT5A0lad78z1XnXuuZKoB2MSecTCDMcq/OcGYfxUbuOaXdMqHNuw76B7X3pJZ1JQVKegjfqdByKV
        o7bN2cnK5Mo2ELf6Dw2Wchxu6lGmI43XpZO9x+iQN3XLrTMWi+h7V0p6L4Hzz96wwjc8A2bqzmEbx
        qkNjnTQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkWhT-001HLo-Cu; Tue, 09 Nov 2021 19:22:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E20813000A3;
        Tue,  9 Nov 2021 20:22:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDFE7212EE58A; Tue,  9 Nov 2021 20:22:30 +0100 (CET)
Date:   Tue, 9 Nov 2021 20:22:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/7] static_call: get rid of static_call_cond()
Message-ID: <YYrKdpACXxCQj09z@hirez.programming.kicks-ass.net>
References: <20211109164549.1724710-1-ardb@kernel.org>
 <20211109164549.1724710-2-ardb@kernel.org>
 <YYrAHMy8xmPXj4ql@hirez.programming.kicks-ass.net>
 <CAMj1kXGdqDQ-WKLBcLhGNofmXpf-Xt8wAE18EBEGeTe9wNqZog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGdqDQ-WKLBcLhGNofmXpf-Xt8wAE18EBEGeTe9wNqZog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 07:41:03PM +0100, Ard Biesheuvel wrote:
> On Tue, 9 Nov 2021 at 19:38, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 09, 2021 at 05:45:43PM +0100, Ard Biesheuvel wrote:
> > > The main reason for the existence of static_call_cond() seems to be that
> > > in theory, when using the generic implementation of static calls, it may
> > > be possible for a compiler to elide the indirect call entirely if the
> > > target is NULL, while still guaranteeing that all side effects of
> > > argument evaluation occur as expected.
> > >
> > > This is rather optimistic: as documented by an existing code comment,
> > > both GCC and Clang (version 10) get this wrong, and even if they ever
> > > get it right, this is far too subtle to rely on for a code path that is
> > > expected to be used only by the 'remaining' architectures once all the
> > > best supported ones implement either the out-of-line or inline optimized
> > > variety of static calls.
> > >
> > > Given that having static_call_cond() clutters up the API, and puts the
> > > burden on the caller to go and check what kind of static call they are
> > > dealing with, let's just get rid of the distinction.
> >
> > No, static_call_cond() signifies the function can be NULL. Both gcc and
> > clang generate correct (but wildly ineffecient) code for this. Without
> > static_call_cond() the generic implementation will do a NULL deref.
> >
> > That is, static_call_cond() does properly encapuslate:
> >
> >         func = READ_ONCE(key.func);
> >         if (func)
> >                 func(ARGS);
> >
> > You can't take that out.
> 
> I actually address that in the patch.
> 
> AIUI, the compiler generates an indirect call to __static_call_nop(),
> right? So why not simply set .func to the address of
> __static_call_nop() when NULL is passed to update / the initializer?

Ooh, lemme go have a proper look then.
