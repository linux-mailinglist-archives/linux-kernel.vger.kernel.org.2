Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0B36E96A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhD2LOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 07:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhD2LOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 07:14:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB7C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 04:13:52 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d19so30983156qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUPjv7s6YOxJEhXKJpXdePB/GgX5l8S7o3M1T+YzLt4=;
        b=py3S0CmlMyy1o1U/SvIZYoVlP6EtECqjtIaTZkjenbf6cqfaCKuidR/4lPV7M6+HCL
         y48RCmN/Ubc1aGeArDumpX2DN++mMh3kIhMikK2ZcLEIjA7TES38F/DWd2LSf9pBurGj
         JoNse4D2Q/fCeN++DMSy8vkIHRfSE6+TwPpVEFYVhyTLArbfjozIL7LIZJ+ZQmTna1dP
         oHIFzwBR4U8KFQEj3R0DiR9WN1ritGCvShYLxQuEwyZQ3o+uo3o62z1DjENMFn8oSD8A
         chhWmVhlcLwZWb6AnXdEwOQe2GnE6Yv6CEkvx/NGzOMy++yykjzJBhrWp4btVK8iKtfZ
         m4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUPjv7s6YOxJEhXKJpXdePB/GgX5l8S7o3M1T+YzLt4=;
        b=anwr5FrCtUUVAbpfPV6sI09iL/b+hvgNsO0lFVBLFZh2yBNBAotmR720PK7udGqjYY
         uSzBXnRZE1pYWErfJAbdN8HDKCZFv9i44kw1I0Il/0W13Pl3ilPKEGSpATy5huHvsp7A
         IsGI7GKBLK/p4x7/FkujzGDK3goTwH5wlVkiZW7KKQ4WcXuuUeGlfd+jvIfAFVUSqFd2
         qXUEFDiAYBk2wIENB9FZID6f4KIrrbbc1aVGuYxomeaSpQUrgPWlVmJS0CENiah3Ql/g
         tOg/BDADf9cbuUSF0h4tVBVJwySzr1Ku6ePDq/0i4UV552YqMfbUBLQetj7z8DpQqAE9
         SgXg==
X-Gm-Message-State: AOAM530rPrI62LjdBjUrQ8XZi2KyDQDhDK2y55fvgG510StEcxFkjLmV
        9dytICu1FX6RQYm1iSYvoB4Q/Lz4LgW7vMWM2KI=
X-Google-Smtp-Source: ABdhPJz8+c4qhfOHq/Jyd3IadwuVQ2g3Dfvz+2Yn8ZRtf0UANpnSz5RtSCMuMl8N/KfuU2Mgrmk2d09/UkCsuIo4oSA=
X-Received: by 2002:ae9:f114:: with SMTP id k20mr34052777qkg.386.1619694831834;
 Thu, 29 Apr 2021 04:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Thu, 29 Apr 2021 19:13:40 +0800
Message-ID: <CAJRGBZxre5=xt-RQFo6HU3rBYu7YuVtXZxNHicbKFX3FMB1T7A@mail.gmail.com>
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

