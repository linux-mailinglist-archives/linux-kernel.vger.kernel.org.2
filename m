Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133B74116D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhITO2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:28:04 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:39005 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237408AbhITO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:28:02 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 269E01C57BF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:26:35 +0100 (IST)
Received: (qmail 4987 invoked from network); 20 Sep 2021 14:26:34 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 20 Sep 2021 14:26:34 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched/fair: Remove redundant lookup of rq in check_preempt_wakeup
Date:   Mon, 20 Sep 2021 15:26:13 +0100
Message-Id: <20210920142614.4891-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920142614.4891-1-mgorman@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rq for curr is read during the function preamble, remove the
redundant lookup.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..038edfaaae9e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7190,7 +7190,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	if (cse_is_idle != pse_is_idle)
 		return;
 
-	update_curr(cfs_rq_of(se));
+	update_curr(cfs_rq);
 	if (wakeup_preempt_entity(se, pse) == 1) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
-- 
2.31.1

