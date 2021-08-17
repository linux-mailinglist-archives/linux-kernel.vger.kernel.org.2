Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3494F3EEB74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbhHQLSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbhHQLSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:18:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B781C061796
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c4so8314161plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bQgFJmhqZNDr9ziYED/kge4ik4AzOoubORy0cWnTvwk=;
        b=PslEYPKmvhL3Oewd5oCaFg3vUpavsr8z1+xhGPT0m5fxt308loGk11JXCsbNxJ3+TG
         VNdA/qVgadLYUsT/RDHDt2BdT0oPUKd7bVrAeV8dkgE8DDtLBaAKxyE/RJ3UWRNY6gCC
         SW8NCVLiNzRUGkAv3oVhbmttHLi4gSno3aVZ9zCTY/IHpL6Fxf36LeEuRRCRpDiBKOGu
         ukBIfaaD69W0awdahiGNLtO4USWUIc9FNHa4tF0iHNEPoOMR01irkSmiwwsRdrC0eAzo
         ePuoR965IRW8rWvHPRd1P+s25CYmDa/32uCqn62C7Hzs3S3zaya1AE+fpwK8ODRZylLj
         Jo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQgFJmhqZNDr9ziYED/kge4ik4AzOoubORy0cWnTvwk=;
        b=ulME+/4RuNtvFf1Dk70AmGxX6skhXdTq4V6uYABE48TpPE8N7T0m+tHuBAFTTUWpc3
         S2coPp6GXXZ6c778ivaOVbbx+IBtdC55qBG1TTz6FAmL5Wft8QZoqTyQ+od9fYX72Yie
         eHWRckJsydPF7XiTqkhTgcv3X0c/P/Bhj89AIedPMbPx8sclBFGb8FOwE/CkhLtVtFl/
         oUso/D3q256zoXB0QU75Aq3Ru2PbAUiXCjbpbwSIGJa3Z3iUBsVuj28JKFoqbEc52hjg
         o8dMzZKO67q7R4mp2xLzf6INvRcftPapU0Ce2mVZYVkT9OB7u6s3yIDleBLvtziJ658H
         1k/g==
X-Gm-Message-State: AOAM533nJsmwTf0CZLM6JgBvKJuA57be0tKRjlyljVvuA+OcpJiTMom5
        7PodMvT2sJt2zHPmLFNwDi2/Tc9PYCI=
X-Google-Smtp-Source: ABdhPJzCw6HoSZkTTGz6OBfyvkKKWzXLoVE/wQxohXwXMxzdfTDWkiSIIJRZe2RF5dUZ0RmwzB6mYg==
X-Received: by 2002:a17:902:ecca:b029:12d:1a3b:571f with SMTP id a10-20020a170902eccab029012d1a3b571fmr2451708plh.37.1629199100248;
        Tue, 17 Aug 2021 04:18:20 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id m2sm2756706pgu.15.2021.08.17.04.18.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 04:18:20 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 4/6] workqueue: Mark barrier work with WORK_STRUCT_INACTIVE
Date:   Tue, 17 Aug 2021 09:32:37 +0800
Message-Id: <20210817013239.3921-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210817013239.3921-1-jiangshanlai@gmail.com>
References: <CAJhGHyBsn+rqVQzNqRw2RxtpHyrpQpa0kMtU1RcZP7TCbC6dqg@mail.gmail.com>
 <20210817013239.3921-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Currently, WORK_NO_COLOR has two meanings:
	Not participate in flushing
	Not participate in nr_active

And only non-barrier work items are marked with WORK_STRUCT_INACTIVE
when they are in inactive_works list.  The barrier work items are not
marked INACTIVE even linked in inactive_works list since these tail
items are always moved together with the head work item.

These definitions are simple, clean and practical. (Except a small
blemish that only the first meaning of WORK_NO_COLOR is documented in
include/linux/workqueue.h while both meanings are in workqueue.c)

But dual-purpose WORK_NO_COLOR used for barrier work items has proven to
be problematical[1].  Only the second purpose is obligatory.  So we plan
to make barrier work items participate in flushing but keep them still
not participating in nr_active.

So the plan is to mark barrier work items inactive without using
WORK_NO_COLOR in this patch so that we can assign a flushing color to
them in next patch.

The reasonable way is to add or reuse a bit in work data of the work
item.  But adding a bit will double the size of pool_workqueue.

Currently, WORK_STRUCT_INACTIVE is only used in try_to_grab_pending()
for user-queued work items and try_to_grab_pending() can't work for
barrier work items.  So we extend WORK_STRUCT_INACTIVE to also mark
barrier work items no matter which list they are in because we don't
need to determind which list a barrier work item is in.

