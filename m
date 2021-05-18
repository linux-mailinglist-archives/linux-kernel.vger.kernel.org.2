Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A415D3873A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347346AbhERH5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:57:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2968 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbhERH5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:57:51 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkpCs1rLnzCtQT;
        Tue, 18 May 2021 15:53:45 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 15:56:30 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 15:56:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <broonie@kernel.org>
Subject: [PATCH -next] ASoC: rk3328: fix missing clk_disable_unprepare() on error in rk3328_platform_probe()
Date:   Tue, 18 May 2021 15:58:47 +0800
Message-ID: <20210518075847.1116983-1-yangyingliang@huawei.com>
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

Fix the missing clk_disable_unprepare() before return
from rk3328_platform_probe() in the error handling case.

Fixes: c32759035ad2 ("ASoC: rockchip: support ACODEC for rk3328")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/codecs/rk3328_codec.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index bfefefcc76d8..758d439e8c7a 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -474,7 +474,8 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 	rk3328->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(rk3328->pclk)) {
 		dev_err(&pdev->dev, "can't get acodec pclk\n");
-		return PTR_ERR(rk3328->pclk);
+		ret = PTR_ERR(rk3328->pclk);
+		goto err_unprepare_mclk;
 	}
 
 	ret = clk_prepare_enable(rk3328->pclk);
@@ -484,19 +485,34 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 	}
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto err_unprepare_pclk;
+	}
 
 	rk3328->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					       &rk3328_codec_regmap_config);
-	if (IS_ERR(rk3328->regmap))
-		return PTR_ERR(rk3328->regmap);
+	if (IS_ERR(rk3328->regmap)) {
+		ret = PTR_ERR(rk3328->regmap);
+		goto err_unprepare_pclk;
+	}
 
 	platform_set_drvdata(pdev, rk3328);
 
-	return devm_snd_soc_register_component(&pdev->dev, &soc_codec_rk3328,
+	ret = devm_snd_soc_register_component(&pdev->dev, &soc_codec_rk3328,
 					       rk3328_dai,
 					       ARRAY_SIZE(rk3328_dai));
+	if (ret)
+		goto err_unprepare_pclk;
+
+	return 0;
+
+err_unprepare_pclk:
+	clk_disable_unprepare(rk3328->pclk);
+
+err_unprepare_mclk:
+	clk_disable_unprepare(rk3328->mclk);
+	return ret;
 }
 
 static const struct of_device_id rk3328_codec_of_match[] __maybe_unused = {
-- 
2.25.1

