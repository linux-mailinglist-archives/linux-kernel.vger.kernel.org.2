Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6396744603A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhKEHqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhKEHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:46:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F1C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 00:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2oz1HGEcgbPAMIb6eiG3EfAWOrZGd7ae24NhcQB86Eo=; b=qMhxU7bz4ZYgxOhpZHuHS2V/tA
        a9wyCrtEyKLxRGwXt2O0x06gtdDAm7km9oAE99Hcf4mHdSqFVnhKYJ7rZdQLrWNccA4i3S47ZDZrE
        h1AkNh824swZ7vMHCNjV8EFKOwu11ARxqzvTvxbYMGS/j0so+WfL9J7GgMIjJH4R4vGebxNcQqsM6
        lqf8W56CVPqmNiwEKPfcExGx1MQ406fwxdi8QjMiFcfOy3ffUoI7kzaj8t22Zze8gIhdodcKvdn5L
        BLTK3kHSP530siEHoXmrlD0lcO0MLjpxLGFd6k1CUhm033DGJfrM8M6JFAFluYseQjUs+ttVUEL2i
        xE61VdPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mitsX-00EJ9T-OY; Fri, 05 Nov 2021 07:43:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A06598632E; Fri,  5 Nov 2021 08:43:12 +0100 (CET)
Date:   Fri, 5 Nov 2021 08:43:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 06/22] x86,entry_32: Remove .fixup usage
Message-ID: <20211105074312.GF174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.864310295@infradead.org>
 <20211104203933.jxuilpksf7rtbkve@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104203933.jxuilpksf7rtbkve@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 01:39:33PM -0700, Josh Poimboeuf wrote:
> On Thu, Nov 04, 2021 at 05:47:35PM +0100, Peter Zijlstra wrote:
> > +++ b/arch/x86/include/asm/extable_fixup_types.h
> > @@ -19,4 +19,6 @@
> >  #define	EX_TYPE_DEFAULT_MCE_SAFE	12
> >  #define	EX_TYPE_FAULT_MCE_SAFE		13
> >  
> > +#define EX_TYPE_POP_SEG			14
> > +
> 
> This looks funky in the patch (but not in the editor), those other ones
> have a tab after '#define'.

Argh, I thought I'd fixed all those :/ I'll go make it a tab.

> >  #endif
> > --- a/arch/x86/mm/extable.c
> > +++ b/arch/x86/mm/extable.c
> > @@ -99,6 +99,13 @@ static bool ex_handler_clear_fs(const st
> >  	return ex_handler_default(fixup, regs);
> >  }
> >  
> > +static bool ex_handler_pop_seg(const struct exception_table_entry *fixup,
> > +			       struct pt_regs *regs)
> > +{
> > +	*((unsigned int *)regs->sp) = 0;
> > +	return ex_handler_default(fixup, regs);
> > +}
> 
> Clever.  Should be "unsigned long" in case this ever gets used by
> 64-bit?  Also, I'd suggest a short comment.

I'll do both.
