Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE4361F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhDPMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:00:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55746 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDPMAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:00:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5065C203A52;
        Fri, 16 Apr 2021 13:59:57 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A630F203A48;
        Fri, 16 Apr 2021 13:59:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 689D54032B;
        Fri, 16 Apr 2021 13:59:51 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ak4458: check reset control status
Date:   Fri, 16 Apr 2021 19:45:02 +0800
Message-Id: <1618573502-1488-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

check the return value of ak4458_rstn_control.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak4458.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 85a1d00894a9..0a94973889a1 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -419,8 +419,13 @@ static int ak4458_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
 			    AK4458_DIF_MASK, format);
 
-	ak4458_rstn_control(component, 0);
-	ak4458_rstn_control(component, 1);
+	ret = ak4458_rstn_control(component, 0);
+	if (ret)
+		return ret;
+
+	ret = ak4458_rstn_control(component, 1);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -429,6 +434,7 @@ static int ak4458_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS: /* Slave Mode */
@@ -461,8 +467,13 @@ static int ak4458_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 				      ak4458->fmt == SND_SOC_DAIFMT_PDM ?
 				      AK4458_DP_MASK : 0);
 
-	ak4458_rstn_control(component, 0);
-	ak4458_rstn_control(component, 1);
+	ret = ak4458_rstn_control(component, 0);
+	if (ret)
+		return ret;
+
+	ret = ak4458_rstn_control(component, 1);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.27.0

