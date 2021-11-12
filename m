Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85CE44E94E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhKLPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235074AbhKLPAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:00:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CDEB61056;
        Fri, 12 Nov 2021 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636729075;
        bh=K075XGPRjZuFasr+VRj/qkdytZ3o1trILkoI9tSBv/s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VL/bCaOMoxYufHxE9GysVHCqr35X8UnuCQcQBVDDxb1pjCyMbNeRsp37fdd/wPOB3
         5LAyY4OEl6pZorOWCc4YfS3vagv+apba0QTEPXbfztIeoeO1SwaT1tWqO1m8IjhZjH
         kXTk6ThFOzx6nFZpVU1uHzrLXexwdo/gjVXzxLa8gp7vymSpjsivEnOf6ABqiBT5Tm
         LazILyR51vNI3ZcNe1gYlxEkptvGclTKvJYchDO/HlJBiV+RG/Jx2HGBVCbFxA0L6T
         lvdwJdQqvgFhKQPWYOjqOWcstVtWrZ+BQ+yhnpcojqXJqxFueunBj2alqBKnaHorRX
         oLeTMMyg1U2Fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B1BE5C0527; Fri, 12 Nov 2021 06:57:55 -0800 (PST)
Date:   Fri, 12 Nov 2021 06:57:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wander Costa <wcosta@redhat.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by
 slow console devices
Message-ID: <20211112145755.GX641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211111195904.618253-1-wander@redhat.com>
 <20211111195904.618253-2-wander@redhat.com>
 <YY3GY8ZSH5ACaZZS@google.com>
 <CAAq0SUkeP0WcVBLmYXAyUxOuRDB3b4brgVsAYF90G+6pYrF4eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SUkeP0WcVBLmYXAyUxOuRDB3b4brgVsAYF90G+6pYrF4eA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 11:42:39AM -0300, Wander Costa wrote:
> On Thu, Nov 11, 2021 at 10:42 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (21/11/11 16:59), Wander Lairson Costa wrote:
> > >
> > > If we have a reasonable large dataset to flush in the printk ring
> > > buffer in the presence of a slow console device (like a serial port
> > > with a low baud rate configured), the RCU stall detector may report
> > > warnings.
> > >
> > > This patch suppresses RCU stall warnings while flushing the ring buffer
> > > to the console.
> > >
> > [..]
> > > +extern int rcu_cpu_stall_suppress;
> > > +
> > > +static void rcu_console_stall_suppress(void)
> > > +{
> > > +     if (!rcu_cpu_stall_suppress)
> > > +             rcu_cpu_stall_suppress = 4;
> > > +}
> > > +
> > > +static void rcu_console_stall_unsuppress(void)
> > > +{
> > > +     if (rcu_cpu_stall_suppress == 4)
> > > +             rcu_cpu_stall_suppress = 0;
> > > +}
> > > +
> > >  /**
> > >   * console_unlock - unlock the console system
> > >   *
> > > @@ -2634,6 +2648,9 @@ void console_unlock(void)
> > >        * and cleared after the "again" goto label.
> > >        */
> > >       do_cond_resched = console_may_schedule;
> > > +
> > > +     rcu_console_stall_suppress();
> > > +
> > >  again:
> > >       console_may_schedule = 0;
> > >
> > > @@ -2645,6 +2662,7 @@ void console_unlock(void)
> > >       if (!can_use_console()) {
> > >               console_locked = 0;
> > >               up_console_sem();
> > > +             rcu_console_stall_unsuppress();
> > >               return;
> > >       }
> > >
> > > @@ -2716,8 +2734,10 @@ void console_unlock(void)
> > >
> > >               handover = console_lock_spinning_disable_and_check();
> > >               printk_safe_exit_irqrestore(flags);
> > > -             if (handover)
> > > +             if (handover) {
> > > +                     rcu_console_stall_unsuppress();
> > >                       return;
> > > +             }
> > >
> > >               if (do_cond_resched)
> > >                       cond_resched();
> > > @@ -2738,6 +2758,8 @@ void console_unlock(void)
> > >       retry = prb_read_valid(prb, next_seq, NULL);
> > >       if (retry && console_trylock())
> > >               goto again;
> > > +
> > > +     rcu_console_stall_unsuppress();
> > >  }
> >
> > May be we can just start touching watchdogs from printing routine?
> >
> Hrm, console_unlock is called from vprintk_emit [0] with preemption
> disabled. and it already has the logic implemented to call
> cond_resched when possible [1].
> 
> [0] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2244
> [1] https://elixir.bootlin.com/linux/latest/source/kernel/printk/printk.c#L2719

So when we are having problems is when console_may_schedule == 0?

							Thanx, Paul
