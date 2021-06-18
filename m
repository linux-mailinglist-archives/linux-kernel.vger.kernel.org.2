Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7379E3AC98F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhFRLQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhFRLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:16:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E32C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NtnkkZAxLcmtEtJFUUC2UEk+EPbb/bjXyYawsWwe/H8=; b=LS1z0I161EdLVAgh9E3dus3CHr
        Newy/BQVE27ZrkcITTK4TP4Wy+pS2KxRF9j1EtJQW8qRp0G8JDJ2j1GAZDf3LuvY5f9aoIvR2eddu
        nSj0jESL37oG2IjkMIFTTyk9QFriiicmu+V8exScOdv9dYzMUxJVCqT0n575I1PHjuzOUythRXIkR
        m0H1Oqg1jBgEGzPhAJO/0VpvbEmYNBgzKleHOvyjbxkF+eHGFAtGZ1outSgUt2sfqF+S05+uCzES6
        jtVMUS3zijRtZqPw/+QGxRcbp5h0xJeLrHoH68vKHAIvmLV4jpqROGCvi7ZXtspJxIze5653zLFGA
        8DwJzA2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luCRi-00ABwb-9u; Fri, 18 Jun 2021 11:14:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D020E300204;
        Fri, 18 Jun 2021 13:13:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABFDA21BD53A7; Fri, 18 Jun 2021 13:13:57 +0200 (CEST)
Date:   Fri, 18 Jun 2021 13:13:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        johannes.berg@intel.com, ndesaulniers@google.com,
        nathan@kernel.org, keescook@chromium.org, elver@google.com,
        mark.rutland@arm.com
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
Message-ID: <YMx/9Xv8BF7ghAO6@hirez.programming.kicks-ass.net>
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
 <2f8a4e21-a09b-8c8d-54ce-45cf2f0e83ff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8a4e21-a09b-8c8d-54ce-45cf2f0e83ff@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 04:43:27PM +0200, Peter Oberparleiter wrote:
> On 14.06.2021 12:17, Peter Zijlstra wrote:
> > As recently discovered, there is no function attribute to disable the
> > -fprofile-generate instrumentation. As such, GCOV is fundamentally
> > incompatible with architectures that rely on 'noinstr' for correctness.
> 
> Does this problem affect all code or just those pieces that use
> 'noinstr'? Doing a quick grep over kernel source shows me ~40 source
> files containing 'noinstr' vs. ~30000 that don't.

I count 82, but yeah.

> It seems to me like an extreme measure to disable gcov-based profiling
> for all files on an architecture when only a small fraction of code
> would actually be affected.
> 
> I'll gladly admit that I haven't followed the full discussion that lead
> to your patch, so maybe some of the following suggestions may already
> have been proposed.
> 
> What about marking source files that contain 'noinstr' using the
> 
>   GCOV_PROFILE_<filename.o> := n
> 
> directive that gcov-kernel profiling provides to exclude those files
> from being compiled with the corresponding profiling flags? If that's
> too much effort there's also a directive for excluding all files in a
> directory.

It's just not scalable and super fragile. Forget one and you have a
potentially dead kernel. At the same time, we'll end up excluding
significant chunks of the core kernel that way, also limit the use of
GCOV.

> If there was a way to automatically identify 'noinstr'-afflicted source
> files (e.g. by grepping the pre-processed source files), one could also
> automate this process by adjusting the kbuild-code that adds profiling
> flags to automatically exclude such files.

Or we just wait for the compilers to implement the required function
attribute and then make the whole thing depend on having a recent enough
compiler, which is what I'm hoping for.

Developers should use recent compilers anyway...

> > Until such time as that compilers have added a function attribute to
> > disable this instrumentation, mark GCOV as broken.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/Kconfig    | 2 +-
> >  kernel/gcov/Kconfig | 4 ++++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 86dae426798b..c0f8c9d4c31a 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -75,7 +75,7 @@ config X86
> >  	select ARCH_HAS_FAST_MULTIPLIER
> >  	select ARCH_HAS_FILTER_PGPROT
> >  	select ARCH_HAS_FORTIFY_SOURCE
> > -	select ARCH_HAS_GCOV_PROFILE_ALL
> > +	select ARCH_HAS_GCOV_BROKEN
> 
> Assuming none of the above mentioned alternatives are viable, removing
> ARCH_HAS_GCOV_PROFILE_ALL should be enough for your purpose. This way
> you are already excluding all source files from automatic profiling on x86.

But you can still select one manually, which is not safe.

> Users that are absolutely sure that their code can work with
> gcov-profiling can manually edit their sub-Makefiles to list those files
> that should be instrumented. In my opinion your introduction of
> ARCH_HAS_GCOV_BROKEN unnecessarily takes away this capability.

Are there any users? Who uses this GCOV stuff, and should we migrate
them to KCOV?

The thing is, I got dead kernel reports from KCOV users really quickly
after all this landed, I've never even heard of a GCOV user, let alone
had a problem report from one.

Given all this seems mostly unused, I suppose we can wait for the
compilers to implement the attribute and simply ignore any and all
problems stemming from the use of GCOV -- telling them to go use KCOV
instead.

At the same time; since there are no users (that I know of), I don't see
the problem with killing the entire thing for x86 either.
