Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5FA3949F6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 04:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhE2Cce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 22:32:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2455 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhE2Ccc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 22:32:32 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsQSx0cj7z67WX;
        Sat, 29 May 2021 10:28:01 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 10:30:54 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 29 May
 2021 10:30:53 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, Bixuan Cui <cuibixuan@huawei.com>
Subject: [PATCH -next] sched: make sched_set_stop_task() static
Date:   Sat, 29 May 2021 10:29:56 +0800
Message-ID: <20210529022956.43858-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 generates the following warning for kernel/sched/core.c:
warning: no previous prototype for ‘sched_set_stop_task’ [-Wmissing-prototypes]

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index adea0b1e8036..1c1e9612018b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3209,7 +3209,7 @@ int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
 	return cpu;
 }
 
-void sched_set_stop_task(int cpu, struct task_struct *stop)
+static void sched_set_stop_task(int cpu, struct task_struct *stop)
 {
 	static struct lock_class_key stop_pi_lock;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
-- 
2.17.1

