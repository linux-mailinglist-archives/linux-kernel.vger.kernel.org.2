Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66343991E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFBRsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFBRse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:48:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E208E61D6C;
        Wed,  2 Jun 2021 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622656010;
        bh=x0q3Rcw55ObgUss1lkILYmRczYYff4+ObuPIrINEwrw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oz9fY6GtQXsNoH1vavfUyJwbD9esOH8GYY66YNyTFrDicOC6OmhSyh/0RQbHKQS2n
         +7IgYINGC7yKnjINATJYFcynB7HJkYfWNbvL8TcYdAHEkxN1qyp5/lDP02pufWQUY9
         V2duIBOeP9gbL2koTrpSrMiiSVLfCPcSCuiTMXv9Mklk88/kgjTUTnzpMyg93i/QOH
         Mk7+YPjTb/bcATiz2JvUk9P5f+4McQk435WhtQDXEjyK9bCev2I2SANdRtP2qvk2Fz
         qmeQjA+smPIqhqERBFUIRoe2Mra3wXJ+0WdnmFKG21Fj0mYDQdOwv/2iH9HR3z/6KE
         GcUlE6OfCtnEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A821D5C0176; Wed,  2 Jun 2021 10:46:50 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:46:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Luming Yu <luming.yu@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        Andi Kleen <ak@linux.intel.com>, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [PATCH V11 clocksource 0/6] Do not mark clocks unstable due to
 delays for v5.13
Message-ID: <20210602174650.GH4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZxre5=xt-RQFo6HU3rBYu7YuVtXZxNHicbKFX3FMB1T7A@mail.gmail.com>
 <20210430051059.GE975577@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZzQ-eQMLHBVzhcTjqQMYEtop3SK=7TAMmC+5tNsfxM_GQ@mail.gmail.com>
 <20210501042834.GK975577@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZzgXyNA1C12uiTo-ffa7Af5FB4ABRK_K9KgT9t4duRsdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJRGBZzgXyNA1C12uiTo-ffa7Af5FB4ABRK_K9KgT9t4duRsdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:10:37PM +0800, Luming Yu wrote:
> Hi Paul,
> 
> It appears that the patch set is not in 5.13.  Will it be in 5.14?

Indeed it is not in v5.13.  There were some late-breaking reviews and
changes.  I am currently thinking in terms of v5.14.

> And more data proof seems to indciate that  tsc is more stable than
> tsc-watchdog.

The tsc-watchdog being HPET?  Or some other clocksource?

> and we need the patch set to dis-arm wrong actions when watch dog is
> hit by a spik.

It does depend on the hardware.  Thomas Gleixner provided a most
excellent summary of the possibilities here:

https://lore.kernel.org/lkml/87a6pimt1f.ffs@nanos.tec.linutronix.de/

And then if your hardware's TSC is the most trustworthy clocksource
on your system, you can always boot with tsc=reliable and avoid the
clocksource watchdog completely, with or without this patch series.

Or am I missing your point?

							Thanx, Paul

