Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4BE44577F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhKDQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhKDQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:52:33 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1A1C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:49:54 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v7so16045405ybq.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QabbAqludQBd2cntTsivxnKMmyKzSq83t/rXQp4d2RE=;
        b=ODMmFNb8SeN3M1atyRIBI6YqcOdrIzinbW1VLjGQtRtDfNJV+Gz+G0I6AoRYCoPFoz
         KfOt+a4/X9aH2VfWy1N+tH/mGIa3K5avo2UK1+HCHy2JFarbcZPbMLTcRnhk2H4qtNz0
         3+tTBNz1S/WYCO0BHQ2Rja5kuCjCfadYYUJy3pSrS2nVzLPTpOOYi7LyX5JGdWRkMsMk
         rzk/oBV8ZH8oeOKovbkxhZwAIskC+rl2A+USyoyz8lCNrfx9JyEcntizFyay4au8jcbU
         OqyQewPIDNh/YkcMtwICjt8qLRynfuQadTbgbpgbpBMm/MogF6ATxWkh/BGznQ8ywsye
         89Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QabbAqludQBd2cntTsivxnKMmyKzSq83t/rXQp4d2RE=;
        b=qJVdPtrKHk76PGDak4omNKnpY5/ZgMERs/S85JeE5H6Fh5ZmQDmX1IAjrrLO8RH5LB
         t98MrbHMNP6ALNQ4Givp7RmvgWVmQqkcwhF9joymTkl2/wa2zF8mOGcQ5IgODM5V+RXK
         PkOe7k/rLKH1MaWcQrlkwRw9/01x4owYxlEmBB9gXVFC94Uw0O3NDFiQ4J8mS8UJ5IGc
         gZ+Z2VHP6A5WBckJwPcYKfrDeii7vyBYIVHva5i5om0PQr1nluB1mQqidsHBS+HhUnx9
         r9QYYmxObR2tKLpBvCj1oGjBSD7rkT50Psy+iJSV7+KgSjiYF5PynBwu1wYoXfdvmmkg
         XeAw==
X-Gm-Message-State: AOAM530rKqfUOE+7S8A6fS1tf5HvbeczHDCqaazZew6h1W0A+9Oqqc8f
        BM9peApRvBGr/LdoXjGBzjfPQH8z852Qmh2NquBJ0A==
X-Google-Smtp-Source: ABdhPJwioKY6rXX5BwHSayQ3R/3/MVVY8rWgBV87vc+a4aNukfhqe3EsjgHfXd9RwsCUQN1bfEgwSxkqo33SXwwuqKw=
X-Received: by 2002:a5b:d50:: with SMTP id f16mr44332433ybr.350.1636044594122;
 Thu, 04 Nov 2021 09:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net> <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com> <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
In-Reply-To: <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 4 Nov 2021 17:49:42 +0100
Message-ID: <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining cfs_rq's
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Benjamin Segall <bsegall@google.com>,
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

