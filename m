Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB436DD3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbhD1QmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhD1QmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:42:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09185C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:41:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s9so15085680ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUbv4f5CvbncylTUGm2hmfl3UwHHyXV3G4kL5c2bXBk=;
        b=Eg9Jcc8vAoAZiyqLbJQPP7DTOIDtB1t78Ur3oPM2/BGj7kVYDIZENzBSrAfV3xC/A7
         MsTwdPqYVbJ3Cr+k/1AlwPaVo4mvyDoPvr8dO/5rLXLiUddC5sqSsDOxVtAqfRueRAbK
         nGATtnFYvvgt7iOWfRF2bPAXJZtdsDPKwz9a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUbv4f5CvbncylTUGm2hmfl3UwHHyXV3G4kL5c2bXBk=;
        b=t5YUs5YdcrZMWcE+0XfYLapNk89aFh5u3GxThwXg2dLNwNRjoDO5ErjKWOc/X7uoW7
         EJwcXPMWblT/p+qNznP26bEiMpCryVkcm/A/fNUW2BL84lxtR9em3v1Pj9wQjfbh+Z6V
         3JGi7Tp6WJSOx/pyzP8qOGKjGlz1m52oG3c5ThVjnblC85Fw9xXk+DvzdFI/pvivsnWi
         F0c98d6Z90nRkWFRXMCI1Rn+Z95bdEsKvHONiOUy1u/ZdUD4iNmz6TnlSJGrTLlVvAy7
         vohzzrkgfQgm/s4VhFuDpxP6Hphlob1QUlg2NsyxEvG5WktZqnb9IFGGlCyf9AvrFkJ8
         aCqw==
X-Gm-Message-State: AOAM531vHjAt3BJWiDwlRltJReOSHBM5fwQmQ5riR4XQQlDD2gCLRjWm
        ivVvUNsUjS11qh/7H3+7PzqzehEJtjWR/h+pbVTuJw==
X-Google-Smtp-Source: ABdhPJzrfhDbjKlzifTHWXjAXjmfZqZjD/zCcP8FQ2mXWj0nhlodGBTG1ZkPNroyeoy/mRQcLl12f3oq3LffxGQo9U8=
X-Received: by 2002:a2e:9d94:: with SMTP id c20mr21368574ljj.49.1619628080097;
 Wed, 28 Apr 2021 09:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
 <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
 <CAERHkrvU2Xzi5p9Dph3zZ7zkoYjSV1krK-UhqE7+Qb80FodEGg@mail.gmail.com>
 <5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com> <CAERHkrsoCR7d3N2rhwKCeFDDBv4-S4HzD567mOaV_pngXn_Hkg@mail.gmail.com>
In-Reply-To: <CAERHkrsoCR7d3N2rhwKCeFDDBv4-S4HzD567mOaV_pngXn_Hkg@mail.gmail.com>
From:   Don Hiatt <dhiatt@digitalocean.com>
Date:   Wed, 28 Apr 2021 09:41:08 -0700
Message-ID: <CAOY2WowOR6HhoKMsGrg+2VFD6ySY67E7Kr1s2GCuO4LdyusyUw@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Josh Don <joshdon@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 3:57 AM Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> On Wed, Apr 28, 2021 at 2:05 PM Aubrey Li <aubrey.li@linux.intel.com> wrote:
> >
> > On 4/28/21 9:03 AM, Aubrey Li wrote:
> > > On Wed, Apr 28, 2021 at 7:36 AM Josh Don <joshdon@google.com> wrote:
> > >>
> > >> On Tue, Apr 27, 2021 at 10:10 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
> > >>> Hi Josh and Peter,
> > >>>
> > >>> I've been running into soft lookups and hard lockups when running a script
> > >>> that just cycles setting the cookie of a group of processes over and over again.
> > >>>
> > >>> Unfortunately the only way I can reproduce this is by setting the cookies
> > >>> on qemu. I've tried sysbench, stress-ng but those seem to work just fine.
> > >>>
> > >>> I'm running Peter's branch and even tried the suggested changes here but
> > >>> still see the same behavior. I enabled panic on hard lockup and here below
> > >>> is a snippet of the log.
> > >>>
> > >>> Is there anything you'd like me to try or have any debugging you'd like me to
> > >>> do? I'd certainly like to get to the bottom of this.
> > >>
> > >> Hi Don,
> > >>
> > >> I tried to repro using qemu, but did not generate a lockup. Could you
> > >> provide more details on what your script is doing (or better yet,
> > >> share the script directly)? I would have expected you to potentially
> > >> hit a lockup if you were cycling sched_core being enabled and
> > >> disabled, but it sounds like you are just recreating the cookie for a
> > >> process group over and over?
> > >>
> > >
> > > I saw something similar on a bare metal hardware. Also tried the suggested
> > > patch here and no luck. Panic stack attached with
> > > softlockup_all_cpu_backtrace=1.
> > > (sorry, my system has 192 cpus and somehow putting 184 cpus offline causes
> > > system hang without any message...)
> >
> > Can you please try the following change to see if the problem is gone on your side?
> >
>
> Please ignore this patch, as the change of double_rq_unlock() in
> Peter's last patch
> fixed the problem.
>
> Thanks,
> -Aubrey
>
I'm still seeing hard lockups while repeatedly setting cookies on qemu
processes even with
the updated patch. If there is any debug you'd like me to turn on,
just let me know.

Thanks!

don



> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f732642e3e09..1ef13b50dfcd 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -493,14 +493,17 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
> >  {
> >         lockdep_assert_irqs_disabled();
> >
> > -       if (rq1->cpu > rq2->cpu)
> > -               swap(rq1, rq2);
> > -
> > -       raw_spin_rq_lock(rq1);
> > -       if (__rq_lockp(rq1) == __rq_lockp(rq2))
> > -               return;
> > -
> > -       raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> > +       if (__rq_lockp(rq1) == __rq_lockp(rq2)) {
> > +               raw_spin_rq_lock(rq1);
> > +       } else {
> > +               if (__rq_lockp(rq1) < __rq_lockp(rq2)) {
> > +                       raw_spin_rq_lock(rq1);
> > +                       raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> > +               } else {
> > +                       raw_spin_rq_lock(rq2);
> > +                       raw_spin_rq_lock_nested(rq1, SINGLE_DEPTH_NESTING);
> > +               }
> > +       }
> >  }
> >  #endif
> >
