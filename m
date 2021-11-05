Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB4C446061
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhKEIDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhKEIDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:03:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A74C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wuiBZuTCfIsczsAnpkrrG1YQpOF4yhcULh1LUTtXpSI=; b=JvOvS9i2q0hrnLY9PQCewxXd/p
        JDM8PyT0Mb8RGLB44CX1GOST/3MxE+9sSG3sVXzyhkUMlzBHvXmKKaZvoGqx9OrXlT7JLEYWkszHm
        sCyc37uh9uLZJRNSCqIwMoB5895wzkhDjMOQw3/6542Cxj9BUwFh2S2kYoWHGy1ovySCt28xdsjNO
        rbtWPiLYhY6cRRoiTtCyrnQvlchJTW2l9r5mS8ld9UwbWJcPbOQ1lQeNmEwzkfvgYe4noXUeJvEv4
        2++dirn+Zj3XgG0i1YTTvtQDjxuG6BFRrVbz2f3w3AYr0flcD1HcbPxEZVP+HxqKgfPAe6mTaCI8+
        m0PkqXKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miu6n-006Psb-8L; Fri, 05 Nov 2021 07:58:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0AC398632E; Fri,  5 Nov 2021 08:57:56 +0100 (CET)
Date:   Fri, 5 Nov 2021 08:57:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 14/22] x86,ftrace: Remove .fixup usage
Message-ID: <20211105075756.GI174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.348183644@infradead.org>
 <20211104223550.aiqewkrwpiastsul@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104223550.aiqewkrwpiastsul@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 03:35:50PM -0700, Josh Poimboeuf wrote:
> On Thu, Nov 04, 2021 at 05:47:43PM +0100, Peter Zijlstra wrote:
> > Create and use EX_TYPE_ONE_REG to load 1 into the %[faulted] register
> > on exception.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/extable_fixup_types.h |    1 +
> >  arch/x86/kernel/ftrace.c                   |    9 ++-------
> >  2 files changed, 3 insertions(+), 7 deletions(-)
> > 
> > --- a/arch/x86/include/asm/extable_fixup_types.h
> > +++ b/arch/x86/include/asm/extable_fixup_types.h
> > @@ -37,5 +37,6 @@
> >  #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(-EFAULT))
> >  #define	EX_TYPE_NEG_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(-1))
> >  #define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(0))
> > +#define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(1))
> >  
> >  #endif
> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -661,13 +661,8 @@ void prepare_ftrace_return(unsigned long
> >  		"   movl $0, %[faulted]\n"
> >  		"3:\n"
> >  
> > -		".section .fixup, \"ax\"\n"
> > -		"4: movl $1, %[faulted]\n"
> > -		"   jmp 3b\n"
> > -		".previous\n"
> > -
> > -		_ASM_EXTABLE(1b, 4b)
> > -		_ASM_EXTABLE(2b, 4b)
> > +		_ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_ONE_REG, %[faulted])
> > +		_ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_ONE_REG, %[faulted])
> >  
> >  		: [old] "=&r" (old), [faulted] "=r" (faulted)
> >  		: [parent] "r" (parent), [return_hooker] "r" (return_hooker)
> 
> This fixup code seems to no longer exist in the latest.

\o/, less patches. That's the risk of doing this stuff during the merge
window I suppose :-)
