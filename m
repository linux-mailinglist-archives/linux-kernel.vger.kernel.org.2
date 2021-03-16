Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD2433D0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhCPJkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:40:35 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59414 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234092AbhCPJk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:40:28 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 816471A3F7D;
        Tue, 16 Mar 2021 10:40:25 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BBFC91A3F71;
        Tue, 16 Mar 2021 10:40:19 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7E2A4402C1;
        Tue, 16 Mar 2021 10:40:12 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: remove reset code from dai_probe
Date:   Tue, 16 Mar 2021 17:27:06 +0800
Message-Id: <1615886826-30844-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

SAI software reset is done in runtime resume,
there is no need to do it in fsl_sai_dai_probe.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 6ef2ce348232..9e7893f91882 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -711,13 +711,6 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
 	unsigned int ofs = sai->soc_data->reg_offset;
 
-	/* Software Reset for both Tx and Rx */
-	regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), FSL_SAI_CSR_SR);
-	regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), FSL_SAI_CSR_SR);
-	/* Clear SR bit to finish the reset */
-	regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), 0);
-	regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), 0);
-
 	regmap_update_bits(sai->regmap, FSL_SAI_TCR1(ofs),
 			   FSL_SAI_CR1_RFW_MASK(sai->soc_data->fifo_depth),
 			   sai->soc_data->fifo_depth - FSL_SAI_MAXBURST_TX);
-- 
2.27.0

