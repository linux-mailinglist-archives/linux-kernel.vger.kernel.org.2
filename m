Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50283FEA8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 10:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbhIBIWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 04:22:18 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:47660 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243953AbhIBIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 04:22:15 -0400
X-UUID: a3a56026d1054594bd0b82012ed08a9d-20210902
X-UUID: a3a56026d1054594bd0b82012ed08a9d-20210902
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 590595087; Thu, 02 Sep 2021 16:21:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 16:21:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 16:21:12 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dan.carpenter@oracle.com>,
        <bicycle.tsai@mediatek.com>
Subject: [PATCH] ASoC: mediatek: common: handle NULL case in suspend/resume function
Date:   Thu, 2 Sep 2021 16:21:11 +0800
Message-ID: <20210902082111.9287-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory allocation for afe->reg_back_up fails, reg_back_up can't
be used.
Keep the suspend/resume flow but skip register backup when
afe->reg_back_up is NULL, in case illegal memory access happens.

Fixes: 283b612429a2 ("ASoC: mediatek: implement mediatek common structure")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index baaa5881b1d4..e95c7c018e7d 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -334,9 +334,11 @@ int mtk_afe_suspend(struct snd_soc_component *component)
 			devm_kcalloc(dev, afe->reg_back_up_list_num,
 				     sizeof(unsigned int), GFP_KERNEL);
 
-	for (i = 0; i < afe->reg_back_up_list_num; i++)
-		regmap_read(regmap, afe->reg_back_up_list[i],
-			    &afe->reg_back_up[i]);
+	if (afe->reg_back_up) {
+		for (i = 0; i < afe->reg_back_up_list_num; i++)
+			regmap_read(regmap, afe->reg_back_up_list[i],
+				    &afe->reg_back_up[i]);
+	}
 
 	afe->suspended = true;
 	afe->runtime_suspend(dev);
@@ -356,12 +358,13 @@ int mtk_afe_resume(struct snd_soc_component *component)
 
 	afe->runtime_resume(dev);
 
-	if (!afe->reg_back_up)
+	if (!afe->reg_back_up) {
 		dev_dbg(dev, "%s no reg_backup\n", __func__);
-
-	for (i = 0; i < afe->reg_back_up_list_num; i++)
-		mtk_regmap_write(regmap, afe->reg_back_up_list[i],
-				 afe->reg_back_up[i]);
+	} else {
+		for (i = 0; i < afe->reg_back_up_list_num; i++)
+			mtk_regmap_write(regmap, afe->reg_back_up_list[i],
+					 afe->reg_back_up[i]);
+	}
 
 	afe->suspended = false;
 	return 0;
-- 
2.18.0

