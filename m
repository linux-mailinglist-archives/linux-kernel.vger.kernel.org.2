Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41E30F125
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhBDKqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:46:09 -0500
Received: from foss.arm.com ([217.140.110.172]:55690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235037AbhBDKqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:46:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A198911D4;
        Thu,  4 Feb 2021 02:45:19 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4243F719;
        Thu,  4 Feb 2021 02:45:17 -0800 (PST)
Date:   Thu, 4 Feb 2021 10:45:15 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to
 update_blocked_averages() for NOHZ
Message-ID: <20210204104515.sa72pcyaihowtncx@e107158-lin>
References: <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book>
 <20210203170916.ows7d2b56t34i2w4@e107158-lin>
 <CAKfTPtAZNLCfnuzFTU1DedL6EqpVWD6KjUZDGNQOOQwV7AfiVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAZNLCfnuzFTU1DedL6EqpVWD6KjUZDGNQOOQwV7AfiVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/21 18:35, Vincent Guittot wrote:
> > >       raw_spin_unlock(&this_rq->lock);
> > > -     /*
> > > -      * This CPU is going to be idle and blocked load of idle CPUs
> > > -      * need to be updated. Run the ilb locally as it is a good
> > > -      * candidate for ilb instead of waking up another idle CPU.
> > > -      * Kick an normal ilb if we failed to do the update.
> > > -      */
> > > -     if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
> >
> > Since we removed the call to this function (which uses this_rq)
> >
> > > -             kick_ilb(NOHZ_STATS_KICK);
> > > +     kick_ilb(NOHZ_STATS_KICK);
> >
> > And unconditionally call kick_ilb() which will find a suitable cpu to run the
> > lb at regardless what this_rq is.
> >
> > Doesn't the below become unnecessary now?
> 
> The end goal is to keep running on this cpu that is about to become idle.
> 
> This patch is mainly  there to check that Joel's problem disappears if
> the update of the blocked load of the cpus is not done in the
> newidle_balance context. I'm preparing few other patches on top to
> clean up the full path

+1

> >
> >           10494         /*
> >           10495          * This CPU doesn't want to be disturbed by scheduler
> >           10496          * housekeeping
> >           10497          */
> >           10498         if (!housekeeping_cpu(this_cpu, HK_FLAG_SCHED))
> >           10499                 return;
> >           10500
> >           10501         /* Will wake up very soon. No time for doing anything else*/
> >           10502         if (this_rq->avg_idle < sysctl_sched_migration_cost)
> >           10503                 return;
> >
> > And we can drop this_rq arg altogether?
> >
> > >       raw_spin_lock(&this_rq->lock);
> > >  }
> > >
> > > @@ -10616,8 +10590,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > >                       update_next_balance(sd, &next_balance);
> > >               rcu_read_unlock();
> > >
> > > -             nohz_newidle_balance(this_rq);
> > > -
> > >               goto out;
> > >       }
> > >
> > > @@ -10683,6 +10655,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > >
> > >       if (pulled_task)
> > >               this_rq->idle_stamp = 0;
> > > +     else
> > > +             nohz_newidle_balance(this_rq);
> >
> > Since nohz_newidle_balance() will not do any real work now, I couldn't figure
> > out what moving this here achieves. Fault from my end to parse the change most
> > likely :-)
> 
> The goal is to schedule the update only if we are about to be idle and
> nothing else has been queued in the meantime

I see. This short coming already existed and not *strictly* related to moving
update of blocked load out of newidle balance.

Thanks

--
Qais Yousef
