Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077E744509D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKDIxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDIxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:53:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09503C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 01:50:57 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j75so12810544ybj.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=luSg9Qb/tGHJq8+n6BC8TW6q6YdjF45KbC8DWD2+zqQ=;
        b=ny+I01M6DfzMT7XHSua+Juj0IjpRWPch8jPbIjYywjbDsCpTbgC56dZ6bahJl76/G6
         lXg9yMQ+OwXWDMssQ79DhLQLQ77trUoXuje4T6+hxUw/1rebLqRc0IgmKYFOJvWUIz3z
         oy63K6zx3y/yD0ix3tQGigXDju9Kl9a1kbs5+/IiMk13lm7EZuIst8F0pBx8iXNdvp0w
         T8uVeVz0ivq64whQik5wxvyOmV5vqD5MJmAG61G7n2GNh25EVL7pXBbikoqvdMZ+kRFm
         xZFtqV1GLpkL/LOFQykHllMCcGJ6g+EusOKnmQfnJFksejnMhQBvs+gP0OyFV2yvl3kp
         cenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=luSg9Qb/tGHJq8+n6BC8TW6q6YdjF45KbC8DWD2+zqQ=;
        b=zlUZ+roqzyWwdFf7VVhcnf/G8bt8lPaoEvhysJaqIMyFLcHNHHrPXrX1kVkY1P3D7s
         ay/cu/Yp1+7vZfHeacc/IMZdsZsHmch6yBWTBVjA4527kG1stGGKQP9iYlXRvJN/ia/u
         4HyJrQIJrsU4m3KKQmWwEpgT/j5D3nggvtP4nbTFCQU7P0s/cCSB39eBqSeEc5InWqSi
         Yetgbfias4lk2ReOXjktPcU7hsEEvekOvGKgro0yJ4fFRBxF3fhVt2KWdtKtJ466Dzt/
         P9ZJQXTFxrRkyf2ynLEiTk0nR9e2g4toI/j8SWEERhUQ6ZBSqUlvfcTqsh3YCtoMXndD
         /Gzw==
X-Gm-Message-State: AOAM5326eFpXALV5URsO0nrITuPI/OxwvTlGV4nUqSnGeqMaV+OQC5YI
        xuNA5y/8V/IuqgPwqES7KjSPpUcfxuc4pmyEwCAWZA==
X-Google-Smtp-Source: ABdhPJwt7UJolzZM3PiHWk+eYKuQoV/F3AMll+wKOejDKzWMkKnOm4QSVz07b7XUoVjxBV1HS4sQcUM5IhD/6l4rl1M=
X-Received: by 2002:a25:dc42:: with SMTP id y63mr18448828ybe.402.1636015856185;
 Thu, 04 Nov 2021 01:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net> <xm26ilx86gmp.fsf@google.com>
In-Reply-To: <xm26ilx86gmp.fsf@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 4 Nov 2021 09:50:44 +0100
Message-ID: <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining cfs_rq's
To:     Benjamin Segall <bsegall@google.com>
Cc:     Mathias Krause <minipli@grsecurity.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2021 at 23:04, Benjamin Segall <bsegall@google.com> wrote:
>
> Mathias Krause <minipli@grsecurity.net> writes:
>
> > Kevin is reporting crashes which point to a use-after-free of a cfs_rq
> > in update_blocked_averages(). Initial debugging revealed that we've liv=
e
> > cfs_rq's (on_list=3D1) in an about to be kfree()'d task group in
> > free_fair_sched_group(). However, it was unclear how that can happen.
> > [...]
> > Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on =
unthrottle")
> > Cc: Odin Ugedal <odin@uged.al>
> > Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
> > Reported-by: Kevin Tanguy <kevin.tanguy@corp.ovh.com>
> > Suggested-by: Brad Spengler <spender@grsecurity.net>
> > Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> > ---
> >  kernel/sched/core.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 978460f891a1..60125a6c9d1b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9506,13 +9506,25 @@ void sched_offline_group(struct task_group *tg)
> >  {
> >       unsigned long flags;
> >
> > -     /* End participation in shares distribution: */
> > -     unregister_fair_sched_group(tg);
> > -
> > +     /*
> > +      * Unlink first, to avoid walk_tg_tree_from() from finding us (vi=
a
> > +      * sched_cfs_period_timer()).
> > +      */
> >       spin_lock_irqsave(&task_group_lock, flags);
> >       list_del_rcu(&tg->list);
> >       list_del_rcu(&tg->siblings);
> >       spin_unlock_irqrestore(&task_group_lock, flags);
> > +
> > +     /*
> > +      * Wait for all pending users of this task group to leave their R=
CU
> > +      * critical section to ensure no new user will see our dying task
> > +      * group any more. Specifically ensure that tg_unthrottle_up() wo=
n't
> > +      * add decayed cfs_rq's to it.
> > +      */
> > +     synchronize_rcu();
>
> I was going to suggest that we could just clear all of avg.load_sum/etc, =
but
> that breaks the speculative on_list read. Currently the final avg update
> just races, but that's not good enough if we wanted to rely on it to
> prevent UAF. synchronize_rcu() doesn't look so bad if the alternative is
> taking every rqlock anyways.
>
> I do wonder if we can move the relevant part of
> unregister_fair_sched_group into sched_free_group_rcu. After all
> for_each_leaf_cfs_rq_safe is not _rcu and update_blocked_averages does
> in fact hold the rqlock (though print_cfs_stats thinks it is _rcu and
> should be updated).

I was wondering the same thing.
we would have to move unregister_fair_sched_group() completely in
sched_free_group_rcu() and probably in cpu_cgroup_css_free() too.

remove_entity_load_avg(tg->se[cpu]); has to be called only once we are
sure that se->my_q will not be updated which means no more in the
leaf_list

>
>
> > +
> > +     /* End participation in shares distribution: */
> > +     unregister_fair_sched_group(tg);
> >  }
> >
> >  static void sched_change_group(struct task_struct *tsk, int type)
