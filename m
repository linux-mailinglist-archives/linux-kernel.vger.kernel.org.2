Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8454317C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhJRLtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:49:02 -0400
Received: from m12-18.163.com ([220.181.12.18]:43843 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhJRLtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=05/bJ
        O+NtsIGyjY8blfRLbktL0TQcHHFo0NtapUGyuM=; b=WFGioA8qHo7cIPe48Zt2c
        GYpQkEVNfo7OlBjSfllvxsSkbzjVBUz8NWcHih4c37Oc1BCPUPjS3QCavHZPI1As
        sPluFnGGQ37n3VfcfHHseE5yL02jMZ4aWxVhPYZCORKBGTfWpYTQZ9xJXwFm7AI+
        uuBmIJOapj4tAmU0PGh3aA=
Received: from localhost (unknown [49.235.41.28])
        by smtp14 (Coremail) with SMTP id EsCowAA3etBzXm1hdQDxGQ--.4818S2;
        Mon, 18 Oct 2021 19:45:56 +0800 (CST)
Date:   Mon, 18 Oct 2021 19:45:54 +0800
From:   Hui Su <suhui_kernel@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/deadline: simplify SCHED_WARN_ON()
Message-ID: <20211018114554.GA3523304@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EsCowAA3etBzXm1hdQDxGQ--.4818S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF48uw18Zw1kWF4kXrW5Jrb_yoWkKFb_Gw
        1rKr1kurn3Wr1YgrW7Cr4jvrnxKw1jqFy3ur929FZ3JrZ3trZ8ArWku3WfC345WrZ7ZFnx
        GF13WF97ArW7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dku7UUUUU==
X-Originating-IP: [49.235.41.28]
X-CM-SenderInfo: 5vxk3xhbnh20lho6il2tof0z/xtbBQxQwbV++NaJ+kAAAsS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simplify SCHED_WARN_ON() code.

Signed-off-by: Hui Su <suhui_kernel@163.com>
---
 kernel/sched/deadline.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index aaacd6cfd42f..f4f4b0a383c7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -172,8 +172,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw -= dl_bw;
-	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
-	if (dl_rq->running_bw > old)
+	if (SCHED_WARN_ON(dl_rq->running_bw > old)) /* underflow */
 		dl_rq->running_bw = 0;
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
@@ -196,8 +195,7 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw -= dl_bw;
-	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
-	if (dl_rq->this_bw > old)
+	if (SCHED_WARN_ON(dl_rq->this_bw > old)) /* underflow */
 		dl_rq->this_bw = 0;
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
 }
-- 
2.25.1


