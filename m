Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBBC3BA0C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhGBNAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhGBNAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:00:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B5C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GW7O2b9giTKhc36P5PVe5SwIe/E7zGRfMUdGgkuBFMY=; b=WJOsav2YAO5yyYWf5MznMqYZdP
        Gw9HxQkqAhef9jFMBEACaXuinWd2eSCWKgz+UFAXi4hgLiHI9CVOKOsGvEmLK+NqQHxyczcQevzz4
        rRDem+Xh8p41XL6sWk6WCdqzt0kgFlxl08Wr8OdzY/ZQN1hJDFf6nh3JJvpO0IBFY34OaMLsthLKJ
        1EXiZbiOoQSR4/5ZbbMjo4hW5mzD3Ss3cJxE/Khy70GoXFKpox4H2j+/cZRhKbgHopYgMxyiyazfa
        +EYJg9yTJW0pxsFft0Dx6kseOxldzX9ioS/l2fZkJKnXnPsMuI/TuqiuiI1D3L0+zXmNEFyi9VoPy
        GXULI5gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzIj3-007i7k-5J; Fri, 02 Jul 2021 12:57:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 707673002D3;
        Fri,  2 Jul 2021 14:56:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38C772B981DA0; Fri,  2 Jul 2021 14:56:56 +0200 (CEST)
Date:   Fri, 2 Jul 2021 14:56:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
Message-ID: <YN8NGLPQ4Cqanc48@hirez.programming.kicks-ass.net>
References: <202106281231.E99B92BB13@keescook>
 <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook>
 <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
 <CAGG=3QXrOnN3-3r-VGDpmikKRpaK_p5hM_qHGprDDMuFNKuifA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QXrOnN3-3r-VGDpmikKRpaK_p5hM_qHGprDDMuFNKuifA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 05:46:46AM -0700, Bill Wendling wrote:
> On Tue, Jun 29, 2021 at 2:04 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Jun 29, 2021 at 1:44 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > And it causes the kernel to be bigger and run slower.
> > >
> > > Right -- that's expected. It's not designed to be the final kernel
> > > someone uses. :)
> >
> > Well, from what I've seen, you actually want to run real loads in
> > production environments for PGO to actually be anything but a bogus
> > "performance benchmarks only" kind of thing.
> >
> The reason we use PGO in this way is because we _cannot_ release a
> kernel into production that hasn't had PGO applied to it. The
> performance of a non-PGO'ed kernel is a non-starter for rollout. We
> try our best to replicate this environment for the benchmarks, which
> is the only sane way to do this. I can't imagine that we're the only
> ones who run up against this chicken-and-egg problem.
> 
> For why we don't use sampling, PGO gives a better performance boost
> from an instrumented kernel rather than a sampled profile. I'll work
> on getting statistics to show this.

I've asked this before; *what* is missing from LBR samples that's
reponsible for the performance gap?
