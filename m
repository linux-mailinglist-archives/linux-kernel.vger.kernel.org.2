Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A9838861A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353297AbhESEgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:36:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3414 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243947AbhESEgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:36:40 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlKjF6t2zzCt01;
        Wed, 19 May 2021 12:32:33 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 12:35:20 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 12:35:19 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <hch@lst.de>, <sagi@grimberg.me>, <chaitanya.kulkarni@wdc.com>,
        <kbusch@kernel.org>, <amit.engel@dell.com>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH 2/2] nvme-loop: Fix memory leak in nvme_loop_create_ctrl()
Date:   Wed, 19 May 2021 13:01:10 +0800
Message-ID: <1621400470-593256-3-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
References: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Form: Wu Bo <wubo40@huawei.com>

When creating loop ctrl in nvme_loop_create_ctrl(), if nvme_init_ctrl()
returns fails, the loop ctrl should be freed before
jumps to the "out" label.

Fixes: 3a85a5de29ea7 ("nvme-loop: add a NVMe loopback host driver")
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/nvme/target/loop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 74b3b15..cb30cb9 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -590,8 +590,10 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
-	if (ret)
+	if (ret) {
+		kfree(ctrl);
 		goto out;
+	}
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		WARN_ON_ONCE(1);
-- 
1.8.3.1

