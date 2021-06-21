Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F913AF237
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFURpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhFURpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:45:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7097EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:43:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w13so4462970wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O8BbUOWDuMnupwNJGCw6qe3Mkxo3Jr+EdIaiPVN/4iU=;
        b=t18qvMKnFXZwUBJlJCyo4Ja7RgC3iUVQ7Jjowv7/kqLuk2VsKvrhz/oQ98yI4aeqIT
         rkHQUmoV+qrb2son47+6xskS93hnBEpjDbQepwmEqzHvlXaOwzAlBfe/uG5i1n42XTMk
         q5opI0tTc335cNQyhnhigAqPmjCWQGbhcf6gNufrh+1dJ9Id3HmIZJIwjV6qKM/sClYm
         YSFCWAqzOjrPTdeb7RZX+C/2kL1D1pF/PhxmhdlI8dyta/xtEIFFmlwC1M2AaAZHbUso
         yuq88aFkJiqpySBeCnT7dZlthziY0ttvEJWq2TquqyrwH8rahJyp+cf+djzqA59Dabnf
         EBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O8BbUOWDuMnupwNJGCw6qe3Mkxo3Jr+EdIaiPVN/4iU=;
        b=ayaXOIw+MOiCfn6+ZcA9BlHNFaYv5HBnlIX9spswS03cTH/DhHtiuuVp7HnYVReqWw
         ltXnmKKyNkSNw8Teq3yvsSNr2f15xMvCp2d5bn//jiUecfiI9KeE+n814atBg5JCFepi
         Ax4BRwKZs2NmVjKLo0+SLb80pNGS6kaC6aXi3ZL08agt/7V8zB1lGoYNs/s/hLYU4Mt3
         kqKZ/Z+pbHwr2PwdLsPFJEpWLWBs8iYigDrMf0paeQq5OPxaMPW8AQ0Y0DRf2snxtpGS
         Jwwkx/pF88v22wKSE3xwSCTXaECvmdoOLkn/g7VHdMMy5ledD9lOchUXGUWmhI3Os3bi
         q39Q==
X-Gm-Message-State: AOAM531qVawU9alFz8Q4RRew9gD/bA5PVsJ0HnsgQKbY9JYK6rC/41wO
        7tQ1HLtwyDRpKR3UgCrq7F2rzQ==
X-Google-Smtp-Source: ABdhPJyV6vogB1+GtgXX60lrBR/tbEANj6coZgCSHcoBw/qqcGLCxtSBep+p29EVapAozxvXpTa/+A==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr5764723wmj.111.1624297414051;
        Mon, 21 Jun 2021 10:43:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:7073:a754:9f82:97c1])
        by smtp.gmail.com with ESMTPSA id b9sm2174878wrt.55.2021.06.21.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:43:33 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        odin@uged.al, sachinp@linux.vnet.ibm.com, riel@surriel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Ensure that the cfs parent is added after unthrottling
Date:   Mon, 21 Jun 2021 19:43:30 +0200
Message-Id: <20210621174330.11258-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

Ensure that a cfs will be in the list whenever one of its child is also
in the list.

A warning on rq->tmp_alone_branch != &rq->leaf_cfs_rq_list has been
reported while running LTP test cfs_bandwidth01.

Odin found the root cause:

$ tree /sys/fs/cgroup/ltp/ -d --charset=ascii
/sys/fs/cgroup/ltp/
|-- drain
`-- test-6851
    `-- level2
        |-- level3a
        |   |-- worker1
        |   `-- worker2
        `-- level3b
            `-- worker3

Timeline (ish):
- worker3 gets throttled
- level3b is decayed, since it has no more load
- level2 get throttled
- worker3 get unthrottled
- level2 get unthrottled
  - worker3 is added to list
  - level3b is not added to list, since nr_running==0 and is decayed

Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
[Rebased and updated to fix for the reported warning]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Odin Ugedal <odin@uged.al>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
---

 kernel/sched/fair.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b8990fd4896..8cc27b847ad8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3255,6 +3255,31 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_FAIR_GROUP_SCHED
+/*
+ * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
+ * immediately before a parent cfs_rq, and cfs_rqs are removed from the list
+ * bottom-up, we only have to test whether the cfs_rq before us on the list
+ * is our child.
+ * If cfs_rq is not on the list, test whether a child needs its to be added to
+ * connect a branch to the tree  * (see list_add_leaf_cfs_rq() for details).
+ */
+static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
+{
+	struct cfs_rq *prev_cfs_rq;
+	struct list_head *prev;
+
+	if (cfs_rq->on_list) {
+		prev = cfs_rq->leaf_cfs_rq_list.prev;
+	} else {
+		struct rq *rq = rq_of(cfs_rq);
+
+		prev = rq->tmp_alone_branch;
+	}
+
+	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
+
+	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
+}
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
@@ -3270,6 +3295,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.runnable_sum)
 		return false;
 
+	if (child_cfs_rq_on_list(cfs_rq))
+		return false;
+
 	/*
 	 * _avg must be null when _sum are null because _avg = _sum / divider
 	 * Make sure that rounding and/or propagation of PELT values never
-- 
2.17.1

