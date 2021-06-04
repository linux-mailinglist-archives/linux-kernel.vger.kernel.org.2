Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE439B14F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFDEZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhFDEZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:25:02 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D38C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 21:23:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id r17so8154131qkp.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 21:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTjVsmt8B/lmfcH6zmtQsEq5A/al73A9Wc41mV1GMNo=;
        b=URAHB3QFDXBe+VlHTcaNqKItL5e2yCGbRjKJ9Ff/ZW5TqT3lmkkdr1Qok5KT9AlY4h
         +f4WxXO+4NDICqcCylDvhH8SzNxU9fbuLXd7qXH5Fc5Q+VpM2ejbtEUtFNXgLvVQt2v6
         MENY4g/8ehiHmjMQon5F2yEZUO5eUYccGSxyno3wcVT2rMNZLVi07dolH3YyEk2aCrDy
         9r07dHc0jWP0XwmWYivg5mjZ4Uhxi4IeJczSE1nsCTz+rOq9zGYQe/XjG+w3eQdKliaH
         C3OHsnPjyeaegDxKoZz5TC1i3txA/S+j7neToWiCmAJWrAzlrAy1DGQQQ0wyeTEtzIiS
         LHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTjVsmt8B/lmfcH6zmtQsEq5A/al73A9Wc41mV1GMNo=;
        b=NhuWxJslhWUi+3D1x/yI0JEsC3j4S+7zp9MdqnyEm4QPRLD2BKwtEPrtV3mcBR7cL2
         jb/ic4Nk9XO8GYSVRnr2jx9LmimZI2VV7ntFIqRBtYmmCH2yZJvsIxlk0r0gZR43OU7q
         f3AG7oMUahnYy6Omskay92rO7CV9Kn+4mqgA4YYcxeG5dT6YaPj5SsNhCTwAydShyWbD
         T48QY70kMUASHeCntMPlHo6ve6ePaNPZpQmv4EwC3wKMgh5ujspF98VPY3GnFnWSqsOF
         iRSR7kmVzIhJ99CjdV813Mis4KDPBtQ398v+QkrMg1D8NkQ8WApY/DrbgBCOCyioj8YQ
         I6Tw==
X-Gm-Message-State: AOAM533mc6zL6QwBMahy30EwlktoZ6+WjONXKpTLu8nUN3PJLTNQHdjD
        G2Z9cd+HqT7yuSuQWbnjh0qvtJLRecUD8xcPpNs=
X-Google-Smtp-Source: ABdhPJxSujyChmO29bhUQOBi1u0Oi8RR6ZuNpHsg438nNphIjHWRwfR4Ps1r6yCCHFRBPkBevVYj0QTL/UHe0j96jqg=
X-Received: by 2002:a37:a80e:: with SMTP id r14mr2655373qke.386.1622780593841;
 Thu, 03 Jun 2021 21:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZxre5=xt-RQFo6HU3rBYu7YuVtXZxNHicbKFX3FMB1T7A@mail.gmail.com>
 <20210430051059.GE975577@paulmck-ThinkPad-P17-Gen-1> <CAJRGBZzQ-eQMLHBVzhcTjqQMYEtop3SK=7TAMmC+5tNsfxM_GQ@mail.gmail.com>
 <20210501042834.GK975577@paulmck-ThinkPad-P17-Gen-1> <CAJRGBZzgXyNA1C12uiTo-ffa7Af5FB4ABRK_K9KgT9t4duRsdA@mail.gmail.com>
 <20210602174650.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210602182413.GA1159254@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZxj9VUYP-azVV3+mZcdizKPWgn4yc5dakO8dok6mZF4sQ@mail.gmail.com> <20210603144038.GN4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210603144038.GN4397@paulmck-ThinkPad-P17-Gen-1>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Fri, 4 Jun 2021 12:23:02 +0800
Message-ID: <CAJRGBZznM8TXXin8jXAgPnP8x5Cv0CMFM-1E88T1qg1Hd8vLcA@mail.gmail.com>
Subject: Re: [PATCH V11 clocksource 0/6] Do not mark clocks unstable due to
 delays for v5.13
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        Andi Kleen <ak@linux.intel.com>, feng.tang@intel.com,
        zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 10:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jun 03, 2021 at 12:25:57PM +0800, Luming Yu wrote:
