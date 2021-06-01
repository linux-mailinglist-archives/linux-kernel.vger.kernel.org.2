Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053DD3970B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhFAJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:55:20 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3318 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhFAJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:55:19 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvS6H4J4Gz1BG6Y;
        Tue,  1 Jun 2021 17:48:55 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:53:37 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:53:36 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next] soc: imx: gpc: add check for of_match_device in imx_gpc_old_dt_init
Date:   Tue, 1 Jun 2021 18:02:56 +0800
Message-ID: <20210601100256.70030-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for of_match_device in imx_gpc_old_dt_init to avoid potential
NULL dereference of of_id.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 drivers/soc/imx/gpc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 90a8b2c0676f..017a5e2bd4e6 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -403,14 +403,25 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 
 static int imx_gpc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(imx_gpc_dt_ids, &pdev->dev);
-	const struct imx_gpc_dt_data *of_id_data = of_id->data;
+	const struct of_device_id *of_id;
+	const struct imx_gpc_dt_data *of_id_data;
 	struct device_node *pgc_node;
 	struct regmap *regmap;
 	void __iomem *base;
 	int ret;
 
+	of_id = of_match_device(imx_gpc_dt_ids, &pdev->dev);
+	if (!of_id) {
+		dev_err(&pdev->dev, "OF id missing\n");
+		return -EINVAL;
+	}
+
+	of_id_data = of_id->data;
+	if (!of_id_data) {
+		dev_err(&pdev->dev, "OF id data missing\n");
+		return -EINVAL;
+	}
+
 	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
 
 	/* bail out if DT too old and doesn't provide the necessary info */
-- 
2.18.0.huawei.25

