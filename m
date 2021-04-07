Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5EF356E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352810AbhDGOTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:19:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16065 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348149AbhDGOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:18:49 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFmfM1tyrz19L6Q;
        Wed,  7 Apr 2021 22:16:27 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 22:18:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 1/5] crypto: atmel-tdes - Remove redundant dev_err call in atmel_tdes_probe()
Date:   Wed, 7 Apr 2021 22:18:15 +0800
Message-ID: <20210407141819.32588-2-yuehaibing@huawei.com>
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
 drivers/crypto/atmel-tdes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 4d63cb13a54f..6f01c51e3c37 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -1217,7 +1217,6 @@ static int atmel_tdes_probe(struct platform_device *pdev)
 
 	tdes_dd->io_base = devm_ioremap_resource(&pdev->dev, tdes_res);
 	if (IS_ERR(tdes_dd->io_base)) {
-		dev_err(dev, "can't ioremap\n");
 		err = PTR_ERR(tdes_dd->io_base);
 		goto err_tasklet_kill;
 	}
-- 
2.17.1

