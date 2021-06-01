Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF7396EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhFAIVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:21:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2928 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbhFAIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:20:59 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvQ3R4w9Sz68Xx;
        Tue,  1 Jun 2021 16:16:19 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:19:16 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 16:19:15 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jaswinder.singh@linaro.org>, <eric@anholt.net>,
        <jassisinghbrar@gmail.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] mailbox: bcm-flexrm-mailbox: Remove redundant dev_err call in flexrm_mbox_probe()
Date:   Tue, 1 Jun 2021 16:28:34 +0800
Message-ID: <20210601082834.129587-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index b4f33dc399a0..78073ad1f2f1 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1523,7 +1523,6 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 	mbox->regs = devm_ioremap_resource(&pdev->dev, iomem);
 	if (IS_ERR(mbox->regs)) {
 		ret = PTR_ERR(mbox->regs);
-		dev_err(&pdev->dev, "Failed to remap mailbox regs: %d\n", ret);
 		goto fail;
 	}
 	regs_end = mbox->regs + resource_size(iomem);
-- 
2.31.1

