Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A69398094
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 07:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFBFMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 01:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhFBFMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 01:12:34 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B313C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 22:10:51 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g17so988008qtk.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 22:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExIpSQCdUwQfXC0k/E0C5WUAuuKOheQBwXBTxYKix0I=;
        b=STzLNIJWj8eSwze6PaSGbS2jgX2PN9mTUdR3AZocy0a+Dv2M26CMnpTuuaGQY4nqRr
         +lpuL3wJhK2bZFqxQ43phy8dmWhWzE8vi8fJsKB4LstuOUpjc/57085NSDg2GhMGqG9Z
         Hqq1FpJJ8EusDSyX8bQbDgcvckRJMLEXKeBG/+Zexcz8nytd2XqqZdMgKyjM25jr/oJZ
         XambXD5ocTl1KV5ySsAdUisO82Udtf4axBl8lygFyT1j18gHcvzNirZk22wwUp3JatsK
         29uyTCz+x+iKE25dxTS48QOq6vLwDWzuiFrXNMNl/XPmqf+ct2CaNBXXb17kAfeX8pII
         ABEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExIpSQCdUwQfXC0k/E0C5WUAuuKOheQBwXBTxYKix0I=;
        b=ayL8qyVExiM4m8J5exticGyan5vhOIZAlz5ALa9QYx7DvakCJHeqWz2LTA5RhBGGsv
         7pD2yQVs6MOLX6uoFWUOeVPSrbpgMu4UyKmymkEhF0yzI+H08jxoWMK+2ZS0O9JUxU63
         5pG/UBBX5p/MDVuardtY6Pcbj6R99mQuxfyaBMHZXmmZPpZ1AC7iG4FB8w7E/WrHEBUK
         6ydp17ErFRsyg4gGXW+PkcryyuWc1VUhmGTE4ZWQfi8rWS+vo0jAhKBixKh2lAvdtbNL
         5oK8ST0uoAEauUcKEMz6HDkqaQmDZKFlQEx5iF/fbYMll2QZEbZQe864AK4eoxP1jMMI
         muDg==
X-Gm-Message-State: AOAM533lOc55YXS4CB+ogurGkCgUGrAtUy+m9hBUzvUZOi7qNhjxWpzF
        EH/2dEqkU3mgt7uYc3g6up8v8kyAJTX66ndqx78=
X-Google-Smtp-Source: ABdhPJwB9pywpwivFns6/pIIRJnxkmdM8mXssJGaRGWWqE3qHGQGTPoCyNB6gaK/jkX+QCN8lQOXAuAe+0kxMvmWGyc=
X-Received: by 2002:ac8:5fc1:: with SMTP id k1mr22725424qta.275.1622610650620;
 Tue, 01 Jun 2021 22:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZxre5=xt-RQFo6HU3rBYu7YuVtXZxNHicbKFX3FMB1T7A@mail.gmail.com>
 <20210430051059.GE975577@paulmck-ThinkPad-P17-Gen-1> <CAJRGBZzQ-eQMLHBVzhcTjqQMYEtop3SK=7TAMmC+5tNsfxM_GQ@mail.gmail.com>
 <20210501042834.GK975577@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210501042834.GK975577@paulmck-ThinkPad-P17-Gen-1>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Wed, 2 Jun 2021 13:10:37 +0800
Message-ID: <CAJRGBZzgXyNA1C12uiTo-ffa7Af5FB4ABRK_K9KgT9t4duRsdA@mail.gmail.com>
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

Hi Paul,

It appears that the patch set is not in 5.13.  Will it be in 5.14?
And more data proof seems to indciate that  tsc is more stable than
tsc-watchdog.
and we need the patch set to dis-arm wrong actions when watch dog is
hit by a spik.

