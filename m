Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B5D406D81
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhIJOUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhIJOUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:20:51 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565B3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:19:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z18so4155780ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0OzOFuk4ubjeI+x60p6cW88fCENPpA30Niqgu5QX/9Q=;
        b=ZKu5a+2gk7BtVJuPGCSdPpHU5XS7LixsPoloNuLN60MuyFhRR4TVyFIUoEDHsbscSD
         m9L15LI7SlhnwNc4ol14QfMM3P0+ejpKh/XfPHmyPMMazQvU4d6JmMuXbuFAUQWPaHZ0
         Slmb2+ookvs/GDNrTIwE4Wpn31GaGFFpeQNUufST0hPnXKdI0cwDPSL3eIc3IwOLSjUz
         EJifdr8d8LZ9rLduglrvXv0+A25lm2/i9yllXJzT/0G4WMlerOzr8neh7xDTB+1OHlnG
         48Zo3uqj83vS2WESu8pGQUupO0qeL/I5bbSbOkJ49xtli8oBtngSGfaUn09ictbP4q4u
         V8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0OzOFuk4ubjeI+x60p6cW88fCENPpA30Niqgu5QX/9Q=;
        b=YZxlZJ0l4zqnHwxg/qQaM/CkIKwUWWUz0mgIi95qTpjje+WlMTBv+FOxCwYweATuW8
         QDlppFZIvgupt55wfk4MzWvjC3puC9aIfGMcNHyAmfQUgD8XGcNCkQRldlg+u1Ssw6A1
         XUBuRXQ5GxvEyokum7X27EFjBaAo6FAnk7rEzBnQGNzRIwpJwc/t88XGJqyvreZS/RpV
         1CoGuFrr+Xc3eWx0+uHryTBtnwD6JI70Eh1baxEpRWJT/hbd+Q/1u+2xIvqMxKSJGcow
         KUTcqyqGY4GAK4dxI4Vb7CyMEuotT8AsLL/5cKkmlDpufvRKZGmif9BUkUC8sKlUTZkq
         i8Gg==
X-Gm-Message-State: AOAM533Xxe4ZhFuWyHprmeA/we++aE1eYHiD1h/672ZRtV8v6A5JYz8b
        h3pvWo3un9Pd36slBx7sWKcyKYqjdF4jW/x/b7FTCQ==
X-Google-Smtp-Source: ABdhPJz9QimJxyuff1/kHqDGwMe5uKBanc22qaDwHIXS1GUQlleqkl3e0INMFJzPIvF6741Fve9uvVPpycVa6bqLxmY=
X-Received: by 2002:a25:9001:: with SMTP id s1mr11223592ybl.191.1631283579371;
 Fri, 10 Sep 2021 07:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-5-mkoutny@suse.com>
In-Reply-To: <20210819175034.4577-5-mkoutny@suse.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Sep 2021 16:19:27 +0200
Message-ID: <CAKfTPtCAxksmsR6DJuAoSZ7XTon+gesyic36EHL-nQk0LiHWQg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] sched/fair: Simplify load_cfs_rq_list maintenance
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 at 19:50, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> load_cfs_rq_list should contain cfs_rqs that have runnable entities in
> them.  When we're operating under a throttled hierarchy we always
> update the load_cfs_rq_list in order not to break list_add_load_cfs_rq
> invariant of adding complete branches.
>
> This caused troubles when an entity became runnable (enqueue_entity)
> under a throttled hierarchy (see commit b34cb07dde7c ("sched/fair: Fix
> enqueue_task_fair() warning some more")). (Basically when we add to the
> load list, we have to ensure all the ancestors are added and when
> deleting we have to delete whole subtree.)
>
> This patch simplifies the code by no updates of load_cfs_rq_list when
> we're operating under the throttled hierarchy and defers the
> load_cfs_rq_list update to the point when whole hierarchy is unthrottled
> (tg_unthrottle_up). Specifically, subtrees of a throttled cfs_rq are not
> decaying their PELT when they're being throttled (but the parent of the
> throttled cfs_rq is decayed).

Your proposal looks interesting but I need more time to make sure that
all cases are covered. We have faced several odd corner cases and
sequences in the past that I need time to check that you don't put
some back