So the meaning of WORK_STRUCT_INACTIVE becomes just "the work items don't
participate in nr_active" (no matter whether it is a barrier work item or
a user-queued work item).  And WORK_STRUCT_INACTIVE for user-queued work
items means they are in inactive_works list.

This patch does it by setting WORK_STRUCT_INACTIVE for barrier work items
in insert_wq_barrier() and checking WORK_STRUCT_INACTIVE first in
pwq_dec_nr_in_flight().  And the meaning of WORK_NO_COLOR is reduced to
only "not participating in flushing".

There is no functionality change intended in this patch.  Because
WORK_NO_COLOR+WORK_STRUCT_INACTIVE represents the previous WORK_NO_COLOR
in meaning and try_to_grab_pending() doesn't use for barrier work items
and avoids being confused by this extended WORK_STRUCT_INACTIVE.

A bunch of comment for nr_active & WORK_STRUCT_INACTIVE is also added for
documenting how WORK_STRUCT_INACTIVE works in nr_active management.

[1]: https://lore.kernel.org/lkml/20210812083814.32453-1-lizhe.67@bytedance.com/
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 55fc2d1688d9..1b2792b397f0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -205,6 +205,23 @@ struct pool_workqueue {
 	int			refcnt;		/* L: reference count */
 	int			nr_in_flight[WORK_NR_COLORS];
 						/* L: nr of in_flight works */
+
+	/*
+	 * nr_active management and WORK_STRUCT_INACTIVE:
+	 *
+	 * When pwq->nr_active >= max_active, new work item is queued to
+	 * pwq->inactive_works instead of pool->worklist and marked with
+	 * WORK_STRUCT_INACTIVE.
+	 *
+	 * All work items marked with WORK_STRUCT_INACTIVE do not participate
+	 * in pwq->nr_active and all work items in pwq->inactive_works are
+	 * marked with WORK_STRUCT_INACTIVE.  But not all WORK_STRUCT_INACTIVE
+	 * work items are in pwq->inactive_works.  Some of them are ready to
+	 * run in pool->worklist or worker->scheduled.  Those work itmes are
+	 * only struct wq_barrier which is used for flush_work() and should
+	 * not participate in pwq->nr_active.  For non-barrier work item, it
+	 * is marked with WORK_STRUCT_INACTIVE iff it is in pwq->inactive_works.
+	 */
 	int			nr_active;	/* L: nr of active works */
 	int			max_active;	/* L: max active works */
 	struct list_head	inactive_works;	/* L: inactive works */
@@ -1171,19 +1188,21 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 {
 	int color = get_work_color(work_data);
 
-	/* uncolored work items don't participate in flushing or nr_active */
+	if (!(work_data & WORK_STRUCT_INACTIVE)) {
+		pwq->nr_active--;
+		if (!list_empty(&pwq->inactive_works)) {
+			/* one down, submit an inactive one */
+			if (pwq->nr_active < pwq->max_active)
+				pwq_activate_first_inactive(pwq);
+		}
+	}
+
+	/* uncolored work items don't participate in flushing */
 	if (color == WORK_NO_COLOR)
 		goto out_put;
 
 	pwq->nr_in_flight[color]--;
 
-	pwq->nr_active--;
-	if (!list_empty(&pwq->inactive_works)) {
-		/* one down, submit an inactive one */
-		if (pwq->nr_active < pwq->max_active)
-			pwq_activate_first_inactive(pwq);
-	}
-
 	/* is flush in progress and are we at the flushing tip? */
 	if (likely(pwq->flush_color != color))
 		goto out_put;
@@ -1283,6 +1302,10 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		debug_work_deactivate(work);
 
 		/*
+		 * A cancelable inactive work item must be in the
+		 * pwq->inactive_works since a queued barrier can't be
+		 * canceled (see the comments in insert_wq_barrier()).
+		 *
 		 * An inactive work item cannot be grabbed directly because
 		 * it might have linked NO_COLOR work items which, if left
 		 * on the inactive_works list, will confuse pwq->nr_active
@@ -2676,6 +2699,9 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 
 	barr->task = current;
 
+	/* The barrier work item does not participate in pwq->nr_active. */
+	work_flags |= WORK_STRUCT_INACTIVE;
+
 	/*
 	 * If @target is currently being executed, schedule the
 	 * barrier to the worker; otherwise, put it after @target.
-- 
2.19.1.6.gb485710b

