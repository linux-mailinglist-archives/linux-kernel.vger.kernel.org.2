Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFA0370F66
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 23:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhEBVtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 17:49:02 -0400
Received: from mail.stusta.mhn.de ([141.84.69.5]:55764 "EHLO
        mail.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhEBVtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 17:49:01 -0400
X-Greylist: delayed 44201 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 May 2021 17:49:00 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.stusta.mhn.de (Postfix) with ESMTPSA id 4FYKTy0CH6z1n;
        Sun,  2 May 2021 23:48:05 +0200 (CEST)
Date:   Mon, 3 May 2021 00:48:04 +0300
From:   Adrian Bunk <bunk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
Message-ID: <20210502214803.GA7951@localhost>
References: <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost>
 <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
 <20210502164542.GA4522@localhost>
 <CAHk-=winSraiwc4gC5WFWSehFq+s7AqCJZoMqUuHLX0nYVG0nQ@mail.gmail.com>
 <20210502175510.GB4522@localhost>
 <CAHk-=whTjJwCt2E0_JM2dDq=+UybvJN7QK+6K6e80A9Zd8duYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whTjJwCt2E0_JM2dDq=+UybvJN7QK+6K6e80A9Zd8duYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2021 at 10:59:10AM -0700, Linus Torvalds wrote:
> On Sun, May 2, 2021 at 10:55 AM Adrian Bunk <bunk@kernel.org> wrote:
> >
> > Are you happy about libclang.so being a shared library?
> 
> Honestly, considering how I don't have any other package that I care
> about than clang itself, and how this seems to be a *huge* performance
> problem, then no.
> 
> But you are still entirely avoiding the real issue: the Fedora rule
> that everything should be a shared library is simply bogus.

It is not a Fedora-specific rule, we have something similar in Debian.

And in general, static libraries in the C/C++ ecosystem often feel like 
a rarely used remnant from the last millenium (except for convenience
libraries during the build).

> Even if the llvm/clang maintainers decide that that is what they want,
> I know for a fact that that rule is completely the wrong thing in
> other situations where people did *not* want that.

libdivecomputer is now a submodule of subsurface.

If this is the only copy of libdivecomputer in a distribution,
then linking subsurface statically with it and not shipping it
as a separate library at all is fine for distributions.

The Fedora policy that was linked to also states that this is OK.

The important part for a distribution is to ship only one copy of the 
code and having to rebuild only the one package containing it when 
fixing a bug.

> Can you please stop dancing around that issue, and just admit that the
> whole "you should always use shared libraries" is simply WRONG.
> 
> Shared libraries really can have huge downsides, and the blind "shared
> libraries are good" standpoint is just wrong.

Good for distributions or good for performance?

These two are quite distinct here, and distribution rules care about 
what is good for distributions.

Library packages in ecosystems like Go or Rust are copies of the source 
code, and when an application package is built with these "libraries" 
(might even be using LTO) this is expected to be faster than using 
shared libraries.

But for distributions not using shared libraries can be a huge pain.

Compared to LTO compilation of all code used in an application, static 
linking gives the same pain to distributions with smaller benefits.

I agree that on the performance side you have a valid point regarding 
the disadvantages of shared libraries, but not using them is bad for 
distributions since it makes maintaining and supporting the software 
much harder and security support often impossible.

>           Linus

cu
Adrian
