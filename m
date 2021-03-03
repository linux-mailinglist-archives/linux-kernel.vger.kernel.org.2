Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357DA32BD74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345390AbhCCQHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:07:39 -0500
Received: from inva021.nxp.com ([92.121.34.21]:37594 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346986AbhCCLfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:35:18 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 800442004F6;
        Wed,  3 Mar 2021 12:34:08 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C5829200507;
        Wed,  3 Mar 2021 12:34:01 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B94C402C1;
        Wed,  3 Mar 2021 12:33:53 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shengjiu.wang@nxp.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        peter.ujfalusi@ti.com, gustavoars@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8962: Relax bit clock divider searching
Date:   Wed,  3 Mar 2021 19:21:28 +0800
Message-Id: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
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
---
 sound/soc/codecs/wm8962.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index ce4666a74793..f5cd22450190 100644
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
@@ -2473,23 +2474,23 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 
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
 
 	aif2 |= wm8962->bclk / wm8962->lrclk;
 	dev_dbg(component->dev, "Selected LRCLK divisor %d for %dHz\n",
-- 
2.27.0

