Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76C9408A08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhIMLV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbhIMLV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:21:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A23C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9pGUQNlOf21affJQQWLYGjo1GPP/2Oe6DkEkHwwWLEA=; b=QovnLdj9HF14SVXlGgP5XfeZw1
        nd4ihRhDM5j72h5GilByaslQJOQlbDKiNly8CFoWd6qrKPGHiGNswGIxmIUaYffEd2x/SoTOFdrx+
        VgB3rT1Cs4OLWDNhwz4DETkn4/akgCmdvPGWvEh8q6+JcaPSoB+di9MI1b5cZ46qgROuBTL92bTrK
        QbQcLhsieDBtI6sSj1sVgCPlDBbWAREVZ58AcqCRtC4bKxtTiikDonSZ4vl2RhLWBjUZ8Rmsvb5P1
        1QIB/IRu6sB9nSiIvXULUTXOYNIxG10atJ3+gNkxzGHBXj96gf6X88Dwfl17Y4xNIU05eWF3chuIM
        s8Z2GKjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPk0n-002oMY-Vg; Mon, 13 Sep 2021 11:20:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A95F1300093;
        Mon, 13 Sep 2021 13:20:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9817E207C3400; Mon, 13 Sep 2021 13:20:32 +0200 (CEST)
Date:   Mon, 13 Sep 2021 13:20:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: Remove rt_rwlock_is_contended()
Message-ID: <YT80AB8/G59QBSVq@hirez.programming.kicks-ass.net>
References: <20210906143004.2259141-1-bigeasy@linutronix.de>
 <20210907100944.7qu3frjuuty3oi3d@linutronix.de>
 <20210907103458.l2iyvjps5bjwnzng@linutronix.de>
 <20210910161614.GJ4323@worktop.programming.kicks-ass.net>
 <20210910163704.ykotcrvbt6yaqron@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910163704.ykotcrvbt6yaqron@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 06:37:04PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-10 18:16:14 [+0200], Peter Zijlstra wrote:
> > On Tue, Sep 07, 2021 at 12:34:58PM +0200, Sebastian Andrzej Siewior wrote:

> Yes. I got arguments against it after sleeping :)

Sleep is magical :-)

> > AFAICT the _is_contended() can still use useful even with preemption,
> > the typicla use case is a long lock-holder deciding to drop the lock in
> > order to let someone else in. That still works with preemptible locks,
> > no?
> 
> Sure. We can do that. Then we should look into:
> - fixing rwsem_is_contended() for the writer. The writer always observes
>   true even with no waiter around.

Right, that function does look somewhat dodgy. I'm thinking the current
function returns true if there's more than a single reader present (or a
writer) present, which is not the same.

I suppose it shoud return something like:

  for a writer: rt_mutex_is_contended(&rwb->rtmutex);
  for a reader: rt_mutex_is_locked(&rwb->rtmutex);

However, given the below arguments,,,

> - checking the top waiter list vs priority of the lock owner/current. If
>   the current lock owner has the highest priority then the unlock+lock
>   is probably pointless as he regains the lock.
>   For the spin_lock() case, if the owner is SCHED_OTHER and the waiter
>   is SCHED_OTHER then unlock+lock will give the lock to the previous
>   owner due to rt_mutex_steal() working in his favour. Unless there is a
>   preemption.

That is a good argument against all this; I had not considered that.

> - reader checking for contention is probably pointless. It works with a
>   pending writer and one reader since a second reader will hold-off the
>   writer from acquiring the lock. Also if the reader does unlock+lock
>   then writer might not be quick enough.

Should be fixable with a handoff, but yeah.

OK, I suppose the safe and easy option is to never report contention as
per your latest patch, and if/when someone complains about it, they can
sort through these issues :-)
