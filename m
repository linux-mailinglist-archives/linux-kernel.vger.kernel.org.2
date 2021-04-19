Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68C7363F53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbhDSKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 06:10:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52616 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhDSKKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:10:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5CD981A26EC;
        Mon, 19 Apr 2021 12:10:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DDB91A26E7;
        Mon, 19 Apr 2021 12:10:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8657A4031F;
        Mon, 19 Apr 2021 12:09:36 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: ak4458: check reset control status
Date:   Mon, 19 Apr 2021 17:54:32 +0800
Message-Id: <1618826072-29344-1-git-send-email-shengjiu.wang@nxp.com>
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
changes in v2:
- fix "use of undeclared identifier 'ret'" reported by kernel test robot

 sound/soc/codecs/ak4458.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 85a1d00894a9..3088128816bb 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -334,7 +334,7 @@ static int ak4458_hw_params(struct snd_pcm_substream *substream,
 	struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
 	int pcm_width = max(params_physical_width(params), ak4458->slot_width);
 	u8 format, dsdsel0, dsdsel1;
-	int nfs1, dsd_bclk;
+	int nfs1, dsd_bclk, ret;
 
 	nfs1 = params_rate(params);
 	ak4458->fs = nfs1;
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

