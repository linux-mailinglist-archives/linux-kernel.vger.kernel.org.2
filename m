Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC2E3305F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhCHCr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:47:58 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42820 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231522AbhCHCrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:47:33 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 720F1200E4D;
        Mon,  8 Mar 2021 03:47:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CEBFF20177F;
        Mon,  8 Mar 2021 03:47:23 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1308A402C9;
        Mon,  8 Mar 2021 03:47:16 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, shengjiu.wang@nxp.com,
        festevam@gmail.com, gustavoars@kernel.org,
        sebastian.krzyszkowiak@puri.sm, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: wm8962: Relax bit clock divider searching
Date:   Mon,  8 Mar 2021 10:34:37 +0800
Message-Id: <1615170877-25918-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With S20_3LE format case, the sysclk = rate * 384,
the bclk = rate * 20 * 2, there is no proper bclk divider
for 384 / 40, because current condition needs exact match.
So driver fails to configure the clocking:

wm8962 3-001a: Unsupported BCLK ratio 9

Fix this by relaxing bitclk divider searching, so that when
no exact value can be derived from sysclk pick the closest
value greater than expected bitclk.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
changes in v2:
- Add debug message according to Charles's comments

 sound/soc/codecs/wm8962.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index ce4666a74793..34080f497584 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2403,6 +2403,7 @@ static const int sysclk_rates[] = {
 static void wm8962_configure_bclk(struct snd_soc_component *component)
 {
 	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
+	int best, min_diff, diff;
 	int dspclk, i;
 	int clocking2 = 0;
 	int clocking4 = 0;
@@ -2473,23 +2474,25 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 
 	dev_dbg(component->dev, "DSPCLK is %dHz, BCLK %d\n", dspclk, wm8962->bclk);
 
-	/* We're expecting an exact match */
+	/* Search a proper bclk, not exact match. */
+	best = 0;
+	min_diff = INT_MAX;
 	for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
 		if (bclk_divs[i] < 0)
 			continue;
 
-		if (dspclk / bclk_divs[i] == wm8962->bclk) {
-			dev_dbg(component->dev, "Selected BCLK_DIV %d for %dHz\n",
-				bclk_divs[i], wm8962->bclk);
-			clocking2 |= i;
+		diff = (dspclk / bclk_divs[i]) - wm8962->bclk;
+		if (diff < 0) /* Table is sorted */
 			break;
+		if (diff < min_diff) {
+			best = i;
+			min_diff = diff;
 		}
 	}
-	if (i == ARRAY_SIZE(bclk_divs)) {
-		dev_err(component->dev, "Unsupported BCLK ratio %d\n",
-			dspclk / wm8962->bclk);
-		return;
-	}
+	wm8962->bclk = dspclk / bclk_divs[best];
+	clocking2 |= best;
+	dev_dbg(component->dev, "Selected BCLK_DIV %d for %dHz\n",
+		bclk_divs[best], wm8962->bclk);
 
 	aif2 |= wm8962->bclk / wm8962->lrclk;
 	dev_dbg(component->dev, "Selected LRCLK divisor %d for %dHz\n",
-- 
2.27.0

