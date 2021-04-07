Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E138356E54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbhDGOSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:18:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16815 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhDGOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:18:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FFmfK3gNhz941H;
        Wed,  7 Apr 2021 22:16:25 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 22:18:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 4/5] crypto: keembay - Remove redundant dev_err calls
Date:   Wed, 7 Apr 2021 22:18:18 +0800
Message-ID: <20210407141819.32588-5-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20210407141819.32588-1-yuehaibing@huawei.com>
References: <20210407141819.32588-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/keembay/keembay-ocs-aes-core.c | 4 +---
 drivers/crypto/keembay/keembay-ocs-hcu-core.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/keembay/keembay-ocs-aes-core.c b/drivers/crypto/keembay/keembay-ocs-aes-core.c
index 2ef312866338..e2a39fdaf623 100644
--- a/drivers/crypto/keembay/keembay-ocs-aes-core.c
+++ b/drivers/crypto/keembay/keembay-ocs-aes-core.c
@@ -1623,10 +1623,8 @@ static int kmb_ocs_aes_probe(struct platform_device *pdev)
 	}
 
 	aes_dev->base_reg = devm_ioremap_resource(&pdev->dev, aes_mem);
-	if (IS_ERR(aes_dev->base_reg)) {
-		dev_err(dev, "Failed to get base address\n");
+	if (IS_ERR(aes_dev->base_reg))
 		return PTR_ERR(aes_dev->base_reg);
-	}
 
 	/* Get and request IRQ */
 	aes_dev->irq = platform_get_irq(pdev, 0);
diff --git a/drivers/crypto/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
index 322c51a6936f..0379dbf32a4c 100644
--- a/drivers/crypto/keembay/keembay-ocs-hcu-core.c
+++ b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
@@ -1192,10 +1192,8 @@ static int kmb_ocs_hcu_probe(struct platform_device *pdev)
 	}
 
 	hcu_dev->io_base = devm_ioremap_resource(dev, hcu_mem);
-	if (IS_ERR(hcu_dev->io_base)) {
-		dev_err(dev, "Could not io-remap mem resource.\n");
+	if (IS_ERR(hcu_dev->io_base))
 		return PTR_ERR(hcu_dev->io_base);
-	}
 
 	init_completion(&hcu_dev->irq_done);
 
-- 
2.17.1

