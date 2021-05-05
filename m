Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC075373360
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhEEA4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:56:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34341 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229586AbhEEA4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:56:47 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1450tcRo016413
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 May 2021 20:55:38 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3A57A15C3C43; Tue,  4 May 2021 20:55:38 -0400 (EDT)
Date:   Tue, 4 May 2021 20:55:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg Stark <stark@mit.edu>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <YJHtCr9rWC0HqHGk@mit.edu>
References: <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <alpine.DEB.2.21.2105020346520.2587@angie.orcam.me.uk>
 <YJAK1C1uLknYGYrH@mit.edu>
 <CAM-w4HOJqDUyK9HXjtqD3K2ja1Wt=u2s5waQ1wqm7jHy0P5V-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM-w4HOJqDUyK9HXjtqD3K2ja1Wt=u2s5waQ1wqm7jHy0P5V-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 07:04:56PM -0400, Greg Stark wrote:
> On Mon, 3 May 2021 at 10:39, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > That was because memory was *incredibly* restrictive in those days.
> > My first Linux server had one gig of memory, and so shared libraries
> > provided a huge performance boost --- because otherwise systems would
> > be swapping or paging their brains out.
> 
> (I assume you mean 1 megabyte?)
> I have 16G and the way modern programs are written I'm still having
> trouble avoiding swap thrashing...

I corrected myself in a follow-on message; I had 16 megabytes of
memory, which was generous at the time.  But it was still restrictive
enough that it made sense to have shared libraries for C library, X
Windows, etc.

> This is always a foolish argument though. Regardless of the amount of
> resources available we always want to use it as efficiently as
> possible. The question is not whether we have more memory today than
> before, but whether the time and power saved in reducing memory usage
> (and memory bandwidth usage) is more or less than other resource costs
> being traded off and whether that balance has changed.

It's always about engineering tradeoffs.  We're always trading off
available CPU, memory, storage device speeds --- and also programmer
time and complexity.  For example, C++ and stable ABI's really don't
go well together.  So if you are using a large number of C++
libraries, the ability to maintain stable ABI's is ***much*** more
difficult.  This was well understood decades ago --- there was an
Ottawa Linux Symposium presentation that discussed this in the context
of KDE two decades ago.

I'll also note that technology can also play a huge role here.  Debian
for example is now much more capable of rebuilding all packages from
source with autobuilders.  In addition, most desktops have easy access
to high speed network links, and are set up auto-update packages.  In
that case, the argument that distributions have to have shared
libraries because otherwise it's too hard to rebuild all of the
binaries that statically linked against a shared library with a
security fix becomes much less compelling.  It should be pretty simple
to set up a system where after a library gets a security update, the
distribution could automatically figure out which packages needs to be
automatically rebuilt, and rebuild them all.

> > However, these days, many if not most developers aren't capable of the
> > discpline needed to maintained the ABI stability needed for shared
> > libraries to work well.
> 
> I would argue you have cause and effect reversed here. The reason
> developers don't understand ABI (or even API) compatibility is
> *because* they're used to people just static linking (or vendoring).
> If people pushed back the world would be a better place.

I'd argue is just that many upstream developers just don't *care*.
The incentives of an upstream developer and the distribution
maintainers are quite different.  ABI compatibility doesn't bring much
benefits to upstream developers, and when you have a separation of
concerns between package maintenance and upstream development, it's
pretty inevitable.

I wear both hats for e2fsprogs as the upstream maintainer as well as
the Debian maintainer for that package, and I can definitely see the
differences in the points of view of those two roles.

Cheers,

					- Ted
