Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2944606D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhKEIIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhKEIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:08:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2469C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RH7dLBPz4joxh614S0DzoaKDbWu/FSVKIuqLklVoXDA=; b=Et8zA5FXVX1Itkn6CitkvA/v7j
        sSZrD1YvRioRPyh04ySIJpc2jx9PJM5u+X5CJpKJqshnC54xyFxRPdSdfuapmZsDRRuSao3q0Q7qY
        BwxW1X+2+Be0W4fsYqFd3LrgL5xXPJPL5G/KMFU2VVK7V+btc2XXIC7fkLAlvZJxOFr1HX0tFZO3W
        +QwUG4UVLd2xWacGL7GjNS/qaJAHODpLURaglONDbpwtePlPDAUUrvApkXN3T4wETh4jCiY0pHdE4
        +QqXa91ar57m9kLvusnFgzIKU3rMo4PI3IqtkpGGMYjrWQxsuChjeNVOuPOJdlbzTv71Sz+uZAuKJ
        UUhVf1lQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miuEN-00EJIK-Dc; Fri, 05 Nov 2021 08:05:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D5CF98632E; Fri,  5 Nov 2021 09:05:47 +0100 (CET)
Date:   Fri, 5 Nov 2021 09:05:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 02/22] x86,mmx_32: Remove .fixup usage
Message-ID: <20211105080547.GL174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.625383149@infradead.org>
 <20211104202220.xwm23nbpvwma6wds@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104202220.xwm23nbpvwma6wds@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 01:22:20PM -0700, Josh Poimboeuf wrote:
> On Thu, Nov 04, 2021 at 05:47:31PM +0100, Peter Zijlstra wrote:
> > This code puts an exception table entry on the "PREFIX" instruction to
> > overwrite it with a jmp.d8 when it triggers an exception. Except of
> > course, our code is no longer writable, also SMP.
> > 
> > Replace it with ALTERNATIVE, the novel
> > 
> > XXX: arguably we should just delete this code
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/lib/mmx_32.c |   83 ++++++++++++++++----------------------------------
> >  1 file changed, 27 insertions(+), 56 deletions(-)
> > 
> > --- a/arch/x86/lib/mmx_32.c
> > +++ b/arch/x86/lib/mmx_32.c
> > @@ -50,23 +50,17 @@ void *_mmx_memcpy(void *to, const void *
> >  	kernel_fpu_begin_mask(KFPU_387);
> >  
> >  	__asm__ __volatile__ (
> > -		"1: prefetch (%0)\n"		/* This set is 28 bytes */
> > -		"   prefetch 64(%0)\n"
> > -		"   prefetch 128(%0)\n"
> > -		"   prefetch 192(%0)\n"
> > -		"   prefetch 256(%0)\n"
> > -		"2:  \n"
> > -		".section .fixup, \"ax\"\n"
> > -		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
> > -		"   jmp 2b\n"
> > -		".previous\n"
> > -			_ASM_EXTABLE(1b, 3b)
> > -			: : "r" (from));
> > +		ALTERNATIVE "",
> > +			    "prefetch (%0)\n"
> > +			    "prefetch 64(%0)\n"
> > +			    "prefetch 128(%0)\n"
> > +			    "prefetch 192(%0)\n"
> > +			    "prefetch 256(%0)\n", X86_FEATURE_3DNOW
> 
> I think this should instead be X86_FEATURE_3DNOWPREFETCH (which isn't
> 3DNow-specific and should really just be called X86_FEATURE_PREFETCH
> anyway)

Ack.

> > +		: : "r" (from));
> >  
> >  	for ( ; i > 5; i--) {
> >  		__asm__ __volatile__ (
> > -		"1:  prefetch 320(%0)\n"
> > -		"2:  movq (%0), %%mm0\n"
> > +		"  movq (%0), %%mm0\n"
> 
> Not sure why this prefetch was removed?  It can also be behind an
> alternative just like the first one.

Urgh, that was me just plain killing all the prefetch in there and
forgetting to put it back :/ Will fix.
