Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BAC3AF175
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFURLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFURLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:11:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:09:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a11so18340561lfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JMmJSnD3/U06oRXyz4Yq2FrOHrZ2wymLSXBpDyNdQf4=;
        b=aFqvERbpM65QMOZG73UxuyPU5BkWbgA6kPF7nHf1gV5+iXHLclPP1EhgyQ107LXd5S
         NUQXitx+NmH1uQmHhIQMXR5QCqe2pgCwYKKtirrgXFzvBTczXJj9ZCEUrxjLIqiQ0ENc
         A1N7mmMLbJlnx37d+NFWaICbnHcEksER084HMoAdEtfgAD1VnBerjvYMZkaa328yyJLe
         L0eCEcl6qoCTSVTNUydjIYekUiexQakrVSnpu83mXxXHRpRRcXh6EHc/KYcZXSDk1AjI
         9kKOVBUFp8ENP6DFkc8gGSXB93vXya4NGiY+1Dm9n39nULcIXXa699QNVB+gyNy4e/VP
         j/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JMmJSnD3/U06oRXyz4Yq2FrOHrZ2wymLSXBpDyNdQf4=;
        b=NMvkCjXpbPUBldNzM0kBODH4VSzM1ZasFoHDsql32ugoZtS/Xp9K9IE30E45ri63BM
         JH9HuFw8nXwm1gT4o1NWs8txUTywLyeP/rA5dNS7kNGmdzf1I3GlQc0XZaZkTvP2j/Nc
         ANgqeAHdJ1zCcJOoFdhOm4Bf/do1WfZtUSoxd2MVP2y1NVPpNf1Q2r4nhWYTm8f3fF0/
         HpmPiJJdXNJW7jvwDPOCXxXh0msZ2vIqrzwn3XMshzhNdMK5nCd1FtUh8VCGYtEeorr2
         4j2wDtlVXCifY3VXOWvcQaHEp1sgJmL/N93eAQpTGH3u4XtERyGJ8QIX6fEBRVfxLFsG
         G3KQ==
X-Gm-Message-State: AOAM532M+pKoxy7lWea9MJs0IprQF9U3CeK3FklxvzTl6d68r0X/dbAx
        6g4lpGGS8fVGwOKDHaGOeQ76NHNOirKeINMdyxe7JA==
X-Google-Smtp-Source: ABdhPJyOnr0zQi9vvzYptYp8H0VJaVlnE+4dVZh/0b5F7SZjB71oomO/BvKD8ADCWcUpJW4wRui9yP+564St5QvBCVc=
X-Received: by 2002:ac2:5088:: with SMTP id f8mr9295030lfm.233.1624295373872;
 Mon, 21 Jun 2021 10:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com>
 <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
 <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
 <CAFpoUr2o2PVPOx+AvatjjUvqPTyNKE3C6oXejyU3HVMmtCnzvQ@mail.gmail.com>
 <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com> <CAFpoUr0iWFTq2grtnX_EH6KnZLZQCg1o6_yv1gfDK8WdbHmUCA@mail.gmail.com>
 <CAFpoUr3Wy9raHx+Dc0S8TB_Xi=E+Epsh_pA3DEFZP4eKf7s07A@mail.gmail.com> <20210621162243.GA29874@vingu-book>
In-Reply-To: <20210621162243.GA29874@vingu-book>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jun 2021 19:09:22 +0200
Message-ID: <CAKfTPtACzzoGhDFW0bTGgZRPB=3LR6kSwuUOrcKDFTAJ7BhTFQ@mail.gmail.com>
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>,
        Odin Ugedal <odin@uged.al>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sacha

