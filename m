Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7C34A2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhCZH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCZH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:57:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F53C0613B0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fC48jgye19/SBBinr2i/1nefzKqg4RZVhxRk4g6QixU=; b=FAUMYML5q8J3VQkEvqOc5ZW8cs
        mBWE8H1qleIg6Z68NR3+Abf+VkBB4CTzAxLPr5X+ZvCj+QmLmJ3CZAP+x/3HiANmMKxAgeMJYMkvk
        FCqMWxZqDkKsG6ZbkVU2yh7TM39pyxTs15FwKsQECOIG4/guevnxh/gRvztutrGRlmvMUPldOm5Wp
        98WvZCDOYiCJwyVYhz6ZTA1oHSE68ja2S7bT7HGHd1KY8CHO343o6fbScX+IiKoK7VjxbPyeV5XVR
        FshjbxD7whv14HJVa0o9VO0AmOLzX+JG4EfKodgTGdwm2YpujDCycsXYChZenxLU89O3V919xgznO
        Ok+oksow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPhKk-00EUEC-Hk; Fri, 26 Mar 2021 07:56:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA528306099;
        Fri, 26 Mar 2021 08:56:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6F6620C8D69C; Fri, 26 Mar 2021 08:56:40 +0100 (CET)
Date:   Fri, 26 Mar 2021 08:56:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] task_struct::state frobbing
Message-ID: <YF2TuBQxU3om/rmT@hirez.programming.kicks-ass.net>
References: <YFzSWR6mAGitxMqA@hirez.programming.kicks-ass.net>
 <87blb7vwpd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blb7vwpd.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:51:10PM +0100, Thomas Gleixner wrote:
> On Thu, Mar 25 2021 at 19:11, Peter Zijlstra wrote:
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3867,7 +3867,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
> >  int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> >  {
> >  	struct blk_mq_hw_ctx *hctx;
> > -	long state;
> > +	unsigned int state;
> >  
> >  	if (!blk_qc_t_valid(cookie) ||
> >  	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> > @@ -3891,7 +3891,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> >  
> >  	hctx->poll_considered++;
> >  
> > -	state = current->state;
> > +	state = READ_ONCE(current->__state);
> 
> Can we please have get_current_state() for that?

Sure...

> >  static bool io_wq_worker_affinity(struct io_worker *worker, void *data)
> >  {
> > -	struct task_struct *task = worker->task;
> > -	struct rq_flags rf;
> > -	struct rq *rq;
> > -
> > -	rq = task_rq_lock(task, &rf);
> > -	do_set_cpus_allowed(task, cpumask_of_node(worker->wqe->node));
> > -	task->flags |= PF_NO_SETAFFINITY;
> > -	task_rq_unlock(rq, task, &rf);
> > +	set_cpus_allowed_ptr(worker->task, cpumask_of_node(worker->wqe->node));
> 
> Duh, I thought we got all of them by now.

It's new and horrible crap, already send an email to Jens about it. It
shouldn't be in this patch, but I didn't clean up.
