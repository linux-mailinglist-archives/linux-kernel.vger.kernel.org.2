Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414DA3BA9D9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 19:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhGCRdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 13:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhGCRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 13:33:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F13C061762
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jul 2021 10:30:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bu12so21929811ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bv4UU4Hid7kkYX008oD1I7TKrIbgBIG91KX8BdgMHZQ=;
        b=v1HICn1tF7hwbKxxeS2A4ls2oNnZ40CxFWSQeV3fubh4V/TiIpTbxWZRw8neQatRWR
         jocAuc89SDBFnLAaPq0Geg2XO9M5ysMCEeaXU6uPYzcxpzeisLyQm1S9OmKcaTzKKKkx
         /QyQiaO4Cy+iCnX3e8qboETp/2SslV4uJQvDaVJHb6I7Fz9aYrfF9ZpyL470pJb8+MIL
         pMelHxkUU6jUQJs+HfP8yK8WaDascHQifc2AW2auJgaD5dRvoXAf5dlzdBlND6GuPiZg
         xkWPC4Fz3+F9hOiYVuodd+gENmEDfqsPJO3S+y7JIdeFsF9CfyQJ9HsrLUKPTNULsv0H
         nLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bv4UU4Hid7kkYX008oD1I7TKrIbgBIG91KX8BdgMHZQ=;
        b=agbFO4l7Zmy5LGYPuySymypFYfQgFs05x8FWUGdceDrwLxvVPKu8UBKQ7Na9u1cM9I
         RZsq17E0c7mG3I7YNW3uE+cTrpNVpihz5j6q56jD8eHhhDNvoPaTHFwhKyimEyco+9kW
         brRflXUXl51BTuHTkZhyXyRHVd2+e/ZZ/aKbM1qagEPeBLXDIou15F9InZR/KLA1B6Ih
         ohk2FGSlWMeB1DbauFDNSFZxYAT8xn44BrwU0kdbNhG2uNC/JmEKjEMw/+8yFYNMSS3B
         oPl0irKsfWojcDfkAuIgJxssjpWKPbleD2thvAgCNK5etkXZf3N51m8du2SadsfJosEm
         VD3g==
X-Gm-Message-State: AOAM533g6VLiDRZSpFTn2ufTKEgEpW2U2h5uiCYK6iUjHZFgLz/TExEb
        BBtQLDGHzSb75ymly6gSn1ek97fBDjC1FUzslxMnEA==
X-Google-Smtp-Source: ABdhPJyk/Iqxcho2RYJfyZHS71tPmI49cyJD6i5Vt+6oatGP4P3Gp8u2j3jbfd2kzZsh9gUKX3j/VjHt7VTdsjtqOI8=
X-Received: by 2002:a17:906:c006:: with SMTP id e6mr5614197ejz.510.1625333434170;
 Sat, 03 Jul 2021 10:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210620101312.1757363-1-ani@anisinha.ca> <87r1gudj87.ffs@nanos.tec.linutronix.de>
 <alpine.DEB.2.22.394.2106262136340.2111427@anisinha-lenovo>
In-Reply-To: <alpine.DEB.2.22.394.2106262136340.2111427@anisinha-lenovo>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Sat, 3 Jul 2021 23:00:23 +0530
Message-ID: <CAARzgwwXihtj+SnrBamPKJATnHYeuhDPcXGnD+a56OGD=p=qNQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add kernel logs when sched clock unstable and
 NO_HZ_FULL is not possible
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, anirban.sinha@nokia.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

