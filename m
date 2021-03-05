Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D344032E035
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 04:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCEDku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 22:40:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13127 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCEDkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 22:40:47 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DsD4639DVz16Ft2;
        Fri,  5 Mar 2021 11:39:02 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 11:40:34 +0800
From:   'Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] regulator: rt4831: Fix return value check in rt4831_regulator_probe()
Date:   Fri, 5 Mar 2021 03:49:30 +0000
Message-ID: <20210305034930.3236099-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function dev_get_regmap() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Fixes: 9351ab8b0cb6 ("regulator: rt4831: Adds support for Richtek RT4831 DSV regulator")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/regulator/rt4831-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rt4831-regulator.c b/drivers/regulator/rt4831-regulator.c
index 3d4695ded629..e3aaac90d238 100644
--- a/drivers/regulator/rt4831-regulator.c
+++ b/drivers/regulator/rt4831-regulator.c
@@ -153,9 +153,9 @@ static int rt4831_regulator_probe(struct platform_device *pdev)
 	int i, ret;
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (IS_ERR(regmap)) {
+	if (!regmap) {
 		dev_err(&pdev->dev, "Failed to init regmap\n");
-		return PTR_ERR(regmap);
+		return -ENODEV;
 	}
 
 	/* Configure DSV mode to normal by default */

