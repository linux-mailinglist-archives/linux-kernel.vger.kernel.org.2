Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D09450925
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 17:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhKOQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 11:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhKOQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 11:05:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62771C061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mdQOvy69vSFrndarw+JF0lfecfLI+mBimpp1r6sJ1a8=; b=fCwyWTbSuVJEfqWe+n8d6TGHhE
        jLfBvoYg3pV/jwZG7DlJnLG27QXwUnyLi/jAby84zsLb5ko+Gsq5guaYfAuBeP0ICgLAWuPow+Qiw
        asPX1HMXHcBeNhRLosrG8VtRy1xP0PoMatvmmeJSmZKBm98SP2NIHsNjzaJ4l6TjBgOi+iJkeWejx
        5PV8DyHnZmkaRDtI4U9A/fHAaweMkB/ULK8REyhZNiri9USnwoKd+oUmeOn28gaGOF90XxS1V3aGA
        m2hHSgRxRQzJqWNmnt45pOC6/zFWZzOjB6ALUQHA1yaLY5QkhE7m71NG+h9NXmYozzUY9DRvRsevb
        P1D/qAPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmeQf-00GAPH-Ne; Mon, 15 Nov 2021 16:01:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37914300347;
        Mon, 15 Nov 2021 17:01:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ECDE20117B1D; Mon, 15 Nov 2021 17:01:55 +0100 (CET)
Date:   Mon, 15 Nov 2021 17:01:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>
Subject: Re: [PATCH v4] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <YZKEc+SgijOcB+0W@hirez.programming.kicks-ass.net>
References: <20211112040753.389380-1-longman@redhat.com>
 <YY5Z009P2jJ4X484@hirez.programming.kicks-ass.net>
 <a141b93d-1945-a44d-467f-54b648cbf4d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a141b93d-1945-a44d-467f-54b648cbf4d0@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 10:38:57PM -0500, Waiman Long wrote:
> On 11/12/21 07:10, Peter Zijlstra wrote:

> > Argh, rwsem_mark_wake() doesn't clear HANDOFF when list_empty(), and
> > write_slowpath() is *far* too clever about all of this.
> rwsem_mark_wake() does clear the HANDOFF flag if it was set.

Argh, yeah, I got confused by the whole !woken case, but that case won't
ever hit list_empty() either. Perhaps that stuff could use a bit of a
reflow too.


> > > @@ -1098,7 +1110,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
> > >   		 * In this case, we attempt to acquire the lock again
> > >   		 * without sleeping.
> > >   		 */
> > > -		if (wstate == WRITER_HANDOFF) {
> > > +		if (waiter.handoff_set) {
> > I'm thinking this wants to be something like:
> > 
> > 		if (rwsem_first_waiter(sem) == &waiter && waiter.handoff_set) {
> handoff_set flag is only set when the waiter becomes the first.

Yes, but a random waiter can wake up and see it be set and also start
spinning.

> > 
> > >   			enum owner_state owner_state;
> > >   			preempt_disable();

> > @@ -575,6 +610,11 @@ static inline bool rwsem_try_write_lock(
> >   		return false;
> >   	}
> > +	/*
> > +	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
> > +	 * success.
> > +	 */
> > +	list_del(&waiter->list);
> >   	rwsem_set_owner(sem);
> >   	return true;
> >   }

> > @@ -1128,16 +1153,14 @@ rwsem_down_write_slowpath(struct rw_sema
> >   		raw_spin_lock_irq(&sem->wait_lock);
> >   	}
> >   	__set_current_state(TASK_RUNNING);
> > -	list_del(&waiter.list);
> +    rwsem_del_waiter(sem, &waiters); ?

I tried that, but then we get an extra atomic in this path. As is I made
try_write_lock() do the full del_waiter, see the hunk above.

> >   	raw_spin_unlock_irq(&sem->wait_lock);
> >   	lockevent_inc(rwsem_wlock);
> > -
> > -	return ret;
> > +	return sem;
> >   out_nolock:
> >   	__set_current_state(TASK_RUNNING);
> >   	raw_spin_lock_irq(&sem->wait_lock);
> > -	rwsem_out_nolock_clear_flags(sem, &waiter);
> > +	rwsem_del_waiter(sem, &waiter);
> >   	if (!list_empty(&sem->wait_list))
> >   		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
> >   	raw_spin_unlock_irq(&sem->wait_lock);
> > 
> Sorry for the late reply as I was busy on other works.
> 
> I like the idea. I will incorporate in a new patch tomorrow.

Thanks!
