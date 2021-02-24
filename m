Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAE5324025
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhBXOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbhBXNZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:25:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8759AC06178C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=J7NU1US48KeKR9uJW6Wimqbg7wFpAd5MGGhuZV0bpr4=; b=FDfUpkdTXUkkafnjQZDRJhNv8d
        b9afaLxfQZ2XM8lMpz5W002DOVy9HcvLpZbu98vfJT6ydc7Okay5KWZ4t3ZI74u4C3R03bO3D+8eH
        blhvfTixWRhFJ7sJUK8rEtZY2IibcNkSJqcnrXq5zXXIJfaCnX/sjdMwZOWoSJzpbE/XugR4xXRHE
        nTIAygY451HHluWVhxyx8qEH28v2sdyOWKPDtm4Z5GgjLLGIElqc6PBYqcgJxjxWpCDk7v4Cxsk8m
        vv6p39qMGbUT2PClXwQjYZTrrjTrUuNtcvIepYC1qiqnC7yKzXlLpxERcoxYHdPppBHcljeHN8UFy
        HZylnZzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEu13-009Qtn-BO; Wed, 24 Feb 2021 13:15:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58385306CEE;
        Wed, 24 Feb 2021 14:15:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E4730207C3A76; Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Message-ID: <20210224131355.724130207@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Feb 2021 13:24:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 6/6] sched: Simplify set_affinity_pending refcounts
References: <20210224122439.176543586@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have set_affinity_pending::stop_pending to indicate if a
stopper is in progress, and we have the guarantee that if that stopper
exists, it will (eventually) complete our @pending we can simplify the
refcount scheme by no longer counting the stopper thread.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1862,6 +1862,10 @@ struct migration_arg {
 	struct set_affinity_pending	*pending;
 };
 
+/*
+ * @refs: number of wait_for_completion()
+ * @stop_pending: is @stop_work in use
+ */
 struct set_affinity_pending {
 	refcount_t		refs;
 	unsigned int		stop_pending;
@@ -1997,10 +2001,6 @@ static int migration_cpu_stop(void *data
 	if (complete)
 		complete_all(&pending->done);
 
-	/* For pending->{arg,stop_work} */
-	if (pending && refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
-
 	return 0;
 }
 
@@ -2199,12 +2199,16 @@ static int affine_move_task(struct rq *r
 			push_task = get_task_struct(p);
 		}
 
+		/*
+		 * If there are pending waiters, but no pending stop_work,
+		 * then complete now.
+		 */
 		pending = p->migration_pending;
-		if (pending) {
-			refcount_inc(&pending->refs);
+		if (pending && !pending->stop_pending) {
 			p->migration_pending = NULL;
 			complete = true;
 		}
+
 		task_rq_unlock(rq, p, rf);
 
 		if (push_task) {
@@ -2213,7 +2217,7 @@ static int affine_move_task(struct rq *r
 		}
 
 		if (complete)
-			goto do_complete;
+			complete_all(&pending->done);
 
 		return 0;
 	}
@@ -2264,9 +2268,9 @@ static int affine_move_task(struct rq *r
 		if (!stop_pending)
 			pending->stop_pending = true;
 
-		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
+
 		task_rq_unlock(rq, p, rf);
 
 		if (!stop_pending) {
@@ -2282,12 +2286,13 @@ static int affine_move_task(struct rq *r
 			if (task_on_rq_queued(p))
 				rq = move_queued_task(rq, rf, p, dest_cpu);
 
-			p->migration_pending = NULL;
-			complete = true;
+			if (!pending->stop_pending) {
+				p->migration_pending = NULL;
+				complete = true;
+			}
 		}
 		task_rq_unlock(rq, p, rf);
 
-do_complete:
 		if (complete)
 			complete_all(&pending->done);
 	}
@@ -2295,7 +2300,7 @@ static int affine_move_task(struct rq *r
 	wait_for_completion(&pending->done);
 
 	if (refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
+		wake_up_var(&pending->refs); /* No UaF, just an address */
 
 	/*
 	 * Block the original owner of &pending until all subsequent callers
@@ -2303,6 +2308,9 @@ static int affine_move_task(struct rq *r
 	 */
 	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
 
+	/* ARGH */
+	WARN_ON_ONCE(my_pending.stop_pending);
+
 	return 0;
 }
 


