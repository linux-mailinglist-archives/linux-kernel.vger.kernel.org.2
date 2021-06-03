Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38B3399857
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 05:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFCDCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 23:02:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58532 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFCDCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 23:02:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 16D6B20384C;
        Thu,  3 Jun 2021 05:01:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com 16D6B20384C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector4; t=1622689263;
        bh=ROQTgs3jR6KqtGsQiGNvFAQlNnnJRWQm4j8P6+1iQ+c=;
        h=From:To:Subject:Date:From;
        b=qq0QLshfSFtIiBI2Sd0Vs3tF3tBX1/TJXogfzUCFt/DVp+meQPpzA+R40+OCUt8mN
         mnE3Icn7TJmp5HOi1qCjuw81PVhSuRNL1sBKRUe8kKwbWl3pzhB8ouMA8ffFPz9O5q
         xM3pLNbLY2dUuirWnP6CdCVb7Sgu4BceMm4vHdORrnnNnynp5L82VMfkHNKiZOLXpt
         AFOMqL4SA0OkMO2S45gt5gxIIva+bpo8Ri3dG57roy2HHtJT4fuQ2Fqm2i3V6M4nmK
         CBEruqvUCd5EtvSwcnVOIpO06ArYhUxW+JH3JrEurFThRQG+p9nal8t+BhS4+9az3c
         UcCaS9MuChK6Q==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A4C31203850;
        Thu,  3 Jun 2021 05:00:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com A4C31203850
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B84C1402DF;
        Thu,  3 Jun 2021 11:00:52 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: fsl-asoc-card: change dev_err to dev_err_probe for defer probe
Date:   Thu,  3 Jun 2021 10:43:23 +0800
Message-Id: <1622688203-12244-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't need to print error message for defer probe

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- use dev_err_probe instead of dev_dbg

 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 4f55b316cf0f..2fa371ec6b1c 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -709,8 +709,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	of_node_put(framemaster);
 
 	if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
-		dev_err(&pdev->dev, "failed to find codec device\n");
 		ret = -EPROBE_DEFER;
+		dev_err_probe(&pdev->dev, ret, "failed to find codec device\n");
 		goto asrc_fail;
 	}
 
-- 
2.27.0

