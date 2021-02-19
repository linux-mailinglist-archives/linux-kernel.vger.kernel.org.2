Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5509231F5BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBSIQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSIQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:16:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EC6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 00:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iKkX0WJXYByG8vi3X4oORfaFYIkpvbsgkXGHehFlrZc=; b=Hh1E7kOp5VqB5OAMemDHzN96/O
        nXdNszBn0WoTQmZdnd5o0ZA+iKfQw8+yEGQNtGLiY10s19d3zAyxs+H5zNtaL61SjkMufhuPRbqC9
        VBouh9kfPjUq641fUax9tYxoWBnn7GkS8KRlqzqC13vX9cCg0ZHMAOSAHzh2ioSTop+8e+RG6lNdb
        cmMQoQDEe49HjKafMnZtlmbtd9IlbO36Z/yi3pG/mHR0b94imzIbrZRTkg+F2lQjss7M4vGouNbaM
        /+Zod/jHU3IFx94ZOhMsoxEfWflcsN2i8s9Taw9xBPwcdbwf7QOCc7cmgEq5onMHyq57wRtiGhFTU
        a8NZ8+mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lD0wQ-0006IM-2W; Fri, 19 Feb 2021 08:15:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55CDE9864D5; Fri, 19 Feb 2021 09:15:07 +0100 (CET)
Date:   Fri, 19 Feb 2021 09:15:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, tony.luck@intel.com, pjt@google.com,
        linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        jpoimboe@redhat.com, jikos@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [RFC PATCH] x86/retpolines: Prevent speculation after RET
Message-ID: <20210219081507.GC59023@worktop.programming.kicks-ass.net>
References: <20210218165938.213678824@infradead.org>
 <20210218184639.GF4214@zn.tnic>
 <20210218190231.GA59023@worktop.programming.kicks-ass.net>
 <20210218191138.GH4214@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218191138.GH4214@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:11:38PM +0100, Borislav Petkov wrote:
> On Thu, Feb 18, 2021 at 08:02:31PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 18, 2021 at 07:46:39PM +0100, Borislav Petkov wrote:
> > > Both vendors speculate after a near RET in some way:
> > > 
> > > Intel:
> > > 
> > > "Unlike near indirect CALL and near indirect JMP, the processor will not
> > > speculatively execute the next sequential instruction after a near RET
> > > unless that instruction is also the target of a jump or is a target in a
> > > branch predictor."
> > 
> > Right, the way I read that means it's not a problem for us here.
> 
> Look at that other thread: the instruction *after* the RET can be
> speculatively executed if that instruction is the target of a jump or it
> is in a branch predictor.

Right, but that has nothing to do with the RET instruction itself. You
can speculatively execute any random instruction by training the BTB,
which is I suppose the entire point of things :-)

So the way I read it is that: RET does not 'leak' speculation, but if
you target the instruction after RET with any other speculation crud,
ofcourse you can get it to 'run'.

And until further clarified, I'll stick with that :-)
