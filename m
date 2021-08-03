Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BBA3DE9F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhHCJtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbhHCJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:49:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CECC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=uLTgg43jTolRBN2Cfu4LwiotiAj0boIpgqpqIEZGy6w=; b=GbmOp/cYA4hCN+ZkebqmhuX49V
        2uzn6eP63MRAvWvwTtKXLXcwbv9bQCBtIYi+zlgFW6v5Dy0K64vuInmGjvbVgl7WEq5fDnzpjBGYW
        oSyLaFJMB8FTHB2kh5Pu7cGdKwrr/+y10jcqnRU+/sel0kL/4UkosIme69e6EY//Wq4BQm1fRboGm
        CyspuXehYHuAP7yr+8101xvieXSrJ2AfSSDhTDRHp6TgBKgJzwjR76rSoFJ5pXRT832t/v4mzQuoU
        +rUA25OW/LJe7lwBJIqvnZt2yvpco95X/8nmH6VdN1uAL/0Wl4Z99KysBeiu0X88GQDHqaS638MFv
        0O0FA/aA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAr2F-005O0P-QZ; Tue, 03 Aug 2021 09:48:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 981ED9862A4; Tue,  3 Aug 2021 11:48:32 +0200 (CEST)
Date:   Tue, 3 Aug 2021 11:48:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 03/63] sched: Prepare for RT sleeping spin/rwlocks
Message-ID: <20210803094832.GA8057@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135205.317820700@linutronix.de>
 <e1fde6625113e7099ddc68f291984b8bedf5e387.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1fde6625113e7099ddc68f291984b8bedf5e387.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 05:30:06PM +0200, Mike Galbraith wrote:
> On Fri, 2021-07-30 at 15:50 +0200, Thomas Gleixner wrote:
> > 
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -155,6 +155,27 @@ struct task_group;
> >                 WRITE_ONCE(current->__state, (state_value));            \
> >                 raw_spin_unlock_irqrestore(&current->pi_lock, flags);   \
> >         } while (0)
> > +
> > +
> > +#define current_save_and_set_rtlock_wait_state()                       \
> > +       do {                                                            \
> > +               raw_spin_lock(&current->pi_lock);                       \

That wants to be irqsafe methinks, I realize this is PREEMPT_RT only and
there the _irqfoo crap is a no-op so this doesn't really matter one way
or the other, but still, taking PI lock without IRQ disable makes my
head go BUG-BUG-BUG :-)

> > +               current->saved_state = current->__state;                \
>                                          ^^should that be using READ_ONCE()?
> 

I think we're good here, per this being 'current' and serialized against
wakeup by virtue of holding pi_lock, __state is actually stable.

> > +		current->saved_state_change = current->task_state_change;\
> > +		current->task_state_change = _THIS_IP_;			\
> > +		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
> > +		raw_spin_unlock(&current->pi_lock);			\
> > +	} while (0);