> On Sat, May 1, 2021 at 12:28 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Apr 30, 2021 at 02:52:58PM +0800, Luming Yu wrote:
> > > On Fri, Apr 30, 2021 at 1:11 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Thu, Apr 29, 2021 at 07:13:40PM +0800, Luming Yu wrote:
> > > > > On Thu, Apr 29, 2021 at 9:30 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > Hello!
> > > > > >
> > > > > > If there is a sufficient delay between reading the watchdog clock and the
> > > > > > clock under test, the clock under test will be marked unstable through no
> > > > > > fault of its own.  This series checks for this, doing limited retries
> > > > > > to get a good set of clock reads.  If the clock is marked unstable
> > > > > > and is marked as being per-CPU, cross-CPU synchronization is checked.
> > > > > > This series also provides delay injection, which may be enabled via
> > > > > > kernel boot parameters to test the checking for delays.
> > > > > >
> > > > > > Note that "sufficient delay" can be provided by SMIs, NMIs, and of course
> > > > > > vCPU preemption.
> > > > > >
> > > > > > 1.      Provide module parameters to inject delays in watchdog.
> > > > > >
> > > > > > 2.      Retry clock read if long delays detected.
> > > > > >
> > > > > > 3.      Check per-CPU clock synchronization when marked unstable.
> > > > > >
> > > > > > 4.      Provide a module parameter to fuzz per-CPU clock checking.
> > > > > >
> > > > > > 5.      Limit number of CPUs checked for clock synchronization.
> > > > > >
> > > > > > 6.      Reduce clocksource-skew threshold for TSC.
> > > > > >
> > > > > > Changes since v10, based on feedback from Thomas Gleixner, Peter Zijlstra,
> > > > > > Feng Tang, Andi Kleen, Luming Yu, Xing Zhengju, and the indefatigible
> > > > > > kernel test robot:
> > > > > >
> > > > > > o       Automatically compute the uncertainty margin for clocksource, and
> > > > > >         also allow them to be specified manually before that clocksource
> > > > > >         is registered.
> > > > > >
> > > > > > o       For the automatically computed uncertainty margins, bound them
> > > > > >         below by 100 microseconds (2 * WATCHDOG_MAX_SKEW).
> > > > > >
> > > > > > o       For the manually specified uncertainty margins, splat (but
> > > > > >         continue) if they are less than 100 microseconds (again 2 *
> > > > > >         WATCHDOG_MAX_SKEW).  The purpose of splatting is to discourage
> > > > > >         production use of this clock-skew-inducing debugging technique.
> > > > > >
> > > > > > o       Manually set the uncertainty margin for clocksource_jiffies
> > > > > >         (and thus refined_jiffies) to TICK_NSEC to compensate for the
> > > > > >         very low frequency of these clocks.
> > > > > >
> > > > > > o       Manually set the uncertainty margin for clocksource_tsc_early
> > > > > >         to 32 milliseconds.
> > > > > >
> > > > > > o       Apply numerous "Link:" fields to all patches.
> > > > > >
> > > > > > o       Add some acks and CCs.
> > > > > >
> > > > > > Changes since v9:
> > > > > >
> > > > > > o       Forgive tsc_early drift, based on feedback from Feng Tang; Xing,
> > > > > >         Zhengjun; and Thomas Gleixner.
> > > > > >
> > > > > > o       Improve CPU selection for clock-synchronization checking.
> > > > > >
> > > > > > Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/
> > > > > >
> > > > > > Changes since v8, based on Thomas Gleixner feedback:
> > > > > >
> > > > > > o       Reduced clock-skew threshold to 200us and delay limit to 50us.
> > > > > >
> > > > > > o       Split out a cs_watchdog_read() function.
> > > > > >
> > > > > > o       Removed the pointless CLOCK_SOURCE_VERIFY_PERCPU from kvm_clock.
> > > > > >
> > > > > > o       Initialized cs_nsec_max and cs_nsec_min to avoid firsttime checks.
> > > > > >
> > > > > > Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/
> > > > > >
> > > > > > Changes since v7, based on Thomas Gleixner feedback:
> > > > > >
> > > > > > o       Fix embarrassing git-format-patch operator error.
> > > > > >
> > > > > > o       Merge pairwise clock-desynchronization checking into the checking
> > > > > >         of per-CPU clock synchronization when marked unstable.
> > > > > >
> > > > > > o       Do selective per-CPU checking rather than blindly checking all
> > > > > >         CPUs.  Provide a clocksource.verify_n_cpus kernel boot parameter
> > > > > >         to control this behavior, with the value -1 choosing the old
> > > > > >         check-all-CPUs behavior.  The default is to randomly check 8 CPUs.
> > > > > >
> > > > > > o       Fix the clock-desynchronization checking to avoid a potential
> > > > > >         use-after-free error for dynamically allocated clocksource
> > > > > >         structures.
> > > > > >
> > > > > > o       Remove redundance "wdagain_nsec < 0" from clocksource_watchdog()
> > > > > >         clocksource skew checking.
> > > > > >
> > > > > > o       Update commit logs and do code-style updates.
> > > > > >
> > > > > > Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/
> > > > > >
> > > > > > Changes since v5:
> > > > > >
> > > > > > o       Rebased to v5.12-rc5.
> > > > > >
> > > > > > Changes since v4:
> > > > > >
> > > > > > o       Rebased to v5.12-rc1.
> > > > > >
> > > > > > Changes since v3:
> > > > > >
> > > > > > o       Rebased to v5.11.
> > > > > >
> > > > > > o       Apply Randy Dunlap feedback.
> > > > > >
> > > > > > Changes since v2:
> > > > > >
> > > > > > o       Rebased to v5.11-rc6.
> > > > > >
> > > > > > o       Updated Cc: list.
> > > > > >
> > > > > > Changes since v1:
> > > > > >
> > > > > > o       Applied feedback from Rik van Riel.
> > > > > >
> > > > > > o       Rebased to v5.11-rc3.
> > > > > >
> > > > > > o       Stripped "RFC" from the subject lines.
> > > > > >
> > > > > >                                                 Thanx, Paul
> > > > > >
> > > > > > ------------------------------------------------------------------------
> > > > > >
> > > > > >  Documentation/admin-guide/kernel-parameters.txt   |   32 +++
> > > > > >  arch/x86/kernel/tsc.c                             |    1
> > > > > >  b/Documentation/admin-guide/kernel-parameters.txt |   21 ++
> > > > > >  b/arch/x86/kernel/tsc.c                           |    3
> > > > > >  b/include/linux/clocksource.h                     |    2
> > > > > >  b/kernel/time/clocksource.c                       |   23 ++
> > > > > >  b/kernel/time/jiffies.c                           |   15 -
> > > > > >  include/linux/clocksource.h                       |    3
> > > > > >  kernel/time/clocksource.c                         |  227 ++++++++++++++++++++--
> > > > > >  9 files changed, 304 insertions(+), 23 deletions(-)
> > > > >
> > > > > Hi Paul,
> > > > > using the v11, I added a approve flag and made it work for my early
> > > > > inject test  where tsc is good
> > > > > through a cross tsc sync test. Ideally with the small tweak, we could
> > > > > get less tsc issues to debug.
> > > > >  And I'm not sure it would help in real trouble shooting cases. But we
> > > > > will see if it would help.
> > > >
> > > > Thank you for the patch!
> > > >
> > > > However, Thomas had me rework this code to put the error injection into
> > > > a kernel module, so this effect is now obtained in a different way.
> > > > So I am unable to make use of your patch.
> > >
> > > np, thanks for the heads up.
> > >
> > > we will also need to measure the tsc sync retest and prove it's robust
> > >  enough to trump the bad decision from clocksource watchdog based on HPET
> > > or other slow and old clocks while leaving good decisions pass through.
> > >
> > > we will re-spin the tsc story when your code is settled and landed in
> > > the mainline.
> >
> > My current series exports clocksource_verify_percpu(), which might help
> > measuring TSC synchronization.
> >
> >                                                         Thanx, Paul
