Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BACC315010
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBINVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhBINVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:21:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36B2C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:20:50 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v5so26070983lft.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIznuqPDc4WvcNIY4tnB8bV1t0R6wmMK7Ffi0fzjZEQ=;
        b=C/E0faOCxk4xQrO0aiwFquOnSAhJYhpZuGttCkoUkFavB30QPrcW6ne5ED10uVTMXR
         4ZaHUIuJvib/g79QGrqZVVhF8EUzAS7M1YArw7y6C0QWKVxmMrz+3wlkT9BzfK5h+ZOG
         /pPSV7FSxr4TWgFWDDZpZIgObO7Q0fBdO5tMPaQNz81nx87H3E5Z73EHuVlJuss63ziZ
         u0vhjTEe6rrakrCufegj9+5Ii6gJbm6KujFWD6ILQgBXYk2MabWZl60zmU6owA2jovQK
         q1jhiay7GNEh/szULghLlJtFq4FE+gaWi6flPXHUfpeTcM8jZzF735LZ3+zDjC0XoFhQ
         3ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIznuqPDc4WvcNIY4tnB8bV1t0R6wmMK7Ffi0fzjZEQ=;
        b=LDrLwXrSZenn3zKdeoMeBxhWPyNhiJPpqJ7IvmG+2gs2+MdaOOfmmaHkFAicUwa0nu
         g4qYOwpL8L84TeIUKJXw0IIhtyTCX0SppMpqUglRwGCJc2p8Kpc3XAZRtCDKhiBF23DX
         XtuX1FH3dbcwy+W57W5E38PDlhtC82tCDPlemFfG6ZpiilSnszNoDLHCwfUFxizS/Ba5
         NAZMzT4CI7xuOyy3EWRY6mwOH7RyiGDZfMT11yJKkZdXQ+NuIRxXLU0RXQaVDMKVsIul
         Ou/agdWRBodOG4+1nyKK/rxfScvw2YkH+GrYtF+i0hzwI7Xorsqp7L3DM0KUlDw4sIbZ
         tjbQ==
X-Gm-Message-State: AOAM533ISDwkngBQ4vQfjRjSPKu0Qb2roA3ZFzfv5g2JXMj1Vqx6jBXY
        KXD1f3NX7PBr3wmd/TqvE3MT/vV1Hu0npnAxOwgozg==
X-Google-Smtp-Source: ABdhPJxs1pr4mI2kLiN7Co8XXgPiIKlqJT6W2VWXBfz+FqdLim18H8LJzWDw1ViqHpFQAw3e5p4DURiWK8mWtZq4Sxs=
X-Received: by 2002:ac2:5e62:: with SMTP id a2mr5637826lfr.277.1612876848252;
 Tue, 09 Feb 2021 05:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20210205114830.781-1-vincent.guittot@linaro.org>
 <20210205114830.781-2-vincent.guittot@linaro.org> <jhjv9b1tmkf.mognet@arm.com>
In-Reply-To: <jhjv9b1tmkf.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Feb 2021 14:20:37 +0100
Message-ID: <CAKfTPtCA79t5Sk18Bv7B_Jn3Ne5r4rxcvRWBurUG6x-Oqwu_DQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] sched/fair: remove update of blocked load from newidle_balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 14:09, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 05/02/21 12:48, Vincent Guittot wrote:
> > @@ -10517,16 +10499,11 @@ static void nohz_newidle_balance(struct rq *this_rq)
> >           time_before(jiffies, READ_ONCE(nohz.next_blocked)))
> >               return;
> >
>
> I was wondering whether all the conditions above were still relevant. I
> think they are, but this one:
>
>         /* Will wake up very soon. No time for doing anything else*/
>         if (this_rq->avg_idle < sysctl_sched_migration_cost)
>                 return;
>
> should have its comment updated to something like:
>
>         /*
>          * Will wake up very soon. Blocked load will be updated
>          * periodically, no need to wake an idle CPU.
>          */
>
> given kick_ilb() isn't the costliest of things.
>
> > -     raw_spin_unlock(&this_rq->lock);
> >       /*
> > -      * This CPU is going to be idle and blocked load of idle CPUs
> > -      * need to be updated. Run the ilb locally as it is a good
> > -      * candidate for ilb instead of waking up another idle CPU.
> > -      * Kick an normal ilb if we failed to do the update.
> > +      * Blocked load of idle CPUs need to be updated.
> > +      * Kick an ILB to update statistics.
> >        */
> > -     if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
> > -             kick_ilb(NOHZ_STATS_KICK);
> > -     raw_spin_lock(&this_rq->lock);
>
> With this change, the return value of _nohz_idle_balance() is no longer
> used. This means we could get rid of the tracking of whether it iterated
> over all nohz CPUs or not.

Yeah, the return is useless now

>
> > +     kick_ilb(NOHZ_STATS_KICK);
> >  }
> >
> >  #else /* !CONFIG_NO_HZ_COMMON */
