Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9A3CBC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhGPSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhGPSuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:50:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D1CD613FD;
        Fri, 16 Jul 2021 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626461226;
        bh=UEtfPyp/Usfco2Tor+/jAbTAAnZolOhcKHgVFrMM0LQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yfa/lKlemkuNKMvim6cWTVXgNfG7VBUt98eeMBRC1S6JWrjexvTRh18HOBynRFNv+
         gOImaLa4vaNq9mtYvjef5vZXlcZ1rps1SPVAEfn69WL9ysWevX7q+0QeeSo79fLwCd
         DxK8zsfzGTvjZ/G4tjaKg5etR2MGRQQ0FjmUqCx+xSk9Vvyfmf8nq8SpXk+PWjTCA7
         8JBrZ564m7/yjrSOfFQXb+JZwwx4ppGPprk3Yc4b12W31f/BxxMgzSNX2llXpQkQpO
         uVAxvKSLCyLEGqiwClJ9Q2x/gPL2obWx1Wr0wyY1HuJuHjSalmEAbQJVrdlEEsu3Jh
         dVOByFTpZJ2Bw==
Date:   Fri, 16 Jul 2021 11:47:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
Message-ID: <YPHUJsiaOuqzW0Od@archlinux-ax161>
References: <20210714200523.GA10606@embeddedor>
 <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 06:04:15PM -0700, Linus Torvalds wrote:
> On Wed, Jul 14, 2021 at 1:03 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc2
> 
> Grr.
> 
> I merged this, but when I actually tested it on my clang build, it
> turns out that the clang "-Wimplicit-fallthrough" flag is unbelievable
> garbage.
> 
> I get
> 
>    warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
> 
> and the stupid warning doesn't even say WHERE THE PROBLEM HAPPENS.
> 
> No file name, no line numbers. Just this pointless garbage warning.
> 
> Honestly, how does a compiler even do something that broken? Am I
> supposed to use my sixth sense to guide me in finding the warning?
> 
> I like the concept of the fallthrough warning, but it looks like the
> clang implementation of it is so unbelievably broken that it's getting
> disabled again.
> 
> Yeah, I can
> 
>  (a) build the kernel without any parallelism
> 
>  (b) use ">&" to get both output and errors into the same file
> 
>  (c) see that it says
> 
>     CC      kernel/sched/core.o
>   warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>   1 warning generated.
> 
> and now I see at least which _file_ it is that causes that warning.
> 
> I can then use my incredible powers of deduction (it's almost like a
> sixth sense, but helped by the fact that there's only one single
> "fallthrough" statement in that file) to figure out that it's
> triggered by this code:
> 
>                 case cpuset:
>                         if (IS_ENABLED(CONFIG_CPUSETS)) {
>                                 cpuset_cpus_allowed_fallback(p);
>                                 state = possible;
>                                 break;
>                         }
>                         fallthrough;
>                 case possible:
> 
> and it all makes it clear that the clang warning is just incredibly
> broken garbage not only in that lack of filename and line number, but
> just in general.

I commented this on the LLVM bug tracker but I will copy and paste it
here for posterity:

"It is actually the fact that

case 1:
    if (something || !IS_ENABLED(CONFIG_SOMETHING))
        return blah;
    fallthrough;
case 2:

looks like

case 1:
    return blah;
    fallthrough;
case 2:

For example: https://godbolt.org/z/GdPeMbdo8

int foo(int a) {
    switch (a) {
    case 0:
        if (0)
            return 0;
        __attribute__((__fallthrough__)); // no warning
    case 1:
        if (1)
            return 1;
        __attribute__((__fallthrough__)); // warning
    case 2:
        return 3;
    default:
        return 4;
    }
}

I am not really sure how to resolve that within checkFallThroughIntoBlock() or
fillReachableBlocks() but given that this is something specific to the kernel,
we could introduce -Wimplicit-fallthrough-unreachable then disable it within
the kernel.

The file location not showing up was fixed by commit 1b4800c26259
("[clang][parser] Set source ranges for GNU-style attributes"). The
differential revision mentions this issue specifically."

Hopefully that would be an adequate solution, otherwise someone with more clang
internal will have to take a look.

Cheers,
Nathan
