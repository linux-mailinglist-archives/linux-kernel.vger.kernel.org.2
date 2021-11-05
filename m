Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5386544605E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhKEH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhKEH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:59:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65EAC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hSnLUwPXYiP1AH1lwRlHMtAIDgxitmFXLi6t4YVopUU=; b=PaUGDuIErWmkAwbreirhf6dQ/I
        TGh0DmXBQ3DPNFL4OkGEXGpwETcyVQTH/kDO7p4YAVX9R3C2dsjSflHnuyYVf4CgrG2Chs+EtfmIJ
        SG8PsKGj6sXNASoG3fk0QYLp+O7X1QkVM0Y3qO7+UV05KdKKKqfJ9tqDAVWu7XK4/QNWwUgemmZoj
        +yxbIzMga0E6Hs4IUfyIWkERfpjLfZyYWth+9THIg3jORfRi1v5tYnyvsByzLRQbEAQsYsdGK+MRh
        P30tmbDqGayfZUMbOHIE3s3SE8La8c9v8UdmOS1WYS2smTU3VyKNMOKrb1v2x/Ch5KluAOpgLqV9p
        Jzycd+kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miu5f-00EJEk-2S; Fri, 05 Nov 2021 07:56:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B936B98632E; Fri,  5 Nov 2021 08:56:46 +0100 (CET)
Date:   Fri, 5 Nov 2021 08:56:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 11/22] x86,xen: Remove .fixup usage
Message-ID: <20211105075646.GH174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.168368031@infradead.org>
 <20211104223151.k553ng4cx6nbke4z@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104223151.k553ng4cx6nbke4z@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 03:31:51PM -0700, Josh Poimboeuf wrote:
> On Thu, Nov 04, 2021 at 05:47:40PM +0100, Peter Zijlstra wrote:
> > Employ the fancy new EX_TYPE_IMM_REG to create EX_TYPE_NEG_REG to
> > store '-1' into the designated register and use this to remove some
> > Xen .fixup usage.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/extable_fixup_types.h |    1 +
> >  arch/x86/include/asm/xen/page.h            |   12 ++----------
> >  2 files changed, 3 insertions(+), 10 deletions(-)
> > 
> > --- a/arch/x86/include/asm/extable_fixup_types.h
> > +++ b/arch/x86/include/asm/extable_fixup_types.h
> > @@ -35,5 +35,6 @@
> >  
> >  #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
> >  #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(-EFAULT))
> > +#define	EX_TYPE_NEG_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(-1))
> >  
> >  #endif
> > --- a/arch/x86/include/asm/xen/page.h
> > +++ b/arch/x86/include/asm/xen/page.h
> > @@ -96,11 +96,7 @@ static inline int xen_safe_write_ulong(u
> >  
> >  	asm volatile("1: mov %[val], %[ptr]\n"
> >  		     "2:\n"
> > -		     ".section .fixup, \"ax\"\n"
> > -		     "3: sub $1, %[ret]\n"
> > -		     "   jmp 2b\n"
> > -		     ".previous\n"
> > -		     _ASM_EXTABLE(1b, 3b)
> > +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_NEG_REG, %[ret])
> >  		     : [ret] "+r" (ret), [ptr] "=m" (*addr)
> >  		     : [val] "r" (val));
> >  
> > @@ -115,11 +111,7 @@ static inline int xen_safe_read_ulong(co
> >  
> >  	asm volatile("1: mov %[ptr], %[rval]\n"
> >  		     "2:\n"
> > -		     ".section .fixup, \"ax\"\n"
> > -		     "3: sub $1, %[ret]\n"
> > -		     "   jmp 2b\n"
> > -		     ".previous\n"
> > -		     _ASM_EXTABLE(1b, 3b)
> > +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_NEG_REG, %[ret])
> >  		     : [ret] "+r" (ret), [rval] "+r" (rval)
> >  		     : [ptr] "m" (*addr));
> >  	*val = rval;
> 
> -EFAULT is also negative, and presumably more appropriate than -1.

Possibly, means I'll have to go audit all it's users. I'll put it on the
todo list.
