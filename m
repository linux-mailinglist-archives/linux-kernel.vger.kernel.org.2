Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1239A2BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFCOFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhFCOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:05:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE23C061756
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 07:03:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a4so7302393ljd.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQZ+QwTHZLmMmg/eLqJwYKGllqljq+Cw+s8mBQT4tIc=;
        b=QXNV79K5rIlKZGl9q8nZnXu2xrx2Fh5TYF7WJdZbWuN/rKd/SRgxbkWad9bzRWBXDo
         m255mOdNFQRpv3JPS7fA1PIi/cmHF0ftKr9ulzvLr23BN+r+52d4cENrW3By4eX3KOcF
         VzrzpStQs3LWSoRzut3h1drtE+mPxDp0OaegVNW2mBWjx9kND3LSL5xPlPM9ZTYTh3WS
         kFEkFXYzS1lDpOswoDSfuvg/yxe3+W3Ahc/ZI96clT7HmGG7AP87rKsJzBkRobrz7e5k
         8Dlkq1+AybOp12DJwqDrZEbWMyVeUrNbk6kREztnlCjhsRimcSSXE+rbF9SyCPSaEujM
         Fzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQZ+QwTHZLmMmg/eLqJwYKGllqljq+Cw+s8mBQT4tIc=;
        b=bPjV8fGfPuCrJmDhZihR/1xohq6BFZs437XNL+Hul7h91xQt/inbX0KFldMmSrk5qa
         qOB4NhLPPkYICuvD0ubGTvLx6bFD3R8/RayDqx8qw5D+7TvoY3aYkAyELnpZzA1mNQJi
         qApRJf+ot/GXsZCb8HDohrtJIVNdWbK/MuiDWJYfmZ2c3SBUJhr6kAoH9YQCRHyJCxtf
         HbWbavRqD31IZBXiMCEeMUQJi5bEFpcXFvCtCUjawj4ho8UUrFxRX7DyzrdI1PmpQKxl
         lQ4jYq05reOBmFh7R3uim9mR0l8H9nZXTZ4Y8c6iwvPg9ft9lSi5MzC7vkllrf5f35fC
         IjcA==
X-Gm-Message-State: AOAM532XbwoPDwh5upMXAXq3JI/b1U04VKc3ScOwZrB4TiBdpziSiuQW
        ZJekUavpmH3E9TPSX7xyhLQUoQ==
X-Google-Smtp-Source: ABdhPJw4XfSSUq8Ok7cdDIrfpiBZpMmIMc4qhhsEIJPgxIvGLBizwYl8bGyNH+lFBtmTN6h/jCEHNQ==
X-Received: by 2002:a2e:90f:: with SMTP id 15mr6957013ljj.277.1622729011194;
        Thu, 03 Jun 2021 07:03:31 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id z2sm327799lfe.229.2021.06.03.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:03:30 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH v3] sched/fair: Correctly insert cfs_rq's to list on unthrottle
Date:   Thu,  3 Jun 2021 16:00:32 +0200
Message-Id: <20210603140032.224359-1-odin@uged.al>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an issue where fairness is decreased since cfs_rq's can
end up not being decayed properly. For two sibling control groups with
the same priority, this can often lead to a load ratio of 99/1 (!!).

This happen because when a cfs_rq is throttled, all the descendant cfs_rq's
will be removed from the leaf list. When they initial cfs_rq is
unthrottled, it will currently only re add descendant cfs_rq's if they
have one or more entities enqueued. This is not a perfect heuristic.

Instead, we insert all cfs_rq's that contain one or more enqueued
entities, or it its load is not completely decayed.

Can often lead to situations like this for equally weighted control
groups:

$ ps u -C stress
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       10009 88.8  0.0   3676   100 pts/1    R+   11:04   0:13 stress --cpu 1
root       10023  3.0  0.0   3676   104 pts/1    R+   11:04   0:00 stress --cpu 1

Fixes: 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
Signed-off-by: Odin Ugedal <odin@uged.al>
---
Original thread: https://lore.kernel.org/lkml/20210518125202.78658-3-odin@uged.al/
Changes since v1:
 - Replaced cfs_rq field with using tg_load_avg_contrib
 - Went from 3 to 1 patches; one is merged and one is replaced
   by a new patchset.
Changes since v2:
 - Use !cfs_rq_is_decayed() instead of tg_load_avg_contrib
 - Moved cfs_rq_is_decayed to above its new use

 kernel/sched/fair.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..cdf6ac1a6b12 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -396,6 +396,23 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
 				 leaf_cfs_rq_list)
 
+static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+{
+	if (cfs_rq->load.weight)
+		return false;
+
+	if (cfs_rq->avg.load_sum)
+		return false;
+
+	if (cfs_rq->avg.util_sum)
+		return false;
+
+	if (cfs_rq->avg.runnable_sum)
+		return false;
+
+	return true;
+}
+
 /* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
 is_same_group(struct sched_entity *se, struct sched_entity *pse)
@@ -4719,8 +4736,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
 
-		/* Add cfs_rq with already running entity in the list */
-		if (cfs_rq->nr_running >= 1)
+		/* Add cfs_rq with load or one or more already running entities to the list */
+		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
@@ -7895,23 +7912,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
-{
-	if (cfs_rq->load.weight)
-		return false;
-
-	if (cfs_rq->avg.load_sum)
-		return false;
-
-	if (cfs_rq->avg.util_sum)
-		return false;
-
-	if (cfs_rq->avg.runnable_sum)
-		return false;
-
-	return true;
-}
-
 static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
 	struct cfs_rq *cfs_rq, *pos;
-- 
2.31.1