On Thu, Apr 29, 2021 at 9:30 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello!
>
> If there is a sufficient delay between reading the watchdog clock and the
> clock under test, the clock under test will be marked unstable through no
> fault of its own.  This series checks for this, doing limited retries
> to get a good set of clock reads.  If the clock is marked unstable
> and is marked as being per-CPU, cross-CPU synchronization is checked.
> This series also provides delay injection, which may be enabled via
> kernel boot parameters to test the checking for delays.
>
> Note that "sufficient delay" can be provided by SMIs, NMIs, and of course
> vCPU preemption.
>
> 1.      Provide module parameters to inject delays in watchdog.
>
> 2.      Retry clock read if long delays detected.
>
> 3.      Check per-CPU clock synchronization when marked unstable.
>
> 4.      Provide a module parameter to fuzz per-CPU clock checking.
>
> 5.      Limit number of CPUs checked for clock synchronization.
>
> 6.      Reduce clocksource-skew threshold for TSC.
>
> Changes since v10, based on feedback from Thomas Gleixner, Peter Zijlstra,
> Feng Tang, Andi Kleen, Luming Yu, Xing Zhengju, and the indefatigible
> kernel test robot:
>
> o       Automatically compute the uncertainty margin for clocksource, and
>         also allow them to be specified manually before that clocksource
>         is registered.
>
> o       For the automatically computed uncertainty margins, bound them
>         below by 100 microseconds (2 * WATCHDOG_MAX_SKEW).
>
> o       For the manually specified uncertainty margins, splat (but
>         continue) if they are less than 100 microseconds (again 2 *
>         WATCHDOG_MAX_SKEW).  The purpose of splatting is to discourage
>         production use of this clock-skew-inducing debugging technique.
>
> o       Manually set the uncertainty margin for clocksource_jiffies
>         (and thus refined_jiffies) to TICK_NSEC to compensate for the
>         very low frequency of these clocks.
>
> o       Manually set the uncertainty margin for clocksource_tsc_early
>         to 32 milliseconds.
>
> o       Apply numerous "Link:" fields to all patches.
>
> o       Add some acks and CCs.
>
> Changes since v9:
>
> o       Forgive tsc_early drift, based on feedback from Feng Tang; Xing,
>         Zhengjun; and Thomas Gleixner.
>
> o       Improve CPU selection for clock-synchronization checking.
>
> Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/
>
> Changes since v8, based on Thomas Gleixner feedback:
>
> o       Reduced clock-skew threshold to 200us and delay limit to 50us.
>
> o       Split out a cs_watchdog_read() function.
>
> o       Removed the pointless CLOCK_SOURCE_VERIFY_PERCPU from kvm_clock.
>
> o       Initialized cs_nsec_max and cs_nsec_min to avoid firsttime checks.
>
> Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/
>
> Changes since v7, based on Thomas Gleixner feedback:
>
> o       Fix embarrassing git-format-patch operator error.
>
> o       Merge pairwise clock-desynchronization checking into the checking
>         of per-CPU clock synchronization when marked unstable.
>
> o       Do selective per-CPU checking rather than blindly checking all
>         CPUs.  Provide a clocksource.verify_n_cpus kernel boot parameter
>         to control this behavior, with the value -1 choosing the old
>         check-all-CPUs behavior.  The default is to randomly check 8 CPUs.
>
> o       Fix the clock-desynchronization checking to avoid a potential
>         use-after-free error for dynamically allocated clocksource
>         structures.
>
> o       Remove redundance "wdagain_nsec < 0" from clocksource_watchdog()
>         clocksource skew checking.
>
> o       Update commit logs and do code-style updates.
>
> Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/
>
> Changes since v5:
>
> o       Rebased to v5.12-rc5.
>
> Changes since v4:
>
> o       Rebased to v5.12-rc1.
>
> Changes since v3:
>
> o       Rebased to v5.11.
>
> o       Apply Randy Dunlap feedback.
>
> Changes since v2:
>
> o       Rebased to v5.11-rc6.
>
> o       Updated Cc: list.
>
> Changes since v1:
>
> o       Applied feedback from Rik van Riel.
>
> o       Rebased to v5.11-rc3.
>
> o       Stripped "RFC" from the subject lines.
>
>                                                 Thanx, Paul
>
> ------------------------------------------------------------------------
>
>  Documentation/admin-guide/kernel-parameters.txt   |   32 +++
>  arch/x86/kernel/tsc.c                             |    1
>  b/Documentation/admin-guide/kernel-parameters.txt |   21 ++
>  b/arch/x86/kernel/tsc.c                           |    3
>  b/include/linux/clocksource.h                     |    2
>  b/kernel/time/clocksource.c                       |   23 ++
>  b/kernel/time/jiffies.c                           |   15 -
>  include/linux/clocksource.h                       |    3
>  kernel/time/clocksource.c                         |  227 ++++++++++++++++++++--
>  9 files changed, 304 insertions(+), 23 deletions(-)

Hi Paul,
using the v11, I added a approve flag and made it work for my early
inject test  where tsc is good
through a cross tsc sync test. Ideally with the small tweak, we could
get less tsc issues to debug.
 And I'm not sure it would help in real trouble shooting cases. But we
will see if it would help.

My hack patch snippet as below:



 static void __clocksource_unstable(struct clocksource *cs)
 {
+       if (!cs->approved)
+               return;
+
        cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
        cs->flags |= CLOCK_SOURCE_UNSTABLE;

@@ -366,9 +369,12 @@
        if (!cpumask_empty(&cpus_behind))
                pr_warn("        CPUs %*pbl behind CPU %d for
clocksource %s.\n",
                        cpumask_pr_args(&cpus_behind), testcpu, cs->name);
-       if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind))
+       if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind)) {
                pr_warn("        CPU %d check durations %lldns -
%lldns for clocksource %s.\n",
                        testcpu, cs_nsec_min, cs_nsec_max, cs->name);
+               cs->approved = true;
+               __clocksource_unstable(cs);
+       }
 }

 static void clocksource_watchdog(struct timer_list *unused)
@@ -396,6 +402,7 @@

                if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
                        /* Clock readout unreliable, so give it up. */
+                       cs->approved = false;
                        __clocksource_unstable(cs);
                        continue;
                }