On Sat, Jun 26, 2021 at 9:49 PM Ani Sinha <ani@anisinha.ca> wrote:
>
>
>
> On Tue, 22 Jun 2021, Thomas Gleixner wrote:
>
> > On Sun, Jun 20 2021 at 15:43, Ani Sinha wrote:
> >
> > > Commit 4f49b90abb4aca ("sched-clock: Migrate to use new tick
> > > dependency mask model") had also removed the kernel warning
> > > message informing the user that it was not possible to turn
> > > on NO_HZ_FULL. Adding back that log message here. It is
> > > unhelpful when the kernel turns off NO_HZ_FULL silently
> > > without informing anyone.
> > > Also added a kernel log when sched clock is marked as unstable.
> >
> > Don't do two things at once. See Documentation/process/....
>
> Ok I will split up this patch into two.
>
> >
> > Also your subject line want's a proper prefix.
>
> OK will fix.
>
> >
> > > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > > index c2b2859ddd82..9f9fe658f8a5 100644
> > > --- a/kernel/sched/clock.c
> > > +++ b/kernel/sched/clock.c
> > > @@ -192,8 +192,11 @@ void clear_sched_clock_stable(void)
> > >
> > >     smp_mb(); /* matches sched_clock_init_late() */
> > >
> > > -   if (static_key_count(&sched_clock_running.key) == 2)
> > > +   if (static_key_count(&sched_clock_running.key) == 2) {
> > > +           WARN_ONCE(sched_clock_stable(),
> > > +                     "sched clock is now marked unstable.");
> >
> > What's the WARN for here? That backtrace is largely uninteresting.
>
> OK to be consistent with other parts of the code, I will replace this with
> pr_warn()
>
> >
> > > -   if (can_stop_full_tick(cpu, ts))
> > > +   if (can_stop_full_tick(cpu, ts)) {
> > >             tick_nohz_stop_sched_tick(ts, cpu);
> > > -   else if (ts->tick_stopped)
> > > -           tick_nohz_restart_sched_tick(ts, ktime_get());
> > > +   } else {
> > > +           /*
> > > +            * Don't allow the user to think they can get
> > > +            * full NO_HZ with this machine.
> > > +            */
> > > +           WARN_ONCE(tick_nohz_full_running,
> > > +                     "NO_HZ_FULL will not work for the current system.");
> >
> > can_stop_full_tick() returning false can be transient and then the user
> > still has no idea _why_ this is printed.
> >
> > Also assume the user/admin starts perf and knows he's going to disturb
> > NOHZ full, then _why_ would he be interested in that warning.
> >
>
> If NOHZ is disabled intentionally, that is not an interesting case. I am
> worried about the situation where the user specifies NOHZ option in the
> kernel commandline and the kernel silently disabled this because of one or
> more limitations in the system. I want to address this. All the reasons
> specified in the following commit is still true:
>
> commit e12d0271774fea9fddf1e2a7952a0bffb2ee8e8b
> Author: Steven Rostedt <rostedt@goodmis.org>
> Date:   Fri May 10 17:12:28 2013 -0400
>
>     nohz: Warn if the machine can not perform nohz_full
>
>     If the user configures NO_HZ_FULL and defines nohz_full=XXX on the
>     kernel command line, or enables NO_HZ_FULL_ALL, but nohz fails
>     due to the machine having a unstable clock, warn about it.
>
>     We do not want users thinking that they are getting the benefit
>     of nohz when their machine can not support it.
>
>     Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>     Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     Cc: Ingo Molnar <mingo@kernel.org>
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: H. Peter Anvin <hpa@zytor.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Borislav Petkov <bp@alien8.de>
>     Cc: Li Zhong <zhong@linux.vnet.ibm.com>
>     Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
>
> This log was removed from the kernel in commit
>
> commit 4f49b90abb4aca6fe677c95fc352fd0674d489bd
> Author: Frederic Weisbecker <fweisbec@gmail.com>
> Date:   Wed Jul 22 17:03:52 2015 +0200
>
>     sched-clock: Migrate to use new tick dependency mask model
>
>     Instead of checking sched_clock_stable from the nohz subsystem to
> verify
>     its tick dependency, migrate it to the new mask in order to include it
>     to the all-in-one check.
>
>
> and it seems to me that the removal of the log defeats the purpose that
> commit e12d0271774fea9fddf tried to serve.
>
> Please enlighten me as to how to achieve this and I will cook up
> something.
>
> Ani
