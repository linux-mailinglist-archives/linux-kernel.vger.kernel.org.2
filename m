Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E58368637
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhDVRuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhDVRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:50:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8B9C06174A;
        Thu, 22 Apr 2021 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VX2ymzHZJn7bHNWK7AEKXZ6aYgpG8hPKsZSE2Wshnq8=; b=TkTF0M7b6IBopDmnkDOPRFUTGU
        RSpvBXWtqboHL28R14djPAw9W8I9jLFLQqb3aa21WExZOFo4NPkFY1z7gqqZ4zq3QjQDMGntsny9n
        TS6i0zygGpF3n01bDbIQ0RQt8/75JBCg0/rP4sO51xYfbm15NwwHkTD/2IavQglJOmxTr3BN0cpvc
        amAAqXDeAvMztVKNhokXPo135paJVv4zsLIwURzEG0TSpjm7tIQkmY5AVxQKeICMpo97H8swu0hrZ
        uBXfHbrKHiUoFMug/aT/4WGGhpH1vgbsEPc3jmLIexhgYH+7+Rg52qUzW5vdKvhIYrPgIWeKnIM1j
        q6BLZSvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZdS8-00HCkK-Ny; Thu, 22 Apr 2021 17:49:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 193783001E2;
        Thu, 22 Apr 2021 19:49:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCE432D04872B; Thu, 22 Apr 2021 19:49:23 +0200 (CEST)
Date:   Thu, 22 Apr 2021 19:49:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     David Malcolm <dmalcolm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        yuanzhaoxiong@baidu.com
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YIG3I+ojW+bc+o4l@hirez.programming.kicks-ass.net>
References: <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
 <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
 <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
 <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net>
 <0a9da587b0330bafdf612c3d51285e144b0b9e46.camel@redhat.com>
 <YHC0dgwhYS9hKcRT@hirez.programming.kicks-ass.net>
 <5a07bde1a9fa9a056a19637399b0635252ddb303.camel@redhat.com>
 <20210409213949.GA33256@worktop.programming.kicks-ass.net>
 <YIFilwwzWiSDZU6b@hirez.programming.kicks-ass.net>
 <20210422170820.GB27473@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422170820.GB27473@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 12:08:20PM -0500, Segher Boessenkool wrote:
> On Thu, Apr 22, 2021 at 01:48:39PM +0200, Peter Zijlstra wrote:
> > Can we please have a __pure__ attribute that is prescriptive and not a
> > hint the compiler is free to ignore for $raisins ?
> 
> What does that mean?  What actual semantics do you want it to have?

I want a function marked as pure to be treated as such, unconditionally.

> The "pure" attribute means the compiler can assume this function does
> not have side effects.  But in general (and in practice in many cases)
> there is no way the compiler can actually check that, if that is what
> you were asking for.

Right, so currently the pure attribute gets ignored by the compiler
because of various reasons, one of them being an asm volatile ("") being
present somewhere inside it (AFAIU).

This means the compiler will emit multiple calls to the function, which
casuses loss in optimization possibilities; we've had
branch-eleminiation and hoisting as practical examples now.

That is; AFAICT the compiler sees the pure attribute and decides it was
wrongly applied because it cannot tell what the asm is doing; I want
that reversed such that it will assume the asm abides by the pure.

Does this mean we can have invalid code generation when we faultily
mark things pure? Yes, but then it's our own damn fault for sticking on
pure in the first place.

In short; I want pure (or really_pure if you want a second attribute) to
be a do-what-I-tell-you-already and not a
only-if-you-think-you-can-prove-I-didn't-make-a-mistake kinda knob. A
little bit like inline vs always_inline.

> And any such checking will depend on optimisation level and related
> flags, making that a no-go anyway.

Realistically I'm only bothered about -O2 and up since that's what we
build the kernel with. Obviously one doesn't care about optimizations
being lost when build with -O0.
