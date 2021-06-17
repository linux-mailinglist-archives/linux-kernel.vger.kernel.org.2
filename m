Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB97E3AA9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 05:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhFQDhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 23:37:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4816 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFQDhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 23:37:23 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G56xw1wFyzWlbg;
        Thu, 17 Jun 2021 11:30:12 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 11:35:14 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 17 Jun
 2021 11:35:14 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH -next] ASoC: sti: sti_uniperif: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 17 Jun 2021 11:39:03 +0800
Message-ID: <20210617033903.613727-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/sti/sti_uniperif.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index e3561f00ed40..34668fe3909d 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -410,16 +410,8 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 	*dai = sti_uniperiph_dai_template;
 	dai->name = dev_data->dai_names;
 
-	/* Get resources */
-	uni->mem_region = platform_get_resource(priv->pdev, IORESOURCE_MEM, 0);
-
-	if (!uni->mem_region) {
-		dev_err(dev, "Failed to get memory resource\n");
-		return -ENODEV;
-	}
-
-	uni->base = devm_ioremap_resource(dev, uni->mem_region);
-
+	/* Get resources and base address */
+	uni->base = devm_platform_get_and_ioremap_resource(priv->pdev, 0, &uni->mem_region);
 	if (IS_ERR(uni->base))
 		return PTR_ERR(uni->base);
 
-- 
2.25.1

