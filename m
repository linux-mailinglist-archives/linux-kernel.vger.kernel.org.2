Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D74936D603
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbhD1K6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbhD1K6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:58:18 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F37C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 03:57:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id g8so1361926ybo.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVsQoqxgVQQxizb2GTtYnxEmKQWFzBXa5NI/YG9jJOI=;
        b=q6BTBIQZdUXml2HO7nE7BhtXrDBju0r7rYV9z4zUA8ERla3/+v28aorCaEZOUpy9oD
         GqD92cWVvVhxn92GC90CIa8mCrbZOfBzVx1Kc8bPL6hy21H7kL3MZiQiP5B9WcefyvJF
         bfma/6hseLJq6jJn7rHYBWQ5WIR6LnvYMl9GJMUH0xpvolwqg35UYVIIr5mFXpn/6Xua
         nAEAP5QCdGSRrHq5OD+J8lCs264947S0B4Aa3bbIwBp0SAdrXJRYMJtehVbDFO06hWYr
         DWVNaqFiAtDQHpkx8eV3vd7GZJMBcu3IXf6U/6ZUy3e3hP3fWZ98fBTOmFOHub4IGxAT
         ATLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVsQoqxgVQQxizb2GTtYnxEmKQWFzBXa5NI/YG9jJOI=;
        b=kVOZsz57/i7yPs4Gktb51s1PoDYFDCeKcS3fV1i/NaAfpPqVft1+TSSG7domSEf0Ac
         dXDl0AAqiFc6XNWJ/LNBYzw91ci5p3irFXritjM8o7kYYcsxZyZR9wGNvf4hmDkBs61l
         B7Y9/5rU+E5w2D1fJCHaRMQdlzt9Q0/5y8yNvEH5p43VW4Xxq91ejZeBG2/fk4kT837l
         945LBkoAMqyIhTyb9OGYnfSTkwCx7hHJHaK/RrAVRHiZeq/RZvPfy/UGQKmwtZODO7HE
         82EljS/XFbx5dpk32nPb4of3vok+MZVldCWwTYh2bIamc9JcPRxExbJPbBjrTaXYbcgE
         Uf4w==
X-Gm-Message-State: AOAM531GcXBN6mh/z+6YoD53WP6BspQ/slBBCVuTIX5eg/QYQ69sTcie
        eLPshg0I1re/PwTxLee/5NFjvESj0GycKdMBeeM=
X-Google-Smtp-Source: ABdhPJxhPlJRm7N6hvEXbjZ3cSzNd2YIM0hasZ9IUL3aHYA/PTEepFY38RUNijHd3XP4jrkgtDGPVeZeosw8rgfHdus=
X-Received: by 2002:a25:6b51:: with SMTP id o17mr40634150ybm.149.1619607452629;
 Wed, 28 Apr 2021 03:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
 <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
 <CAERHkrvU2Xzi5p9Dph3zZ7zkoYjSV1krK-UhqE7+Qb80FodEGg@mail.gmail.com> <5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com>
In-Reply-To: <5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 28 Apr 2021 18:57:21 +0800
Message-ID: <CAERHkrsoCR7d3N2rhwKCeFDDBv4-S4HzD567mOaV_pngXn_Hkg@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     Josh Don <joshdon@google.com>, Don Hiatt <dhiatt@digitalocean.com>,
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

On Wed, Apr 28, 2021 at 2:05 PM Aubrey Li <aubrey.li@linux.intel.com> wrote:
>
> On 4/28/21 9:03 AM, Aubrey Li wrote:
> > On Wed, Apr 28, 2021 at 7:36 AM Josh Don <joshdon@google.com> wrote:
> >>
> >> On Tue, Apr 27, 2021 at 10:10 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
> >>> Hi Josh and Peter,
> >>>
> >>> I've been running into soft lookups and hard lockups when running a script
> >>> that just cycles setting the cookie of a group of processes over and over again.
> >>>
> >>> Unfortunately the only way I can reproduce this is by setting the cookies
> >>> on qemu. I've tried sysbench, stress-ng but those seem to work just fine.
> >>>
> >>> I'm running Peter's branch and even tried the suggested changes here but
> >>> still see the same behavior. I enabled panic on hard lockup and here below
> >>> is a snippet of the log.
> >>>
> >>> Is there anything you'd like me to try or have any debugging you'd like me to
> >>> do? I'd certainly like to get to the bottom of this.
> >>
> >> Hi Don,
> >>
> >> I tried to repro using qemu, but did not generate a lockup. Could you
> >> provide more details on what your script is doing (or better yet,
> >> share the script directly)? I would have expected you to potentially
> >> hit a lockup if you were cycling sched_core being enabled and
> >> disabled, but it sounds like you are just recreating the cookie for a
> >> process group over and over?
> >>
> >
> > I saw something similar on a bare metal hardware. Also tried the suggested
> > patch here and no luck. Panic stack attached with
> > softlockup_all_cpu_backtrace=1.
> > (sorry, my system has 192 cpus and somehow putting 184 cpus offline causes
> > system hang without any message...)
>
> Can you please try the following change to see if the problem is gone on your side?
>

Please ignore this patch, as the change of double_rq_unlock() in
Peter's last patch
fixed the problem.

Thanks,
-Aubrey

>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f732642e3e09..1ef13b50dfcd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -493,14 +493,17 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
>  {
>         lockdep_assert_irqs_disabled();
>
> -       if (rq1->cpu > rq2->cpu)
> -               swap(rq1, rq2);
> -
> -       raw_spin_rq_lock(rq1);
> -       if (__rq_lockp(rq1) == __rq_lockp(rq2))
> -               return;
> -
> -       raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> +       if (__rq_lockp(rq1) == __rq_lockp(rq2)) {
> +               raw_spin_rq_lock(rq1);
> +       } else {
> +               if (__rq_lockp(rq1) < __rq_lockp(rq2)) {
> +                       raw_spin_rq_lock(rq1);
> +                       raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> +               } else {
> +                       raw_spin_rq_lock(rq2);
> +                       raw_spin_rq_lock_nested(rq1, SINGLE_DEPTH_NESTING);
> +               }
> +       }
>  }
>  #endif
>
