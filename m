Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8554B3CFFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhGTP6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhGTP6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:58:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A979761019;
        Tue, 20 Jul 2021 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626799123;
        bh=kdftOJ0jhLGL8T4pVTEICvk/6wY0iakTmc3Nm5aAINA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HBW52fom0qZMsx31fsVii6Bi0ut6kJVea6Yyx9/1sYEWGAFTiUAkEGXm8mZjulZiW
         G1LS5OynJqBfxG43oXZlSqN+GeufXZ5p/UX6ybc4/jt45vGXrMCsi1ALjG9gY4tleF
         9GiUOQiUvI0V6pS4kxFQB7YjFLzQrG1/0qupjNbpQTM/dwZfg5LqBjUihH80MZs9vH
         dmiwKrcjEogPzu8qCqOZTWLLo4nUYzxNciehzlaRXroLqyGbHGOygzVLusbUouhXqe
         bgTh7ujaegcK0qC+FRX4SAIBjXmb2W+lvMBkNkZluYLy2Brs0rhHD7WIWEQz8C9cGe
         01dfqGUlb0HMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 807345C094C; Tue, 20 Jul 2021 09:38:43 -0700 (PDT)
Date:   Tue, 20 Jul 2021 09:38:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_kthread
Message-ID: <20210720163843.GI4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <00000000000080403805c6ef586d@google.com>
 <CANpmjNPx2b+W2OZxNROTWfGcU92bwqyDe-=vxgnV9MEurjyqzQ@mail.gmail.com>
 <20210720131851.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNPR3FTMRa9zyb3Pd+f7EXfvjxBUmPVKOaKodn8JJt9raQ@mail.gmail.com>
 <CAABZP2x4Q1mOism_yTuGj2CdHs=OOZUi3vnGJxpoqtLYnUFrDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2x4Q1mOism_yTuGj2CdHs=OOZUi3vnGJxpoqtLYnUFrDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:19:02AM +0800, Zhouyi Zhou wrote:
> On Tue, Jul 20, 2021 at 10:16 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, 20 Jul 2021 at 15:18, Paul E. McKenney <paulmck@kernel.org> wrote:
> > [...]
> > > Good catch!  And yes, this would be hard to reproduce.
> > >
> > > How about as shown below?
> >
> > Acked-by: Marco Elver <elver@google.com>
> >
> > I was merely a little surprised syzbot was able to exercise RCU in a
> > way that resulted in a data race your torture runs hadn't found yet
> > (or perhaps it did and missed?).
> 
> I think rcu_state.n_force_qs is used to give grace period a kick. In worst
> case, the data race will cause the grace period to miss at most one
> kick, but the grace
> period will get kicked soon because of too many callbacks, I guess that's
> why rcu torture will not find this data race.

In theory, rcutorture -could- find it, but it would require a call_rcu()
or similar just at the beginning of the grace period.  This is a tough
target to hit.

							Thanx, Paul

> Many thanks
> Zhouyi
> >
> > Thanks,
> > -- Marco
> >
> > >                                                         Thanx, Paul
> > >
> > > ------------------------------------------------------------------------
> > >
> > > commit 43e0f01f3b6f510dbe31d02a8f4c909c45deff04
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Tue Jul 20 06:16:27 2021 -0700
> > >
> > >     rcu: Mark accesses to rcu_state.n_force_qs
> > >
> > >     This commit marks accesses to the rcu_state.n_force_qs.  These data
> > >     races are hard to make happen, but syzkaller was equal to the task.
> > >
> > >     Reported-by: syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index a7379c44a2366..245bca7cdf6ee 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1913,7 +1913,7 @@ static void rcu_gp_fqs(bool first_time)
> > >         struct rcu_node *rnp = rcu_get_root();
> > >
> > >         WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > > -       rcu_state.n_force_qs++;
> > > +       WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
> > >         if (first_time) {
> > >                 /* Collect dyntick-idle snapshots. */
> > >                 force_qs_rnp(dyntick_save_progress_counter);
> > > @@ -2556,7 +2556,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
> > >         /* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
> > >         if (count == 0 && rdp->qlen_last_fqs_check != 0) {
> > >                 rdp->qlen_last_fqs_check = 0;
> > > -               rdp->n_force_qs_snap = rcu_state.n_force_qs;
> > > +               rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> > >         } else if (count < rdp->qlen_last_fqs_check - qhimark)
> > >                 rdp->qlen_last_fqs_check = count;
> > >
> > > @@ -2904,10 +2904,10 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
> > >                 } else {
> > >                         /* Give the grace period a kick. */
> > >                         rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
> > > -                       if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
> > > +                       if (READ_ONCE(rcu_state.n_force_qs) == rdp->n_force_qs_snap &&
> > >                             rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
> > >                                 rcu_force_quiescent_state();
> > > -                       rdp->n_force_qs_snap = rcu_state.n_force_qs;
> > > +                       rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> > >                         rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> > >                 }
> > >         }
> > > @@ -4134,7 +4134,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
> > >         /* Set up local state, ensuring consistent view of global state. */
> > >         raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > >         rdp->qlen_last_fqs_check = 0;
> > > -       rdp->n_force_qs_snap = rcu_state.n_force_qs;
> > > +       rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> > >         rdp->blimit = blimit;
> > >         rdp->dynticks_nesting = 1;      /* CPU not up, no tearing. */
> > >         rcu_dynticks_eqs_online();
