Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DF3B420A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFYLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFYLC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:02:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FE5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 04:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=d40CktXfb6b6FLiJu8AoDj622C4mMamlEAAYjRrXrX8=; b=iq8X8FX77hsBEEDmpiFPbAt/by
        Gxk2vqz5hQh096LbmuI3yaYSEw8S5WLxTOj+oZc22l1VunwRgl8n/jiTLOmYZcIZlvMChBUjeL/FU
        464EwHnIFAkMHsSrPXHUOWA5fA3+pRFn3V8vThozb2OKnHpaJ0G4vXivGvfTYzTgrrWkpD/6M290B
        o3VdeLE5YrQsiSQaZ+21mZLU0N9EVLbx4teeUVpxoWulzMvqB0K//uFShJJo1GIuqQtpPLeoURDXG
        tgWa1pfNUDCWYOKjXs0L4ixTyjOqFUroOUvhrRTdX4VRCj/Hguy/88wqpNG1JDlkYeluUf8xhidd8
        rH5UhLIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwjZ8-00BXs7-Gj; Fri, 25 Jun 2021 11:00:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E84A2300233;
        Fri, 25 Jun 2021 13:00:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBB9B203C0A78; Fri, 25 Jun 2021 13:00:11 +0200 (CEST)
Date:   Fri, 25 Jun 2021 13:00:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [RFC PATCH 1/4] x86/entry/nmi: Switch to the entry stack before
 switching to the thread stack
Message-ID: <YNW3O1YxZx9XkZqU@hirez.programming.kicks-ass.net>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
 <20210601065217.23540-2-jiangshanlai@gmail.com>
 <87bl81h3ih.ffs@nanos.tec.linutronix.de>
 <444d7139-e47a-4831-93d0-8eb5b9680fdc@www.fastmail.com>
 <YNWytd64PzMwZKQX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNWytd64PzMwZKQX@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:40:53PM +0200, Peter Zijlstra wrote:
> On Sat, Jun 19, 2021 at 08:13:15PM -0700, Andy Lutomirski wrote:
> > 
> > 
> > On Sat, Jun 19, 2021, at 3:51 PM, Thomas Gleixner wrote:
> > > On Tue, Jun 01 2021 at 14:52, Lai Jiangshan wrote:
> > > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > > >
> > > > Current kernel has no code to enforce data breakpoint not on the thread
> > > > stack.  If there is any data breakpoint on the top area of the thread
> > > > stack, there might be problem.
> > > 
> > > And because the kernel does not prevent data breakpoints on the thread
> > > stack we need to do more complicated things in the already horrible
> > > entry code instead of just doing the obvious and preventing data
> > > breakpoints on the thread stack?
> > 
> > Preventing breakpoints on the thread stack is a bit messy: it’s
> > possible for a breakpoint to be set before the address in question is
> > allocated for the thread stack.
> 
> How about we call into C from the entry stack and have the from-user
> stack swizzle there. The from-kernel entries land on the ISTs and those
> are already excluded.
> 
> > None of this is NMI-specific. #DB itself has the same problem.  We
> > could plausibly solve it differently by disarming breakpoints in the
> > entry asm before switching stacks. I’m not sure how much I like that
> > approach.
> 
> I'm not sure I see how, from-user #DB already doesn't clear DR7, and if
> we recurse, we'll get a from-kernel trap, which will land on the IST,
> whcih is excluded, and then we clear DR7 there.
> 
> IST and entry stack are excluded, the only problem we have is thread
> stack, and that can be solved by calling into C from the entry stack.
> 
> I should put teaching objtool about .data references from .noinstr.text
> and .entry.text higher on the todo list I suppose ...

Also, I think we can run the from-user exceptions on the entry stack,
without ever switching to the kernel stack, except for #PF, which is
magical and schedules.

Same for SYSCALL, leave switching to the thread stack until C, somewhere
late, right before we'd enable IRQs or something.
