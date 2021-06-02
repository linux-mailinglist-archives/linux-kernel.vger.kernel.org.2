Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087B4398A75
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhFBNb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:31:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7075 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBNbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:31:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw8vM3vtgzYmbt;
        Wed,  2 Jun 2021 21:26:55 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 21:29:40 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 2 Jun 2021
 21:29:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>
Subject: [PATCH -next] ASoC: fsl: imx-es8328: use devm_snd_soc_register_card()
Date:   Wed, 2 Jun 2021 21:33:59 +0800
Message-ID: <20210602133359.310647-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using devm_snd_soc_register_card() can make the code
shorter and cleaner.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/fsl/imx-es8328.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index fad1eb6253d5..1981dcd7e930 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -193,7 +193,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	data->card.owner = THIS_MODULE;
 	data->card.dai_link = &data->dai;
 
-	ret = snd_soc_register_card(&data->card);
+	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
 	if (ret) {
 		dev_err(dev, "Unable to register: %d\n", ret);
 		goto put_device;
@@ -209,15 +209,6 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_es8328_remove(struct platform_device *pdev)
-{
-	struct imx_es8328_data *data = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(&data->card);
-
-	return 0;
-}
-
 static const struct of_device_id imx_es8328_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-es8328", },
 	{ /* sentinel */ }
@@ -230,7 +221,6 @@ static struct platform_driver imx_es8328_driver = {
 		.of_match_table = imx_es8328_dt_ids,
 	},
 	.probe = imx_es8328_probe,
-	.remove = imx_es8328_remove,
 };
 module_platform_driver(imx_es8328_driver);
 
-- 
2.25.1

