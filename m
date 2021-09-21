Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E02413A83
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhIUTIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhIUTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:08:24 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7F6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:06:55 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f22so895851qkm.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7OMkfQelNGCl57zqS63PlSYBROkN/4uCxQ+DW/eYiFg=;
        b=iZ5AxNBqYc1MyJKzqQ4wJs4OdR1fL3WUnzJv7ab3dCw8SFZceoN9f8LmnpUuTn+JdN
         ic04XUcwQpVgkGeYcj0s6UgaGCWuEzf7s9GKQtXGQJo+aImA97LMt7NuQ2juD5VOlK3l
         aEQvz82/ZxUXpj0oXBHCAdTanILu8bK85vhLC4PiVCqRVQgBH7qTEjH6oBmHT6FA2giM
         nb3NLEa0pQ9fj2AzXNbcCiMZd9jno15YcRLgd9Bp5FEKGqOfp+NN9ZUKI2c4spejMBf2
         CUuhjzPxMrT3ArOFTmiEVEBX/py927hRew6Vne1dGSTvJwRvvnpxjlxVLtpOSA+cZi7t
         I0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7OMkfQelNGCl57zqS63PlSYBROkN/4uCxQ+DW/eYiFg=;
        b=setjEt7ahV4wxIbEqLhiMbjW+r4YzinR1TUoTYO2w3H1BLZyzAJYcoz2swlhT7hNRr
         0FaqCj4APLrkVg2C79RE5nvW9ib2pbQAl2Q/CsnuRVLO9J4fW5aEPjxqg0YpurU0Tnaw
         kYKoHs/8UyEkv3u8l2Zo1E8aAIF/FlkMBgD2+e84WXED9SvkIDbtscUF6MyqwvoWlrzk
         3tIeLJ3o8BPqUNF4yLHjDwVNa80DyoPEe3s9/1ofy9Lp9Vm6qZjPeiI+l6zjq0llX2mm
         n55cpODH7i/qXn9212fef1ZdfiDTJLQdF/zzlqjNuU1weluCo0GN+IeXek6up+Lucy+l
         NgBQ==
X-Gm-Message-State: AOAM530LNJ8NLGVFQS04jyAirD7PD6S2M7zO5PwTwYPiwD7nawwIAKtT
        fPdYsoBuVoML1K/K/JP1s0AWubikhSMr5EU214L7hg==
X-Google-Smtp-Source: ABdhPJxwG7jI7TOe3p6jvPK4Qor7QB5aRidsYeUiCZfbTmfybozkZ2CrGTnBHGiC2Kn76252XjiOsjFW+i5rRf85who=
X-Received: by 2002:a37:9bd2:: with SMTP id d201mr28317539qke.456.1632251214340;
 Tue, 21 Sep 2021 12:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-4-mkoutny@suse.com>
In-Reply-To: <20210819175034.4577-4-mkoutny@suse.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Tue, 21 Sep 2021 20:06:40 +0100
Message-ID: <CAFpoUr36x44xRpU0CH3sVYNNt9n3JyUuPpWGSzPyH4OWbX8VpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] sched/fair: Rename leaf_list to more fitting load_list
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

