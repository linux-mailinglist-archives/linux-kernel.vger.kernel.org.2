Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE06368F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbhDWJFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:05:24 -0400
Received: from m12-15.163.com ([220.181.12.15]:53242 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWJFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cFbST
        E6Czjk4KjXKIgOiGiJfgIQnopPxCeF0GEEvNd4=; b=e0UyaF+fYUKwhBv/OJf1Y
        x5Oo//E4A+lzvjCCAD5T+4mxXGFhN/cB2Bghlxq/tu5CjHjTqMe7CR7pbuvaCIYo
        Tj46+UACCZKHj/eVCJ5AFn806b28j9FrqbOYfiC6FkziPC85KLUbt2VywrvM+st+
        Mu5BsCFfdBqtAAmVdBxmyU=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp11 (Coremail) with SMTP id D8CowAC3me2VjYJgYDbmAQ--.4S2;
        Fri, 23 Apr 2021 17:04:31 +0800 (CST)
From:   dingsenjie@163.com
To:     ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] soc: ti: Use devm_platform_ioremap_resource_byname
Date:   Fri, 23 Apr 2021 17:04:09 +0800
Message-Id: <20210423090409.25032-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAC3me2VjYJgYDbmAQ--.4S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4rZrWfGF4DZr13WFykXwb_yoW5Ww43pr
        yxKayxCrWrCrsrXayrJa1DZFsxX3W2k3yF9r4fG3WSv3s8XF9xAa1UCFWjvr1ay3yqkr13
        trWFvr4UZas8XFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXXoxUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiHgB9yFSIuED+-wAAsO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/soc/ti/k3-ringacc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index b495b0d..aa8ebd4 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1352,7 +1352,6 @@ static int k3_ringacc_init(struct platform_device *pdev,
 	const struct soc_device_attribute *soc;
 	void __iomem *base_fifo, *base_rt;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int ret, i;
 
 	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
@@ -1373,24 +1372,19 @@ static int k3_ringacc_init(struct platform_device *pdev,
 		ringacc->dma_ring_reset_quirk = soc_data->dma_ring_reset_quirk;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rt");
-	base_rt = devm_ioremap_resource(dev, res);
+	base_rt = devm_platform_ioremap_resource_byname(pdev, "rt");
 	if (IS_ERR(base_rt))
 		return PTR_ERR(base_rt);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fifos");
-	base_fifo = devm_ioremap_resource(dev, res);
+	base_fifo = devm_platform_ioremap_resource_byname(pdev, "fifos");
 	if (IS_ERR(base_fifo))
 		return PTR_ERR(base_fifo);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "proxy_gcfg");
-	ringacc->proxy_gcfg = devm_ioremap_resource(dev, res);
+	ringacc->proxy_gcfg = devm_platform_ioremap_resource_byname(pdev, "proxy_gcfg");
 	if (IS_ERR(ringacc->proxy_gcfg))
 		return PTR_ERR(ringacc->proxy_gcfg);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "proxy_target");
-	ringacc->proxy_target_base = devm_ioremap_resource(dev, res);
+	ringacc->proxy_target_base = devm_platform_ioremap_resource_byname(pdev, "proxy_target");
 	if (IS_ERR(ringacc->proxy_target_base))
 		return PTR_ERR(ringacc->proxy_target_base);
 
@@ -1458,7 +1452,6 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct k3_ringacc *ringacc;
 	void __iomem *base_rt;
-	struct resource *res;
 	int i;
 
 	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
@@ -1473,8 +1466,7 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 
 	mutex_init(&ringacc->req_lock);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ringrt");
-	base_rt = devm_ioremap_resource(dev, res);
+	base_rt = devm_platform_ioremap_resource_byname(pdev, "ringrt");
 	if (IS_ERR(base_rt))
 		return ERR_CAST(base_rt);
 
-- 
1.9.1