On Thu, 4 Nov 2021 at 16:13, Mathias Krause <minipli@grsecurity.net> wrote:
>
> Am 04.11.21 um 09:50 schrieb Vincent Guittot:
> > On Wed, 3 Nov 2021 at 23:04, Benjamin Segall <bsegall@google.com> wrote=
:
> >>
> >> Mathias Krause <minipli@grsecurity.net> writes:
> >>
> >>> Kevin is reporting crashes which point to a use-after-free of a cfs_r=
q
> >>> in update_blocked_averages(). Initial debugging revealed that we've l=
ive
> >>> cfs_rq's (on_list=3D1) in an about to be kfree()'d task group in
> >>> free_fair_sched_group(). However, it was unclear how that can happen.
> >>> [...]
> >>> Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list o=
n unthrottle")
> >>> Cc: Odin Ugedal <odin@uged.al>
> >>> Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
> >>> Reported-by: Kevin Tanguy <kevin.tanguy@corp.ovh.com>
> >>> Suggested-by: Brad Spengler <spender@grsecurity.net>
> >>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> >>> ---
> >>>  kernel/sched/core.c | 18 +++++++++++++++---
> >>>  1 file changed, 15 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >>> index 978460f891a1..60125a6c9d1b 100644
> >>> --- a/kernel/sched/core.c
> >>> +++ b/kernel/sched/core.c
> >>> @@ -9506,13 +9506,25 @@ void sched_offline_group(struct task_group *t=
g)
> >>>  {
> >>>       unsigned long flags;
> >>>
> >>> -     /* End participation in shares distribution: */
> >>> -     unregister_fair_sched_group(tg);
> >>> -
> >>> +     /*
> >>> +      * Unlink first, to avoid walk_tg_tree_from() from finding us (=
via
> >>> +      * sched_cfs_period_timer()).
> >>> +      */
> >>>       spin_lock_irqsave(&task_group_lock, flags);
> >>>       list_del_rcu(&tg->list);
> >>>       list_del_rcu(&tg->siblings);
> >>>       spin_unlock_irqrestore(&task_group_lock, flags);
> >>> +
> >>> +     /*
> >>> +      * Wait for all pending users of this task group to leave their=
 RCU
> >>> +      * critical section to ensure no new user will see our dying ta=
sk
> >>> +      * group any more. Specifically ensure that tg_unthrottle_up() =
won't
> >>> +      * add decayed cfs_rq's to it.
> >>> +      */
> >>> +     synchronize_rcu();
> >>
> >> I was going to suggest that we could just clear all of avg.load_sum/et=
c, but
> >> that breaks the speculative on_list read. Currently the final avg upda=
te
> >> just races, but that's not good enough if we wanted to rely on it to
> >> prevent UAF. synchronize_rcu() doesn't look so bad if the alternative =
is
> >> taking every rqlock anyways.
> >>
> >> I do wonder if we can move the relevant part of
> >> unregister_fair_sched_group into sched_free_group_rcu. After all
> >> for_each_leaf_cfs_rq_safe is not _rcu and update_blocked_averages does
> >> in fact hold the rqlock (though print_cfs_stats thinks it is _rcu and
> >> should be updated).
> >
> > I was wondering the same thing.
> > we would have to move unregister_fair_sched_group() completely in
> > sched_free_group_rcu() and probably in cpu_cgroup_css_free() too.
>
> Well, the point is, print_cfs_stats() pretty much relies on the list to
> be stable, i.e. safe to traverse. It doesn't take locks while walking it
> (beside the RCU lock), so if we would modify it concurrently, bad things
> would happen.
>
> Now, all manipulations of &cfs_rq->leaf_cfs_rq_list happen via the
> list_*_rcu() variants, so that assumption in print_cfs_stats() is
> actually sound -- the list chain can be walked without fearing to
> dereference bad pointers. But if we would move the unchaining of
> cfs_rq's down to sched_free_group_rcu() (or free_fair_sched_group(), as
> that gets called more or less directly from sched_free_group_rcu()), we
> would have the unchaining and kfree() of cfs_rq's in the same RCU GP.
> Or, ignoring RCU for a moment, print_cfs_stats() may see a cfs_rq on one
> CPU we're about to kfree() on the other. So, at least, the
> kfree(tg->cfs_rq[i]) would need to become a kfree_rcu(). But likely all
> the others as well, as print_cfs_stats() looks at cfs_rq->tg and
> cfs_rq->tg->se[cpu], too.
>
> > remove_entity_load_avg(tg->se[cpu]); has to be called only once we are
> > sure that se->my_q will not be updated which means no more in the
> > leaf_list
>
> And that would be only be after tq was unlinked in sched_offline_group()
> so walk_tg_tree_from() can't find it any more (to prevent re-linking the
> cfs_rq) and after unregister_fair_sched_group() has run. But between the
> two an RCU GP is needed. We can, sure, use the existing one by moving
> unregister_fair_sched_group() to sched_free_group_rcu() /
> cpu_cgroup_css_free(). But then we also need another RCU GP after that,
> prior to releasing the involved objects, to ensure print_cfs_stats()
> won't be the new UAF subject.

Ok so we must have 2 GPs:

list_del_rcu(&tg->siblings);
GP to wait for the end of ongoing walk_tg_tree_from : synchronize_rcu
in your patch
list_del_leaf_cfs_rq(tg->cfs_rq[cpu]); if on_list
remove_entity_load_avg(tg->se[cpu]);
GP to wait for the end of ongoing for_each_leaf_cfs_rq_safe (print_cfs_stat=
s)
kfree everything


>
> Thanks,
> Mathias
