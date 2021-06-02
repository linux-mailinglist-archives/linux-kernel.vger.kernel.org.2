Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2DC398256
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFBHBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:01:41 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59476 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhFBHBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:01:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 746AE1A1E9D;
        Wed,  2 Jun 2021 08:59:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 746AE1A1E9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector3; t=1622617197;
        bh=SWgLA9X2K6gN6TIyMw7jN/rBkJDvoZSmZ7cEH5X1U7M=;
        h=From:To:Subject:Date:From;
        b=jDC9TnR4i6xgH8zwaCPLpZl13UR9d0C4rmME9PtLbcPebgyN2/Z16g8lXrWgSZBVr
         QmTMG8LZ2Txqub8jwsN8LKB5Bn9BMi6psMj5ujnW2eVCJ4QZTIdk9GXYcnUHJiwrwf
         sKQp7FuPWdo7Ow2NzZ1jN+5SGQ3yZuxfjZkEdLFJx8ERmDV+QA7x/4lFge6td/Gl90
         Dh53wioGhYD1xeq1o/WyZSmwfm49NqKtCGtsQF62fTNa4MezD6XYbqJGvdlhBANjtc
         X1nFMI2IQ7/fKFv3O0Dj6ai5C1cYTFYS9mKqTHaVCLJ6F2eQg6xiQL0mHpzN8hRDyL
         Ow7GAcXDkaxBw==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1050D1A1E8A;
        Wed,  2 Jun 2021 08:59:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 1050D1A1E8A
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7933B4031D;
        Wed,  2 Jun 2021 14:59:47 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl-asoc-card: change dev_err to dev_dbg for defer probe
Date:   Wed,  2 Jun 2021 14:42:12 +0800
Message-Id: <1622616132-10391-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't need to print error message for defer probe

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 4f55b316cf0f..b40ba910ae9d 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -709,7 +709,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	of_node_put(framemaster);
 
 	if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
-		dev_err(&pdev->dev, "failed to find codec device\n");
+		dev_dbg(&pdev->dev, "failed to find codec device\n");
 		ret = -EPROBE_DEFER;
 		goto asrc_fail;
 	}
-- 
2.27.0

