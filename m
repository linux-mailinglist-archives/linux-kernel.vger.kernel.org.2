Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBB7371E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhECRRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhECRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:17:20 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 940DCC06138C
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 10:14:27 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id CFF9792009C; Mon,  3 May 2021 19:14:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C372A92009B;
        Mon,  3 May 2021 19:14:25 +0200 (CEST)
Date:   Mon, 3 May 2021 19:14:25 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
In-Reply-To: <YJAOq9CD72EWaF8P@mit.edu>
Message-ID: <alpine.DEB.2.21.2105031838150.2587@angie.orcam.me.uk>
References: <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com> <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com> <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com> <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com> <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com> <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <alpine.DEB.2.21.2105020346520.2587@angie.orcam.me.uk> <YJAK1C1uLknYGYrH@mit.edu> <YJAOq9CD72EWaF8P@mit.edu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021, Theodore Ts'o wrote:

> On Mon, May 03, 2021 at 10:38:12AM -0400, Theodore Ts'o wrote:
> > On Mon, May 03, 2021 at 03:03:31AM +0200, Maciej W. Rozycki wrote:
> > > 
> > > People went through great efforts to support shared libraries, sacrificed
> > > performance for it even back then when the computing power was much lower
> > > than nowadays.
> > 
> > That was because memory was *incredibly* restrictive in those days.
> > My first Linux server had one gig of memory, and so shared libraries
> > provided a huge performance boost --- because otherwise systems would
> > be swapping or paging their brains out.
> 
> Correction.  My bad, my first Linux machine had 16 megs of memory....

 There was memory and there was storage.  Back in 1990s I maintained Linux 
machines with as little as 4MiB of RAM or 2MiB even with some 80386SX box, 
and as little as 40MB HDD or 64MB SSD (which was pretty damn expensive and 
occupied the whole 3.5" drive space in the PATA form factor).  Yes, 2MiB 
used to be the minimum for x86 around 2.0.x, and you could actually boot a 
system multiuser with as little RAM.  And obviously dynamic executables 
took less storage space than static ones, so if you had more than just a 
couple, the saving balanced the overhead of the shared library files used.

 But I agree this is only relevant nowadays in certain specific use cases 
(which will often anyway choose to run things like BusyBox plus maybe just 
a bunch of tools, and won't see any benefit from memory sharing or storage 
saving).

> > However, these days, many if not most developers aren't capable of the
> > discpline needed to maintained the ABI stability needed for shared
> > libraries to work well.  I can think several packages where if you
> > used shared libraries, the major version number would need to be
> > bumped at every releases, because people don't know how to spell ABI,
> > never mind be able to *preserve* ABI.  Heck, it's the same reason that
> > we don't promise kernel ABI compatibility for kernel modules!
> > 
> > https://www.kernel.org/doc/Documentation/process/stable-api-nonsense.rst
> > 
> > And in the case of Debian, use of shared libraries means that every
> > time you release a new version of, say, f2fs-tools, things can get
> > stalled for months or in one case, over a year, due to the new package
> > review process (a shared library version bump means a new binary
> > package, and that in turn requires a full review of the entire source
> > package for GPL compliance from scratch, and f2fs-tools has bumped
> > their shared library major version *every* *single* *release*) ---
> > during which time, security bug fixes were being held up due to the
> > new package review tarpit.

 Well, SONAME maintenance is indeed a hassle, but to solve this problem 
we've had symbol versioning for decades now, ever since we've switched 
from libc 5 to glibc 2.0.  And glibc hasn't bumped the SONAMEs of the 
individual libraries ever since, while maintaining all the old ABIs (not 
necessarily available to link against) and adding new ones as required.

 So it has been pretty easy to maintain ABI compatibility nowadays without 
the need to carry multiple library versions along, as long as you actually 
care to do so.

> > If people could actually guarantee stable ABI's, then shared libraries
> > might make sense.  E2fsprogs hasn't had a major version bump in shared
> > libraries for over a decade (although some developers whine and
> > complain about how I reject function signature changes in the
> > libext2fs library to provide that ABI stability).  But how many
> > userspace packages can make that claim?

 That's actually the matter of general software quality and the competence 
of software developers.  I have no good answer except for a suggestion to 
see this talk: <https://lca2020.linux.org.au/schedule/presentation/105/>.

  Maciej
