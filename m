Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA27404606
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350982AbhIIHRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:17:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9019 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbhIIHRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:17:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H4qzM4SjPzVrxx;
        Thu,  9 Sep 2021 15:15:43 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 15:16:36 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 15:16:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC:     <vkoul@kernel.org>, <steen.hegelund@microchip.com>
Subject: [PATCH] phy: Sparx5 Eth SerDes: Fix return value check in sparx5_serdes_probe()
Date:   Thu, 9 Sep 2021 15:21:49 +0800
Message-ID: <20210909072149.2934047-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_ioremap() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Fixes: 2ff8a1eeb5aa ("phy: Add Sparx5 ethernet serdes PHY driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index 4076580fc2cd..ab1b0986aa67 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -2475,10 +2475,10 @@ static int sparx5_serdes_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	iomem = devm_ioremap(priv->dev, iores->start, resource_size(iores));
-	if (IS_ERR(iomem)) {
+	if (!iomem) {
 		dev_err(priv->dev, "Unable to get serdes registers: %s\n",
 			iores->name);
-		return PTR_ERR(iomem);
+		return -ENOMEM;
 	}
 	for (idx = 0; idx < ARRAY_SIZE(sparx5_serdes_iomap); idx++) {
 		struct sparx5_serdes_io_resource *iomap = &sparx5_serdes_iomap[idx];
-- 
2.25.1

