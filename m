Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453E3446066
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhKEIGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhKEIGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:06:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F508C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZZ1p2MkIaALiQuwbaHGLLU5JyyG/6OBel/a7uMOt8A8=; b=TPDuf+O6TnEBl1gx4YRIsSsVH2
        g/UYy3Ew2hSBwj+XutfFA8bZpXUCSz8CBtKcwON19UaRGJzkAFvvOREyhmzpftWI1iHD5RtGs5lis
        nIW7FNvJj41KjuTSq+QSZolqzNVKzJXl0tv+CBFizbH8QAUAZqPNBgSECnLEF1KHq4qMnOyZMDQP2
        vOnqMFFO2F4zEMn4EJ5t6HHctYOmQboGZAVPxWGn0HV4w/bmqo7jZAVv9agRTLU24D8cWafy9EYKr
        eFmB8nFmtmUnTVIzH16Wd3ZyM6a9xmmAewPpTvD8nCOPajzbKq2QrjoOkDRzQwIuHM/gMdsJOg6IL
        f7PNRq7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miuCe-00EJHP-KS; Fri, 05 Nov 2021 08:04:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4624E98632E; Fri,  5 Nov 2021 09:04:00 +0100 (CET)
Date:   Fri, 5 Nov 2021 09:04:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 21/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211105080400.GK174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.767986267@infradead.org>
 <20211104233310.2dg2gilae27l75a3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104233310.2dg2gilae27l75a3@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 04:33:10PM -0700, Josh Poimboeuf wrote:
> On Thu, Nov 04, 2021 at 05:47:50PM +0100, Peter Zijlstra wrote:
> > XXX: I'm not really happy with this patch
> >
> >  static inline unsigned long load_unaligned_zeropad(const void *addr)
> >  {
> > -	unsigned long ret, dummy;
> > +	unsigned long ret;
> > +
> > +	asm("1:\tmov (%0),%0\n"
> > +	    "2:\n"
> > +	    _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_LOAD_UNALIGNED, %0)
> > +	    : "=&r" (ret)
> > +	    : "0" ((unsigned long)addr));
> >  
> > -	asm(
> > -		"1:\tmov %2,%0\n"
> > -		"2:\n"
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
> >  	return ret;
> >  }
> 
> Yeah, it hurts code generation and I guess it's a hot path.
> 
> Maybe put the fixup code in the function.  In case of
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT, it could be at a label at the end of the
> function.  Otherwise it'd have to be inline.

Ooh, yes. If we use ASM_GOTO_OUTPUT then it'll work just right, and the
legacy code will get worse, but I can live with that (everybody is
already building their kernels with gcc-11/clang anyway :-))
