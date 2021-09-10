Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C9C406FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhIJQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:38:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhIJQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:38:17 -0400
Date:   Fri, 10 Sep 2021 18:37:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631291825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IvDpwOczDRqm9rI0g/uY9I1ionUNWs+le2JnOc/SO7Q=;
        b=WKKmzah4eSSVJ7UeCKPRPGa25hwmHIu2o0s56eXAYMrtuvjrpYUGoxBHeM0OCcCHtWGemF
        7WCPp1I1+zZLQYu7pgxd60nRGRGsDGJ2jcENEX0iUajCCG9U03XZBRuWLqq30V4uJqWlK/
        IAzrq8kBEY95oPuJg3oZZPMowWFmH0xT0Zifa89oH8NuYH+UGU4Oyg7FtI59jjJHAd5Ilq
        UqGL2o7uwfPjWxO1+GnPuJRs+vzmm4VqZHYn282Mv5heapfw8eIJp0F6rmQf2C6M7CWPyr
        QHiWsC/Z2pdD/epkrNp3OEPOspXxHbBf7xbTqkEw4iD6fsj6NBXU/jbwlWyb/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631291825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IvDpwOczDRqm9rI0g/uY9I1ionUNWs+le2JnOc/SO7Q=;
        b=kZMv8vD2+4cFldVpYhvijokfw/AyzwCzAhA+gbaZs7eGT4dJCfQ7zWSPZhnPFU9ghYTOIh
        w0EnVF1RG73AQ5AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: Remove rt_rwlock_is_contended()
Message-ID: <20210910163704.ykotcrvbt6yaqron@linutronix.de>
References: <20210906143004.2259141-1-bigeasy@linutronix.de>
 <20210907100944.7qu3frjuuty3oi3d@linutronix.de>
 <20210907103458.l2iyvjps5bjwnzng@linutronix.de>
 <20210910161614.GJ4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210910161614.GJ4323@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-10 18:16:14 [+0200], Peter Zijlstra wrote:
> On Tue, Sep 07, 2021 at 12:34:58PM +0200, Sebastian Andrzej Siewior wrote:
> > rt_rwlock_is_contended() has not users. It makes no sense to use it as
> > rwlock_is_contended() because it is a sleeping lock on RT and preemption
> > is possible. It reports always != 0 if used by a writer and even if
> > there is a waiter then the lock might not be handed over if the
> > current owner has the highest priority.
> 
> I'm confused now... so first you have two patches that wire up
> {spin,rwlock}_is_contended() and how you're arguing we shouldn't do
> that?

Yes. I got arguments against it after sleeping :)

> AFAICT the _is_contended() can still use useful even with preemption,
> the typicla use case is a long lock-holder deciding to drop the lock in
> order to let someone else in. That still works with preemptible locks,
> no?

Sure. We can do that. Then we should look into:
- fixing rwsem_is_contended() for the writer. The writer always observes
  true even with no waiter around.

- checking the top waiter list vs priority of the lock owner/current. If
  the current lock owner has the highest priority then the unlock+lock
  is probably pointless as he regains the lock.
  For the spin_lock() case, if the owner is SCHED_OTHER and the waiter
  is SCHED_OTHER then unlock+lock will give the lock to the previous
  owner due to rt_mutex_steal() working in his favour. Unless there is a
  preemption.

- reader checking for contention is probably pointless. It works with a
  pending writer and one reader since a second reader will hold-off the
  writer from acquiring the lock. Also if the reader does unlock+lock
  then writer might not be quick enough.

Sebastian
