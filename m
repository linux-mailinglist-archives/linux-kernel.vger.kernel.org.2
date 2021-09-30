Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C587B41D606
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349246AbhI3JKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349229AbhI3JKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:10:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F9AC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ox9OWuN7RHJxdHwhF2ob+nn/R5+J/c/5xPc3KgejRW8=; b=v+o1rl+/yLJ3CXs9WeDwgKV6uE
        GFjDcxFj/x9Q+FQy1Zc4ZXtIbmb1vFhZc4mn9YBRq5P/qt7Cw19fQDGFn2uZZ5B/5BaPgMmcAtdnK
        roiH0FSqWUSp1TXg1djk+M7NTuSiMenMTB3P+G36a8c5GoLnJims1tlBlbDwbz4I0AByWWj4q1bPW
        D2IwbTdT6+IkfzQLhHiimNKebXaO2d04zcvUMtAG1bUFjDUlfSGPNbi/sbGTNBYHJ8pNmUrxkJwiM
        VIU3dJ6WaqbmcKl+0sVkQrnMT50GlYKh00j9iYO0bCJbK7jrcCCEbYSePOavYI9661+pkrJnQ8KdW
        bsfVf4ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVs2B-00CgFI-Ic; Thu, 30 Sep 2021 09:07:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 272C3300252;
        Thu, 30 Sep 2021 11:07:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAC9320317205; Thu, 30 Sep 2021 11:07:18 +0200 (CEST)
Date:   Thu, 30 Sep 2021 11:07:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/5] irq_work: Handle some irq_work in SOFTIRQ on
 PREEMPT_RT
Message-ID: <YVV+RklIlsG6N2ic@hirez.programming.kicks-ass.net>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
 <20210927211919.310855-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927211919.310855-5-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:19:18PM +0200, Sebastian Andrzej Siewior wrote:
> The irq_work callback is invoked in hard IRQ context. By default all
> callbacks are scheduled for invocation right away (given supported by
> the architecture) except for the ones marked IRQ_WORK_LAZY which are
> delayed until the next timer-tick.
> 
> While looking over the callbacks, some of them may acquire locks
> (spinlock_t, rwlock_t) which are transformed into sleeping locks on
> PREEMPT_RT and must not be acquired in hard IRQ context.
> Changing the locks into locks which could be acquired in this context
> will lead to other problems such as increased latencies if everything
> in the chain has IRQ-off locks. This will not solve all the issues as
> one callback has been noticed which invoked kref_put() and its callback
> invokes kfree() and this can not be invoked in hardirq context.
> 
> Some callbacks are required to be invoked in hardirq context even on
> PREEMPT_RT to work properly. This includes for instance the NO_HZ
> callback which needs to be able to observe the idle context.
> 
> The callbacks which require to be run in hardirq have already been
> marked. Use this information to split the callbacks onto the two lists
> on PREEMPT_RT:
> - lazy_list
>   Work items which are not marked with IRQ_WORK_HARD_IRQ will be added
>   to this list. Callbacks on this list will be invoked from timer
>   softirq handler. The handler here may acquire sleeping locks such as
>   spinlock_t and invoke kfree().
> 
> - raised_list
>   Work items which are marked with IRQ_WORK_HARD_IRQ will be added to
>   this list. They will be invoked in hardirq context and must not
>   acquire any sleeping locks.
> 
> [bigeasy: melt tglx's irq_work_tick_soft() which splits irq_work_tick() into a
>           hard and soft variant. Collected fixes over time from Steven
> 	  Rostedt and Mike Galbraith. ]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

IIRC we have existing problems in -RT due to this irq_work softirq muck.

I think the problem was something Jolsa found a while ago, where perf
defers to an irq_work (from NMI context) and that irq_work wants to
deliver signals, which it can't on -RT, so the whole thing gets punted
to softirq. With the end-result that if you self-profile RT tasks,
things come apart or something.

There might have been others as well, I don't know. But generally I
think we want *less* softirq, not more.