>
> The code is now simpler and load_cfs_rq_list contains only cfs_rqs that
> have load to decay.
>
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  kernel/sched/fair.c | 58 ++++++++++-----------------------------------
>  1 file changed, 12 insertions(+), 46 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6f4d5d4dcdd9..9978485334ec 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3086,6 +3086,8 @@ void reweight_task(struct task_struct *p, int prio)
>         load->inv_weight =3D sched_prio_to_wmult[prio];
>  }
>
> +static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  #ifdef CONFIG_SMP
>  /*
> @@ -3196,8 +3198,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq=
)
>  }
>  #endif /* CONFIG_SMP */
>
> -static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
> -
>  /*
>   * Recomputes the group entity based on the current state of its group
>   * runqueue.
> @@ -4294,10 +4294,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int flags)
>
>         /*
>          * When bandwidth control is enabled, cfs might have been removed
> -        * because of a parent been throttled but cfs->nr_running > 1. Tr=
y to
> -        * add it unconditionally.
> +        * because of a parent been throttled. We'll add it later (with
> +        * complete branch up to se->on_rq/cfs_eq->on_list) in
> +        * tg_unthrottle_up() and unthrottle_cfs_rq().
>          */
> -       if (cfs_rq->nr_running =3D=3D 1 || cfs_bandwidth_used())
> +       if (cfs_rq->nr_running =3D=3D 1 && !throttled_hierarchy(cfs_rq))
>                 list_add_load_cfs_rq(cfs_rq);
>
>         if (cfs_rq->nr_running =3D=3D 1)
> @@ -4936,31 +4937,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto unthrottle_throttle;
> -
> -               /*
> -                * One parent has been throttled and cfs_rq removed from =
the
> -                * list. Add it back to not break the load list.
> -                */
> -               if (throttled_hierarchy(cfs_rq))
> -                       list_add_load_cfs_rq(cfs_rq);
>         }
>
>         /* At this point se is NULL and we are at root level*/
>         add_nr_running(rq, task_delta);
>
>  unthrottle_throttle:
> -       /*
> -        * The cfs_rq_throttled() breaks in the above iteration can resul=
t in
> -        * incomplete load list maintenance, resulting in triggering the
> -        * assertion below.
> -        */
> -       for_each_sched_entity(se) {
> -               cfs_rq =3D cfs_rq_of(se);
> -
> -               if (list_add_load_cfs_rq(cfs_rq))
> -                       break;
> -       }
> -
> +       /* See enqueue_task_fair:enqueue_throttle */
>         assert_list_load_cfs_rq(rq);
>
>         /* Determine whether we need to wake up potentially idle CPU: */
> @@ -5600,13 +5583,6 @@ enqueue_task_fair(struct rq *rq, struct task_struc=
t *p, int flags)
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto enqueue_throttle;
> -
> -               /*
> -                * One parent has been throttled and cfs_rq removed from =
the
> -                * list. Add it back to not break the load list.
> -                */
> -               if (throttled_hierarchy(cfs_rq))
> -                       list_add_load_cfs_rq(cfs_rq);
>         }
>
>         /* At this point se is NULL and we are at root level*/
> @@ -5630,21 +5606,11 @@ enqueue_task_fair(struct rq *rq, struct task_stru=
ct *p, int flags)
>                 update_overutilized_status(rq);
>
>  enqueue_throttle:
> -       if (cfs_bandwidth_used()) {
> -               /*
> -                * When bandwidth control is enabled; the cfs_rq_throttle=
d()
> -                * breaks in the above iteration can result in incomplete
> -                * load list maintenance, resulting in triggering the ass=
ertion
> -                * below.
> -                */
> -               for_each_sched_entity(se) {
> -                       cfs_rq =3D cfs_rq_of(se);
> -
> -                       if (list_add_load_cfs_rq(cfs_rq))
> -                               break;
> -               }
> -       }
> -
> +       /*
> +        * If we got here, subtree of a cfs_rq must have been throttled a=
nd
> +        * therefore we did not modify load list or we climbed up to root=
 (or
> +        * joined to an ancestor cfs_rq with on_rq =3D=3D 1 =3D> on_list)=
.
> +        */
>         assert_list_load_cfs_rq(rq);
>
>         hrtick_update(rq);
> --
> 2.32.0
>
