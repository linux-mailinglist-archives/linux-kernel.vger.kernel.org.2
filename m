Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508BF41A038
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhI0Uh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:37:26 -0400
Received: from elvis.franken.de ([193.175.24.41]:46317 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235925AbhI0UhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:37:25 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mUxLl-0004AL-00; Mon, 27 Sep 2021 22:35:45 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D9E66C1CE8; Mon, 27 Sep 2021 22:09:32 +0200 (CEST)
Date:   Mon, 27 Sep 2021 22:09:32 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc3
Message-ID: <20210927200932.GA8510@alpha.franken.de>
References: <CAHk-=wgoE8XBPVA6Mu4CygxX9TE0FgWaAsVUJOe8KQH-CzEcAA@mail.gmail.com>
 <20210927110548.GA771805@roeck-us.net>
 <CAHk-=wiuGKOBvgje56X-EdOp4mnoz4C2nM1ML6DqRFfsptai3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiuGKOBvgje56X-EdOp4mnoz4C2nM1ML6DqRFfsptai3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:55:52AM -0700, Linus Torvalds wrote:
> On Mon, Sep 27, 2021 at 4:05 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Sun, Sep 26, 2021 at 02:21:52PM -0700, Linus Torvalds wrote:
> > > So after a somewhat rocky merge window and second rc, things are now
> > > actually looking pretty normal for rc3. Knock wood.
> > >
> > > There are fixes all over, and the statistics look fairly regular, with
> > > drivers dominating as they should (since they are most of the tree).
> > > And outside of drivers, we have a fairly usual mix of changes -
> > > architecture fixes, networking, filesystems, and tooling (the latter
> > > being mostly kvm selftests).
> > >
> > > Shortlog appended, it's not too long and easy to scan through to get a
> > > flavor for the details if you happen to care.
> > >
> > > Please do give it a whirl,
> > >
> >
> > Build results:
> >         total: 153 pass: 152 fail: 1
> > Failed builds:
> >         mips:allmodconfig
> 
> Gaah. I assume this is the
> 
>    arch/mips/include/asm/sibyte/bcm1480_scd.h:261: error:
> "M_SPC_CFG_CLEAR" redefined
> 
> thing still.
> 
> It's been pending too long in the mips tree, I'll just take the patch
> directly and finally empty your queue of build failures.

if it was a fix in the mips tree I would have sent it already, but it's
watchdog driver fix, which was meant to be picked up by Wim. Anyway,
thank you for taking it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
