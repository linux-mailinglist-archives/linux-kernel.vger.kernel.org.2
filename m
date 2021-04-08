Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBDE357D33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhDHHTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:19:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15965 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDHHTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:19:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGCJ563xKzyNjn;
        Thu,  8 Apr 2021 15:17:09 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 15:19:12 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 7/7] crypto: omap-aes - Fix PM reference leak on omap-aes.c
Date:   Thu, 8 Apr 2021 15:18:39 +0800
Message-ID: <20210408071839.836942-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
Fix it by replacing it with pm_runtime_resume_and_get to keep usage
counter balanced.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/crypto/omap-aes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index a45bdcf3026d..0dd4c6b157de 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -103,9 +103,8 @@ static int omap_aes_hw_init(struct omap_aes_dev *dd)
 		dd->err = 0;
 	}
 
-	err = pm_runtime_get_sync(dd->dev);
+	err = pm_runtime_resume_and_get(dd->dev);
 	if (err < 0) {
-		pm_runtime_put_noidle(dd->dev);
 		dev_err(dd->dev, "failed to get sync: %d\n", err);
 		return err;
 	}
@@ -1134,7 +1133,7 @@ static int omap_aes_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(dev, DEFAULT_AUTOSUSPEND_DELAY);
 
 	pm_runtime_enable(dev);
-	err = pm_runtime_get_sync(dev);
+	err = pm_runtime_resume_and_get(dev);
 	if (err < 0) {
 		dev_err(dev, "%s: failed to get_sync(%d)\n",
 			__func__, err);
@@ -1303,7 +1302,7 @@ static int omap_aes_suspend(struct device *dev)
 
 static int omap_aes_resume(struct device *dev)
 {
-	pm_runtime_get_sync(dev);
+	pm_runtime_resume_and_get(dev);
 	return 0;
 }
 #endif
-- 
2.25.1

