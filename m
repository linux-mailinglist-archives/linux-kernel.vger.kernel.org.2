Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340343873D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347423AbhERIWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:22:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3015 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346279AbhERIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:22:20 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fkpmj6lyPzlg3D;
        Tue, 18 May 2021 16:18:45 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 16:20:49 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 16:20:48 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <hch@lst.de>, <sagi@grimberg.me>, <chaitanya.kulkarni@wdc.com>,
        <kbusch@kernel.org>, <amit.engel@dell.com>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
Date:   Tue, 18 May 2021 16:46:38 +0800
Message-ID: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Bo <wubo40@huawei.com>

When cntlid_min is greater than cntlid_max,
goto wrong label, should be goto out_free_sqs
label. Otherwise there is a memory leak problem
on the nvmet_alloc_ctrl function().

Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")
Fixes: 6d65aeab7bf6e ("nvmet: remove unused ctrl->cqs")
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 25cc2ee8de3f..1853db38b682 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1372,7 +1372,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out_free_changed_ns_list;
 
 	if (subsys->cntlid_min > subsys->cntlid_max)
-		goto out_free_changed_ns_list;
+		goto out_free_sqs;
 
 	ret = ida_simple_get(&cntlid_ida,
 			     subsys->cntlid_min, subsys->cntlid_max,
-- 
2.30.0

