Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFAD323FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhBXOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhBXNQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:16:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B934EC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Pg1x0icFBLk1EvYDl0MXx1yelK4vrkWiLmK8Fes7PZI=; b=H/xBgcIQD+y1eEcjynV15lyE6F
        NR/RU9sJ0T4rTWOAkhuCZeG42awR+kjtUOh5KgwfyAUiRwGvj5Iro+F5Dp6XY/SUtVd5m3FCcjp6R
        fwAAiAtqOkWwTW4kwzIDfFkHU9skgngMzNiAqajn5afkwbOBRiMSrLa4sh2eR2H2zmrpnv4F+R/H+
        r8jCPnLn4KkJu2+hl8HR8AZW/yJK41VCYQFSby+yvVzHZLOBlWYiR8dcingtHoycbODJwawodQddF
        7qRd5mODe2OCgoEM2Ic3TyPaAvXcRHpnrtxdPusbtd7Id13bglX4YhfWwt64l3T72pSrYcd7KvrJO
        VKCj1dNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEu14-00076I-6N; Wed, 24 Feb 2021 13:15:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 076C9300DB4;
        Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DB43C207B3A66; Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Message-ID: <20210224131355.569238629@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Feb 2021 13:24:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 4/6] sched: Optimize migration_cpu_stop()
References: <20210224122439.176543586@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the purpose of migration_cpu_stop() is to migrate the task to
'any' valid CPU, don't migrate the task when it's already running on a
valid CPU.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1936,14 +1936,25 @@ static int migration_cpu_stop(void *data
 			complete = true;
 		}
 
-		if (dest_cpu < 0)
+		if (dest_cpu < 0) {
+			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
+				goto out;
+
 			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
+		}
 
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
 			p->wake_cpu = dest_cpu;
 
+		/*
+		 * XXX __migrate_task() can fail, at which point we might end
+		 * up running on a dodgy CPU, AFAICT this can only happen
+		 * during CPU hotplug, at which point we'll get pushed out
+		 * anyway, so it's probably not a big deal.
+		 */
+
 	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s


