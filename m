Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F977432BED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 04:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhJSCt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 22:49:27 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56098 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhJSCt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 22:49:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UsooOMV_1634611624;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0UsooOMV_1634611624)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 10:47:12 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Remove rq_relock()
Date:   Tue, 19 Oct 2021 10:46:25 +0800
Message-Id: <6ab667ed9704d7c880a1dbed8484e4f21191c56a.1634610709.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the removal of migrate_tasks(), there is no user of
rq_lock() left, so remove it.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/sched.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d3e579..8470c9e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1622,14 +1622,6 @@ rq_lock(struct rq *rq, struct rq_flags *rf)
 }
 
 static inline void
-rq_relock(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_rq_lock(rq);
-	rq_repin_lock(rq, rf);
-}
-
-static inline void
 rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
-- 
2.9.5

