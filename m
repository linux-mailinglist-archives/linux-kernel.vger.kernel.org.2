Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A2F432BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 04:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJSDBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 23:01:34 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60582 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhJSDBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 23:01:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Usp.i22_1634612353;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0Usp.i22_1634612353)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 10:59:19 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/core: Remove rq_relock()
Date:   Tue, 19 Oct 2021 10:58:39 +0800
Message-Id: <449948fdf9be4764b3929c52572917dd25eef758.1634611953.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <6ab667ed9704d7c880a1dbed8484e4f21191c56a.1634610709.git.rocking@linux.alibaba.com>
References: <6ab667ed9704d7c880a1dbed8484e4f21191c56a.1634610709.git.rocking@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the removal of migrate_tasks(), there is no user of
rq_relock() left, so remove it.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---

Changes since v1:
- fix typo in commit log: rq_lock() -> rq_relock()

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