On Sat, May 1, 2021 at 12:28 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Apr 30, 2021 at 02:52:58PM +0800, Luming Yu wrote:
> > On Fri, Apr 30, 2021 at 1:11 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Apr 29, 2021 at 07:13:40PM +0800, Luming Yu wrote:
> > > > On Thu, Apr 29, 2021 at 9:30 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > Hello!
> > > > >
> > > > > If there is a sufficient delay between reading the watchdog clock and the
> > > > > clock under test, the clock under test will be marked unstable through no
> > > > > fault of its own.  This series checks for this, doing limited retries
> > > > > to get a good set of clock reads.  If the clock is marked unstable
> > > > > and is marked as being per-CPU, cross-CPU synchronization is checked.
> > > > > This series also provides delay injection, which may be enabled via
> > > > > kernel boot parameters to test the checking for delays.
> > > > >
> > > > > Note that "sufficient delay" can be provided by SMIs, NMIs, and of course
> > > > > vCPU preemption.
> > > > >
> > > > > 1.      Provide module parameters to inject delays in watchdog.
> > > > >
> > > > > 2.      Retry clock read if long delays detected.
> > > > >
> > > > > 3.      Check per-CPU clock synchronization when marked unstable.
> > > > >
> > > > > 4.      Provide a module parameter to fuzz per-CPU clock checking.
> > > > >
> > > > > 5.      Limit number of CPUs checked for clock synchronization.
> > > > >
> > > > > 6.      Reduce clocksource-skew threshold for TSC.
> > > > >
> > > > > Changes since v10, based on feedback from Thomas Gleixner, Peter Zijlstra,
> > > > > Feng Tang, Andi Kleen, Luming Yu, Xing Zhengju, and the indefatigible
> > > > > kernel test robot:
> > > > >
> > > > > o       Automatically compute the uncertainty margin for clocksource, and
> > > > >         also allow them to be specified manually before that clocksource
> > > > >         is registered.
> > > > >
> > > > > o       For the automatically computed uncertainty margins, bound them
> > > > >         below by 100 microseconds (2 * WATCHDOG_MAX_SKEW).
> > > > >
> > > > > o       For the manually specified uncertainty margins, splat (but
> > > > >         continue) if they are less than 100 microseconds (again 2 *
> > > > >         WATCHDOG_MAX_SKEW).  The purpose of splatting is to discourage
> > > > >         production use of this clock-skew-inducing debugging technique.
> > > > >
> > > > > o       Manually set the uncertainty margin for clocksource_jiffies
> > > > >         (and thus refined_jiffies) to TICK_NSEC to compensate for the
> > > > >         very low frequency of these clocks.
> > > > >
> > > > > o       Manually set the uncertainty margin for clocksource_tsc_early
> > > > >         to 32 milliseconds.
> > > > >
> > > > > o       Apply numerous "Link:" fields to all patches.
> > > > >
> > > > > o       Add some acks and CCs.
> > > > >
> > > > > Changes since v9:
> > > > >
> > > > > o       Forgive tsc_early drift, based on feedback from Feng Tang; Xing,
> > > > >         Zhengjun; and Thomas Gleixner.
> > > > >
> > > > > o       Improve CPU selection for clock-synchronization checking.
> > > > >
> > > > > Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/
> > > > >
> > > > > Changes since v8, based on Thomas Gleixner feedback:
> > > > >
> > > > > o       Reduced clock-skew threshold to 200us and delay limit to 50us.
> > > > >
> > > > > o       Split out a cs_watchdog_read() function.
> > > > >
> > > > > o       Removed the pointless CLOCK_SOURCE_VERIFY_PERCPU from kvm_clock.
> > > > >
> > > > > o       Initialized cs_nsec_max and cs_nsec_min to avoid firsttime checks.
> > > > >
> > > > > Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/
> > > > >
> > > > > Changes since v7, based on Thomas Gleixner feedback:
> > > > >
> > > > > o       Fix embarrassing git-format-patch operator error.
> > > > >
> > > > > o       Merge pairwise clock-desynchronization checking into the checking
> > > > >         of per-CPU clock synchronization when marked unstable.
> > > > >
> > > > > o       Do selective per-CPU checking rather than blindly checking all
> > > > >         CPUs.  Provide a clocksource.verify_n_cpus kernel boot parameter
> > > > >         to control this behavior, with the value -1 choosing the old
> > > > >         check-all-CPUs behavior.  The default is to randomly check 8 CPUs.
> > > > >
> > > > > o       Fix the clock-desynchronization checking to avoid a potential
> > > > >         use-after-free error for dynamically allocated clocksource
> > > > >         structures.
> > > > >
> > > > > o       Remove redundance "wdagain_nsec < 0" from clocksource_watchdog()
> > > > >         clocksource skew checking.
> > > > >
> > > > > o       Update commit logs and do code-style updates.
> > > > >
> > > > > Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/
> > > > >
> > > > > Changes since v5:
> > > > >
> > > > > o       Rebased to v5.12-rc5.
> > > > >
> > > > > Changes since v4:
> > > > >
> > > > > o       Rebased to v5.12-rc1.
> > > > >
> > > > > Changes since v3:
> > > > >
> > > > > o       Rebased to v5.11.
> > > > >
> > > > > o       Apply Randy Dunlap feedback.
> > > > >
> > > > > Changes since v2:
> > > > >
> > > > > o       Rebased to v5.11-rc6.
> > > > >
> > > > > o       Updated Cc: list.
> > > > >
> > > > > Changes since v1:
> > > > >
> > > > > o       Applied feedback from Rik van Riel.
> > > > >
> > > > > o       Rebased to v5.11-rc3.
> > > > >
> > > > > o       Stripped "RFC" from the subject lines.
> > > > >
> > > > >                                                 Thanx, Paul
> > > > >
> > > > > ------------------------------------------------------------------------
> > > > >
> > > > >  Documentation/admin-guide/kernel-parameters.txt   |   32 +++
> > > > >  arch/x86/kernel/tsc.c                             |    1
> > > > >  b/Documentation/admin-guide/kernel-parameters.txt |   21 ++
> > > > >  b/arch/x86/kernel/tsc.c                           |    3
> > > > >  b/include/linux/clocksource.h                     |    2
> > > > >  b/kernel/time/clocksource.c                       |   23 ++
> > > > >  b/kernel/time/jiffies.c                           |   15 -
> > > > >  include/linux/clocksource.h                       |    3
> > > > >  kernel/time/clocksource.c                         |  227 ++++++++++++++++++++--
> > > > >  9 files changed, 304 insertions(+), 23 deletions(-)
> > > >
> > > > Hi Paul,
> > > > using the v11, I added a approve flag and made it work for my early
> > > > inject test  where tsc is good
> > > > through a cross tsc sync test. Ideally with the small tweak, we could
> > > > get less tsc issues to debug.
> > > >  And I'm not sure it would help in real trouble shooting cases. But we
> > > > will see if it would help.
> > >
> > > Thank you for the patch!
> > >
> > > However, Thomas had me rework this code to put the error injection into
> > > a kernel module, so this effect is now obtained in a different way.
> > > So I am unable to make use of your patch.
> >
> > np, thanks for the heads up.
> >
> > we will also need to measure the tsc sync retest and prove it's robust
> >  enough to trump the bad decision from clocksource watchdog based on HPET
> > or other slow and old clocks while leaving good decisions pass through.
> >
> > we will re-spin the tsc story when your code is settled and landed in
> > the mainline.
>
> My current series exports clocksource_verify_percpu(), which might help
> measuring TSC synchronization.
>
>                                                         Thanx, Paul
