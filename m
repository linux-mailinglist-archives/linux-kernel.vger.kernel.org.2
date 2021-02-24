Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74683324157
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhBXPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhBXPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:36:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C47C061788
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JCkYrcZlxdxfoVNc1cEMypWzJ6c2NYyR/a+MaqpLe9A=; b=oqxleu2C5+KgJv4XfxQdzfxl4M
        peJjjpdoPGzkTbIFBLAfkRNNh9jyHn3No2a77BMrzCoQXAzO3ArVGmgS5OIUlU+T0uiLNeKFrHXq3
        6jNIKcH1BR/E9fPZy/wAN88P+WjXhWsiH4v+HdejI8xrscY/sFYNjyMNC5BWZnfdk4cEpRq8J2Xc6
        hUBjMv0nB9cTyy6GG39Lej8IJpVbbkMn4fjchUqekeGVJISC5anvSLQwMBZimGktuF9S2T/xaeXEb
        58PTVUrgSTtJ0pmaPgGNujCNA8oJMyTqMQjadDlx2IiRPwk6MSvKA+nT9jKVVHNddIbRNO4BfZXFH
        8a1jcjPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEwBn-009ZOG-KF; Wed, 24 Feb 2021 15:35:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BC5630477A;
        Wed, 24 Feb 2021 16:34:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5700C200E0496; Wed, 24 Feb 2021 16:34:58 +0100 (CET)
Date:   Wed, 24 Feb 2021 16:34:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 6/6] sched: Simplify set_affinity_pending refcounts
Message-ID: <YDZyIugiyxAq0tVz@hirez.programming.kicks-ass.net>
References: <20210224122439.176543586@infradead.org>
 <20210224131355.724130207@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224131355.724130207@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 01:24:45PM +0100, Peter Zijlstra wrote:
> @@ -2199,12 +2199,16 @@ static int affine_move_task(struct rq *r
>  			push_task = get_task_struct(p);
>  		}
>  
> +		/*
> +		 * If there are pending waiters, but no pending stop_work,
> +		 * then complete now.
> +		 */
>  		pending = p->migration_pending;
> +		if (pending && !pending->stop_pending) {
>  			p->migration_pending = NULL;
>  			complete = true;
>  		}

> @@ -2282,12 +2286,13 @@ static int affine_move_task(struct rq *r
>  			if (task_on_rq_queued(p))
>  				rq = move_queued_task(rq, rf, p, dest_cpu);
>  
> +			if (!pending->stop_pending) {
> +				p->migration_pending = NULL;
> +				complete = true;
> +			}
>  		}
>  		task_rq_unlock(rq, p, rf);

Elsewhere Valentin argued something like the below ought to be possible.
I've not drawn diagrams yet, but if I understood his argument right it
should be possible.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1c56ac4df2c9..3ffbd1b76f3e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2204,9 +2204,10 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		 * then complete now.
 		 */
 		pending = p->migration_pending;
-		if (pending && !pending->stop_pending) {
+		if (pending) {
 			p->migration_pending = NULL;
-			complete = true;
+			if (!pending->stop_pending)
+				complete = true;
 		}
 
 		task_rq_unlock(rq, p, rf);
@@ -2286,10 +2287,9 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			if (task_on_rq_queued(p))
 				rq = move_queued_task(rq, rf, p, dest_cpu);
 
-			if (!pending->stop_pending) {
-				p->migration_pending = NULL;
+			p->migration_pending = NULL;
+			if (!pending->stop_pending)
 				complete = true;
-			}
 		}
 		task_rq_unlock(rq, p, rf);
 
