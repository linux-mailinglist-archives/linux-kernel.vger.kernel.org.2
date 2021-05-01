Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240F63708DC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 21:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhEAT7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 15:59:30 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:41502 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhEAT7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 15:59:30 -0400
Received: from localhost (unknown [88.164.140.197])
        (Authenticated sender: sergesanspaille@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id F011CB0052C;
        Sat,  1 May 2021 21:57:50 +0200 (CEST)
Date:   Sat, 1 May 2021 21:57:50 +0200
From:   Serge Guelton <sguelton@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
Message-ID: <20210501195750.GA1480516@sguelton.remote.csb>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 09:32:25AM -0700, Linus Torvalds wrote:
> On Fri, Apr 30, 2021 at 8:33 PM Tom Stellard <tstellar@redhat.com> wrote:
> >
> > Yes, it's intentional.  Dynamic linking libraries from other packages is
> > the Fedora policy[1], and clang and llvm are separate packages (in Fedora).
> 
> Side note: I really wish Fedora stopped doing that.
> 
> Shared libraries are not a good thing in general. They add a lot of
> overhead in this case, but more importantly they also add lots of
> unnecessary dependencies and complexity, and almost no shared
> libraries are actually version-safe, so it adds absolutely zero
> upside.
> 
> Yes, it can save on disk use, but unless it's some very core library
> used by a lot of things (ie particularly things like GUI libraries
> like gnome or Qt or similar), the disk savings are often not all that
> big - and disk is cheap. And the memory savings are often actually
> negative (again, unless it's some big library that is typically used
> by lots of different programs at the same time).
> 
> In this case, for example, it's true that a parallel build will be
> running possibly hundreds of copies of clang at the same time - and
> they'll all share the shared llvm library. But they'd share those same
> pages even if it wasn't a shared library, because it's the same
> executable! And the dynamic linking will actually cause a lot _less_
> sharing because of all the fixups.
> 
> We hit this in the subsurface project too. We had a couple of
> libraries that *nobody* else used. Literally *nobody*. But the Fedora
> policy meant that a Fedora package had to go the extra mile to make
> those other libraries be shared libraries, for actual negative gain,
> and a much more fragile end result (since those libraries were in no
> way compatible across different versions - so it all had to be updated
> in lock-step).
> 
> I think people have this incorrect picture that "shared libraries are
> inherently good". They really really aren't. They cause a lot of
> problems, and the advantage really should always be weighed against
> those (big) disadvantages.
> 
> Pretty much the only case shared libraries really make sense is for
> truly standardized system libraries that are everywhere, and are part
> of the base distro.
> 
> [ Or, for those very rare programs that end up dynamically loading
> rare modules at run-time - not at startup - because that's their
> extension model. But that's a different kind of "shared library"
> entirely, even if ELF makes the technical distinction between
> "loadable module" and "shared library" be a somewhat moot point ]

I tend to agree with most of these arguments, but let me offer another
perspective:

# from an llvm-repo, configured to use libLLVM.so
> du -s bin
9152344 bin

# from the same repo, configured to use static libraries
> du -s bin
43777528

As a packager, I roughly need to put all these bits in packages, across
base, development and debug package. As a user, I may need to download them.
disk space is ok, but network bandwidth is not as cheap for everyone.

Different metrics lead to different choice, then comes the great pleasure of
making compromises :-)
not
