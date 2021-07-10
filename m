Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F53C3279
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 05:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhGJEAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 00:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhGJEA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 00:00:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE4C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 20:57:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t3so16882660edc.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 20:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KqSNIckkIKStvdKDE9v38SnA5B+iM/HTiHOk0YeVjo=;
        b=kn7dRf3+xq4jVNBo5/cA9EvwR/OIq9mBB3/WOm+eyfqwkIDfgqtJRg9dh4TanDy9NO
         KcyDWm1Nj9JyD1BmFZEUYfDCiFsDPNkRhVN7rUjjlCPYl///94WffrHWgxegCWdUNgJN
         t1qJ9mgBBscwPJKDbWhm9R3ZD9AovdHma/09Xr4Y5+3h96l+mF+LPKAIrlRb4fFAZLaU
         w9pHYunxXOHIMlEyhengwXEkZ5D+1hILy1F2iJ2qSuKky54NBAjZks6G4rZJ8HtvLfSu
         8Je52qW7b9/r2OUfkFOXnxQHt72tb0X466qtdXA9mFmUMZ5fLuY82TnJYxYkxAqd9Shr
         dHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KqSNIckkIKStvdKDE9v38SnA5B+iM/HTiHOk0YeVjo=;
        b=NpxbjX3s43VANp1ZniwS7LQP5v7IYMW5QJ+bWF62W9pJjDIRnxy04mr8seRpPty3OA
         dviRY9iBWouCUBnzFazB10Yz9mTQkQthCHTNSM53zFF36at+Az2F3I5rssFbn9GpZRf3
         CEHeznx5EPlAxxs08TFxr3SE3SGyjzAcgy+XoMSdBzvs+q+P3v2QltD1BxO/oUwqEp+M
         f0gmMGoJ28tIMgln21gbnmmvharTt0HWxfe8ZQes0Ldl+49cUM4JBilF3vA1sRku+xri
         0mRinCbcM+kfy+wbZARDNRWfSIwoRDPIGOvb1VKTiYWRsPtAnMaX7esFraoNYv6aOa96
         SFrQ==
X-Gm-Message-State: AOAM530wjnJhkAwLLEU9WGcpELgOx7Nt02+LYS6C/spGV3NkebjeAeGp
        ZHJNLwJPgCMKQdCDpp4Vc/4ppUT5WjcjqtiRYayuwA==
X-Google-Smtp-Source: ABdhPJzZndfFf/ApEeocUCZAL/67+z3aHCgtuF8yKX1ERhLk6Xei0RfZVgiZlnCPmdIPX9BSPj+jpIe1xrXX7jgzs2c=
X-Received: by 2002:a50:8e19:: with SMTP id 25mr27517762edw.11.1625889461442;
 Fri, 09 Jul 2021 20:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210627072833.2199463-1-ani@anisinha.ca> <87zguypgy8.ffs@nanos.tec.linutronix.de>
 <20210707104353.GA115752@lothringen>
In-Reply-To: <20210707104353.GA115752@lothringen>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Sat, 10 Jul 2021 09:27:31 +0530
Message-ID: <CAARzgwwQK4K7pyaXYu4fM+uKkfsg5U8JG0YXx=h9WuD63J_W7g@mail.gmail.com>
Subject: Re: [PATCH v1] Add info log when user enables NOHZ in commandline but
 NOHZ is not possible
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        anirban.sinha@nokia.com, Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 4:13 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Wed, Jul 07, 2021 at 12:16:15PM +0200, Thomas Gleixner wrote:
> > Ani,
> >
> > On Sun, Jun 27 2021 at 12:58, Ani Sinha wrote:
> >
> > same comment vs. Subject, 'this patch' and 'we'
> >
> > > @@ -930,6 +930,7 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
> > >  {
> > >  #ifdef CONFIG_NO_HZ_FULL
> > >     int cpu = smp_processor_id();
> > > +   static bool no_tick_warned;
> > >
> > >     if (!tick_nohz_full_cpu(cpu))
> > >             return;
> > > @@ -937,10 +938,24 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
> > >     if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
> > >             return;
> > >
> > > -   if (can_stop_full_tick(cpu, ts))
> > > +   if (can_stop_full_tick(cpu, ts)) {
> > >             tick_nohz_stop_sched_tick(ts, cpu);
> > > -   else if (ts->tick_stopped)
> > > -           tick_nohz_restart_sched_tick(ts, ktime_get());
> > > +           if (no_tick_warned) {
> > > +                   pr_info("NO_HZ_FULL is now enabled in the system.\n");
> > > +                   no_tick_warned = false;
> > > +           }
> > > +   } else {
> > > +           /*
> > > +            * Don't allow the user to think they can get
> > > +            * full NO_HZ with this machine.
> > > +            */
> > > +           if (!no_tick_warned && tick_nohz_full_running) {
> > > +                   pr_info("NO_HZ_FULL has been disabled in the system.");
> > > +                   no_tick_warned = true;
> > > +           }
> >
> > So this is going to emit this message everytime the NOHZ state of a CPU
> > changes, which is an easy to trigger dmesg flooding from unpriviledged
> > user space.
> >
> > Also the message is misleading because this is a per CPU condition and
> > not a system wide condition.
>
> IIUC, the clock can be marked unstable anytime before or after nohz_full
> is initialized.
>
> So we can do two things:
>
> * If tick_nohz_init() is called after the clock has been marked unstable,
>   just don't initialize nohz_full.
>
> * If the clock is marked unstable after tick_nohz_init(), issue a pr_warn()
>   from __clear_sched_clock_stable().

As Peter mentions in the other thread, there is already logging for
this transition in the work function. The reason why I sent these
patches was because I was seeing some issues on the hyperV platform
where the sched clock was seemingly marked unstable but no logging was
present. I have bisected that issue and it seems we should fix this
elsewhere, in the hyperV platform init code and not here by adding
more logging,  Tglx was right - this is per cpu state and we do see
some toggles between NOHZ enable and disable (some other condition
unrelated to sched clock stability). So adding logs here would add
more confusion and verbosity for reasons other than the one we wish to
alert users for. It would not add any value.

So this patch can be discarded.

Ani
