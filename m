Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E59356E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352817AbhDGOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:18:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16386 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348154AbhDGOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:18:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFmfq0HTJzlW61;
        Wed,  7 Apr 2021 22:16:51 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 22:18:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 5/5] crypto: ccree - Remove redundant dev_err call in init_cc_resources()
Date:   Wed, 7 Apr 2021 22:18:19 +0800
Message-ID: <20210407141819.32588-6-yuehaibing@huawei.com>
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
 drivers/crypto/ccree/cc_driver.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index d0e59e942568..e599ac6dc162 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -352,10 +352,8 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	req_mem_cc_regs = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
 	/* Map registers space */
 	new_drvdata->cc_base = devm_ioremap_resource(dev, req_mem_cc_regs);
-	if (IS_ERR(new_drvdata->cc_base)) {
-		dev_err(dev, "Failed to ioremap registers");
+	if (IS_ERR(new_drvdata->cc_base))
 		return PTR_ERR(new_drvdata->cc_base);
-	}
 
 	dev_dbg(dev, "Got MEM resource (%s): %pR\n", req_mem_cc_regs->name,
 		req_mem_cc_regs);
-- 
2.17.1

