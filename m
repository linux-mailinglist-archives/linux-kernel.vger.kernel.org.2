Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292EF3DB0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhG3CBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhG3CA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:00:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DECC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:00:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so8840199yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=815DJ8OtHglvQaLXgblpbZ73YnggNV5/zd6zwJggP0Y=;
        b=NYti1vdbO8cG++R1F2BWMicO6cPbQql9q3TYSaUtkbkz3fI4SUXPaih9shsHhyoQhf
         jBEqldQew5AC/VuD5U+8VSBirL12+TfmW/H6u0pFMQDL8ZL75KNhyiKhvCEjAan7FVXv
         mEFg06RiR5FJCrWuzOAjeOd0yGhIh8bVrhQV6svrD6SMw98yNizJT5C7DeUakreDITXZ
         7xSt47qDhR8VBC5cTGJNVztuO4lE1RpK4weU3Po5V1NXYnYwbD9kpcQ+wiH7i4IcR+5t
         LqzogfLEZl9rX40xGgdI4QRUz9AznZYzzg/Gd+gm7IIHBZS6mlrPG5e7On+jFDAbHeI3
         wvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=815DJ8OtHglvQaLXgblpbZ73YnggNV5/zd6zwJggP0Y=;
        b=SYciqPZiMKcI41UVKtARoAexippQqpGpn694yjYPuK0o2Aed+6+OIYaeRL1TQg4J/w
         aTmTDjQXlcmIoKfidgg2GU3vXgY3rUDpi/F+QKFigA5aB7AjrCit09t9Y1BAd6FopZl9
         JupOIq0xY6yBrE34lFFftSUAE/U3t/+iVWBkH3wpAFothb1PbDcTiHeIKDkCr7wYpFVq
         PjGK2InHB6ylNe6SeoeDmvQ06gAQyeRdbnIfkPYgNHMPAA1QV/KANbG5YkGiOOU+S2LP
         UD9rbZ+ZImN+OZ/ckYaipBSsJijTGuae50uo8w5wXiTsST4MrwuTFhR8xSUPwZgsPNJ9
         MPIQ==
X-Gm-Message-State: AOAM532kOq7/aXXBQTyqOWzNEUNkwlSrlzlonGjItZVsNX9IpsBRH16J
        VhvkhsaB2BTdTvFjwGaU04YOS3CbKkmS
X-Google-Smtp-Source: ABdhPJyypnx++AMOGVhTTYLsGdXqUAYHIfuxDj1o6p9O2jef62cxGn8KzK+3I22U3uo3Drf2tGqe8v30HeSG
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:363b:28db:fef9:14c6])
 (user=joshdon job=sendgmr) by 2002:a25:49c2:: with SMTP id
 w185mr83215yba.294.1627610453816; Thu, 29 Jul 2021 19:00:53 -0700 (PDT)
Date:   Thu, 29 Jul 2021 19:00:19 -0700
In-Reply-To: <20210730020019.1487127-1-joshdon@google.com>
Message-Id: <20210730020019.1487127-3-joshdon@google.com>
Mime-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH 2/2] sched: adjust SCHED_IDLE interactions
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some behavioral changes when SCHED_IDLE entities are
competing with non SCHED_IDLE entities.

1) Ignore min_granularity for determining the sched_slide of a
SCHED_IDLE entity when it is competing with a non SCHED_IDLE entity.
This reduces the latency of getting a non SCHED_IDLE entity back on cpu,
at the expense of increased context switch frequency of SCHED_IDLE
entities.

In steady state competition between SCHED_IDLE/non-SCHED_IDLE,
preemption is driven by the tick, so SCHED_IDLE min_granularity is
approximately bounded on the low end by the tick HZ.

Example: on a machine with HZ=1000, spawned two threads, one of which is
SCHED_IDLE, and affined to one cpu. Without this patch, the SCHED_IDLE
thread runs for 4ms then waits for 1.4s. With this patch, it runs for
1ms and waits 340ms (as it round-robins with the other thread).

The benefit of this change is to reduce the round-robin latency for non
SCHED_IDLE entities when competing with a SCHED_IDLE entity.

2) Don't give sleeper credit to SCHED_IDLE entities when they wake onto
a cfs_rq with non SCHED_IDLE entities. As a result, newly woken
SCHED_IDLE entities will take longer to preempt non SCHED_IDLE entities.

Example: spawned four threads affined to one cpu, one of which was set
to SCHED_IDLE. Without this patch, wakeup latency for the SCHED_IDLE
thread was ~1-2ms, with the patch the wakeup latency was ~10ms.

The benefit of this change is to make it less likely that a newly woken
SCHED_IDLE entity will preempt a short-running non SCHED_IDLE entity
before it blocks.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a7feae1cb0f0..24b2c6c057e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -674,6 +674,7 @@ static u64 __sched_period(unsigned long nr_running)
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	unsigned int nr_running = cfs_rq->nr_running;
+	struct sched_entity *init_se = se;
 	u64 slice;
 
 	if (sched_feat(ALT_PERIOD))
@@ -684,12 +685,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct load_weight *load;
 		struct load_weight lw;
+		struct cfs_rq *qcfs_rq;
 
-		cfs_rq = cfs_rq_of(se);
-		load = &cfs_rq->load;
+		qcfs_rq = cfs_rq_of(se);
+		load = &qcfs_rq->load;
 
 		if (unlikely(!se->on_rq)) {
-			lw = cfs_rq->load;
+			lw = qcfs_rq->load;
 
 			update_load_add(&lw, se->load.weight);
 			load = &lw;
@@ -697,8 +699,18 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		slice = __calc_delta(slice, se->load.weight, load);
 	}
 
-	if (sched_feat(BASE_SLICE))
-		slice = max(slice, (u64)sysctl_sched_min_granularity);
+	if (sched_feat(BASE_SLICE)) {
+		/*
+		 * SCHED_IDLE entities are not subject to min_granularity if
+		 * they are competing with non SCHED_IDLE entities. As a result,
+		 * non SCHED_IDLE entities will have reduced latency to get back
+		 * on cpu, at the cost of increased context switch frequency of
+		 * SCHED_IDLE entities.
+		 */
+		if (!se_is_idle(init_se) ||
+		    cfs_rq->h_nr_running == cfs_rq->idle_h_nr_running)
+			slice = max(slice, (u64)sysctl_sched_min_granularity);
+	}
 
 	return slice;
 }
@@ -4216,7 +4228,15 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 		if (sched_feat(GENTLE_FAIR_SLEEPERS))
 			thresh >>= 1;
 
-		vruntime -= thresh;
+		/*
+		 * Don't give sleep credit to a SCHED_IDLE entity if we're
+		 * placing it onto a cfs_rq with non SCHED_IDLE entities.
+		 */
+		if (!se_is_idle(se) ||
+		    cfs_rq->h_nr_running == cfs_rq->idle_h_nr_running)
+			vruntime -= thresh;
+		else
+			vruntime += 1;
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-- 
2.32.0.554.ge1b32706d8-goog

