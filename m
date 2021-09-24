Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE66416B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 07:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbhIXFsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 01:48:22 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:39224 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhIXFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 01:48:21 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 081B11A56019; Thu, 23 Sep 2021 22:46:47 -0700 (PDT)
Date:   Thu, 23 Sep 2021 22:46:47 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
        luto@kernel.org, jannh@google.com,
        Kees Cook <keescook@chromium.org>
Subject: Re: CONFIG_ORC_UNWINDER=y breaks get_wchan()?
Message-ID: <20210924054647.v6x6risoa4jhuu6s@shells.gnugeneration.com>
References: <20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com>
 <20210922001537.4ktg3r2ky3b3r6yp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922001537.4ktg3r2ky3b3r6yp@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:15:37PM -0700, Josh Poimboeuf wrote:
> On Tue, Sep 21, 2021 at 12:32:49PM -0700, Vito Caputo wrote:
> > Is this an oversight of the ORC_UNWINDER implementation?  It's
> > arguably a regression to completely break wchans for tools like `ps -o
> > wchan` and `top`, or my window manager and its separate monitoring
> > utility.  Presumably there are other tools out there sampling wchans
> > for monitoring as well, there's also an internal use of get_chan() in
> > kernel/sched/fair.c for sleep profiling.
> > 
> > I've occasionally seen when monitoring at a high sample rate (60hz) on
> > something churny like a parallel kernel or systemd build, there's a
> > spurious non-zero sample coming out of /proc/[pid]/wchan containing a
> > hexadecimal address like 0xffffa9ebc181bcf8.  This all smells broken,
> > is get_wchan() occasionally spitting out random junk here kallsyms
> > can't resolve, because get_chan() is completely ignorant of
> > ORC_UNWINDER's effects?
> 
> Hi Vito,
> 
> Thanks for reporting this.  Does this patch fix your issue?
> 
>   https://lkml.kernel.org/r/20210831083625.59554-1-zhengqi.arch@bytedance.com

Yes, it fixes things for me, thanks for the quick reply and fix!

> 
> Though, considering wchan has been silently broken for four years, I do
> wonder what the impact would be if we were to just continue to show "0"
> (and change frame pointers to do the same).
> 
> The kernel is much more cautious than it used to be about exposing this
> type of thing.  Can you elaborate on your use case?
> 

My personal use case is my window manager continuously monitors all
processes associated with a given window, maintaining CPU utilization
graph overlays at all times, which may be toggled visible at a
keypress.

One of the columns in these overlays is the WCHAN, which helps
understand where processes are blocking and generally how programs are
written/architected.  When I switched to using Arch with the included
kernel having ORC_UNWDINER=y, this broke.  I had previously been using
Debian for decades, but at some point switched to building my own
kernel with my own .config and never switched to using ORC_UNWINDER.
So despite ORC_UNWINDER being the defconfig for years, I never used it
until recently on the Arch machine.

It's unclear to me how much can be inferred from ORC_UNWINDER breaking
this since 2017, since CONFIG_FRAME_POINTER has preserved the
functionality this whole time and I don't know what
users/distros/cloud providers have continued using that setting,
ignoring ORC_UNWDINER altogether.

Isn't it entirely plausible that others have been doing the same thing
I've been doing with my .config and haven't yet got on the
ORC_UNWINDER train?  It's kind of YOLO to just ship the defconfig when
you've got a stable configuration your end-users are relying upon.


> If we do keep it, we might want to require CAP_SYS_ADMIN anyway, for
> similar reasons as 
> 
>   f8a00cef1720 ("proc: restrict kernel stack dumps to root")
> 
> ... since presumably proc_pid_wchan()'s use of '%ps' can result in an
> actual address getting printed if the unwind gets confused, thanks to
> __sprint_symbol()'s backup option if kallsyms_lookup_buildid() doesn't
> find a name.
> 
> Though, instead of requiring CAP_SYS_ADMIN, maybe we can just fix
> __sprint_symbol() to not expose addresses?
> 
> Or is there some other reason for needing CAP_SYS_ADMIN?  Jann?
> 

I'd really appreciate it if my regular user could continue accessing
the wchan at least for my own processes.  My monitoring tooling which
I've invested significant time in are an integral part of my
development workflow.  I regularly flip on the overlays to observe
changes during testing and seeing which WCHANs my code is spending
time in at a glance is quite useful.  If this is some kind of serious
security problem, then perhaps expose a sysctl to enable users access
their own wchans.  It's obviously not an issue for us developers on
non-multiuser linux hosts we're just writing and testing code on.

Thanks,
Vito Caputo
