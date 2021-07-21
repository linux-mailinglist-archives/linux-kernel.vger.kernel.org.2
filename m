Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD81F3D0B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhGUI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:26:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7041 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbhGUIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:25:09 -0400
Received: from dggeml754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GV8fR3Np8zYdrW;
        Wed, 21 Jul 2021 16:59:43 +0800 (CST)
Received: from huawei.com (10.175.103.14) by dggeml754-chm.china.huawei.com
 (10.1.199.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 17:05:29 +0800
From:   Wang Hui <john.wanghui@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sched: remove redundant on_rq status change
Date:   Wed, 21 Jul 2021 17:11:09 +0800
Message-ID: <20210721091109.1406043-1-john.wanghui@huawei.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeml754-chm.china.huawei.com (10.1.199.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

activate_task/deactivate_task will change on_rq status,
no need to do it again.

Signed-off-by: Wang Hui <john.wanghui@huawei.com>
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 014ce8b385c7..a0c35da186d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5679,11 +5679,9 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
-		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
 		activate_task(dst, p, 0);
-		p->on_rq = TASK_ON_RQ_QUEUED;
 
 		resched_curr(dst);
 
-- 
2.29.0

