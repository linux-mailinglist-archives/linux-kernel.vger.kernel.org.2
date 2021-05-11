Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8822237A3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEKJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:46:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2626 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhEKJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:46:40 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FfXzZ1hH8zlZXj
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 17:43:22 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 17:45:25 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mailbox: arm_mhu: Remove redundant error printing in mhu_probe()
Date:   Tue, 11 May 2021 17:45:21 +0800
Message-ID: <20210511094521.4832-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When devm_ioremap_resource() fails, a clear enough error message will be
printed by its subfunction __devm_ioremap_resource(). The error
information contains the device name, failure cause, and possibly resource
information.

Therefore, remove the error printing here to simplify code and reduce the
binary size.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mailbox/arm_mhu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index b7fbf276eb62bf8..22243cabe056542 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -122,10 +122,8 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 		return -ENOMEM;
 
 	mhu->base = devm_ioremap_resource(dev, &adev->res);
-	if (IS_ERR(mhu->base)) {
-		dev_err(dev, "ioremap failed\n");
+	if (IS_ERR(mhu->base))
 		return PTR_ERR(mhu->base);
-	}
 
 	for (i = 0; i < MHU_CHANS; i++) {
 		mhu->chan[i].con_priv = &mhu->mlink[i];
-- 
2.26.0.106.g9fadedd


