Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FAC3B05C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFVN2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:28:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7502 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:28:27 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G8Rsm5554zZkhh;
        Tue, 22 Jun 2021 21:23:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 22 Jun 2021 21:26:08 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] sched/fair: Fix a comment of function rebalance_domains()
Date:   Tue, 22 Jun 2021 21:21:36 +0800
Message-ID: <1624368096-29024-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Use sched_init_domains instead of init_sched_domains which is not existed
in kernel.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92a..3021f28 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10026,7 +10026,7 @@ void update_max_interval(void)
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
  *
- * Balancing parameters are set up in init_sched_domains.
+ * Balancing parameters are set up in sched_init_domains.
  */
 static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 {
-- 
2.8.1

