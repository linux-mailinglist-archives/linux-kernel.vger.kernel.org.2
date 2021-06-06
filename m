Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A1D39CF85
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFFOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 10:33:13 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:32837 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFFOdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 10:33:09 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d04 with ME
        id DqXB2500121Fzsu03qXBtD; Sun, 06 Jun 2021 16:31:18 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Jun 2021 16:31:18 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com,
        pierre-louis.bossart@linux.intel.com, lumi.lee@mediatek.com,
        kaichieh.chuang@mediatek.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: mediatek: mtk-btcvsd: Fix an error handling path in 'mtk_btcvsd_snd_probe()'
Date:   Sun,  6 Jun 2021 16:31:09 +0200
Message-Id: <0c2ba562c3364e61bfbd5b3013a99dfa0d9045d7.1622989685.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful 'of_iomap()' call, it must be undone
by a corresponding 'iounmap()' call, as already done in the remove
function.

While at it, remove the useless initialization of 'ret' at the beginning of
the function.

Fixes: 4bd8597dc36c ("ASoC: mediatek: add btcvsd driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is NOT compile tested.

Even if CONFIG_SND_SOC_MTK_BTCVSD is correctly set in my .config file, I've
not been able to have this file compiled.
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index f85b5ea180ec..d884bb7c0fc7 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -1281,7 +1281,7 @@ static const struct snd_soc_component_driver mtk_btcvsd_snd_platform = {
 
 static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 {
-	int ret = 0;
+	int ret;
 	int irq_id;
 	u32 offset[5] = {0, 0, 0, 0, 0};
 	struct mtk_btcvsd_snd *btcvsd;
@@ -1337,7 +1337,8 @@ static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 	btcvsd->bt_sram_bank2_base = of_iomap(dev->of_node, 1);
 	if (!btcvsd->bt_sram_bank2_base) {
 		dev_err(dev, "iomap bt_sram_bank2_base fail\n");
-		return -EIO;
+		ret = -EIO;
+		goto unmap_pkv_err;
 	}
 
 	btcvsd->infra = syscon_regmap_lookup_by_phandle(dev->of_node,
@@ -1345,7 +1346,8 @@ static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 	if (IS_ERR(btcvsd->infra)) {
 		dev_err(dev, "cannot find infra controller: %ld\n",
 			PTR_ERR(btcvsd->infra));
-		return PTR_ERR(btcvsd->infra);
+		ret = PTR_ERR(btcvsd->infra);
+		goto unmap_bank2_err;
 	}
 
 	/* get offset */
@@ -1354,7 +1356,7 @@ static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 					 ARRAY_SIZE(offset));
 	if (ret) {
 		dev_warn(dev, "%s(), get offset fail, ret %d\n", __func__, ret);
-		return ret;
+		goto unmap_bank2_err;
 	}
 	btcvsd->infra_misc_offset = offset[0];
 	btcvsd->conn_bt_cvsd_mask = offset[1];
@@ -1373,8 +1375,18 @@ static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 	mtk_btcvsd_snd_set_state(btcvsd, btcvsd->tx, BT_SCO_STATE_IDLE);
 	mtk_btcvsd_snd_set_state(btcvsd, btcvsd->rx, BT_SCO_STATE_IDLE);
 
-	return devm_snd_soc_register_component(dev, &mtk_btcvsd_snd_platform,
-					       NULL, 0);
+	ret = devm_snd_soc_register_component(dev, &mtk_btcvsd_snd_platform,
+					      NULL, 0);
+	if (ret)
+		goto unmap_bank2_err;
+
+	return 0;
+
+unmap_bank2_err:
+	iounmap(btcvsd->bt_sram_bank2_base);
+unmap_pkv_err:
+	iounmap(btcvsd->bt_pkv_base);
+	return ret;
 }
 
 static int mtk_btcvsd_snd_remove(struct platform_device *pdev)
-- 
2.30.2

