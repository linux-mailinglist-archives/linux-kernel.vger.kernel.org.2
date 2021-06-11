Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441103A3B32
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 06:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFKFAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:00:30 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5500 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhFKFAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:00:30 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1T7H3k81zZfPn;
        Fri, 11 Jun 2021 12:55:39 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 12:58:30 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 12:58:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>
Subject: [PATCH -next] ASoC: bcm: cygnus_ssp: Use devm_platform_ioremap_resource_byname()
Date:   Fri, 11 Jun 2021 13:02:35 +0800
Message-ID: <20210611050235.4182746-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/bcm/cygnus-ssp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index ba03bb62ba96..fca5a3f2eec5 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1308,7 +1308,6 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *child_node;
-	struct resource *res;
 	struct cygnus_audio *cygaud;
 	int err;
 	int node_count;
@@ -1320,13 +1319,11 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, cygaud);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aud");
-	cygaud->audio = devm_ioremap_resource(dev, res);
+	cygaud->audio = devm_platform_ioremap_resource_byname(pdev, "aud");
 	if (IS_ERR(cygaud->audio))
 		return PTR_ERR(cygaud->audio);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "i2s_in");
-	cygaud->i2s_in = devm_ioremap_resource(dev, res);
+	cygaud->i2s_in = devm_platform_ioremap_resource_byname(pdev, "i2s_in");
 	if (IS_ERR(cygaud->i2s_in))
 		return PTR_ERR(cygaud->i2s_in);
 
-- 
2.25.1

