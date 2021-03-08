Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65AB330953
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCHIXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:23:18 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:48607 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhCHIXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:23:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UQr5Aen_1615191785;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQr5Aen_1615191785)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Mar 2021 16:23:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] sched/fair: Use true and false for bool variable
Date:   Mon,  8 Mar 2021 16:23:03 +0800
Message-Id: <1615191783-114032-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./kernel/sched/fair.c:9497:9-10: WARNING: return of 0/1 in function
'imbalanced_active_balance' with return type bool

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb..5388fde 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9494,9 +9494,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 	 */
 	if ((env->migration_type == migrate_task) &&
 	    (sd->nr_balance_failed > sd->cache_nice_tries+2))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 static int need_active_balance(struct lb_env *env)
-- 
1.8.3.1