tor. 19. aug. 2021 kl. 18:50 skrev Michal Koutn=C3=BD <mkoutny@suse.com>:
>
> The leaf_list name is obsolete and misleading. The list is nowadays used
> to hold cfs_rqs with non-zero PELT that has to be decayed to properly
> account for blocked tasks. Those can be inner nodes of the task_group
> tree as well.
>
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  kernel/sched/core.c  |   4 +-
>  kernel/sched/fair.c  | 114 +++++++++++++++++++++----------------------
>  kernel/sched/sched.h |  17 +++----
>  3 files changed, 65 insertions(+), 70 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 20ffcc044134..e55a7c898cd9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8961,8 +8961,8 @@ void __init sched_init(void)
>                 init_rt_rq(&rq->rt);
>                 init_dl_rq(&rq->dl);
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -               INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
> -               rq->tmp_alone_branch =3D &rq->leaf_cfs_rq_list;
> +               INIT_LIST_HEAD(&rq->load_cfs_rq_list);
> +               rq->tmp_alone_branch =3D &rq->load_cfs_rq_list;
>                 /*
>                  * How much CPU bandwidth does root_task_group get?
>                  *
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 905f95b91a7a..6f4d5d4dcdd9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -286,13 +286,13 @@ static inline void cfs_rq_tg_path(struct cfs_rq *cf=
s_rq, char *path, int len)
>                 strlcpy(path, "(null)", len);
>  }
>
> -static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> +static inline bool list_add_load_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>         struct rq *rq =3D rq_of(cfs_rq);
>         int cpu =3D cpu_of(rq);
>
>         if (cfs_rq->on_list)
> -               return rq->tmp_alone_branch =3D=3D &rq->leaf_cfs_rq_list;
> +               return rq->tmp_alone_branch =3D=3D &rq->load_cfs_rq_list;
>
>         cfs_rq->on_list =3D 1;
>
> @@ -313,14 +313,14 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_=
rq *cfs_rq)
>                  * the list, this means to put the child at the tail
>                  * of the list that starts by parent.
>                  */
> -               list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
> -                       &(cfs_rq->tg->parent->cfs_rq[cpu]->leaf_cfs_rq_li=
st));
> +               list_add_tail_rcu(&cfs_rq->load_cfs_rq_list,
> +                       &(cfs_rq->tg->parent->cfs_rq[cpu]->load_cfs_rq_li=
st));
>                 /*
>                  * The branch is now connected to its tree so we can
>                  * reset tmp_alone_branch to the beginning of the
>                  * list.
>                  */
> -               rq->tmp_alone_branch =3D &rq->leaf_cfs_rq_list;
> +               rq->tmp_alone_branch =3D &rq->load_cfs_rq_list;
>                 return true;
>         }
>
> @@ -329,13 +329,13 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_=
rq *cfs_rq)
>                  * cfs rq without parent should be put
>                  * at the tail of the list.
>                  */
> -               list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
> -                       &rq->leaf_cfs_rq_list);
> +               list_add_tail_rcu(&cfs_rq->load_cfs_rq_list,
> +                       &rq->load_cfs_rq_list);
>                 /*
>                  * We have reach the top of a tree so we can reset
>                  * tmp_alone_branch to the beginning of the list.
>                  */
> -               rq->tmp_alone_branch =3D &rq->leaf_cfs_rq_list;
> +               rq->tmp_alone_branch =3D &rq->load_cfs_rq_list;
>                 return true;
>         }
>
> @@ -345,44 +345,44 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_=
rq *cfs_rq)
>          * tmp_alone_branch points to the begin of the branch
>          * where we will add parent.
>          */
> -       list_add_rcu(&cfs_rq->leaf_cfs_rq_list, rq->tmp_alone_branch);
> +       list_add_rcu(&cfs_rq->load_cfs_rq_list, rq->tmp_alone_branch);
>         /*
>          * update tmp_alone_branch to points to the new begin
>          * of the branch
>          */
> -       rq->tmp_alone_branch =3D &cfs_rq->leaf_cfs_rq_list;
> +       rq->tmp_alone_branch =3D &cfs_rq->load_cfs_rq_list;
>         return false;
>  }
>
> -static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> +static inline void list_del_load_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>         if (cfs_rq->on_list) {
>                 struct rq *rq =3D rq_of(cfs_rq);
>
>                 /*
>                  * With cfs_rq being unthrottled/throttled during an enqu=
eue,
> -                * it can happen the tmp_alone_branch points the a leaf t=
hat
> +                * it can happen the tmp_alone_branch points the cfs_rq t=
hat
>                  * we finally want to del. In this case, tmp_alone_branch=
 moves
> -                * to the prev element but it will point to rq->leaf_cfs_=
rq_list
> +                * to the prev element but it will point to rq->load_cfs_=
rq_list
>                  * at the end of the enqueue.
>                  */
> -               if (rq->tmp_alone_branch =3D=3D &cfs_rq->leaf_cfs_rq_list=
)
> -                       rq->tmp_alone_branch =3D cfs_rq->leaf_cfs_rq_list=
.prev;
> +               if (rq->tmp_alone_branch =3D=3D &cfs_rq->load_cfs_rq_list=
)
> +                       rq->tmp_alone_branch =3D cfs_rq->load_cfs_rq_list=
.prev;
>
> -               list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
> +               list_del_rcu(&cfs_rq->load_cfs_rq_list);
>                 cfs_rq->on_list =3D 0;
>         }
>  }
>
> -static inline void assert_list_leaf_cfs_rq(struct rq *rq)
> +static inline void assert_list_load_cfs_rq(struct rq *rq)
>  {
> -       SCHED_WARN_ON(rq->tmp_alone_branch !=3D &rq->leaf_cfs_rq_list);
> +       SCHED_WARN_ON(rq->tmp_alone_branch !=3D &rq->load_cfs_rq_list);
>  }
>
> -/* Iterate thr' all leaf cfs_rq's on a runqueue */
> -#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)                     \
> -       list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,    \
> -                                leaf_cfs_rq_list)
> +/* Iterate thr' all loaded cfs_rq's on a runqueue */
> +#define for_each_load_cfs_rq_safe(rq, cfs_rq, pos)                     \
> +       list_for_each_entry_safe(cfs_rq, pos, &rq->load_cfs_rq_list,    \
> +                                load_cfs_rq_list)
>
>  /* Do the two (enqueued) entities belong to the same group ? */
>  static inline struct cfs_rq *
> @@ -442,20 +442,20 @@ static inline void cfs_rq_tg_path(struct cfs_rq *cf=
s_rq, char *path, int len)
>                 strlcpy(path, "(null)", len);
>  }
>
> -static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> +static inline bool list_add_load_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>         return true;
>  }
>
> -static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> +static inline void list_del_load_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>  }
>
> -static inline void assert_list_leaf_cfs_rq(struct rq *rq)
> +static inline void assert_list_load_cfs_rq(struct rq *rq)
>  {
>  }
>
> -#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)     \
> +#define for_each_load_cfs_rq_safe(rq, cfs_rq, pos)     \
>                 for (cfs_rq =3D &rq->cfs, pos =3D NULL; cfs_rq; cfs_rq =
=3D pos)
>
>  static inline struct sched_entity *parent_entity(struct sched_entity *se=
)
> @@ -3257,12 +3257,12 @@ static inline void cfs_rq_util_change(struct cfs_=
rq *cfs_rq, int flags)
>  #ifdef CONFIG_SMP
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  /*
> - * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
> + * Because list_add_load_cfs_rq always places a child cfs_rq on the list
>   * immediately before a parent cfs_rq, and cfs_rqs are removed from the =
list
>   * bottom-up, we only have to test whether the cfs_rq before us on the l=
ist
>   * is our child.
>   * If cfs_rq is not on the list, test whether a child needs its to be ad=
ded to
> - * connect a branch to the tree  * (see list_add_leaf_cfs_rq() for detai=
ls).
> + * connect a branch to the tree (see list_add_load_cfs_rq() for details)=
.
>   */
>  static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
>  {
> @@ -3270,14 +3270,14 @@ static inline bool child_cfs_rq_on_list(struct cf=
s_rq *cfs_rq)
>         struct list_head *prev;
>
>         if (cfs_rq->on_list) {
> -               prev =3D cfs_rq->leaf_cfs_rq_list.prev;
> +               prev =3D cfs_rq->load_cfs_rq_list.prev;
>         } else {
>                 struct rq *rq =3D rq_of(cfs_rq);
>
>                 prev =3D rq->tmp_alone_branch;
>         }
>
> -       prev_cfs_rq =3D container_of(prev, struct cfs_rq, leaf_cfs_rq_lis=
t);
> +       prev_cfs_rq =3D container_of(prev, struct cfs_rq, load_cfs_rq_lis=
t);
>
>         return (prev_cfs_rq->tg->parent =3D=3D cfs_rq->tg);
>  }
> @@ -4298,7 +4298,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_=
entity *se, int flags)
>          * add it unconditionally.
>          */
>         if (cfs_rq->nr_running =3D=3D 1 || cfs_bandwidth_used())
> -               list_add_leaf_cfs_rq(cfs_rq);
> +               list_add_load_cfs_rq(cfs_rq);
>
>         if (cfs_rq->nr_running =3D=3D 1)
>                 check_enqueue_throttle(cfs_rq);
> @@ -4775,7 +4775,7 @@ static int tg_unthrottle_up(struct task_group *tg, =
void *data)
>
>                 /* Add cfs_rq with load or one or more already running en=
tities to the list */
>                 if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
> -                       list_add_leaf_cfs_rq(cfs_rq);
> +                       list_add_load_cfs_rq(cfs_rq);
>         }
>
>         return 0;
> @@ -4789,7 +4789,7 @@ static int tg_throttle_down(struct task_group *tg, =
void *data)
>         /* group is entering throttled state, stop time */
>         if (!cfs_rq->throttle_count) {
>                 cfs_rq->throttled_clock_task =3D rq_clock_task(rq);
> -               list_del_leaf_cfs_rq(cfs_rq);
> +               list_del_load_cfs_rq(cfs_rq);
>         }
>         cfs_rq->throttle_count++;
>
> @@ -4900,10 +4900,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>                 /* Nothing to run but something to decay? Complete the br=
anch */
>                 if (cfs_rq->on_list)
>                         for_each_sched_entity(se) {
> -                               if (list_add_leaf_cfs_rq(group_cfs_rq(se)=
))
> +                               if (list_add_load_cfs_rq(group_cfs_rq(se)=
))
>                                         break;
>                         }
> -               assert_list_leaf_cfs_rq(rq);
> +               assert_list_load_cfs_rq(rq);
>                 return;
>         }
>
> @@ -4939,10 +4939,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>
>                 /*
>                  * One parent has been throttled and cfs_rq removed from =
the
> -                * list. Add it back to not break the leaf list.
> +                * list. Add it back to not break the load list.
>                  */
>                 if (throttled_hierarchy(cfs_rq))
> -                       list_add_leaf_cfs_rq(cfs_rq);
> +                       list_add_load_cfs_rq(cfs_rq);
>         }
>
>         /* At this point se is NULL and we are at root level*/
> @@ -4951,17 +4951,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  unthrottle_throttle:
>         /*
>          * The cfs_rq_throttled() breaks in the above iteration can resul=
t in
> -        * incomplete leaf list maintenance, resulting in triggering the
> +        * incomplete load list maintenance, resulting in triggering the
>          * assertion below.
>          */
>         for_each_sched_entity(se) {
>                 cfs_rq =3D cfs_rq_of(se);
>
> -               if (list_add_leaf_cfs_rq(cfs_rq))
> +               if (list_add_load_cfs_rq(cfs_rq))
>                         break;
>         }
>
> -       assert_list_leaf_cfs_rq(rq);
> +       assert_list_load_cfs_rq(rq);
>
>         /* Determine whether we need to wake up potentially idle CPU: */
>         if (rq->curr =3D=3D rq->idle && rq->cfs.nr_running)
> @@ -5601,12 +5601,12 @@ enqueue_task_fair(struct rq *rq, struct task_stru=
ct *p, int flags)
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto enqueue_throttle;
>
> -               /*
> -                * One parent has been throttled and cfs_rq removed from =
the
> -                * list. Add it back to not break the leaf list.
> -                */
> -               if (throttled_hierarchy(cfs_rq))
> -                       list_add_leaf_cfs_rq(cfs_rq);
> +               /*
> +                * One parent has been throttled and cfs_rq removed from =
the
> +                * list. Add it back to not break the load list.
> +                */
> +               if (throttled_hierarchy(cfs_rq))
> +                       list_add_load_cfs_rq(cfs_rq);
>         }
>
>         /* At this point se is NULL and we are at root level*/
> @@ -5634,18 +5634,18 @@ enqueue_task_fair(struct rq *rq, struct task_stru=
ct *p, int flags)
>                 /*
>                  * When bandwidth control is enabled; the cfs_rq_throttle=
d()
>                  * breaks in the above iteration can result in incomplete
> -                * leaf list maintenance, resulting in triggering the ass=
ertion
> +                * load list maintenance, resulting in triggering the ass=
ertion
>                  * below.
>                  */
>                 for_each_sched_entity(se) {
>                         cfs_rq =3D cfs_rq_of(se);
>
> -                       if (list_add_leaf_cfs_rq(cfs_rq))
> +                       if (list_add_load_cfs_rq(cfs_rq))
>                                 break;
>                 }
>         }
>
> -       assert_list_leaf_cfs_rq(rq);
> +       assert_list_load_cfs_rq(rq);
>
>         hrtick_update(rq);
>  }
> @@ -8122,9 +8122,9 @@ static bool __update_blocked_fair(struct rq *rq, bo=
ol *done)
>
>         /*
>          * Iterates the task_group tree in a bottom up fashion, see
> -        * list_add_leaf_cfs_rq() for details.
> +        * list_add_load_cfs_rq() for details.
>          */
> -       for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
> +       for_each_load_cfs_rq_safe(rq, cfs_rq, pos) {
>                 struct sched_entity *se;
>
>                 if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs=
_rq)) {
> @@ -8144,7 +8144,7 @@ static bool __update_blocked_fair(struct rq *rq, bo=
ol *done)
>                  * decayed cfs_rqs linger on the list.
>                  */
>                 if (cfs_rq_is_decayed(cfs_rq))
> -                       list_del_leaf_cfs_rq(cfs_rq);
> +                       list_del_load_cfs_rq(cfs_rq);
>
>                 /* Don't need periodic decay once load/util_avg are null =
*/
>                 if (cfs_rq_has_blocked(cfs_rq))
> @@ -11111,7 +11111,7 @@ static void propagate_entity_cfs_rq(struct sched_=
entity *se)
>  {
>         struct cfs_rq *cfs_rq;
>
> -       list_add_leaf_cfs_rq(cfs_rq_of(se));
> +       list_add_load_cfs_rq(cfs_rq_of(se));
>
>         /* Start to propagate at parent */
>         se =3D se->parent;
> @@ -11121,11 +11121,11 @@ static void propagate_entity_cfs_rq(struct sche=
d_entity *se)
>
>                 if (!cfs_rq_throttled(cfs_rq)){
>                         update_load_avg(cfs_rq, se, UPDATE_TG);
> -                       list_add_leaf_cfs_rq(cfs_rq);
> +                       list_add_load_cfs_rq(cfs_rq);
>                         continue;
>                 }
>
> -               if (list_add_leaf_cfs_rq(cfs_rq))
> +               if (list_add_load_cfs_rq(cfs_rq))
>                         break;
>         }
>  }
> @@ -11383,7 +11383,7 @@ void unregister_fair_sched_group(struct task_grou=
p *tg)
>                 rq =3D cpu_rq(cpu);
>
>                 raw_spin_rq_lock_irqsave(rq, flags);
> -               list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
> +               list_del_load_cfs_rq(tg->cfs_rq[cpu]);
>                 raw_spin_rq_unlock_irqrestore(rq, flags);
>         }
>  }
> @@ -11543,7 +11543,7 @@ void print_cfs_stats(struct seq_file *m, int cpu)
>         struct cfs_rq *cfs_rq, *pos;
>
>         rcu_read_lock();
> -       for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
> +       for_each_load_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
>                 print_cfs_rq(m, cpu, cfs_rq);
>         rcu_read_unlock();
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 219ee463fe64..dc9382295ec9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -587,16 +587,8 @@ struct cfs_rq {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         struct rq               *rq;    /* CPU runqueue to which this cfs=
_rq is attached */
>
> -       /*
> -        * leaf cfs_rqs are those that hold tasks (lowest schedulable ent=
ity in
> -        * a hierarchy). Non-leaf lrqs hold other higher schedulable enti=
ties
> -        * (like users, containers etc.)
> -        *
> -        * leaf_cfs_rq_list ties together list of leaf cfs_rq's in a CPU.
> -        * This list is used during load balance.
> -        */
>         int                     on_list;
> -       struct list_head        leaf_cfs_rq_list;
> +       struct list_head        load_cfs_rq_list;
>         struct task_group       *tg;    /* group that "owns" this runqueu=
e */
>
>  #ifdef CONFIG_CFS_BANDWIDTH
> @@ -950,8 +942,11 @@ struct rq {
>         struct dl_rq            dl;
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -       /* list of leaf cfs_rq on this CPU: */
> -       struct list_head        leaf_cfs_rq_list;
> +       /* Bottom up ordered list of cfs_rqs with load (see
> +        * cfs_rq_is_decayed()) on this CPU.
> +        * This list is used during load balance.
> +        */

Fully agree that a rename of some sort is good, as I struggled to understan=
d it
in the beginning as well. However, I am not sure if "load_list" is the
best one (but
it is definitely better). It cfs_rq will be in the list even if it has
no load, as long as some
of its descendants have. Also, "load->weight" is not _really_ load,
but that all depends on
definition I guess.

I have no new suggestions right now, other than maybe "active" (but
not 100% sure)
so "load list" might be a good one after all.

> +       struct list_head        load_cfs_rq_list;
>         struct list_head        *tmp_alone_branch;
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
> --
> 2.32.0
>

Odin
Thanks