> > These options works as how they are designed. But it needs to
> > go through a manual work and can't scale in highly automated data center
> > fleets.
> >
> > .if we really don't need a watch dog at runtime, we need some data proof.
> >
> > Before we can disable TSC watchdog by default for all Linux instances, we
> > still need a solution based on your patch set to train the watch dog from doing
> > wrong things , just based on some other latency issues in system that might be
> > unavoidable. We really can't punish tsc for the latency issues from
> > unknown source.
> >
> > I agree we still need to sort out the quality problems from these latency issues
> > noticed from watchdog rather than that we simply mute and hide as you
> > may suspect
> > that we may abuse the thresholds and the mechanism your patch set provides.
> > But it should be a focus after the patch is merged in upstream.
>
> Works for me!
>
> Would you be willing to provide your Reviewed-by, Acked-by, or Tested-by
> for the series?

sure!

Feel free to use Reviewed-by: luming.yu@gmail.com  or luming.yu@intel.com
for requesting the patch set to be merged in mainline as it can help us to
sort out real issues while it can improve overall user experience with tsc.




>
>                                                         Thanx, Paul
>
> > On Thu, Jun 3, 2021 at 2:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Jun 02, 2021 at 10:46:50AM -0700, Paul E. McKenney wrote:
> > > > On Wed, Jun 02, 2021 at 01:10:37PM +0800, Luming Yu wrote:
> > > > > Hi Paul,
> > > > >
> > > > > It appears that the patch set is not in 5.13.  Will it be in 5.14?
> > > >
> > > > Indeed it is not in v5.13.  There were some late-breaking reviews and
> > > > changes.  I am currently thinking in terms of v5.14.
> > > >
> > > > > And more data proof seems to indciate that  tsc is more stable than
> > > > > tsc-watchdog.
> > > >
> > > > The tsc-watchdog being HPET?  Or some other clocksource?
> > > >
> > > > > and we need the patch set to dis-arm wrong actions when watch dog is
> > > > > hit by a spik.
> > > >
> > > > It does depend on the hardware.  Thomas Gleixner provided a most
> > > > excellent summary of the possibilities here:
> > > >
> > > > https://lore.kernel.org/lkml/87a6pimt1f.ffs@nanos.tec.linutronix.de/
> > > >
> > > > And then if your hardware's TSC is the most trustworthy clocksource
> > > > on your system, you can always boot with tsc=reliable and avoid the
> > > > clocksource watchdog completely, with or without this patch series.
> > >
> > > Oh, and firmware can and apparently still sometimes does "adjust" the TSC,
> > > and so booting with tsc=reliable can such adjustments from you.
> > >
> > > > Or am I missing your point?
> > >
> > >                                                         Thanx, Paul
> > >
> > > > > On Sat, May 1, 2021 at 12:28 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Apr 30, 2021 at 02:52:58PM +0800, Luming Yu wrote:
> > > > > > > On Fri, Apr 30, 2021 at 1:11 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Apr 29, 2021 at 07:13:40PM +0800, Luming Yu wrote:
> > > > > > > > > On Thu, Apr 29, 2021 at 9:30 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hello!
> > > > > > > > > >
> > > > > > > > > > If there is a sufficient delay between reading the watchdog clock and the
> > > > > > > > > > clock under test, the clock under test will be marked unstable through no
> > > > > > > > > > fault of its own.  This series checks for this, doing limited retries
> > > > > > > > > > to get a good set of clock reads.  If the clock is marked unstable
> > > > > > > > > > and is marked as being per-CPU, cross-CPU synchronization is checked.
> > > > > > > > > > This series also provides delay injection, which may be enabled via
> > > > > > > > > > kernel boot parameters to test the checking for delays.
> > > > > > > > > >
> > > > > > > > > > Note that "sufficient delay" can be provided by SMIs, NMIs, and of course
> > > > > > > > > > vCPU preemption.
> > > > > > > > > >
> > > > > > > > > > 1.      Provide module parameters to inject delays in watchdog.
> > > > > > > > > >
> > > > > > > > > > 2.      Retry clock read if long delays detected.
> > > > > > > > > >
> > > > > > > > > > 3.      Check per-CPU clock synchronization when marked unstable.
> > > > > > > > > >
> > > > > > > > > > 4.      Provide a module parameter to fuzz per-CPU clock checking.
> > > > > > > > > >
> > > > > > > > > > 5.      Limit number of CPUs checked for clock synchronization.
> > > > > > > > > >
> > > > > > > > > > 6.      Reduce clocksource-skew threshold for TSC.
> > > > > > > > > >
> > > > > > > > > > Changes since v10, based on feedback from Thomas Gleixner, Peter Zijlstra,
> > > > > > > > > > Feng Tang, Andi Kleen, Luming Yu, Xing Zhengju, and the indefatigible
> > > > > > > > > > kernel test robot:
> > > > > > > > > >
> > > > > > > > > > o       Automatically compute the uncertainty margin for clocksource, and
> > > > > > > > > >         also allow them to be specified manually before that clocksource
> > > > > > > > > >         is registered.
> > > > > > > > > >
> > > > > > > > > > o       For the automatically computed uncertainty margins, bound them
> > > > > > > > > >         below by 100 microseconds (2 * WATCHDOG_MAX_SKEW).
> > > > > > > > > >
> > > > > > > > > > o       For the manually specified uncertainty margins, splat (but
> > > > > > > > > >         continue) if they are less than 100 microseconds (again 2 *
> > > > > > > > > >         WATCHDOG_MAX_SKEW).  The purpose of splatting is to discourage
> > > > > > > > > >         production use of this clock-skew-inducing debugging technique.
> > > > > > > > > >
> > > > > > > > > > o       Manually set the uncertainty margin for clocksource_jiffies
> > > > > > > > > >         (and thus refined_jiffies) to TICK_NSEC to compensate for the
> > > > > > > > > >         very low frequency of these clocks.
> > > > > > > > > >
> > > > > > > > > > o       Manually set the uncertainty margin for clocksource_tsc_early
> > > > > > > > > >         to 32 milliseconds.
> > > > > > > > > >
> > > > > > > > > > o       Apply numerous "Link:" fields to all patches.
> > > > > > > > > >
> > > > > > > > > > o       Add some acks and CCs.
> > > > > > > > > >
> > > > > > > > > > Changes since v9:
> > > > > > > > > >
> > > > > > > > > > o       Forgive tsc_early drift, based on feedback from Feng Tang; Xing,
> > > > > > > > > >         Zhengjun; and Thomas Gleixner.
> > > > > > > > > >
> > > > > > > > > > o       Improve CPU selection for clock-synchronization checking.
> > > > > > > > > >
> > > > > > > > > > Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/
> > > > > > > > > >
> > > > > > > > > > Changes since v8, based on Thomas Gleixner feedback:
> > > > > > > > > >
> > > > > > > > > > o       Reduced clock-skew threshold to 200us and delay limit to 50us.
> > > > > > > > > >
> > > > > > > > > > o       Split out a cs_watchdog_read() function.
> > > > > > > > > >
> > > > > > > > > > o       Removed the pointless CLOCK_SOURCE_VERIFY_PERCPU from kvm_clock.
> > > > > > > > > >
> > > > > > > > > > o       Initialized cs_nsec_max and cs_nsec_min to avoid firsttime checks.
> > > > > > > > > >
> > > > > > > > > > Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/
> > > > > > > > > >
> > > > > > > > > > Changes since v7, based on Thomas Gleixner feedback:
> > > > > > > > > >
> > > > > > > > > > o       Fix embarrassing git-format-patch operator error.
> > > > > > > > > >
> > > > > > > > > > o       Merge pairwise clock-desynchronization checking into the checking
> > > > > > > > > >         of per-CPU clock synchronization when marked unstable.
> > > > > > > > > >
> > > > > > > > > > o       Do selective per-CPU checking rather than blindly checking all
> > > > > > > > > >         CPUs.  Provide a clocksource.verify_n_cpus kernel boot parameter
> > > > > > > > > >         to control this behavior, with the value -1 choosing the old
> > > > > > > > > >         check-all-CPUs behavior.  The default is to randomly check 8 CPUs.
> > > > > > > > > >
> > > > > > > > > > o       Fix the clock-desynchronization checking to avoid a potential
> > > > > > > > > >         use-after-free error for dynamically allocated clocksource
> > > > > > > > > >         structures.
> > > > > > > > > >
> > > > > > > > > > o       Remove redundance "wdagain_nsec < 0" from clocksource_watchdog()
> > > > > > > > > >         clocksource skew checking.
> > > > > > > > > >
> > > > > > > > > > o       Update commit logs and do code-style updates.
> > > > > > > > > >
> > > > > > > > > > Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/
> > > > > > > > > >
> > > > > > > > > > Changes since v5:
> > > > > > > > > >
> > > > > > > > > > o       Rebased to v5.12-rc5.
> > > > > > > > > >
> > > > > > > > > > Changes since v4:
> > > > > > > > > >
> > > > > > > > > > o       Rebased to v5.12-rc1.
> > > > > > > > > >
> > > > > > > > > > Changes since v3:
> > > > > > > > > >
> > > > > > > > > > o       Rebased to v5.11.
> > > > > > > > > >
> > > > > > > > > > o       Apply Randy Dunlap feedback.
> > > > > > > > > >
> > > > > > > > > > Changes since v2:
> > > > > > > > > >
> > > > > > > > > > o       Rebased to v5.11-rc6.
> > > > > > > > > >
> > > > > > > > > > o       Updated Cc: list.
> > > > > > > > > >
> > > > > > > > > > Changes since v1:
> > > > > > > > > >
> > > > > > > > > > o       Applied feedback from Rik van Riel.
> > > > > > > > > >
> > > > > > > > > > o       Rebased to v5.11-rc3.
> > > > > > > > > >
> > > > > > > > > > o       Stripped "RFC" from the subject lines.
> > > > > > > > > >
> > > > > > > > > >                                                 Thanx, Paul
> > > > > > > > > >
> > > > > > > > > > ------------------------------------------------------------------------
> > > > > > > > > >
> > > > > > > > > >  Documentation/admin-guide/kernel-parameters.txt   |   32 +++
> > > > > > > > > >  arch/x86/kernel/tsc.c                             |    1
> > > > > > > > > >  b/Documentation/admin-guide/kernel-parameters.txt |   21 ++
> > > > > > > > > >  b/arch/x86/kernel/tsc.c                           |    3
> > > > > > > > > >  b/include/linux/clocksource.h                     |    2
> > > > > > > > > >  b/kernel/time/clocksource.c                       |   23 ++
> > > > > > > > > >  b/kernel/time/jiffies.c                           |   15 -
> > > > > > > > > >  include/linux/clocksource.h                       |    3
> > > > > > > > > >  kernel/time/clocksource.c                         |  227 ++++++++++++++++++++--
> > > > > > > > > >  9 files changed, 304 insertions(+), 23 deletions(-)
> > > > > > > > >
> > > > > > > > > Hi Paul,
> > > > > > > > > using the v11, I added a approve flag and made it work for my early
> > > > > > > > > inject test  where tsc is good
> > > > > > > > > through a cross tsc sync test. Ideally with the small tweak, we could
> > > > > > > > > get less tsc issues to debug.
> > > > > > > > >  And I'm not sure it would help in real trouble shooting cases. But we
> > > > > > > > > will see if it would help.
> > > > > > > >
> > > > > > > > Thank you for the patch!
> > > > > > > >
> > > > > > > > However, Thomas had me rework this code to put the error injection into
> > > > > > > > a kernel module, so this effect is now obtained in a different way.
> > > > > > > > So I am unable to make use of your patch.
> > > > > > >
> > > > > > > np, thanks for the heads up.
> > > > > > >
> > > > > > > we will also need to measure the tsc sync retest and prove it's robust
> > > > > > >  enough to trump the bad decision from clocksource watchdog based on HPET
> > > > > > > or other slow and old clocks while leaving good decisions pass through.
> > > > > > >
> > > > > > > we will re-spin the tsc story when your code is settled and landed in
> > > > > > > the mainline.
> > > > > >
> > > > > > My current series exports clocksource_verify_percpu(), which might help
> > > > > > measuring TSC synchronization.
> > > > > >
> > > > > >                                                         Thanx, Paul
