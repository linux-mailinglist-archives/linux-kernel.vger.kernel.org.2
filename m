Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9364940758D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 10:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhIKIR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 04:17:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9418 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhIKIR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 04:17:57 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H657l2fDqz8yFx;
        Sat, 11 Sep 2021 16:12:19 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 16:16:42 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 11 Sep
 2021 16:16:41 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH -next] ASoC: mediatek: mt8195: Add missing of_node_put()
Date:   Sat, 11 Sep 2021 16:12:46 +0800
Message-ID: <20210911081246.33867-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_node is returned by of_parse_phandle() should have
of_node_put() before return.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
index c97ace7387b4..8cd8450409e8 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
@@ -1041,8 +1041,10 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	if (!priv) {
+		of_node_put(platform_node);
 		return -ENOMEM;
+	}
 
 	snd_soc_card_set_drvdata(card, priv);
 
@@ -1050,6 +1052,8 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
 	if (ret)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
+
+	of_node_put(platform_node);
 	return ret;
 }
 
-- 
2.17.1

