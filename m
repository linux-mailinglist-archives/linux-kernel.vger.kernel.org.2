Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B173D392A48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhE0JOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhE0JOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:14:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB0AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wgb6E8dMxJXYjKUUdWK9BOokc0mLqmBW/k+HSWWbfIE=; b=WJv45jld9pW7onaajOTNr3ijop
        pnjcjuHt0zSthYh1I4l16k9nAb2ysoGrHtzEtEbcgvvgFKlg7yd6XSJu62Im+/c8ck34HmUPdCRb/
        H9fyzgrPyag4+FDjx5UguRtZlYC4VpcyG8Wr1RZPCHrjTtXcuqLSQ10wyI/Dw1CVVR4N5jFtyXDG2
        IrnkAphX+XREUG+P740DuuR+0hrz0yZQd0jFkZ+h9lypNrzJhnoGVBlUx7JEG1JxaGJoYyCLtU/pC
        SnNxYFJxtvT64vHqx3uk83TRNGHTCHLUuFhArOflzz49LTeOrY4K9WuwJfycYPrYvq4Af2xCoUSDB
        cGVyh7hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmC3s-000xwS-SF; Thu, 27 May 2021 09:12:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56FE530022C;
        Thu, 27 May 2021 11:12:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3ED1D200E5F57; Thu, 27 May 2021 11:12:22 +0200 (CEST)
Date:   Thu, 27 May 2021 11:12:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] sched: Plug race between SCA, hotplug and
 migration_cpu_stop()
Message-ID: <YK9idgafP4G/ECme@hirez.programming.kicks-ass.net>
References: <20210526205751.842360-1-valentin.schneider@arm.com>
 <20210526205751.842360-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526205751.842360-3-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 09:57:51PM +0100, Valentin Schneider wrote:

> -			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);

Suggests we ought to at the very least include something like the below.

/me continues reading...

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2246,28 +2246,6 @@ struct set_affinity_pending {
 	struct migration_arg	arg;
 };
 
-/*
- * Move (not current) task off this CPU, onto the destination CPU. We're doing
- * this because either it can't run here any more (set_cpus_allowed()
- * away from this CPU, or CPU going down), or because we're
- * attempting to rebalance this task on exec (sched_exec).
- *
- * So we race with normal scheduler movements, but that's OK, as long
- * as the task is no longer on this CPU.
- */
-static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
-				 struct task_struct *p, int dest_cpu)
-{
-	/* Affinity changed (again). */
-	if (!is_cpu_allowed(p, dest_cpu))
-		return rq;
-
-	update_rq_clock(rq);
-	rq = move_queued_task(rq, rf, p, dest_cpu);
-
-	return rq;
-}
-
 static int select_fallback_rq(int cpu, struct task_struct *p);
 
 /*
@@ -2292,7 +2270,7 @@ static int migration_cpu_stop(void *data
 	local_irq_save(rf.flags);
 	/*
 	 * We need to explicitly wake pending tasks before running
-	 * __migrate_task() such that we will not miss enforcing cpus_ptr
+	 * move_queued_task() such that we will not miss enforcing cpus_ptr
 	 * during wakeups, see set_cpus_allowed_ptr()'s TASK_WAKING test.
 	 */
 	flush_smp_call_function_from_idle();
@@ -8463,7 +8441,7 @@ static int __balance_push_cpu_stop(void
 
 	if (task_rq(p) == rq && task_on_rq_queued(p)) {
 		cpu = select_fallback_rq(rq->cpu, p);
-		rq = __migrate_task(rq, &rf, p, cpu);
+		rq = move_queued_task(rq, &rf, p, cpu);
 	}
 
 	rq_unlock(rq, &rf);
