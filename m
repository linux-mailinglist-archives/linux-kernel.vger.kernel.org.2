Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E453CFF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhGTPsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbhGTPjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:39:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D971C0613E0;
        Tue, 20 Jul 2021 09:19:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dt7so35130820ejc.12;
        Tue, 20 Jul 2021 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAaYKM8ucvDWBmp1byH2RkXdDsEcz52adVeFA/SYbjI=;
        b=XtRVNGu5RKJNvWKwbxKgLruGiPAsSO1yJi6zHqkj10IzM+MTWmnJiexomOlhVSV5i5
         snFM+upFrSwOG8fVj323gOl6XZoYfD5r2vROqgu1MQHwtSyH1QR4Zz1QIs90js1iHBOB
         pO60iXRp+yoqVnqO5PwdqK9ShKRFd0Ehzaf52Ie5CadeQeBk7ojlpXAGYMuIsWDV+fPQ
         87sRpCuEoZok6cOBAPvFVELlrbZt15IU5B287t2EzimhxbBoz3sxKsygPosjemONYzRl
         Hsj/JLd61drmOHOPOMcS8marO4bCXA8X2s7K6l2PmHi0C6I0Cs3Fga7AC0zvqVdM/ufj
         vo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAaYKM8ucvDWBmp1byH2RkXdDsEcz52adVeFA/SYbjI=;
        b=psFCmh9uUqrFaxv7+PPt6MdgnXUmnTU6DN5m99Z4pBi+auvs2qIjgPVVtS1/zpCKAX
         JjcoUiXgK/1bhJYKZ+KJt/m8t8rIf/gfXVDbezHwaPti4ypuDhUeXhBmDdQKU1rXddXr
         iDhy858+XoZ4Qf9v5sZ82PvPzm/eIyxPxBdnHIMhLT71j1c5HSJ+38kDWOjkwuUsR6sc
         eVnmcSNeUSSKzH8vZmr3y2iRBrXpmeDi7q26pBkrQAKmxO6NVKWWRXJsduDNbBWMjGI8
         WPg1WiQTDYHnlzZ37Swxoz8N2zzE1AhrFKK4Ujv+0/XiMqyDIRAUm4vwUxYCir6cfp0I
         J+Xg==
X-Gm-Message-State: AOAM5306lssV5yjFU6mxdaPuv4mSgbnOnTn8PoyGIGpX1cGwmyXI4tB5
        jG+hPxjqbK1H8Mn7vUc9guLgBD8uGzVKWyycn5Y=
X-Google-Smtp-Source: ABdhPJxH/cKR92dHmVdWYs6khP6qMIKSwe+52NXMx0s3XNANItX7OEtE9nRnUbSc4GGIXU1h8yeKAu2n9+ZQ2e2OroE=
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr32432846ejy.201.1626797954194;
 Tue, 20 Jul 2021 09:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000080403805c6ef586d@google.com> <CANpmjNPx2b+W2OZxNROTWfGcU92bwqyDe-=vxgnV9MEurjyqzQ@mail.gmail.com>
 <20210720131851.GE4397@paulmck-ThinkPad-P17-Gen-1> <CANpmjNPR3FTMRa9zyb3Pd+f7EXfvjxBUmPVKOaKodn8JJt9raQ@mail.gmail.com>
In-Reply-To: <CANpmjNPR3FTMRa9zyb3Pd+f7EXfvjxBUmPVKOaKodn8JJt9raQ@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 21 Jul 2021 00:19:02 +0800
Message-ID: <CAABZP2x4Q1mOism_yTuGj2CdHs=OOZUi3vnGJxpoqtLYnUFrDg@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_kthread
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org,
        syzbot <syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:16 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 20 Jul 2021 at 15:18, Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > Good catch!  And yes, this would be hard to reproduce.
> >
> > How about as shown below?
>
> Acked-by: Marco Elver <elver@google.com>
>
> I was merely a little surprised syzbot was able to exercise RCU in a
> way that resulted in a data race your torture runs hadn't found yet
> (or perhaps it did and missed?).

I think rcu_state.n_force_qs is used to give grace period a kick. In worst
case, the data race will cause the grace period to miss at most one
kick, but the grace
period will get kicked soon because of too many callbacks, I guess that's
why rcu torture will not find this data race.

Many thanks
Zhouyi
>
> Thanks,
> -- Marco
>
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit 43e0f01f3b6f510dbe31d02a8f4c909c45deff04
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Jul 20 06:16:27 2021 -0700
> >
> >     rcu: Mark accesses to rcu_state.n_force_qs
> >
> >     This commit marks accesses to the rcu_state.n_force_qs.  These data
> >     races are hard to make happen, but syzkaller was equal to the task.
> >
> >     Reported-by: syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a7379c44a2366..245bca7cdf6ee 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1913,7 +1913,7 @@ static void rcu_gp_fqs(bool first_time)
> >         struct rcu_node *rnp = rcu_get_root();
> >
> >         WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > -       rcu_state.n_force_qs++;
> > +       WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
> >         if (first_time) {
> >                 /* Collect dyntick-idle snapshots. */
> >                 force_qs_rnp(dyntick_save_progress_counter);
> > @@ -2556,7 +2556,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >         /* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
> >         if (count == 0 && rdp->qlen_last_fqs_check != 0) {
> >                 rdp->qlen_last_fqs_check = 0;
> > -               rdp->n_force_qs_snap = rcu_state.n_force_qs;
> > +               rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> >         } else if (count < rdp->qlen_last_fqs_check - qhimark)
> >                 rdp->qlen_last_fqs_check = count;
> >
> > @@ -2904,10 +2904,10 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
> >                 } else {
> >                         /* Give the grace period a kick. */
> >                         rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
> > -                       if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
> > +                       if (READ_ONCE(rcu_state.n_force_qs) == rdp->n_force_qs_snap &&
> >                             rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
> >                                 rcu_force_quiescent_state();
> > -                       rdp->n_force_qs_snap = rcu_state.n_force_qs;
> > +                       rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> >                         rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> >                 }
> >         }
> > @@ -4134,7 +4134,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
> >         /* Set up local state, ensuring consistent view of global state. */
> >         raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >         rdp->qlen_last_fqs_check = 0;
> > -       rdp->n_force_qs_snap = rcu_state.n_force_qs;
> > +       rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> >         rdp->blimit = blimit;
> >         rdp->dynticks_nesting = 1;      /* CPU not up, no tearing. */
> >         rcu_dynticks_eqs_online();
