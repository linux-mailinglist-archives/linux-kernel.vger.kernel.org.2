Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581CB45DED1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346910AbhKYQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:58:01 -0500
Received: from foss.arm.com ([217.140.110.172]:53192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237265AbhKYQ4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:56:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 608C81042;
        Thu, 25 Nov 2021 08:52:49 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E62B3F73B;
        Thu, 25 Nov 2021 08:52:48 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] sched/uclamp: Fix rq->uclamp_max not set on first enqueue
Date:   Thu, 25 Nov 2021 16:52:33 +0000
Message-Id: <20211125165233.1425633-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d81ae8aac85c ("sched/uclamp: Fix initialization of struct
uclamp_rq") introduced a bug where uclamp_max of the rq is not reset to
match the woken up task's uclamp_max when the rq is idle. This only
impacts the first wake up after enabling the static key. And it only
matters if the uclamp_max of this task is < 1024 since only then its
uclamp_max will be effectively ignored.

Fix it by properly initializing rq->uclamp_flags = UCLAMP_FLAG_IDLE to
ensure we reset rq uclamp_max when waking up from idle.

Fixes: d81ae8aac85c ("sched/uclamp: Fix initialization of struct uclamp_rq")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index beaa8be6241e..52b0c7513a32 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1929,7 +1929,7 @@ static void __init init_uclamp_rq(struct rq *rq)
 		};
 	}
 
-	rq->uclamp_flags = 0;
+	rq->uclamp_flags = UCLAMP_FLAG_IDLE;
 }
 
 static void __init init_uclamp(void)
-- 
2.25.1

