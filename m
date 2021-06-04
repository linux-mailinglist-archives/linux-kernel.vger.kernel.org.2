Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2A339B654
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFDKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:01:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4306 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:01:41 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FxJ646CBDz1BHrv;
        Fri,  4 Jun 2021 17:55:08 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 17:59:48 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 4 Jun
 2021 17:59:48 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <mripard@kernel.org>, <wens@csie.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiaosong2@huawei.com>
Subject: [PATCH -next] mailbox: sun6i-msgbox: Remove redundant dev_err call in sun6i_msgbox_probe()
Date:   Fri, 4 Jun 2021 18:06:11 +0800
Message-ID: <20210604100611.3653738-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 drivers/mailbox/sun6i-msgbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/sun6i-msgbox.c b/drivers/mailbox/sun6i-msgbox.c
index ccecf2e5941d..e357236c7dd1 100644
--- a/drivers/mailbox/sun6i-msgbox.c
+++ b/drivers/mailbox/sun6i-msgbox.c
@@ -255,7 +255,6 @@ static int sun6i_msgbox_probe(struct platform_device *pdev)
 	mbox->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(mbox->regs)) {
 		ret = PTR_ERR(mbox->regs);
-		dev_err(dev, "Failed to map MMIO resource: %d\n", ret);
 		goto err_disable_unprepare;
 	}
 
-- 
2.25.4

