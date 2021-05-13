Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9037FCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhEMRvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231351AbhEMRvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FE1E613CB;
        Thu, 13 May 2021 17:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620928223;
        bh=3PVEo3OV+xFT1p8Y9C/KZVbC3Uw7dg+uLbcU4y6Hfc4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P4cjcE91z02F08n5/lneabewj3RA1KYztzMrfMYe62oM0Ba0MSV+45mWCkkphjWlV
         pnq+3ArMsq9cdhfUwJR8eKLQK3lS2Vi84eo7vbkz5dO0j82ShGU1nx62MUr9KxQl6y
         HrsNr0c+E5zHOIw5Qm1s7e6QrM8eBjHlYXfFpoJMqwo0UI0fdum6wPYZyu1ieBgpWi
         Xg39rNj7oY3dCQ7nb8NtCdqoXOIj2G4p6VGEnIBuduTz18Lv2dvYDFrQOc1ZIXrw0e
         Aub0vu+byrqPGW6tVdPstZAkspxW1LfIzarpjbvP+lbt7wvNGGPj5A9bL4pwzmQ/gf
         hz6sf0H5avVcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 22B995C014E; Thu, 13 May 2021 10:50:23 -0700 (PDT)
Date:   Thu, 13 May 2021 10:50:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH tip/core/rcu 01/10] kcsan: Add pointer to
 access-marking.txt to data_race() bullet
Message-ID: <20210513175023.GD975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
 <20210511232401.2896217-1-paulmck@kernel.org>
 <a1675b9f-5727-e767-f835-6ab9ff711ef3@gmail.com>
 <CANpmjNM48id0b+H=PqFkCBDSyK76RFTB3Uk0mNeE2htu3v8qfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM48id0b+H=PqFkCBDSyK76RFTB3Uk0mNeE2htu3v8qfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:53:44PM +0200, Marco Elver wrote:
> On Thu, 13 May 2021 at 12:47, Akira Yokosawa <akiyks@gmail.com> wrote:
> >
> > Hi Paul,
> >
> > On Tue, 11 May 2021 16:23:52 -0700, Paul E. McKenney wrote:
> > > This commit references tools/memory-model/Documentation/access-marking.txt
> > > in the bullet introducing data_race().  The access-marking.txt file
> > > gives advice on when data_race() should and should not be used.
> > >
> > > Suggested-by: Akira Yokosawa <akiyks@gmail.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  Documentation/dev-tools/kcsan.rst | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> > > index d85ce238ace7..80894664a44c 100644
> > > --- a/Documentation/dev-tools/kcsan.rst
> > > +++ b/Documentation/dev-tools/kcsan.rst
> > > @@ -106,7 +106,9 @@ the below options are available:
> > >
> > >  * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
> > >    any data races due to accesses in ``expr`` should be ignored and resulting
> > > -  behaviour when encountering a data race is deemed safe.
> > > +  behaviour when encountering a data race is deemed safe.  Please see
> > > +  ``tools/memory-model/Documentation/access-marking.txt`` in the kernel source
> > > +  tree for more information.
> > >
> > >  * Disabling data race detection for entire functions can be accomplished by
> > >    using the function attribute ``__no_kcsan``::
> > >
> >
> > I think this needs some adjustment for overall consistency.
> > A possible follow-up patch (relative to the change above) would look
> > like the following.
> >
> > Thoughts?
> >
> >         Thanks, Akira
> >
> > -------8<--------
> > From: Akira Yokosawa <akiyks@gmail.com>
> > Subject: [PATCH] kcsan: Use URL link for pointing access-marking.txt
> >
> > For consistency within kcsan.rst, use a URL link as the same as in
> > section "Data Races".
> >
> > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> 
> Good catch. I'd be in favour of this change, as it makes it simpler to
> just follow the link. Because in most cases I usually just point folks
> at the rendered version of this:
> https://www.kernel.org/doc/html/latest/dev-tools/kcsan.html
> 
> Acked-by: Marco Elver <elver@google.com>

Queued with Marco's ack, thank you both!

							Thanx, Paul

> > ---
> >  Documentation/dev-tools/kcsan.rst | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> > index 80894664a44c..151f96b7fef0 100644
> > --- a/Documentation/dev-tools/kcsan.rst
> > +++ b/Documentation/dev-tools/kcsan.rst
> > @@ -107,8 +107,7 @@ the below options are available:
> >  * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
> >    any data races due to accesses in ``expr`` should be ignored and resulting
> >    behaviour when encountering a data race is deemed safe.  Please see
> > -  ``tools/memory-model/Documentation/access-marking.txt`` in the kernel source
> > -  tree for more information.
> > +  `"Marking Shared-Memory Accesses" in the LKMM`_ for more information.
> >
> >  * Disabling data race detection for entire functions can be accomplished by
> >    using the function attribute ``__no_kcsan``::
> > @@ -130,6 +129,8 @@ the below options are available:
> >
> >      KCSAN_SANITIZE := n
> >
> > +.. _"Marking Shared-Memory Accesses" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> > +
> >  Furthermore, it is possible to tell KCSAN to show or hide entire classes of
> >  data races, depending on preferences. These can be changed via the following
> >  Kconfig options:
> > --
> > 2.17.1
