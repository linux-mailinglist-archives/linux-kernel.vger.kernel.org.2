Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B61A3B4DAF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFZIb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 04:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 04:31:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E73C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IjKdaSReCJtlnsj8eiahmXFz7ULzuXL8mj5EZKgUqyI=; b=M4akMry5dcBSIyjxZMVd+T9iVJ
        9LPtvAM2PPwi/3V5koIg/zj1Ak2W+JWFrV2m1Cdt/4eG09BVVymepAVzYpomHpCeTbksajtPevCVk
        U3wUMDL6k8kfG0gWf2CLmSyD6qmG6W2O6ZiO5oeGY5kAuRgmZmBPjIIfon6MnDGiTDyjob1voIirQ
        8km9faznZdzBZlfF4mf8ukJMhYFXJ0kSQWXYYUhx46i3eEp0MMxnSCvb9EEGtBM6ucR33FdVxqo34
        NrA5Lco9Il4R+PoAICQxrW8Z1LYc3vkdpB83tloWTYGtcfhpjvJFeKAWIQ/TQbTWomSFR7sje8bbF
        0kimcHBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lx3fn-000s5r-IA; Sat, 26 Jun 2021 08:28:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89FA6300252;
        Sat, 26 Jun 2021 10:28:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CE822C12CC04; Sat, 26 Jun 2021 10:28:18 +0200 (CEST)
Date:   Sat, 26 Jun 2021 10:28:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <YNblIsUFlsX5WXui@hirez.programming.kicks-ass.net>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
 <20210601065217.23540-2-jiangshanlai@gmail.com>
 <87bl81h3ih.ffs@nanos.tec.linutronix.de>
 <444d7139-e47a-4831-93d0-8eb5b9680fdc@www.fastmail.com>
 <YNWytd64PzMwZKQX@hirez.programming.kicks-ass.net>
 <YNW3O1YxZx9XkZqU@hirez.programming.kicks-ass.net>
 <87a6ndumys.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6ndumys.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 09:03:23AM +0200, Thomas Gleixner wrote:
> On Fri, Jun 25 2021 at 13:00, Peter Zijlstra wrote:
> > On Fri, Jun 25, 2021 at 12:40:53PM +0200, Peter Zijlstra wrote:
> >> On Sat, Jun 19, 2021 at 08:13:15PM -0700, Andy Lutomirski wrote:
> >> > 
> >> > 
> >> > On Sat, Jun 19, 2021, at 3:51 PM, Thomas Gleixner wrote:
> >> > > On Tue, Jun 01 2021 at 14:52, Lai Jiangshan wrote:
> >> > > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >> > > >
> >> > > > Current kernel has no code to enforce data breakpoint not on the thread
> >> > > > stack.  If there is any data breakpoint on the top area of the thread
> >> > > > stack, there might be problem.
> >> > > 
> >> > > And because the kernel does not prevent data breakpoints on the thread
> >> > > stack we need to do more complicated things in the already horrible
> >> > > entry code instead of just doing the obvious and preventing data
> >> > > breakpoints on the thread stack?
> >> > 
> >> > Preventing breakpoints on the thread stack is a bit messy: it’s
> >> > possible for a breakpoint to be set before the address in question is
> >> > allocated for the thread stack.
> >> 
> >> How about we call into C from the entry stack and have the from-user
> >> stack swizzle there. The from-kernel entries land on the ISTs and those
> >> are already excluded.
> >> 
> >> > None of this is NMI-specific. #DB itself has the same problem.  We
> >> > could plausibly solve it differently by disarming breakpoints in the
> >> > entry asm before switching stacks. I’m not sure how much I like that
> >> > approach.
> >> 
> >> I'm not sure I see how, from-user #DB already doesn't clear DR7, and if
> >> we recurse, we'll get a from-kernel trap, which will land on the IST,
> >> whcih is excluded, and then we clear DR7 there.
> >> 
> >> IST and entry stack are excluded, the only problem we have is thread
> >> stack, and that can be solved by calling into C from the entry stack.
> >> 
> >> I should put teaching objtool about .data references from .noinstr.text
> >> and .entry.text higher on the todo list I suppose ...
> >
> > Also, I think we can run the from-user exceptions on the entry stack,
> > without ever switching to the kernel stack, except for #PF, which is
> > magical and schedules.
> 
> No. Pretty much any exception coming from user space can schedule and
> even if it does not voluntary it can be preempted.

Won't most of them have IRQs disabled throughout? In any case, I think
we should only switch to the task stack right around the time we're
ready to enable IRQs just like for syscall/#PF, not earlier.
