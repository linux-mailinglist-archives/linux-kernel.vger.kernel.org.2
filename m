Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40581446847
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhKESNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhKESM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:12:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6021DC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bIKw3Z6T+EwvQMxsdscDQz+2r/YCdbYlSnn2vUgwzeg=; b=d6yiAXK4kbF36XxjQoYUKwdWC5
        wTldBkY5gQWV6srDjsR6aP3xuu9Y6BOJUShBnwgE4jhFeSmXnhSiJnUMKqWSO2J4ZTpgEe8mFzabT
        paTLk5ssbO/l8NdRKL72yhqp4BXHciR3is/ck9BXSvpO+c59GisAoA/lXJ4SmyFPbmU7ayKg/Cci5
        kLTO2oiCtcVKh4qo4cfxos0mGx4ALS2EeJAkKigqHK8cVGo+LT2tzCZeIWiNyAehGTNxDPalg0IwX
        IVNUQTkvy1f9IiyuYWgfABSoI1wkiwtrmVM1ixVFOxTn5k9uF89YuxbwWPBh4hsN/tVfmrJV5NM7C
        LkB61jCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj3cX-006j6m-7c; Fri, 05 Nov 2021 18:07:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 441D29869D8; Fri,  5 Nov 2021 19:07:19 +0100 (CET)
Date:   Fri, 5 Nov 2021 19:07:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211105180719.GM174703@worktop.programming.kicks-ass.net>
References: <20211105171023.989862879@infradead.org>
 <20211105171821.654356149@infradead.org>
 <20211105180152.oi7h3p6fb6c5pjkf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105180152.oi7h3p6fb6c5pjkf@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 11:01:52AM -0700, Josh Poimboeuf wrote:
> On Fri, Nov 05, 2021 at 06:10:43PM +0100, Peter Zijlstra wrote:
> > +#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> > +
> > +static inline unsigned long load_unaligned_zeropad(const void *addr)
> > +{
> > +	unsigned long offset, data;
> > +	unsigned long ret;
> > +
> > +	asm_volatile_goto(
> > +		"1:	mov %[mem], %[ret]\n"
> > +
> > +		_ASM_EXTABLE(1b, %l[do_exception])
> > +
> > +		: [ret] "=&r" (ret)
> > +		: [mem] "m" (*(unsigned long *)addr)
> > +		: : do_exception);
> > +
> > +out:
> > +	return ret;
> > +
> > +do_exception: __cold;
> > +
> > +	offset = (unsigned long)addr & (sizeof(long) - 1);
> > +	addr = (void *)((unsigned long)addr & ~(sizeof(long) - 1));
> > +	data = *(unsigned long *)addr;
> > +	ret = data >> offset * 8;
> > +	goto out;
> 
> Superfluous goto, can just return here?

Can do I suppose.

> >  static inline unsigned long load_unaligned_zeropad(const void *addr)
> >  {
> > -	unsigned long ret, dummy;
> > +	unsigned long offset, data;
> > +	unsigned long ret, err = 0;
> >  
> > -	asm(
> > -		"1:\tmov %2,%0\n"
> > +	asm(	"1:	mov %[mem], %[ret]\n"
> >  		"2:\n"
> > -		".section .fixup,\"ax\"\n"
> > -		"3:\t"
> > -		"lea %2,%1\n\t"
> > -		"and %3,%1\n\t"
> > -		"mov (%1),%0\n\t"
> > -		"leal %2,%%ecx\n\t"
> > -		"andl %4,%%ecx\n\t"
> > -		"shll $3,%%ecx\n\t"
> > -		"shr %%cl,%0\n\t"
> > -		"jmp 2b\n"
> > -		".previous\n"
> > -		_ASM_EXTABLE(1b, 3b)
> > -		:"=&r" (ret),"=&c" (dummy)
> > -		:"m" (*(unsigned long *)addr),
> > -		 "i" (-sizeof(unsigned long)),
> > -		 "i" (sizeof(unsigned long)-1));
> > +
> > +		_ASM_EXTABLE_FAULT(1b, 2b)
> > +
> > +		: [ret] "=&r" (ret), "+a" (err)
> > +		: [mem] "m" (*(unsigned long *)addr));
> > +
> > +	if (unlikely(err)) {
> > +		offset = (unsigned long)addr & (sizeof(long) - 1);
> > +		addr = (void *)((unsigned long)addr & ~(sizeof(long) - 1));
> > +		data = *(unsigned long *)addr;
> > +		ret = data >> offset * 8;
> > +	}
> > +
> >  	return ret;
> 
> This adds a (normally not taken) conditional jump, would a straight jmp
> over the fixup not be better?
> 
> i.e.
> 
> 	1: mov %[mem], %[ret]
> 	jmp 2
> 	... fixup code ...
> 	2:

I really don't know, this way we can get the bulk of the text
out-of-line.
