Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF61737103B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 03:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhECBE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 21:04:26 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:39794 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhECBEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 21:04:25 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 30AE692009C; Mon,  3 May 2021 03:03:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2A1E992009B;
        Mon,  3 May 2021 03:03:31 +0200 (CEST)
Date:   Mon, 3 May 2021 03:03:31 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
In-Reply-To: <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2105020346520.2587@angie.orcam.me.uk>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com> <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com> <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com> <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com> <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com> <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com> <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2021, Linus Torvalds wrote:

> > Yes, it's intentional.  Dynamic linking libraries from other packages is
> > the Fedora policy[1], and clang and llvm are separate packages (in Fedora).
> 
> Side note: I really wish Fedora stopped doing that.

 I wish they never stop.

> Shared libraries are not a good thing in general. They add a lot of
> overhead in this case, but more importantly they also add lots of
> unnecessary dependencies and complexity, and almost no shared
> libraries are actually version-safe, so it adds absolutely zero
> upside.

 I agree shared libraries are a tough compromise, but there is an 
important upside.  Let me quote myself from a recent discussion 
<https://lore.kernel.org/linux-mips/alpine.DEB.2.21.2103191500040.21463@angie.orcam.me.uk/>:

"Dynamic shared objects (libraries) were invented in early 1990s for two
reasons:

1. To limit the use of virtual memory.  Memory conservation may not be as
   important nowadays in many applications where vast amounts of RAM are
   available, though of course this does not apply everywhere, and still
   it has to be weighed up whether any waste of resources is justified and
   compensated by a gain elsewhere.

2. To make it easy to replace a piece of code shared among many programs,
   so that you don't have to relink them all (or recompile if sources are
   available) when say an issue is found or a feature is added that is
   transparent to applications (for instance a new protocol or a better
   algorithm).  This still stands very much nowadays.

People went through great efforts to support shared libraries, sacrificed
performance for it even back then when the computing power was much lower
than nowadays.  Support was implemented in Linux for the a.out binary
format even, despite the need to go through horrible hoops to get a.out
shared libraries built.  Some COFF environments were adapted for shared
library support too."

 And the context here is a bug in the linker caused all programs built by 
Golang to be broken WRT FPU handling for the 32-bit MIPS configuration, 
due to a bad ABI annotation causing the wrong per-process FPU mode being 
set up at run time (Golang seemed to have got stuck in early 2000s as far 
the MIPS ABI goes and chose to produce what has been considered legacy 
objects for some 10 years now, and nobody noticed in 10 years or so that 
the GNU linker does not handle legacy MIPS objects correctly anymore).  
This could have been fixed easily by rebuilding the Go runtime, but as it 
happens Google chose not to create a shared Go runtime and all programs 
are linked statically except for libc.

 This had led to a desperate attempt to work the issue around crudely in 
the kernel (which cannot be done in a completely foolproof way, because 
there's missing information) so that Debian does not have to rebuild 2000+ 
packages in a stable distribution, which OTOH is a no-no for them.

 Whether distributions package shared libraries in a reasonable manner is 
another matter, and I've lost hope it will ever happen, at least widely 
(there has been an attempt to address that with a distribution called PLD, 
where the policy used to have it that shared libraries coming from a given 
source package need to go into a separate binary package on their own, so 
that several versions of different SONAMEs each of the same shared library 
package can safely coexist in a single system, but I haven't checked it in 
many years whether the policy has been retained, nor actually ever used 
PLD myself).

  Maciej
