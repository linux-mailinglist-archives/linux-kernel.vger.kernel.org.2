Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BAC3AFAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhFVBeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:34:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47644 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhFVBeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:34:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 400242007C2;
        Tue, 22 Jun 2021 03:31:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 36CD02005D7;
        Tue, 22 Jun 2021 03:31:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EBCB84024D;
        Tue, 22 Jun 2021 09:31:46 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] ASoC: fsl-asoc-card: change dev_err to dev_err_probe for defer probe
Date:   Tue, 22 Jun 2021 09:13:15 +0800
Message-Id: <1624324395-7260-1-git-send-email-shengjiu.wang@nxp.com>
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
index 121e08c2af2a..24c890d76da0 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -708,8 +708,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	of_node_put(framemaster);
 
 	if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
-		dev_err(&pdev->dev, "failed to find codec device\n");
 		ret = -EPROBE_DEFER;
+		dev_err_probe(&pdev->dev, ret, "failed to find codec device\n");
 		goto asrc_fail;
 	}
 
-- 
2.27.0

