Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E093074F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhA1LjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:39:03 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:48276 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhA1LjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:39:02 -0500
X-Greylist: delayed 657 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 06:39:01 EST
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee460129f8f7bd-37730; Thu, 28 Jan 2021 19:27:11 +0800 (CST)
X-RM-TRANSID: 2ee460129f8f7bd-37730
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee560129f8be3a-d290f;
        Thu, 28 Jan 2021 19:27:11 +0800 (CST)
X-RM-TRANSID: 2ee560129f8be3a-d290f
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: fsl_spdif: Utilize the defined parameter to clear code
Date:   Thu, 28 Jan 2021 19:27:14 +0800
Message-Id: <20210128112714.16324-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the defined parameter 'dev' to make the code cleaner.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_spdif.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 455f96908..b6d5563df 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1215,7 +1215,7 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 
 	for (i = 0; i < STC_TXCLK_SRC_MAX; i++) {
 		sprintf(tmp, "rxtx%d", i);
-		clk = devm_clk_get(&pdev->dev, tmp);
+		clk = devm_clk_get(dev, tmp);
 		if (IS_ERR(clk)) {
 			dev_err(dev, "no rxtx%d clock in devicetree\n", i);
 			return PTR_ERR(clk);
@@ -1237,14 +1237,14 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 			break;
 	}
 
-	dev_dbg(&pdev->dev, "use rxtx%d as tx clock source for %dHz sample rate\n",
+	dev_dbg(dev, "use rxtx%d as tx clock source for %dHz sample rate\n",
 			spdif_priv->txclk_src[index], rate[index]);
-	dev_dbg(&pdev->dev, "use txclk df %d for %dHz sample rate\n",
+	dev_dbg(dev, "use txclk df %d for %dHz sample rate\n",
 			spdif_priv->txclk_df[index], rate[index]);
 	if (clk_is_match(spdif_priv->txclk[index], spdif_priv->sysclk))
-		dev_dbg(&pdev->dev, "use sysclk df %d for %dHz sample rate\n",
+		dev_dbg(dev, "use sysclk df %d for %dHz sample rate\n",
 				spdif_priv->sysclk_df[index], rate[index]);
-	dev_dbg(&pdev->dev, "the best rate for %dHz sample rate is %dHz\n",
+	dev_dbg(dev, "the best rate for %dHz sample rate is %dHz\n",
 			rate[index], spdif_priv->txrate[index]);
 
 	return 0;
-- 
2.20.1.windows.1



