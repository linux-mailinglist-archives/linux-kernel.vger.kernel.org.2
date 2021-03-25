Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CCC349AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCYTve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCYTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:51:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59743C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:51:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616701870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATCY5fT3ztxotw8/PweNSVsUj4wxjdnYQR7LylBMeGY=;
        b=XCguCDAazYJoo9xI0zgIQvGRF92SgOhfNnX2Fb+nPjikb38WyrJmRdevzZ/QJZaerKI043
        HTwTG00MwZ6osjINjJksB5NTDbyP98ZVpwCstc2ePMBfQyroJ/tmivNsEIEj5Q5Me6ujcR
        O4Yx7OBRQ5Ya/gpOcA8D70ug+ZcOPGgtnnVMeuDgDyxtZdBYlYYrKGNELuf9UCazH7+MQf
        c+aSEF0dALzPPbM+R1JsHL0TF3zIuggEQuxxJWXZcrQW/UUszx5PMufzTuOu0CZhY2tG5D
        j1R+ui6S+UWbJM0QaM8S8iYzZEHvprWWCRQ5l5HiNc9ofCx0SDE1hOBIkedvsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616701870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATCY5fT3ztxotw8/PweNSVsUj4wxjdnYQR7LylBMeGY=;
        b=MUotxBPiy9akk/Q/j6VnWvuJGYZaa9enSPb92oLJfhqj0PjqcA2oaGDACzjNsyS+mg0Qco
        p/7if6GxDEwPAOAA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] task_struct::state frobbing
In-Reply-To: <YFzSWR6mAGitxMqA@hirez.programming.kicks-ass.net>
References: <YFzSWR6mAGitxMqA@hirez.programming.kicks-ass.net>
Date:   Thu, 25 Mar 2021 20:51:10 +0100
Message-ID: <87blb7vwpd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25 2021 at 19:11, Peter Zijlstra wrote:
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3867,7 +3867,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
>  int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>  {
>  	struct blk_mq_hw_ctx *hctx;
> -	long state;
> +	unsigned int state;
>  
>  	if (!blk_qc_t_valid(cookie) ||
>  	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> @@ -3891,7 +3891,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>  
>  	hctx->poll_considered++;
>  
> -	state = current->state;
> +	state = READ_ONCE(current->__state);

Can we please have get_current_state() for that?

>  static bool io_wq_worker_affinity(struct io_worker *worker, void *data)
>  {
> -	struct task_struct *task = worker->task;
> -	struct rq_flags rf;
> -	struct rq *rq;
> -
> -	rq = task_rq_lock(task, &rf);
> -	do_set_cpus_allowed(task, cpumask_of_node(worker->wqe->node));
> -	task->flags |= PF_NO_SETAFFINITY;
> -	task_rq_unlock(rq, task, &rf);
> +	set_cpus_allowed_ptr(worker->task, cpumask_of_node(worker->wqe->node));

Duh, I thought we got all of them by now.

Thanks,

        tglx
