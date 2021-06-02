Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6A398C23
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhFBOPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:15:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3516 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFBONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:13:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw9r75CxLzYnCv;
        Wed,  2 Jun 2021 22:09:11 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 22:11:56 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 2 Jun 2021
 22:11:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>
Subject: [PATCH -next] ASoC: atmel: sam9x5_wm8731: use devm_snd_soc_register_card()
Date:   Wed, 2 Jun 2021 22:16:19 +0800
Message-ID: <20210602141619.323286-1-yangyingliang@huawei.com>
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
 sound/soc/atmel/sam9x5_wm8731.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 9fbc3c1113cc..7745250fd743 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -159,7 +159,7 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 	of_node_put(codec_np);
 	of_node_put(cpu_np);
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "Platform device allocation failed\n");
 		goto out_put_audio;
@@ -180,7 +180,6 @@ static int sam9x5_wm8731_driver_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct sam9x5_drvdata *priv = card->drvdata;
 
-	snd_soc_unregister_card(card);
 	atmel_ssc_put_audio(priv->ssc_id);
 
 	return 0;
-- 
2.25.1

