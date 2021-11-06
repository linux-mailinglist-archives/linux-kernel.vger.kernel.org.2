Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF60C446D03
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 09:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhKFIjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 04:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhKFIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 04:39:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8642FC061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 01:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zfMgVzAnsO2wWuNz4TdEj/LqiS7+DTBkRiG3slg/FNg=; b=rKsfwwz8aIOXu8nqqE8XnzEWMS
        vGClrvoYnYvcIy5jHZFlV9aaKKMRIJDXtORJPr4D4zRy8xw/ohaUJlgfEqb2WwEf8Q7o7lBy6ijhU
        JilBtvXHJLtocCDwLNQu6pGKNEFfHUmX/rvpTK4eW0GQxmpMu7L2tjQPDq4Ofpk6sY/dcrHALr9k4
        a7uFDDefqxhaN/WDL1lXSU/7lc7Y9Q/ntnmLwmEuj6ObikaFG5GgXRjcseLYGzkDpeBFhfYASvs61
        lEUFmyGdAKIiqJUY1H/TofGWFWK35SnIAF39ZRXHUfZckHQBBKQ4eQ2Jd144PW0AoOekhFuhU6xnj
        flEUAIDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjHBv-00EUCY-JA; Sat, 06 Nov 2021 08:36:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D4739862D2; Sat,  6 Nov 2021 09:36:46 +0100 (CET)
Date:   Sat, 6 Nov 2021 09:36:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, mbenes@suse.cz
Subject: Re: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
Message-ID: <20211106083646.GT174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.408049586@infradead.org>
 <YYV1UeFeWUtnQ4jV@google.com>
 <18358428-e0cd-d329-7558-6eb548b3fc53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18358428-e0cd-d329-7558-6eb548b3fc53@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2021 at 08:05:51AM +0100, Paolo Bonzini wrote:
> On 11/5/21 19:17, Sean Christopherson wrote:
> > On Thu, Nov 04, 2021, Peter Zijlstra wrote:
> > > In the vmread exceptin path, use the, thus far, unused output register
> > > to push the @fault argument onto the stack. This, in turn, enables the
> > > exception handler to not do pushes and only modify that register when
> > > an exception does occur.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >   arch/x86/kvm/vmx/vmx_ops.h |   14 ++++++--------
> > >   1 file changed, 6 insertions(+), 8 deletions(-)
> > > 
> > > --- a/arch/x86/kvm/vmx/vmx_ops.h
> > > +++ b/arch/x86/kvm/vmx/vmx_ops.h
> > > @@ -80,9 +80,11 @@ static __always_inline unsigned long __v
> > >   		      * @field, and bounce through the trampoline to preserve
> > >   		      * volatile registers.
> > >   		      */
> > > -		     "push $0\n\t"
> > > +		     "xorl %k1, %k1\n\t"
> > > +		     "2:\n\t"
> > > +		     "push %1\n\t"
> > >   		     "push %2\n\t"
> > 
> > This trick doesn't work if the compiler selects the same GPR for %1 and %2, as
> > the "field" will get lost.
> 
> Ouch, good catch.  It should be actually very simple to fix it, just mark
> "value" as an "early clobber" output:
> 
>       : ASM_CALL_CONSTRAINT, "=&r"(value) : "r"(field) : "cc");
> 
> That's an output which is written before the instruction is finished using
> the input operands.  The manual even says "this operand may not lie in a
> register that is read by the instruction or as part of any memory address",
> which is exactly what you caught with %1 and %2 both being the same GPR.

Yes, but as Sean points out, that will negatively affect code-gen on the
happy path. But perhaps that's acceptable if we add the asm-goto-output
variant?
