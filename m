Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5573BC7F9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhGFIk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:40:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:10310 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhGFIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:40:27 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GJwn34Tnnz76SN;
        Tue,  6 Jul 2021 16:33:27 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 16:37:46 +0800
Received: from huawei.com (10.67.174.153) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 6 Jul 2021
 16:37:45 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <pjt@google.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sched: Dec __cfs_bandwith_used in destroy_cfs_bandwidth()
Date:   Tue, 6 Jul 2021 16:38:20 +0800
Message-ID: <20210706083820.41358-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.153]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__cfs_bandwith_uesd is a static_key to control cfs bandwidth
feature. When adding a cfs_bandwidth group, we need increase
the key, and decrease it when removing. But currently when we
remove a cfs_bandwidth group, we don't decrease the key and
this switch will always be on even if there is no cfs bandwidth
group in the system.
Therefore, when removing a cfs bandwidth group, we decrease
__cfs_bandwith_used by calling cfs_bandwidth_usage_dec().

Fixes: 56f570e512ee ("sched: use jump labels to reduce overhead when bandwidth control is inactive")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 103e31e53e2b..857e8908b7f7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5344,6 +5344,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	if (!cfs_b->throttled_cfs_rq.next)
 		return;
 
+	if (cfs_b->quota != RUNTIME_INF)
+		cfs_bandwidth_usage_dec();
+
 	hrtimer_cancel(&cfs_b->period_timer);
 	hrtimer_cancel(&cfs_b->slack_timer);
 }
-- 
2.18.0.huawei.25

