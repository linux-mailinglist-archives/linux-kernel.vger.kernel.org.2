Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82740658B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 04:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhIJCNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 22:13:41 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48794 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhIJCNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 22:13:39 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CA1BE1A5FED;
        Fri, 10 Sep 2021 04:12:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92D251A0AD8;
        Fri, 10 Sep 2021 04:12:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 22F50183AD05;
        Fri, 10 Sep 2021 10:12:27 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_spdif: Add support for i.MX8ULP
Date:   Fri, 10 Sep 2021 09:49:22 +0800
Message-Id: <1631238562-27081-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8ULP the spdif works with EDMA, so add compatible
string and soc specific data for i.MX8ULP.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8ffb1a6048d6..61ba08322f23 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -186,6 +186,16 @@ static struct fsl_spdif_soc_data fsl_spdif_imx8mm = {
 	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
 };
 
+static struct fsl_spdif_soc_data fsl_spdif_imx8ulp = {
+	.imx = true,
+	.shared_root_clock = true,
+	.raw_capture_mode = false,
+	.interrupts = 1,
+	.tx_burst = 2,		/* Applied for EDMA */
+	.rx_burst = 2,		/* Applied for EDMA */
+	.tx_formats = SNDRV_PCM_FMTBIT_S24_LE,	/* Applied for EDMA */
+};
+
 /* Check if clk is a root clock that does not share clock source with others */
 static inline bool fsl_spdif_can_set_clk_rate(struct fsl_spdif_priv *spdif, int clk)
 {
@@ -1556,6 +1566,7 @@ static const struct of_device_id fsl_spdif_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-spdif", .data = &fsl_spdif_imx6sx, },
 	{ .compatible = "fsl,imx8qm-spdif", .data = &fsl_spdif_imx8qm, },
 	{ .compatible = "fsl,imx8mm-spdif", .data = &fsl_spdif_imx8mm, },
+	{ .compatible = "fsl,imx8ulp-spdif", .data = &fsl_spdif_imx8ulp, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_spdif_dt_ids);
-- 
2.17.1

