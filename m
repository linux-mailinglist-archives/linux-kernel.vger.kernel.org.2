Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3791542A28E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhJLKp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236114AbhJLKpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:45:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D88E60E53;
        Tue, 12 Oct 2021 10:43:22 +0000 (UTC)
Date:   Tue, 12 Oct 2021 12:43:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: Should EXIT_DEAD be visible to userspace ?
Message-ID: <20211012104319.il5g3vkooh5qmsmd@wittgenstein>
References: <20211011194016.GA16788@codemonkey.org.uk>
 <CAHk-=wgx6VQW192hbUiZABmkmZjNDynH75OR=-wvg=un960nRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgx6VQW192hbUiZABmkmZjNDynH75OR=-wvg=un960nRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 01:33:21PM -0700, Linus Torvalds wrote:
> On Mon, Oct 11, 2021 at 12:40 PM Dave Jones <davej@codemonkey.org.uk> wrote:
> >
> > One of our users reported a crash in some userspace tooling this
> > morning, which scrapes /proc/pid to gather stack traces, process states
> > etc of everything running at the time.
> >
> > The crash occurred because it fell over an unexpected task state,
> > which was 'X'.   According to the procps man-pages, this state should
> > never be seen, but here it clearly was.
> 
> Heh.
> 
> > The kernel running at the time was kinda old (5.2) but I don't see much
> > change in the EXIT_DEAD space that would explain something that got
> > fixed subsequently.   It's also probably going to be difficult to
> > reproduce unfortunately.
> >
> > So my question is, is procps wrong and code should expect to see X state
> > processes in proc ?  The code in question is being hardened to handle
> > unexpected inputs, but I'm curious if the kernel is leaking some state
> > that it shouldn't.
> 
> My gut feel is that the man-pages have clearly been wrong - or at
> least misleading - for at least the last couple of years (and possibly
> longer), and this is the first report we've ever had of it actually
> causing problems.
> 
> The docs *do* mention 'X'. Even if they say 'should never be seen',
> it's not like it's not right there.
> 
> So we could either ask to just have the man-pages fixed to be a little
> less strongly worded ("never" -> "seldom" or whatever). And apparently
> procps is already getting fixed.
> 
> Or we could hide the 'X' state in newer kernels, and just call them
> zombies to user space. We could literally just change the string from
> "X (dead)" to "Z (dead)" and the "dead" part would still be there (and
> different from "Z (zombie)").
> 
> And either way, it's likely not going to be something that people will
> notice ever again. You update your system, and you wouldn't see the
> problem, because whether the kernel was changed or not, procps was
> updated.
> 
> And if the argument is that people didn't update procps, but *did*
> update the kernel, then sure, that could avoid somebody hitting this
> again, but that's where the "at least a couple of years and nobody has
> noticed before" comes in.
> 
> So I can certainly take a patch that hides 'X', and we can even mark
> it for stable.
> 
> But it feels like realistically nobody will actually care, and the
> real fix is the one to procps, and that fix will make any kernel
> change irrelevant (and possibly even a slight negative, since now
> procps might report interesting cases?).
> 
> End result: if somebody cares enough and sends me a tested patch, I'll
> apply it. But I personally wouldn't care much, and wouldn't push for
> it unless we get somebody who does.
> 
> And I really think that "should never be seen" in the docs is just wrong.
> 
> Yes, we hold the task lock in task_state() when you look at
> /proc/<pid>/status. So maybe it will never be seen there, because
> maybe (I didn't check) we move from X->Z while holding the lock.
> 
> But other parts of /proc don't actually do that lock_task(), I think.
> IOW, looking at /proc/<pid>/stat (which shows just the first letter of
> the state), doesn't do that, I think. So it's not actually serialized
> with the process going through its dying moments.
> 
> So I _think_ the "never" was always just "almost never".
> 
> In fact, take a look at commit ad86622b478e ("wait: swap EXIT_ZOMBIE
> and EXIT_DEAD to hide EXIT_TRACE from user-space"). That 'X' has been
> seen before. It's not great when it happens, but I think this is an
> example of "the 'never' has never been true, and goes back to at least
> 2014".
> 
> .. and that 2014 was just when we happened on it before. The actual
> issue of 'X' showing up looks like it probably predates it (and likely
> goes back to before git history).
> 
> So I suspect that stray 'X' is not actually a regression. Just rare
> enough to be _almost_ "never".

Imho, let's
1. update the manpage
2. update procps
and call it done.

Christian
