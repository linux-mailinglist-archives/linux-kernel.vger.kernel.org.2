Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0076F323FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhBXOaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbhBXNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:18:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CF6C061793
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=68OvZzTYc3WqHusX9KvRarCqQE0VdBLlfaAl85h45Yk=; b=e+8TBO9w57nIK7jt0NyAQz7Dsc
        RVibS41R8MQspAvI4MsKFFgTCuj65d/PACh+qZrs2gyx2k7vtngcFNgnDjiwvHr0Hy0N2Pwm4L+Ym
        MK+tXTV6cgt6kfQZQxI/cXeOiOZ+r3U18frwa7QX/NIrn8BEajjK+N8UrajoVh91ihY3+9HUS0D6E
        lvs4yyNlzC4RBAWNIEIHkrCIScE+sojSO0NHaeYuqvgz9NLcCrsFzLIsCSDfWuKrbmRqvTljx8i0j
        LHRh5t/AZk5CZI2BGB8mi9HS03o2iopSnUaiyl9x7/DPeuwPdPpi6VlIHeguLKZqbXQfJpwW2ii/a
        +9tuqToA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEu14-009Qty-Qh; Wed, 24 Feb 2021 13:15:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21A3B30504E;
        Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D8861207C3A73; Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Message-ID: <20210224131355.500108964@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Feb 2021 13:24:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 3/6] sched: Collate affine_move_task() stoppers
References: <20210224122439.176543586@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCA_MIGRATE_ENABLE and task_running() cases are almost identical,
collapse them to avoid further duplication.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2239,30 +2239,23 @@ static int affine_move_task(struct rq *r
 		return -EINVAL;
 	}
 
-	if (flags & SCA_MIGRATE_ENABLE) {
-
-		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
-		p->migration_flags &= ~MDF_PUSH;
-		task_rq_unlock(rq, p, rf);
-
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
-
-		return 0;
-	}
-
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		/*
-		 * Lessen races (and headaches) by delegating
-		 * is_migration_disabled(p) checks to the stopper, which will
-		 * run on the same CPU as said p.
+		 * MIGRATE_ENABLE gets here because 'p == current', but for
+		 * anything else we cannot do is_migration_disabled(), punt
+		 * and have the stopper function handle it all race-free.
 		 */
+
 		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
+		if (flags & SCA_MIGRATE_ENABLE)
+			p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
 		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 
+		if (flags & SCA_MIGRATE_ENABLE)
+			return 0;
 	} else {
 
 		if (!is_migration_disabled(p)) {


