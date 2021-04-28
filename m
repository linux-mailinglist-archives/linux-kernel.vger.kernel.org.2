Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B63536D2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhD1HQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhD1HQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:16:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EF1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YAx1czeZMGTOngYcTaYGWSs9XW5iqQk2Rryh4aE/lZA=; b=JHGcuwZvy3sGa0Vl51dbGMcCTU
        kEkaCT8S5SuSaINe07eQ3iWSMqhOxYqWXHFt2vTWBmjS3b0nMd1JP+600AhdNmVsY5KKNskun2B68
        KF8/Ie6Mob1I/Eq/d/QjzBX3unmicHdmy0K0jd+IZWz/j+/EVnOxSOkI6c86s85aI5r/1MPq+qM2o
        +OmBfZgb2hi7X5c+Hj+LUqmVFBMxllJ1NRiLgqxAZPyys82HWBAgs3aLtT70yA3Hy+w0O3ooU6aoL
        +S4Ti/d2EXeE9B93RhXoE+NTFPjb1zDUYgfqGmW4UKPTy2DtIBGsEOb4UQ0mPPiDRQhPa+C1Wh/7t
        ilm5yANA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbeOI-007y9Y-Rh; Wed, 28 Apr 2021 07:13:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 362B030003A;
        Wed, 28 Apr 2021 09:13:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F5F32D3DF417; Wed, 28 Apr 2021 09:13:44 +0200 (CEST)
Date:   Wed, 28 Apr 2021 09:13:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <YIkLKNdr8Zld+0u4@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net>
 <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 03:21:36PM -0700, Josh Don wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f732642e3e09..1a81e9cc9e5d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -290,6 +290,10 @@ static void sched_core_assert_empty(void)
> >  static void __sched_core_enable(void)
> >  {
> >         static_branch_enable(&__sched_core_enabled);
> > +       /*
> > +        * Ensure raw_spin_rq_*lock*() have completed before flipping.
> > +        */
> > +       synchronize_sched();
> 
> synchronize_rcu()

Moo, I actually like synchronize_sched() because it indicates it matches
a preempt disabled region.

> >         __sched_core_flip(true);
> >         sched_core_assert_empty();
> >  }
> > @@ -449,16 +453,22 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
> >  {
> >         raw_spinlock_t *lock;
> >
> > +       preempt_disable();
> >         if (sched_core_disabled()) {
> >                 raw_spin_lock_nested(&rq->__lock, subclass);
> > +               /* preempt *MUST* still be disabled here */
> > +               preempt_enable_no_resched();
> >                 return;
> >         }
> 
> This approach looks good to me. I'm guessing you went this route
> instead of doing the re-check after locking in order to optimize the
> disabled case?

Exactly.

> Recommend a comment that the preempt_disable() here pairs with the
> synchronize_rcu() in __sched_core_enable().

Fair enough.
