Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B664468B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhKES5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhKES52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:57:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F63C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tkATYriU6dGDKbRSQKMaRGDOW96dOGoD7azQ1oWY4UY=; b=HkHM2E5LXurfsJ9XQL0TA3xCBx
        WSrR1jajSgcLDOsh5I7TSWnZ0jLc/MaqDue7gV8vYdAIyw29R7k1+2Sm4Y8mP8LWF/2TeyO+sSSUl
        AGopMy50jnEUTlc0PPITfmiMIboair/tIvh/ljeLN5Xc1+2M43c/wZJu9mf5zzUJalTp2gP9/QO32
        U95gG5bpYl/r6xVgmK2hayK5CnmQ63TYuFz7ux2qSikGeTAj7cHUNYeK+C0ssTaj/eokbtCnWt6HD
        Q25pn3N3CkAC6WK/K9FmMxD3+QOmuI8seV6zoEFkkfuFJR51GDEg4wjTum00X/8z22qO9AN4z7IRc
        5x8LM/Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj4Kf-006lL0-UE; Fri, 05 Nov 2021 18:53:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A513D9862D2; Fri,  5 Nov 2021 19:52:56 +0100 (CET)
Date:   Fri, 5 Nov 2021 19:52:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
Message-ID: <20211105185256.GO174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.408049586@infradead.org>
 <YYV1UeFeWUtnQ4jV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYV1UeFeWUtnQ4jV@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 06:17:53PM +0000, Sean Christopherson wrote:
> On Thu, Nov 04, 2021, Peter Zijlstra wrote:
> > In the vmread exceptin path, use the, thus far, unused output register
> > to push the @fault argument onto the stack. This, in turn, enables the
> > exception handler to not do pushes and only modify that register when
> > an exception does occur.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kvm/vmx/vmx_ops.h |   14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > --- a/arch/x86/kvm/vmx/vmx_ops.h
> > +++ b/arch/x86/kvm/vmx/vmx_ops.h
> > @@ -80,9 +80,11 @@ static __always_inline unsigned long __v
> >  		      * @field, and bounce through the trampoline to preserve
> >  		      * volatile registers.
> >  		      */
> > -		     "push $0\n\t"
> > +		     "xorl %k1, %k1\n\t"
> > +		     "2:\n\t"
> > +		     "push %1\n\t"
> >  		     "push %2\n\t"
> 
> This trick doesn't work if the compiler selects the same GPR for %1 and %2, as
> the "field" will get lost.
> 
>    0x00000000000005a2 <+66>:	0f 78 c0	vmread %rax,%rax
>    0x00000000000005a5 <+69>:	3e 77 0b	ja,pt  0x5b3 <vmx_read_guest_seg_selector+83>
>    0x00000000000005a8 <+72>:	31 c0	xor    %eax,%eax
>    0x00000000000005aa <+74>:	50	push   %rax
>    0x00000000000005ab <+75>:	50	push   %rax

*argh* I misread that thing, %2 is an input reg :/ Thanks for your
patch.