On Mon, 21 Jun 2021 at 18:22, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Le lundi 21 juin 2021 =C3=A0 14:42:23 (+0200), Odin Ugedal a =C3=A9crit :
> > Hi,
> >
> > Did some more research, and it looks like this is what happens:
> >
> > $ tree /sys/fs/cgroup/ltp/ -d --charset=3Dascii
> > /sys/fs/cgroup/ltp/
> > |-- drain
> > `-- test-6851
> >     `-- level2
> >         |-- level3a
> >         |   |-- worker1
> >         |   `-- worker2
> >         `-- level3b
> >             `-- worker3
> >
> > Timeline (ish):
> > - worker3 gets throttled
> > - level3b is decayed, since it has no more load
> > - level2 get throttled
> > - worker3 get unthrottled
> > - level2 get unthrottled
> >   - worker3 is added to list
> >   - level3b is not added to list, since nr_running=3D=3D0 and is decaye=
d
> >
> >
> > The attached diff (based on
> > https://lore.kernel.org/lkml/20210518125202.78658-3-odin@uged.al/)
> > fixes the issue for me. Not the most elegant solution, but the
> > simplest one as of now, and to show what is wrong.
> >
> > Any thoughts Vincent?
>
>
> I would prefer that we use the reason of adding the cfs in the list inste=
ad.
>
> Something like the below should also fixed the problem. It is based on a
> proposal I made to Rik sometimes ago when he tried to flatten the rq:
> https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/
>
> This will ensure that a cfs is added in the list whenever one of its  chi=
ld
> is still in the list.

Could you confirm that this patch fixes the problem for you too ?

>
> ---
>  kernel/sched/fair.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ea7de54cb022..e751061a9449 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3272,6 +3272,31 @@ static inline void cfs_rq_util_change(struct cfs_r=
q *cfs_rq, int flags)
>
>  #ifdef CONFIG_SMP
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> +/*
> + * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
> + * immediately before a parent cfs_rq, and cfs_rqs are removed from the =
list
> + * bottom-up, we only have to test whether the cfs_rq before us on the l=
ist
> + * is our child.
> + * If cfs_rq is not on the list, test wether a child needs its to be add=
ed to
> + * connect a branch to the tree  * (see list_add_leaf_cfs_rq() for detai=
ls).
> + */
> +static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
> +{
> +       struct cfs_rq *prev_cfs_rq;
> +       struct list_head *prev;
> +
> +       if (cfs_rq->on_list) {
> +               prev =3D cfs_rq->leaf_cfs_rq_list.prev;
> +       } else {
> +               struct rq *rq =3D rq_of(cfs_rq);
> +
> +               prev =3D rq->tmp_alone_branch;
> +       }
> +
> +       prev_cfs_rq =3D container_of(prev, struct cfs_rq, leaf_cfs_rq_lis=
t);
> +
> +       return (prev_cfs_rq->tg->parent =3D=3D cfs_rq->tg);
> +}
>
>  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  {
> @@ -3287,6 +3312,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq =
*cfs_rq)
>         if (cfs_rq->avg.runnable_sum)
>                 return false;
>
> +       if (child_cfs_rq_on_list(cfs_rq))
> +               return false;
> +
>         return true;
>  }
>
> --
> 2.17.1
>
>
>
> >
> > Thanks
> > Odin
> >
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index bfaa6e1f6067..aa32e9c29efd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -376,7 +376,8 @@ static inline bool list_add_leaf_cfs_rq(struct
> > cfs_rq *cfs_rq)
> >         return false;
> >  }
> >
> > -static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> > +/* Returns 1 if cfs_rq was present in the list and removed */
> > +static inline bool list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >  {
> >         if (cfs_rq->on_list) {
> >                 struct rq *rq =3D rq_of(cfs_rq);
> > @@ -393,7 +394,9 @@ static inline void list_del_leaf_cfs_rq(struct
> > cfs_rq *cfs_rq)
> >
> >                 list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
> >                 cfs_rq->on_list =3D 0;
> > +               return 1;
> >         }
> > +       return 0;
> >  }
> >
> >  static inline void assert_list_leaf_cfs_rq(struct rq *rq)
> > @@ -3298,24 +3301,6 @@ static inline void cfs_rq_util_change(struct
> > cfs_rq *cfs_rq, int flags)
> >
> >  #ifdef CONFIG_SMP
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> > -
> > -static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > -{
> > -       if (cfs_rq->load.weight)
> > -               return false;
> > -
> > -       if (cfs_rq->avg.load_sum)
> > -               return false;
> > -
> > -       if (cfs_rq->avg.util_sum)
> > -               return false;
> > -
> > -       if (cfs_rq->avg.runnable_sum)
> > -               return false;
> > -
> > -       return true;
> > -}
> > -
> >  /**
> >   * update_tg_load_avg - update the tg's load avg
> >   * @cfs_rq: the cfs_rq whose avg changed
> > @@ -4109,11 +4094,6 @@ static inline void update_misfit_status(struct
> > task_struct *p, struct rq *rq)
> >
> >  #else /* CONFIG_SMP */
> >
> > -static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > -{
> > -       return true;
> > -}
> > -
> >  #define UPDATE_TG      0x0
> >  #define SKIP_AGE_LOAD  0x0
> >  #define DO_ATTACH      0x0
> > @@ -4771,10 +4751,11 @@ static int tg_unthrottle_up(struct task_group
> > *tg, void *data)
> >         if (!cfs_rq->throttle_count) {
> >                 cfs_rq->throttled_clock_task_time +=3D rq_clock_task(rq=
) -
> >                                              cfs_rq->throttled_clock_ta=
sk;
> > -
> > -               /* Add cfs_rq with load or one or more already running
> > entities to the list */
> > -               if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
> > +               if (cfs_rq->insert_on_unthrottle) {
> >                         list_add_leaf_cfs_rq(cfs_rq);
> > +                       if (tg->parent)
> > +
> > tg->parent->cfs_rq[cpu_of(rq)]->insert_on_unthrottle =3D true;
> > +                       }
> >         }
> >
> >         return 0;
> > @@ -4788,7 +4769,7 @@ static int tg_throttle_down(struct task_group
> > *tg, void *data)
> >         /* group is entering throttled state, stop time */
> >         if (!cfs_rq->throttle_count) {
> >                 cfs_rq->throttled_clock_task =3D rq_clock_task(rq);
> > -               list_del_leaf_cfs_rq(cfs_rq);
> > +               cfs_rq->insert_on_unthrottle =3D list_del_leaf_cfs_rq(c=
fs_rq);
> >         }
> >         cfs_rq->throttle_count++;
> >
> > @@ -8019,6 +8000,23 @@ static bool __update_blocked_others(struct rq
> > *rq, bool *done)
> >
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >
> > +static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > +{
> > +       if (cfs_rq->load.weight)
> > +               return false;
> > +
> > +       if (cfs_rq->avg.load_sum)
> > +               return false;
> > +
> > +       if (cfs_rq->avg.util_sum)
> > +               return false;
> > +
> > +       if (cfs_rq->avg.runnable_sum)
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
> >  static bool __update_blocked_fair(struct rq *rq, bool *done)
> >  {
> >         struct cfs_rq *cfs_rq, *pos;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index a189bec13729..12a707d99ee6 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -602,6 +602,7 @@ struct cfs_rq {
> >         u64                     throttled_clock_task_time;
> >         int                     throttled;
> >         int                     throttle_count;
> > +       int                     insert_on_unthrottle;
> >         struct list_head        throttled_list;
> >  #endif /* CONFIG_CFS_BANDWIDTH */
> >  #endif /* CONFIG_FAIR_GROUP_SCHED */
