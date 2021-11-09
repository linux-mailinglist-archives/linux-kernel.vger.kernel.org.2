Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4157444B35D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbhKIToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhKIToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:44:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702ECC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/uZHFFIiFMSRR8NICP960/weilugmtUf1FBCM+vX2OY=; b=m0f5ITxorLF23pUNQ17kC0jyX1
        Xz6WD1Q2FJJdJzEGHX3oKxR295cj3MGEU0V7G2dclImQFTQahTppWwwSoQaLkmISciZ9Dg7XptTJ1
        /gEQYCBwmPnNcL7zu0cG7wBC5Ufh2oIieaaKmothC2Ek0ce32E104WSHht0oidF+0BEEvQ40FhqlK
        BeohNPUeBTnQXVsTMlwSq9oLy/C2F4x1EeoB1lYPBjsd8hJ5lUxKwda/hUr5yQqB+OHyWKPByuW4O
        XGJN/58zJF8KunnV1wTc3pFMaNKePs1PIuwCHjckzsvD372LpZw2uGke1+ncW+aDkqJqWltwDyuXW
        IAKKl5sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkWzk-00F7OZ-PI; Tue, 09 Nov 2021 19:41:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 268023000A3;
        Tue,  9 Nov 2021 20:41:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09B592C525D3B; Tue,  9 Nov 2021 20:41:23 +0100 (CET)
Date:   Tue, 9 Nov 2021 20:41:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 2/7] static_call: deal with unexported keys without
 cluttering up the API
Message-ID: <YYrO4/S7tfr7P5YA@hirez.programming.kicks-ass.net>
References: <20211109164549.1724710-1-ardb@kernel.org>
 <20211109164549.1724710-3-ardb@kernel.org>
 <YYrCn3mc+EbY+OB/@hirez.programming.kicks-ass.net>
 <CAMj1kXHArfyvZ-b11vLshpj84drDtuU+T_o+h+cWqhtajpon0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHArfyvZ-b11vLshpj84drDtuU+T_o+h+cWqhtajpon0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 07:53:33PM +0100, Ard Biesheuvel wrote:
> On Tue, 9 Nov 2021 at 19:49, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 09, 2021 at 05:45:44PM +0100, Ard Biesheuvel wrote:
> >
> > > diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
> > > index 5a00b8b2cf9f..0bb36294cce7 100644
> > > --- a/include/linux/static_call_types.h
> > > +++ b/include/linux/static_call_types.h
> > > @@ -32,15 +32,20 @@
> > >  struct static_call_site {
> > >       s32 addr;
> > >       s32 key;
> > > +     s32 tramp;
> > >  };
> >
> > I can't say I'm thrilled at growing this thing, but the cleanup is nice.
> > Perhaps we can increase alignment on struct static_call_key and instead
> > frob it in .key still?
> >
> 
> This is already a place-relative field, and one points into the data
> section and the other into text. So I don't see how we can squeeze
> enough bits out of it to make this fit.

Well, the actual address will be:

	((unsigned long)&site->key + site->key)

either way around, right? Now, if we align struct static_call_key to 8,
that means the low 3 bits of that address will be 0 and free for us to
muck about with.

That is, we already use the low 2 bits of that (because natural
alignment etc.).

If we got 3 bits, we could shift the existing two bits one up and free
up bit0, then say that if bit0 is set, it's a trampoline address. The
only additional requirement would be that trampolines are (at least)
aligned 2 (they're at 4 currently).

Except.... it would be the linker having to create that field, and
there's no way that thing is smart like that :-( Ooh well.


