Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91931EDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhBRSBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhBRPSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:18:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09DD864E6F;
        Thu, 18 Feb 2021 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613661453;
        bh=CDfkNKuqFSHlmgCFOXtVGshhVMYojd1WS1YEotdlQys=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ku2gDfilTAXpCoBYanruco8Y8LF5nfV0Hzx6FNLRR6DqUH5slVHUdYWLs20/Ud5iu
         9lb73cPBEP7d0QG8413w+0ZJwYQEUb5TEnQ2u7J01PJ/yHJQVhBSE0OUxMgiQQd/3W
         zHkkdZdh3JIlOptIjT1bd4WsrPV9bJ12jFgiWtnOFNo+ZmOKR/2kxRFDC9u/NuDxcP
         yqx72g9fAtOhJYgnPyCx/gFxIdjmrNzi+OjfsTIFikWSSYtmRJtlVBqG08A8ocQ6B1
         e04Mnooui3/j18VLkjAVik4emgHbxevSvBWtXGF+gc0xwQGaxy9MQ96qGUX+x28JIs
         ZlI5AsP9EJOBg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A240E35226A0; Thu, 18 Feb 2021 07:17:32 -0800 (PST)
Date:   Thu, 18 Feb 2021 07:17:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     "Zhang, Qiang" <qiang.zhang@windriver.com>,
        Tejun Heo <tj@kernel.org>, Tejun Heo <htejun@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: Remove rcu_read_lock/unlock() in
 workqueue_congested()
Message-ID: <20210218151732.GR2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210217115802.49580-1-qiang.zhang@windriver.com>
 <CAJhGHyDE18PwQtS_W-aZA4Z6SAX3ZiCr6bA1Gqpu=XMN2n724w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDE18PwQtS_W-aZA4Z6SAX3ZiCr6bA1Gqpu=XMN2n724w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:04:00AM +0800, Lai Jiangshan wrote:
> +CC Paul
> 
> 
> On Wed, Feb 17, 2021 at 7:58 PM <qiang.zhang@windriver.com> wrote:
> >
> > From: Zqiang <qiang.zhang@windriver.com>
> >
> > The RCU read critical area already by preempt_disable/enable()
> > (equivalent to rcu_read_lock_sched/unlock_sched()) mark, so remove
> > rcu_read_lock/unlock().
> 
> I think we can leave it which acks like document, especially
> workqueue_congested() is not performance crucial.  Either way
> is Ok for me.

If the rcu_read_lock() is removed, should there be a comment saying that
it interacts with synchronize_rcu()?  Just in case one of the real-time
guys figures out a way to get the job done without disabling preemption...

							Thanx, Paul

> If it needs to be changed, please also do the same for
> rcu_read_lock() in wq_watchdog_timer_fn().
> 
> And __queue_work() and try_to_grab_pending() also use local_irq_save()
> and rcu_read_lock() at the same time, but I don't know will these
> local_irq_save() be changed to raw_local_irq_save() in PREEMPT_RT.
> 
> 
> >
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > ---
> >  kernel/workqueue.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 0d150da252e8..c599835ad6c3 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -4540,7 +4540,6 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
> >         struct pool_workqueue *pwq;
> >         bool ret;
> >
> > -       rcu_read_lock();
> >         preempt_disable();
> >
> >         if (cpu == WORK_CPU_UNBOUND)
> > @@ -4553,7 +4552,6 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
> >
> >         ret = !list_empty(&pwq->delayed_works);
> >         preempt_enable();
> > -       rcu_read_unlock();
> >
> >         return ret;
> >  }
> > --
> > 2.25.1
> >
