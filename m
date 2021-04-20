Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456B63656F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhDTK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:59:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34776 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhDTK7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:59:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 774151A157E;
        Tue, 20 Apr 2021 12:59:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CC2091A2FF4;
        Tue, 20 Apr 2021 12:59:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3AC0B40291;
        Tue, 20 Apr 2021 12:59:15 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: ak4458: enable daisy chain
Date:   Tue, 20 Apr 2021 18:44:13 +0800
Message-Id: <1618915453-29445-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Enable Daisy Chain if in TDM mode and the number of played
channels is bigger than the maximum supported number of channels.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak4458.c | 47 ++++++++++++++++++++++++++-------------
 sound/soc/codecs/ak4458.h |  1 +
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 3088128816bb..29eb78702bf3 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -306,6 +306,20 @@ static const struct snd_soc_dapm_route ak4497_intercon[] = {
 
 };
 
+static int ak4458_get_tdm_mode(struct ak4458_priv *ak4458)
+{
+	switch (ak4458->slots * ak4458->slot_width) {
+	case 128:
+		return 1;
+	case 256:
+		return 2;
+	case 512:
+		return 3;
+	default:
+		return 0;
+	}
+}
+
 static int ak4458_rstn_control(struct snd_soc_component *component, int bit)
 {
 	int ret;
@@ -333,13 +347,16 @@ static int ak4458_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 	int pcm_width = max(params_physical_width(params), ak4458->slot_width);
-	u8 format, dsdsel0, dsdsel1;
-	int nfs1, dsd_bclk, ret;
+	u8 format, dsdsel0, dsdsel1, dchn;
+	int nfs1, dsd_bclk, ret, channels, channels_max;
 
 	nfs1 = params_rate(params);
 	ak4458->fs = nfs1;
 
 	/* calculate bit clock */
+	channels = params_channels(params);
+	channels_max = dai->driver->playback.channels_max;
+
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_DSD_U8:
 	case SNDRV_PCM_FORMAT_DSD_U16_LE:
@@ -419,6 +436,17 @@ static int ak4458_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
 			    AK4458_DIF_MASK, format);
 
+	/*
+	 * Enable/disable Daisy Chain if in TDM mode and the number of played
+	 * channels is bigger than the maximum supported number of channels
+	 */
+	dchn = ak4458_get_tdm_mode(ak4458) &&
+		(ak4458->fmt == SND_SOC_DAIFMT_DSP_B) &&
+		(channels > channels_max) ? AK4458_DCHAIN_MASK : 0;
+
+	snd_soc_component_update_bits(component, AK4458_0B_CONTROL7,
+				      AK4458_DCHAIN_MASK, dchn);
+
 	ret = ak4458_rstn_control(component, 0);
 	if (ret)
 		return ret;
@@ -519,20 +547,7 @@ static int ak4458_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	ak4458->slots = slots;
 	ak4458->slot_width = slot_width;
 
-	switch (slots * slot_width) {
-	case 128:
-		mode = AK4458_MODE_TDM128;
-		break;
-	case 256:
-		mode = AK4458_MODE_TDM256;
-		break;
-	case 512:
-		mode = AK4458_MODE_TDM512;
-		break;
-	default:
-		mode = AK4458_MODE_NORMAL;
-		break;
-	}
+	mode = ak4458_get_tdm_mode(ak4458) << AK4458_MODE_SHIFT;
 
 	snd_soc_component_update_bits(component, AK4458_0A_CONTROL6,
 			    AK4458_MODE_MASK,
diff --git a/sound/soc/codecs/ak4458.h b/sound/soc/codecs/ak4458.h
index 9548c5d78621..9ad869575f8d 100644
--- a/sound/soc/codecs/ak4458.h
+++ b/sound/soc/codecs/ak4458.h
@@ -82,6 +82,7 @@
  * */
 #define AK4458_ATS_SHIFT	6
 #define AK4458_ATS_MASK		GENMASK(7, 6)
+#define AK4458_DCHAIN_MASK	(0x1 << 1)
 
 #define AK4458_DSDSEL_MASK		(0x1 << 0)
 #define AK4458_DP_MASK			(0x1 << 7)
-- 
2.27.0

